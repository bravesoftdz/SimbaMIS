unit fmOrderInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzEdit, StdCtrls, Mask, RzCmboBx, RzButton, ExtCtrls, RzPanel,
  RzLabel, pngimage, ComCtrls, RzDTP, mysql;

type
  TFormOrderInfo = class(TForm)
    Image1: TImage;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel3: TRzLabel;
    RzPanel1: TRzPanel;
    RzButtonCancel: TRzButton;
    RzComboBoxTable: TRzComboBox;
    RzEditName: TRzEdit;
    RzEditTel: TRzEdit;
    RzNumericEditUsers: TRzNumericEdit;
    RzLabel5: TRzLabel;
    RzDateTimeEditDate: TRzDateTimeEdit;
    RzButtonOk: TRzButton;
    RzDateTimeEditTime: TRzDateTimeEdit;
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadTablesNameData;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; tablename: string); reintroduce;
        overload;
    { Public declarations }
  end;

var
  FormOrderInfo: TFormOrderInfo;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

constructor TFormOrderInfo.Create(AOwner: TComponent; tablename: string);
begin
  inherited Create(AOwner);
  self.RzComboBoxTable.Text:=tablename;
end;

procedure TFormOrderInfo.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormOrderInfo.FormActivate(Sender: TObject);
begin
  self.RzComboBoxTable.SetFocus;
end;

procedure TFormOrderInfo.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  self.RzDateTimeEditDate.Date:=Date();
  loadTablesNameData;
end;

procedure TFormOrderInfo.loadTablesNameData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  sql := 'select tablename from tables order by tablename ';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        self.RzComboBoxTable.Add(getUTF8String(MYSQL_ROW^[0]));
      end;
    until MYSQL_ROW=nil;
  end;
end;

procedure TFormOrderInfo.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormOrderInfo.RzButtonOkClick(Sender: TObject);
var
  sql:string;
  table,name,tel,time:string;
  users:integer;
begin
  if length(trim(self.RzComboBoxTable.Text))=0 then begin
    MessageBox(self.Handle,'请先输入选择台号再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxTable.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditName.Text))=0 then begin
    MessageBox(self.Handle,'请先输入预订人姓名再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditName.SetFocus;
    exit;
  end;

  table:=self.RzComboBoxTable.Text;
  name:=trim(self.RzEditName.Text);
  tel:=trim(self.RzEditTel.Text);
  time:=self.RzDateTimeEditDate.Text+' '+self.RzDateTimeEditTime.Text;
  users:=self.RzNumericEditUsers.IntValue;

  sql := Format('INSERT INTO orders SET ordertablename="%s",ordername="%s",ordertel="%s",orderusers=%d,ordertime="%s"',
      [ table,name,tel,users,time ]);
  execMySql(sql,LibHandle);

  self.Close;
end;

end.
