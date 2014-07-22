unit fmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, RzLabel, RzButton, RzPanel, ExtCtrls,
  pngimage, mysql;

type
  TFormLogin = class(TForm)
    Image1: TImage;
    RzGroupBox1: TRzGroupBox;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    RzLabel3: TRzLabel;
    RzEditUser: TRzEdit;
    RzEditPass: TRzEdit;
    RzLabel1: TRzLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    logined:boolean;
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLogin: TFormLogin;

implementation

uses myfunction, dbfunction, fmMain;

{$R *.dfm}

procedure TFormLogin.FormActivate(Sender: TObject);
begin
  self.RzGroupBox1.SetFocus;
  self.RzEditUser.SetFocus;
end;

procedure TFormLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not logined then
    Application.Terminate;
end;

procedure TFormLogin.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormLogin.FormCreate(Sender: TObject);
begin
  self.logined:=false;
  connectMySql(LibHandle);
  self.Caption:='登录'+GetStringFromINI('PUBLIC','misTitle','辛巴西餐咖啡厅')+'管理系统';
end;

procedure TFormLogin.FormShow(Sender: TObject);
begin
  self.RzEditUser.SetFocus;
end;

procedure TFormLogin.RzButtonCancelClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormLogin.RzButtonOkClick(Sender: TObject);
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  if length(trim(self.RzEditUser.Text))=0 then begin
    MessageBox(self.Handle,'请输入登录用户名','提示',MB_OK or MB_ICONWARNING);
    self.RzEditUser.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditPass.Text))=0 then begin
    MessageBox(self.Handle,'请输入登录密码','提示',MB_OK or MB_ICONWARNING);
    self.RzEditPass.SetFocus;
    exit;
  end;

  sql := Format('SELECT loginpass,username,access FROM users WHERE loginname="%s"',[trim(self.RzEditUser.Text)]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    if mysql_num_rows(mySQL_Res)>0 then begin
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        if getMyStr(MYSQL_ROW^[0])<>trim(self.RzEditPass.Text) then begin
          MessageBox(self.Handle,PWideChar('你输入的密码不正确，请重新输入！'),'提示',MB_OK or MB_ICONWARNING);
          self.RzEditPass.SetFocus;
        end else begin
          LOGINNAME:=trim(self.RzEditUser.Text);
          USERNAME:=getMyStr(MYSQL_ROW^[1]);
          ACCESS:=strtoint(getMyStr(MYSQL_ROW^[2]));
          FormMain.isLogined:=true;
          FormMain.setButtonEnableWithAccess(ACCESS);
          FormMain.RzStatusPaneUserName.Caption:='当前用户：'+USERNAME;
          self.logined:=true;
          self.close;
        end;
      end;
    end else begin
      MessageBox(self.Handle,PWideChar('你输入的用户'+trim(self.RzEditUser.Text)+'并不存在！'),'提示',MB_OK or MB_ICONWARNING);
    end;
  end;
end;

end.
