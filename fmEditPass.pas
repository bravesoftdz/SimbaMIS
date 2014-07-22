unit fmEditPass;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzBckgnd, StdCtrls, Mask, RzEdit, RzLabel, pngimage,
  ExtCtrls, mysql, RzPanel;

type
  TFormEditPass = class(TForm)
    Image1: TImage;
    RzLabel6: TRzLabel;
    RzEditOldPass: TRzEdit;
    RzLabel1: TRzLabel;
    RzEditNewPass: TRzEdit;
    RzLabel2: TRzLabel;
    RzEditConfimPass: TRzEdit;
    RzSeparator1: TRzSeparator;
    RzLabel13: TRzLabel;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    editUsername:string;
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    { Private declarations }
  public
    procedure setEditUserName(name: string);
    { Public declarations }
  end;

var
  FormEditPass: TFormEditPass;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

procedure TFormEditPass.FormActivate(Sender: TObject);
begin
  self.RzEditOldPass.SetFocus;
end;

procedure TFormEditPass.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormEditPass.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
end;

procedure TFormEditPass.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormEditPass.RzButtonOkClick(Sender: TObject);
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  if length(trim(self.RzEditOldPass.Text))=0 then begin
    MessageBox(self.Handle,'请输入旧的登录密码再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditOldPass.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditNewPass.Text))=0 then begin
    MessageBox(self.Handle,'请输入新的登录密码再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditNewPass.SetFocus;
    exit;
  end;
  if trim(self.RzEditNewPass.Text)<>trim(self.RzEditConfimPass.Text) then begin
    MessageBox(self.Handle,'新的登录密码与验证密码不一致！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditConfimPass.SetFocus;
    exit;
  end;

  sql := Format('SELECT loginpass FROM users WHERE loginname="%s"',[self.editUsername]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      if getMyStr(MYSQL_ROW^[0])<>trim(self.RzEditOldPass.Text) then begin
        MessageBox(self.Handle,PWideChar('你输入的旧密码不正确，请重新输入！'),'提示',MB_OK or MB_ICONWARNING);
        self.RzEditOldPass.SetFocus;
      end else begin
        sql := Format('update users set loginpass="%s" WHERE loginname="%s"',[trim(self.RzEditNewPass.Text),self.editUsername]);
        queryMySql(sql,LibHandle, mySQL_Res);
        MessageBox(self.Handle,PWideChar('你的登录密码已修改，请牢记！'),'提示',MB_OK or MB_ICONWARNING);
        self.Close;
      end;
    end else begin
      MessageBox(self.Handle,PWideChar('用户'+self.editUsername+'并不存在！'),'提示',MB_OK or MB_ICONWARNING);
    end;
  end;

end;

procedure TFormEditPass.setEditUserName(name: string);
begin
  self.editUsername:=name;
end;

end.
