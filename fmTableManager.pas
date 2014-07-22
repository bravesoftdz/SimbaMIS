unit fmTableManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, RzButton, ComCtrls, RzListVw, mysql;

type
  TFormTableManager = class(TForm)
    RzListViewTableList: TRzListView;
    RzButtonEdit: TRzButton;
    RzButtonDel: TRzButton;
    RzButtonAdd: TRzButton;
    RzButtonClose: TRzButton;
    ImageListMainToolbar: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButtonAddClick(Sender: TObject);
    procedure RzButtonCloseClick(Sender: TObject);
    procedure RzButtonDelClick(Sender: TObject);
    procedure RzButtonEditClick(Sender: TObject);
    procedure RzListViewTableListDblClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadTableData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTableManager: TFormTableManager;

implementation

uses myfunction, dbfunction, fmTableInfo;
{$R *.dfm}

procedure TFormTableManager.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  loadTableData();
end;

procedure TFormTableManager.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormTableManager.loadTableData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  tg: TListGroup;
  item: TListItem;
begin
  self.RzListViewTableList.Groups.Clear;
  self.RzListViewTableList.Items.Clear;
  //load group
  sql := 'select tabletype from tables group by tabletype';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        tg:=self.RzListViewTableList.Groups.Add;
        tg.GroupID:=strtoint(getMyStr(MYSQL_ROW^[0]));
        tg.Header:= getTableGroupTitle(strtoint(getMyStr(MYSQL_ROW^[0])));
      end;
    until MYSQL_ROW=nil;
  end;
  //load user
  sql := 'select tablename,tabletype from tables';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        item:=self.RzListViewTableList.Items.Add;
        item.ImageIndex:=0;
        item.GroupID:=strtoint(getMyStr(MYSQL_ROW^[1]));
        item.Caption:=getMyStr(MYSQL_ROW^[0]);
      end;
    until MYSQL_ROW=nil;
  end;
end;

procedure TFormTableManager.RzButtonAddClick(Sender: TObject);
var
  f:TFormTableInfo;
begin
  f:=TFormTableInfo.Create(self);
  f.editTableName:='';
  f.setControlStatus('ADD');
  f.ShowModal;
  loadTableData;
  f.Destroy;
end;

procedure TFormTableManager.RzButtonCloseClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormTableManager.RzButtonDelClick(Sender: TObject);
var
  res:integer;
  u,sql:string;
begin
  if self.RzListViewTableList.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要删除的台位！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;

  u:=self.RzListViewTableList.Items.Item[RzListViewTableList.ItemIndex].Caption;
  res := MessageBox(self.Handle, PWideChar('是否确定要删除台位'+u), '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    sql := Format('DELETE FROM tables WHERE tablename="%s"',[u]);
    execMySql(sql,LibHandle);
    self.loadTableData;
  end;
end;

procedure TFormTableManager.RzButtonEditClick(Sender: TObject);
var
  f:TFormTableInfo;
begin
  if self.RzListViewTableList.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要编辑的台位！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;

  f:=TFormTableInfo.Create(self);
  f.editTableName:=self.RzListViewTableList.Items.Item[RzListViewTableList.ItemIndex].Caption;
  f.setControlStatus('EDIT');
  f.ShowModal;
  loadTableData;
  f.Destroy;
end;

procedure TFormTableManager.RzListViewTableListDblClick(Sender: TObject);
begin
  self.RzButtonEditClick(self);
end;

end.
