unit fmActivityInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzEdit, Mask, RzButton, ExtCtrls, RzPanel, StdCtrls, ComCtrls,
  RzLabel, pngimage, mysql;

type
  TFormActivityInfo = class(TForm)
    Image1: TImage;
    RzLabel3: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel5: TRzLabel;
    RzRichEditContent: TRzRichEdit;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    RzEditTitle: TRzEdit;
    RzDateTimeEditStart: TRzDateTimeEdit;
    RzDateTimeEditEnd: TRzDateTimeEdit;
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    cmdAction: string;
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadInfoItemData;
    { Private declarations }
  public
    editInfoIdx:Integer;
    procedure setControlStatus(action: string);
    { Public declarations }
  end;

var
  FormActivityInfo: TFormActivityInfo;

implementation

uses myfunction, dbfunction, fmActivityManager;

{$R *.dfm}

procedure TFormActivityInfo.FormActivate(Sender: TObject);
begin
  self.RzEditTitle.SetFocus;
end;

procedure TFormActivityInfo.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormActivityInfo.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  self.RzDateTimeEditStart.Date:=Date();
end;

procedure TFormActivityInfo.loadInfoItemData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  starttime,endtime: TDate;
  dfs: TFormatSettings;
begin
  sql := Format('SELECT starttime,endtime,title,content FROM activity WHERE id=%d',[self.editInfoIdx]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      dfs.ShortDateFormat := 'yyyy-MM-dd';
      dfs.DateSeparator := '-';
      starttime:=StrToDate(getUTF8String(MYSQL_ROW^[0]),dfs);
      endtime:=StrToDate(getUTF8String(MYSQL_ROW^[1]),dfs);
      self.RzDateTimeEditStart.Date:=starttime;
      self.RzDateTimeEditEnd.Date:=endtime;

      self.RzEditTitle.Text:=getUTF8String(MYSQL_ROW^[2]);
      self.RzRichEditContent.Lines.Add(getUTF8String(MYSQL_ROW^[3]));
    end;
  end;
end;

procedure TFormActivityInfo.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormActivityInfo.RzButtonOkClick(Sender: TObject);
var
  sql:string;
  f:TFormActivityManager;
  n0,n1,n2,n:TTreeNode;
  newid:integer;
begin
  if length(trim(self.RzEditTitle.Text))=0 then begin
    MessageBox(self.Handle,'���������������ύ��','��ʾ',MB_OK or MB_ICONWARNING);
    self.RzEditTitle.SetFocus;
    exit;
  end;
  if length(trim(self.RzDateTimeEditStart.Text))=0 then begin
    MessageBox(self.Handle,'����ѡ����ʼ�������ύ��','��ʾ',MB_OK or MB_ICONWARNING);
    self.RzDateTimeEditStart.SetFocus;
    exit;
  end;
  if length(trim(self.RzDateTimeEditEnd.Text))=0 then begin
    MessageBox(self.Handle,'����ѡ�������������ύ��','��ʾ',MB_OK or MB_ICONWARNING);
    self.RzDateTimeEditEnd.SetFocus;
    exit;
  end;
  if self.RzDateTimeEditStart.Date>self.RzDateTimeEditEnd.Date then begin
    MessageBox(self.Handle,'���ʼ���ڲ��ܴ��ڻ�������ڣ�','��ʾ',MB_OK or MB_ICONWARNING);
    self.RzDateTimeEditEnd.SetFocus;
    exit;
  end;
  if self.RzRichEditContent.Lines.Count=0 then begin
    MessageBox(self.Handle,'���������������ύ��','��ʾ',MB_OK or MB_ICONWARNING);
    self.RzRichEditContent.SetFocus;
    exit;
  end;

  if cmdAction='ADD' then begin
    sql := Format('INSERT INTO activity SET starttime="%s",endtime="%s",title="%s",content="%s"',
      [ self.RzDateTimeEditStart.Text,
        self.RzDateTimeEditEnd.Text,
        self.RzEditTitle.Text,
        self.RzRichEditContent.Lines.GetText
      ]);
  end else if cmdAction='EDIT' then begin
    sql := Format('UPDATE activity SET starttime="%s",endtime="%s",title="%s",content="%s" WHERE id=%d',
      [ self.RzDateTimeEditStart.Text,
        self.RzDateTimeEditEnd.Text,
        self.RzEditTitle.Text,
        self.RzRichEditContent.Lines.GetText,
        self.editInfoIdx
      ]);
  end;
  //showmessage(sql);
  execMySql(sql,LibHandle);


  f:=TFormActivityManager(self.Owner);
  n0:=f.RzTreeViewList.Items.Item[0];
  n1:=n0.getNextSibling;
  n2:=n1.getNextSibling;
  if cmdAction='ADD' then begin

    newid:=mysql_insert_id(LibHandle);

    if(self.RzDateTimeEditEnd.Date<Date())then begin         //����
      n:=f.RzTreeViewList.Items.AddChild(n0,trim(self.RzEditTitle.Text));
      n.ImageIndex:=newid;
    end else if(self.RzDateTimeEditStart.Date>Date())then begin      //δ��Ч
      n:=f.RzTreeViewList.Items.AddChild(n2,trim(self.RzEditTitle.Text));
      n.ImageIndex:=newid;
    end else begin                                    //��ǰ
      n:=f.RzTreeViewList.Items.AddChild(n1,trim(self.RzEditTitle.Text));
      n.ImageIndex:=newid;
    end;
    f.RzTreeViewList.Selected:=n;
    f.RzTreeViewListChange(f.RzTreeViewList,n);
  end else if cmdAction='EDIT' then begin
    f.RzTreeViewList.Selected.Delete;
    if(self.RzDateTimeEditEnd.Date<Date())then begin         //����
      n:=f.RzTreeViewList.Items.AddChild(n0,trim(self.RzEditTitle.Text));
      n.ImageIndex:=self.editInfoIdx;
    end else if(self.RzDateTimeEditStart.Date>Date())then begin      //δ��Ч
      n:=f.RzTreeViewList.Items.AddChild(n2,trim(self.RzEditTitle.Text));
      n.ImageIndex:=self.editInfoIdx;
    end else begin                                    //��ǰ
      n:=f.RzTreeViewList.Items.AddChild(n1,trim(self.RzEditTitle.Text));
      n.ImageIndex:=self.editInfoIdx;
    end;
    f.RzTreeViewList.Selected:=n;
    f.RzTreeViewListChange(f.RzTreeViewList,n);
  end;

  self.Close;
end;

procedure TFormActivityInfo.setControlStatus(action: string);
begin
  self.cmdAction:=action;
  if action='ADD' then begin
    self.Caption:='��ӻ';
    self.RzButtonOk.Caption:='���';
  end else if action='EDIT' then begin
    self.Caption:='�༭�';
    self.RzButtonOk.Caption:='�༭';
    loadInfoItemData;
  end;
end;

end.
