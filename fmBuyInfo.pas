unit fmBuyInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzPanel, StdCtrls, Mask, RzEdit, RzCmboBx, RzLabel,
  ExtCtrls, pngimage, mysql;

type
  TFormBuyInfo = class(TForm)
    Image1: TImage;
    RzGroupBox1: TRzGroupBox;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzComboBoxBuyType: TRzComboBox;
    RzNumericEditTotal: TRzNumericEdit;
    RzComboBoxPay: TRzComboBox;
    RzComboBoxSellerList: TRzComboBox;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    RzURLLabel1: TRzURLLabel;
    RzLabel5: TRzLabel;
    RzNumericEditPrice: TRzNumericEdit;
    RzLabel6: TRzLabel;
    RzNumericEditNums: TRzNumericEdit;
    RzLabel8: TRzLabel;
    RzEditDesc: TRzEdit;
    RzLabel7: TRzLabel;
    RzComboBoxForWhere: TRzComboBox;
    RzLabel9: TRzLabel;
    RzComboBoxForWho: TRzComboBox;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
    procedure RzComboBoxForWhereChange(Sender: TObject);
    procedure RzNumericEditPriceChange(Sender: TObject);
    procedure RzURLLabel1Click(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure initBuyType;
    procedure initForWhereList;
    procedure initSellerList;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBuyInfo: TFormBuyInfo;

implementation

uses myfunction, dbfunction, fmSellerInfo;

{$R *.dfm}

procedure TFormBuyInfo.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormBuyInfo.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);

  initBuyType;
  initSellerList;
  initForWhereList;
end;

procedure TFormBuyInfo.initBuyType;
var
  accList:TStringList;
  i: Integer;
  t:string;
begin
  accList:=TStringList.Create;
  getSectionList('BUYTYPE', accList);
  for i := 0 to accList.Count - 1 do begin
    t:=GetStringFromINI('BUYTYPE',accList[i],'水果');
    self.RzComboBoxBuyType.AddItemValue(t,accList[i]);
  end;
  if accList.Count>0 then
    self.RzComboBoxBuyType.ItemIndex:=0;
  accList.Free;
end;

procedure TFormBuyInfo.initForWhereList;
var
  forList:TStringList;
  i: Integer;
  t:string;
begin
  forList:=TStringList.Create;
  getSectionList('ACCESSTYPE', forList);
  for i := 0 to forList.Count - 1 do begin
    t:=GetStringFromINI('ACCESSTYPE',forList[i],'前厅');
    self.RzComboBoxForWhere.AddItemValue(t,forList[i]);
  end;
  //if forList.Count>0 then
  //  self.RzComboBoxForWhere.ItemIndex:=0;
  forList.Free;
end;

procedure TFormBuyInfo.initSellerList;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  self.RzComboBoxSellerList.Clear;
  sql:='SELECT id,sellername from seller where sellerstatus=0';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        self.RzComboBoxSellerList.AddItemValue(getUTF8String(MYSQL_ROW^[1]),getUTF8String(MYSQL_ROW^[0]));
      end;
    until MYSQL_ROW=nil;
  end;
end;

procedure TFormBuyInfo.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormBuyInfo.RzButtonOkClick(Sender: TObject);
var
  sql:string;
begin
  if self.RzComboBoxBuyType.Value='' then begin
    MessageBox(self.Handle,'请先选择采品种类再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxBuyType.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditDesc.Text))=0 then begin
    MessageBox(self.Handle,'请先输入采品描述再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditDesc.SetFocus;
    exit;
  end;
  if self.RzNumericEditPrice.Value=0 then begin
    MessageBox(self.Handle,'请先输入采品单价再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzNumericEditPrice.SetFocus;
    exit;
  end;
  if self.RzNumericEditNums.Value=0 then begin
    MessageBox(self.Handle,'请先输入采品数量再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzNumericEditNums.SetFocus;
    exit;
  end;
  if self.RzComboBoxSellerList.Value='' then begin
    MessageBox(self.Handle,'请先选择供应商再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxSellerList.SetFocus;
    exit;
  end;
  if self.RzComboBoxForWhere.Value='' then begin
    MessageBox(self.Handle,'请先选择领用部门再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxForWhere.SetFocus;
    exit;
  end;
  if self.RzComboBoxForWho.Value='' then begin
    MessageBox(self.Handle,'请先选择领用人再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxForWho.SetFocus;
    exit;
  end;

  sql := Format('INSERT INTO purchase(buytype,buydesc,buyprice,buynums,buypaysum,buyselleridx,forwhere,forwho,paystatus,addloginname) values(%s,"%s",%f,%f,%f,%s,%s,%s,%s,"%s")',
    [ self.RzComboBoxBuyType.Value,
      trim(self.RzEditDesc.Text),
      self.RzNumericEditPrice.Value,
      self.RzNumericEditNums.Value,
      self.RzNumericEditTotal.Value,
      self.RzComboBoxSellerList.Value,
      self.RzComboBoxForWhere.Value,
      self.RzComboBoxForWho.Value,
      self.RzComboBoxPay.Value,
      LOGINNAME
    ]);
  execMySql(sql,LibHandle);
  self.Close;
end;

procedure TFormBuyInfo.RzComboBoxForWhereChange(Sender: TObject);
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  self.RzComboBoxForWho.Values.Clear;
  self.RzComboBoxForWho.Items.Clear;
  sql := 'SELECT username,id FROM users WHERE access='+self.RzComboBoxForWhere.Value;
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        self.RzComboBoxForWho.AddItemValue(getUTF8String(MYSQL_ROW^[0]),getUTF8String(MYSQL_ROW^[1]));
      end;
    until MYSQL_ROW=nil;
  end;
end;

procedure TFormBuyInfo.RzNumericEditPriceChange(Sender: TObject);
begin
  self.RzNumericEditTotal.Value:=self.RzNumericEditPrice.Value * self.RzNumericEditNums.Value;
end;

procedure TFormBuyInfo.RzURLLabel1Click(Sender: TObject);
var
  f:TFormSellerInfo;
begin
  f:=TFormSellerInfo.Create(self);
  f.ShowModal;
  f.Destroy;
  self.initSellerList;
end;

end.
