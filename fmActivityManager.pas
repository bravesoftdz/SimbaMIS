unit fmActivityManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mysql, StdCtrls, RzEdit, RzButton, RzLabel, ExtCtrls, RzPanel,
  ComCtrls, RzTreeVw;

type
  TFormActivityManager = class(TForm)
    RzTreeViewList: TRzTreeView;
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabelTitle: TRzLabel;
    RzPanel2: TRzPanel;
    RzButtonAdd: TRzButton;
    RzButtonEdit: TRzButton;
    RzButtonDel: TRzButton;
    RzButtonClose: TRzButton;
    RzLabelStartTime: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabelEndTime: TRzLabel;
    RzLabel5: TRzLabel;
    RzRichEditContent: TRzRichEdit;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonAddClick(Sender: TObject);
    procedure RzButtonCloseClick(Sender: TObject);
    procedure RzButtonDelClick(Sender: TObject);
    procedure RzButtonEditClick(Sender: TObject);
    procedure RzTreeViewListChange(Sender: TObject; Node: TTreeNode);
    procedure RzTreeViewListDblClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadActivityData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormActivityManager: TFormActivityManager;

implementation

uses myfunction, dbfunction, fmActivityInfo;

{$R *.dfm}

procedure TFormActivityManager.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormActivityManager.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  loadActivityData;
end;

procedure TFormActivityManager.loadActivityData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  starttime,endtime: TDateTime;
  title:string;
  n,n0,n1,n2:TTreeNode;
  dfs: TFormatSettings;
begin
  self.RzTreeViewList.Items.Clear;
  n0:=self.RzTreeViewList.Items.AddChild(nil,'已过期的营销活动');
  n1:=self.RzTreeViewList.Items.AddChild(nil,'进行中的营销活动');
  n2:=self.RzTreeViewList.Items.AddChild(nil,'未生效的营销活动');

  sql := 'select id,starttime,endtime,title from activity order by id desc';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        title:=getUTF8String(MYSQL_ROW^[0])+'：'+getUTF8String(MYSQL_ROW^[3]);
        dfs.ShortDateFormat := 'yyyy-MM-dd';
        dfs.DateSeparator := '-';
        starttime:=StrToDate(getUTF8String(MYSQL_ROW^[1]),dfs);
        endtime:=StrToDate(getUTF8String(MYSQL_ROW^[2]),dfs);
        if(endtime<Date())then begin         //过期
          n:=self.RzTreeViewList.Items.AddChild(n0,title);
          n.ImageIndex:=strtoint(getUTF8String(MYSQL_ROW^[0]));
        end else if(starttime>Date())then begin      //未生效
          n:=self.RzTreeViewList.Items.AddChild(n2,title);
          n.ImageIndex:=strtoint(getUTF8String(MYSQL_ROW^[0]));
        end else begin                                    //当前
          n:=self.RzTreeViewList.Items.AddChild(n1,title);
          n.ImageIndex:=strtoint(getUTF8String(MYSQL_ROW^[0]));
        end;
      end;
    until MYSQL_ROW=nil;
  end;
  self.RzTreeViewList.Selected:=n0;
end;

procedure TFormActivityManager.RzButtonAddClick(Sender: TObject);
var
  f:TFormActivityInfo;
begin
  f:=TFormActivityInfo.Create(self);
  f.editInfoIdx:=0;
  f.setControlStatus('ADD');
  f.ShowModal;
  //self.loadActivityData;
  f.Destroy;
end;

procedure TFormActivityManager.RzButtonCloseClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormActivityManager.RzButtonDelClick(Sender: TObject);
var
  res:integer;
  u,sql:string;
begin
  if (self.RzTreeViewList.Selected=nil) or (self.RzTreeViewList.Selected.Parent=nil) then begin
    MessageBox(self.Handle,'请选择你要删除的活动条目！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  u:=self.RzTreeViewList.Selected.Text;
  res := MessageBox(self.Handle, PWideChar('是否确定要删除活动条目：'+u), '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    sql := Format('DELETE FROM activity WHERE id=%d',[RzTreeViewList.Selected.ImageIndex]);
    execMySql(sql,LibHandle);
    //self.loadActivityData;
    self.RzTreeViewList.Selected.Delete;
  end;
end;

procedure TFormActivityManager.RzButtonEditClick(Sender: TObject);
var
  f:TFormActivityInfo;
begin
  if (self.RzTreeViewList.Selected=nil) or (self.RzTreeViewList.Selected.Parent=nil) then begin
    MessageBox(self.Handle,'请选择你要编辑的活动条目！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  f:=TFormActivityInfo.Create(self);
  f.editInfoIdx:=self.RzTreeViewList.Selected.ImageIndex;
  f.setControlStatus('EDIT');
  f.ShowModal;
  //loadActivityData;
  f.Destroy;
end;

procedure TFormActivityManager.RzTreeViewListChange(Sender: TObject; Node:
    TTreeNode);
var
  idx:integer;
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  if self.RzTreeViewList.Selected.Parent=nil then begin
    self.RzLabelTitle.Caption:='';
    self.RzLabelStartTime.Caption:='';
    self.RzLabelEndTime.Caption:='';
    self.RzRichEditContent.Lines.Clear;
  end else begin
    self.RzRichEditContent.Lines.Clear;
    idx:=self.RzTreeViewList.Selected.ImageIndex;
    sql := Format('SELECT starttime,endtime,title,content FROM activity WHERE id=%d',[idx]);
    queryMySql(sql,LibHandle, mySQL_Res);
    if mySQL_Res<>nil then begin
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        self.RzLabelStartTime.Caption:=getUTF8String(MYSQL_ROW^[0]);
        self.RzLabelEndTime.Caption:=getUTF8String(MYSQL_ROW^[1]);
        self.RzLabelTitle.Caption:=inttostr(idx)+'：'+getUTF8String(MYSQL_ROW^[2]);
        self.RzRichEditContent.Lines.Add(getUTF8String(MYSQL_ROW^[3]));
      end;
    end;
  end;
end;

procedure TFormActivityManager.RzTreeViewListDblClick(Sender: TObject);
begin
  if self.RzTreeViewList.Selected.Parent<>nil then begin
    self.RzButtonEditClick(self);
  end;
end;

end.
