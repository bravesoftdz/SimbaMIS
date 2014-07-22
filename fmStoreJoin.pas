unit fmStoreJoin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ExtCtrls, RzPanel, StdCtrls, RzEdit, RzCmboBx, pngimage,
  Mask, RzLabel, mysql;

type
  TFormStoreJoin = class(TForm)
    RzLabel8: TRzLabel;
    RzEditBrands: TRzEdit;
    Image1: TImage;
    RzComboBoxStoreType: TRzComboBox;
    RzLabel1: TRzLabel;
    RzComboBoxStoreName: TRzComboBox;
    RzLabel2: TRzLabel;
    RzNumericEditNum: TRzNumericEdit;
    RzLabel4: TRzLabel;
    RzNumericEditPrice: TRzNumericEdit;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzDateTimeDate: TRzDateTimeEdit;
    RzLabel7: TRzLabel;
    RzMemoStoreDesc: TRzMemo;
    RzLabel9: TRzLabel;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    RzURLLabel1: TRzURLLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
    procedure RzComboBoxStoreTypeChange(Sender: TObject);
    procedure RzURLLabel1Click(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadStoreType;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormStoreJoin: TFormStoreJoin;

implementation

uses myfunction, dbfunction, fmStoreItemManager;

{$R *.dfm}

procedure TFormStoreJoin.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormStoreJoin.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  loadStoreType;
end;

procedure TFormStoreJoin.loadStoreType;
var
  l:TStringList;
  i:integer;
begin
  l:=TStringList.Create;
  getSectionList('STORETYPE',l);
  for i := 0 to l.Count - 1 do begin
    self.RzComboBoxStoreType.AddItemValue(GetStringFromINI('STORETYPE',l[i],'1'), l[i]);
  end;
  l.Free;
end;

procedure TFormStoreJoin.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormStoreJoin.RzButtonOkClick(Sender: TObject);
var
  sql:string;
begin
  if self.RzComboBoxStoreType.Value='' then begin
    MessageBox(self.Handle,'请先选择库存类型再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxStoreType.SetFocus;
    exit;
  end;
  if self.RzComboBoxStoreName.Value='' then begin
    MessageBox(self.Handle,'请先选择商品名称再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxStoreName.SetFocus;
    exit;
  end;
  if self.RzNumericEditNum.Value=0 then begin
    MessageBox(self.Handle,'请先输入入库数量再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzNumericEditNum.SetFocus;
    exit;
  end;
  if self.RzNumericEditPrice.Value=0 then begin
    MessageBox(self.Handle,'请先输入入库单价再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzNumericEditPrice.SetFocus;
    exit;
  end;

  sql := Format('INSERT INTO storeitems(storetypeidx,storeid,joinnums,overnums,joinprice,joinbrands,joinqualitydate,storedesc,loginname) values(%s,%s,%2.2f,%2.2f,%2.2f,"%s","%s","%s","%s")',
      [ self.RzComboBoxStoreType.Value,
        self.RzComboBoxStoreName.Value,
        self.RzNumericEditNum.Value,
        self.RzNumericEditNum.Value,
        self.RzNumericEditPrice.Value,
        trim(self.RzEditBrands.Text),
        self.RzDateTimeDate.Text,
        trim(self.RzMemoStoreDesc.Text),
        LOGINNAME
      ]);
  execMySql(sql,LibHandle);
  self.Close;
end;

procedure TFormStoreJoin.RzComboBoxStoreTypeChange(Sender: TObject);
var
  sql,tit: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  RzComboBoxStoreName.Items.BeginUpdate;
  RzComboBoxStoreName.Clear;

  sql := 'SELECT id,storename,storeunit FROM stores where storetypeidx='+self.RzComboBoxStoreType.Value;
  sql:=sql+' order by id';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        tit:=getUTF8String(MYSQL_ROW^[1]);
        tit:=tit+'('+getUTF8String(MYSQL_ROW^[2])+')';
        self.RzComboBoxStoreName.AddItemValue(tit,getUTF8String(MYSQL_ROW^[0]));
      end;
    until MYSQL_ROW=nil;
  end;
  RzComboBoxStoreName.Items.EndUpdate;
end;

procedure TFormStoreJoin.RzURLLabel1Click(Sender: TObject);
var
  f:TFormStoreItemManager;
begin
  f:=TFormStoreItemManager.Create(self);
  f.ShowModal;
  if self.RzComboBoxStoreType.Value<>'' then
    self.RzComboBoxStoreTypeChange(nil);
  f.Destroy;
end;

end.
