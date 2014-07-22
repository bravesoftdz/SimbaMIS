unit fmUserManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzBckgnd, pngimage, ExtCtrls, ComCtrls, RzListVw, ImgList, RzButton,
  WideStrings, mysql;

type
  TFormUserManager = class(TForm)
    RzListViewUserList: TRzListView;
    ImageListMainToolbar: TImageList;
    RzButtonEdit: TRzButton;
    RzButtonDel: TRzButton;
    RzButtonAdd: TRzButton;
    RzButtonClose: TRzButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonAddClick(Sender: TObject);
    procedure RzButtonCloseClick(Sender: TObject);
    procedure RzButtonDelClick(Sender: TObject);
    procedure RzButtonEditClick(Sender: TObject);
    procedure RzListViewUserListDblClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadUserData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUserManager: TFormUserManager;

implementation

uses fmUserInfo, myfunction, dbfunction;
{$R *.dfm}

procedure TFormUserManager.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormUserManager.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  loadUserData();
end;

procedure TFormUserManager.loadUserData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  tg: TListGroup;
  item: TListItem;
begin
  self.RzListViewUserList.Groups.Clear;
  self.RzListViewUserList.Items.Clear;
  //load group
  sql := 'select access from users where delflag=0 group by access';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        tg:=self.RzListViewUserList.Groups.Add;
        tg.GroupID:=strtoint(getMyStr(MYSQL_ROW^[0]));
        tg.Header:= getUserGroupTitle(strtoint(getMyStr(MYSQL_ROW^[0])));
      end;
    until MYSQL_ROW=nil;
  end;
  //load user
  sql := 'select username,access from users where delflag=0';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        item:=self.RzListViewUserList.Items.Add;
        item.ImageIndex:=0;
        item.GroupID:=strtoint(getMyStr(MYSQL_ROW^[1]));
        item.Caption:=getMyStr(MYSQL_ROW^[0]);
      end;
    until MYSQL_ROW=nil;
  end;
end;

procedure TFormUserManager.RzButtonAddClick(Sender: TObject);
var
  f:TFormUserInfo;
begin
  f:=TFormUserInfo.Create(self);
  f.editUserName:='';
  f.setControlStatus('ADD');
  f.ShowModal;
  loadUserData;
  f.Destroy;
end;

procedure TFormUserManager.RzButtonCloseClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormUserManager.RzButtonDelClick(Sender: TObject);
var
  res:integer;
  u,sql:string;
begin
  if self.RzListViewUserList.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要删除的用户！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;

  u:=self.RzListViewUserList.Items.Item[RzListViewUserList.ItemIndex].Caption;
  res := MessageBox(self.Handle, PWideChar('是否确定要删除用户'+u), '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    sql := Format('UPDATE users SET delflag=1 WHERE username="%s"',[u]);
    execMySql(sql,LibHandle);
    self.loadUserData;
  end;
end;

procedure TFormUserManager.RzButtonEditClick(Sender: TObject);
var
  f:TFormUserInfo;
begin
  if self.RzListViewUserList.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要编辑的用户！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;

  f:=TFormUserInfo.Create(self);
  f.editUserName:=self.RzListViewUserList.Items.Item[RzListViewUserList.ItemIndex].Caption;
  f.setControlStatus('EDIT');
  f.ShowModal;
  loadUserData;
  f.Destroy;
end;

procedure TFormUserManager.RzListViewUserListDblClick(Sender: TObject);
begin
  self.RzButtonEditClick(self);
end;

end.
