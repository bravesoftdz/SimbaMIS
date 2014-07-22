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
    MessageBox(self.Handle,'������ɵĵ�¼�������ύ��','��ʾ',MB_OK or MB_ICONWARNING);
    self.RzEditOldPass.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditNewPass.Text))=0 then begin
    MessageBox(self.Handle,'�������µĵ�¼�������ύ��','��ʾ',MB_OK or MB_ICONWARNING);
    self.RzEditNewPass.SetFocus;
    exit;
  end;
  if trim(self.RzEditNewPass.Text)<>trim(self.RzEditConfimPass.Text) then begin
    MessageBox(self.Handle,'�µĵ�¼��������֤���벻һ�£�','��ʾ',MB_OK or MB_ICONWARNING);
    self.RzEditConfimPass.SetFocus;
    exit;
  end;

  sql := Format('SELECT loginpass FROM users WHERE loginname="%s"',[self.editUsername]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      if getMyStr(MYSQL_ROW^[0])<>trim(self.RzEditOldPass.Text) then begin
        MessageBox(self.Handle,PWideChar('������ľ����벻��ȷ�����������룡'),'��ʾ',MB_OK or MB_ICONWARNING);
        self.RzEditOldPass.SetFocus;
      end else begin
        sql := Format('update users set loginpass="%s" WHERE loginname="%s"',[trim(self.RzEditNewPass.Text),self.editUsername]);
        queryMySql(sql,LibHandle, mySQL_Res);
        MessageBox(self.Handle,PWideChar('��ĵ�¼�������޸ģ����μǣ�'),'��ʾ',MB_OK or MB_ICONWARNING);
        self.Close;
      end;
    end else begin
      MessageBox(self.Handle,PWideChar('�û�'+self.editUsername+'�������ڣ�'),'��ʾ',MB_OK or MB_ICONWARNING);
    end;
  end;

end;

procedure TFormEditPass.setEditUserName(name: string);
begin
  self.editUsername:=name;
end;

end.
