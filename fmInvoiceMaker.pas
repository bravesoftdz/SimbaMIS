unit fmInvoiceMaker;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzPanel, StdCtrls, Mask, RzEdit, RzRadGrp, RzLabel,
  ExtCtrls, pngimage, mysql;

type
  TFormInvoiceMaker = class(TForm)
    Image1: TImage;
    RzGroupBoxNow: TRzGroupBox;
    RzLabel4: TRzLabel;
    RzRadioGroupInvoiceType: TRzRadioGroup;
    RzLabel1: TRzLabel;
    RzNumericEditTotal: TRzNumericEdit;
    RzGroupBoxLater: TRzGroupBox;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    RzLabel5: TRzLabel;
    RzNumericEditNewInvoiceValue: TRzNumericEdit;
    RzLabel2: TRzLabel;
    RzNumericEditCanUse: TRzNumericEdit;
    RzLabelAlreadyTotal: TRzLabel;
    RzRadioGroupMain: TRzRadioGroup;
    RzLabel3: TRzLabel;
    RzEditInvoiceName: TRzEdit;
    RzEditInvoiceTel: TRzEdit;
    RzLabel6: TRzLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
    procedure RzRadioGroupMainClick(Sender: TObject);
  private
    invoiceType:integer;
    payIdx:integer;
    paySum:integer;
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadInvoiceItemInfo;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; invoiceType, payidx: integer);
        reintroduce; overload;
    { Public declarations }
  end;

var
  FormInvoiceMaker: TFormInvoiceMaker;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

constructor TFormInvoiceMaker.Create(AOwner: TComponent; invoiceType, payidx:
    integer);
begin
  inherited Create(AOwner);
  self.invoiceType:=invoiceType;
  self.payIdx:=payidx;
end;

procedure TFormInvoiceMaker.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormInvoiceMaker.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  self.loadInvoiceItemInfo;
end;

procedure TFormInvoiceMaker.loadInvoiceItemInfo;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  self.RzRadioGroupMain.ItemIndex:=0;
  self.RzRadioGroupInvoiceType.ItemIndex:=self.invoiceType;

  //��������ܶ��Ʊ���
  if self.invoiceType=0 then
    sql := Format('SELECT paysum,invoicetotal FROM payitems WHERE id=%d',[self.payIdx])
  else
    sql := Format('SELECT paysum,invoicetotal FROM memberdetail WHERE id=%d',[self.payIdx]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      paySum:=strtoint(getUTF8String(MYSQL_ROW^[0]));
      self.RzNumericEditTotal.IntValue:=paySum;
      self.RzLabelAlreadyTotal.Caption:=' �ѿ�Ʊ��'+getUTF8String(MYSQL_ROW^[1]);
      self.RzNumericEditCanUse.IntValue:=paySum-strtoint(getUTF8String(MYSQL_ROW^[1]));
    end;
  end;
end;

procedure TFormInvoiceMaker.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormInvoiceMaker.RzButtonOkClick(Sender: TObject);
var
  sql:string;
  res:integer;
begin
  if self.RzRadioGroupMain.ItemIndex=1 then begin
    if self.RzNumericEditNewInvoiceValue.IntValue=0 then begin
      MessageBox(self.Handle,'��Ʊ����Ϊ0��','��ʾ',MB_OK or MB_ICONWARNING);
      self.RzNumericEditNewInvoiceValue.SetFocus;
      exit;
    end;
    if self.RzNumericEditNewInvoiceValue.IntValue>self.RzNumericEditCanUse.IntValue then begin
      res := MessageBox(self.Handle, '��Ʊ�����ڿ��ö�ȣ�ȷ��Ҫ������Ʊ��', '��ʾ', MB_YESNO or MB_ICONWARNING);
      if res = IDNO then begin
        self.RzNumericEditNewInvoiceValue.SetFocus;
        exit;
      end;
    end;
    //���뷢Ʊ��¼
    sql := Format('INSERT INTO invoices set invoicetype=%d,payidx=%d,invoicesum=%d,loginname="%s"',
      [ self.invoiceType,
        self.payIdx,
        self.RzNumericEditNewInvoiceValue.IntValue,
        LOGINNAME
        ]);
    execMySql(sql,LibHandle);
    //�޸Ľ��˼�¼����ط�Ʊ�ֶ�
    if self.invoiceType=0 then
      sql := Format('UPDATE payitems set invoicestatus=1,invoicetotal=invoicetotal+%d  WHERE id=%d',[RzNumericEditNewInvoiceValue.IntValue,self.payIdx])
    else
      sql := Format('UPDATE memberdetail set invoicestatus=1,invoicetotal=invoicetotal+%d WHERE id=%d',[RzNumericEditNewInvoiceValue.IntValue,self.payIdx]);
    execMySql(sql,LibHandle);
  end else if self.RzRadioGroupMain.ItemIndex=2 then begin
    //д����˼�¼�ķ�Ʊ��ϵ����Ϣ
    if (length(trim(RzEditInvoiceName.Text))>0) or (length(trim(RzEditInvoiceTel.Text))>0) then begin
      if self.invoiceType=0 then
        sql := Format('UPDATE payitems set invoicestatus=2,invoicename="%s",invoicetel="%s"  WHERE id=%d',[trim(RzEditInvoiceName.Text),trim(RzEditInvoiceTel.Text),self.payIdx])
      else
        sql := Format('UPDATE memberdetail set invoicestatus=2,invoicename="%s",invoicetel="%s" WHERE id=%d',[trim(RzEditInvoiceName.Text),trim(RzEditInvoiceTel.Text),self.payIdx]);
    end;
    execMySql(sql,LibHandle);
  end;
  self.Close;
end;

procedure TFormInvoiceMaker.RzRadioGroupMainClick(Sender: TObject);
begin
  if RzRadioGroupMain.ItemIndex=0 then begin
    self.RzGroupBoxNow.Enabled:=false;
    self.RzGroupBoxLater.Enabled:=false;
  end else if RzRadioGroupMain.ItemIndex=1 then begin
    self.RzGroupBoxNow.Enabled:=true;
    self.RzGroupBoxLater.Enabled:=false;
  end else if RzRadioGroupMain.ItemIndex=2 then begin
    self.RzGroupBoxNow.Enabled:=false;
    self.RzGroupBoxLater.Enabled:=true;
  end;

end;

end.
