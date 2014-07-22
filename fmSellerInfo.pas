unit fmSellerInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, RzButton, RzPanel, RzLabel, ExtCtrls,
  pngimage, mysql;

type
  TFormSellerInfo = class(TForm)
    Image1: TImage;
    RzGroupBox1: TRzGroupBox;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    RzEditName: TRzEdit;
    RzEditTel: TRzEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSellerInfo: TFormSellerInfo;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

procedure TFormSellerInfo.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
end;

procedure TFormSellerInfo.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormSellerInfo.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormSellerInfo.RzButtonOkClick(Sender: TObject);
var
  sql:string;
begin
  if length(trim(self.RzEditName.Text))=0 then begin
    MessageBox(self.Handle,'请先输入供应商名字再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditName.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditTel.Text))=0 then begin
    MessageBox(self.Handle,'请先输入供应商联系电话再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditTel.SetFocus;
    exit;
  end;

  sql := Format('INSERT INTO seller(sellername,sellertel,loginname) values("%s","%s","%s")',
    [ self.RzEditName.Text,
      self.RzEditTel.Text,
      LOGINNAME
    ]);
  execMySql(sql,LibHandle);
  self.Close;
end;

end.
