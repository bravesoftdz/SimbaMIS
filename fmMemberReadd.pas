unit fmMemberReadd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, RzLabel, RzPanel, pngimage, ExtCtrls,
  RzButton, mysql;

type
  TFormMemberReadd = class(TForm)
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    Image1: TImage;
    RzGroupBox2: TRzGroupBox;
    RzLabel4: TRzLabel;
    RzEditCardOldNo: TRzEdit;
    RzEditCardNewNo: TRzEdit;
    RzLabel1: TRzLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; cno: string); reintroduce;
        overload;
    { Public declarations }
  end;

var
  FormMemberReadd: TFormMemberReadd;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

constructor TFormMemberReadd.Create(AOwner: TComponent; cno: string);
begin
  inherited Create(AOwner);
  self.RzEditCardOldNo.Text:=cno;
end;

procedure TFormMemberReadd.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
end;

procedure TFormMemberReadd.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormMemberReadd.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormMemberReadd.RzButtonOkClick(Sender: TObject);
var
  sql:string;
begin
  if length(trim(self.RzEditCardNewNo.Text))=0 then begin
    MessageBox(self.Handle,'请先输入新的会员卡号再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditCardNewNo.SetFocus;
    exit;
  end;

  sql := Format('UPDATE members SET cardno="%s",cardstatus=0 where cardno="%s"',[ trim(self.RzEditCardNewNo.Text),trim(self.RzEditCardOldNo.Text)]);
  execMySql(sql,LibHandle);
  sql := Format('UPDATE memberdetail SET cardno="%s" where cardno="%s"',[ trim(self.RzEditCardNewNo.Text),trim(self.RzEditCardOldNo.Text)]);
  execMySql(sql,LibHandle);
  self.Close;
end;

end.
