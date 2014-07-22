unit fmInvoiceManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, RzPanel, RzRadGrp, pngimage, ExtCtrls, ComCtrls, RzListVw,
  RzButton, StdCtrls, RzLabel, mysql, Mask, RzEdit, RzTabs;

type
  TFormInvoiceManager = class(TForm)
    RzPanel1: TRzPanel;
    RzLabelRows: TRzLabel;
    RzButtonCancel: TRzButton;
    RzListView: TRzListView;
    RzPanel2: TRzPanel;
    Image1: TImage;
    RzRadioGroupInvoiceType: TRzRadioGroup;
    ImageList1: TImageList;
    RzLabelTotal: TRzLabel;
    RzPageControlKey: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    RzLabel1: TRzLabel;
    RzEditCardNo: TRzEdit;
    RzEditTelNo: TRzEdit;
    RzLabel2: TRzLabel;
    RzButtonInvoiceLog: TRzButton;
    RzButtonInvoice: TRzButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonInvoiceClick(Sender: TObject);
    procedure RzButtonInvoiceLogClick(Sender: TObject);
    procedure RzEditCardNoChange(Sender: TObject);
    procedure RzEditTelNoChange(Sender: TObject);
    procedure RzListViewChange(Sender: TObject; Item: TListItem; Change:
        TItemChange);
    procedure RzListViewDblClick(Sender: TObject);
    procedure RzRadioGroupInvoiceTypeClick(Sender: TObject);
  private
    orderString:string;
    whereString:string;
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadInvoiceInfo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormInvoiceManager: TFormInvoiceManager;

implementation

uses myfunction, dbfunction, fmInvoiceMaker, fmMemberInvoiceLog;

{$R *.dfm}

procedure TFormInvoiceManager.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormInvoiceManager.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  orderString:=' order by id';
  whereString:='';
  self.RzRadioGroupInvoiceType.ItemIndex:=0;
end;

procedure TFormInvoiceManager.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormInvoiceManager.loadInvoiceInfo;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  item:TListItem;
  total,yu:integer;
begin
  RzListView.Items.BeginUpdate;
  self.RzListView.Clear;
  RzListView.SmallImages:=ImageList1;
  ImageList1.Height:=26;
  ImageList1.Width:=0;
  total:=0;

  if self.RzRadioGroupInvoiceType.ItemIndex=0 then begin
    sql := 'SELECT id,cardno,paysum,invoicetotal,creationtime FROM memberdetail WHERE payidx=0';
  end else begin
    sql := 'SELECT id,invoicetel,paysum,invoicetotal,creationtime FROM payitems WHERE length(invoicetel)>0';
  end;
  sql:=sql+whereString;
  sql:=sql+orderString;
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        item:=self.RzListView.Items.Add;
        item.Caption:=getUTF8String(MYSQL_ROW^[0]);
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[1]));
        item.SubItems.Add('+'+getUTF8String(MYSQL_ROW^[2]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[4]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[3]));
        yu:=strtoint(getUTF8String(MYSQL_ROW^[2]))-strtoint(getUTF8String(MYSQL_ROW^[3]));
        item.SubItems.Add(inttostr(yu));
        total:=total+yu;
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
  RzLabelRows.Caption:='记录数：'+inttostr(mysql_num_rows(mySQL_Res));
  self.RzLabelTotal.Caption:='可用额度合计：'+inttostr(total)+'元';
end;

procedure TFormInvoiceManager.RzButtonInvoiceClick(Sender: TObject);
var
  f:TFormInvoiceMaker;
  item:TListItem;
  t:integer;
begin
  item:=self.RzListView.Selected;
  if self.RzRadioGroupInvoiceType.ItemIndex=0 then
    t:=1
  else
    t:=0;

  if item<>nil then begin
    f:=TFormInvoiceMaker.Create(self,t,strtoint(item.Caption));
    f.ShowModal;
    f.Destroy;
    self.loadInvoiceInfo;
  end;
end;

procedure TFormInvoiceManager.RzButtonInvoiceLogClick(Sender: TObject);
var
  f:TFormMemberInvoiceLog;
  item:TListItem;
  t:integer;
begin
  item:=self.RzListView.Selected;
  if self.RzRadioGroupInvoiceType.ItemIndex=0 then
    t:=1
  else
    t:=0;

  if item<>nil then begin
    f:=TFormMemberInvoiceLog.Create(self,t,strtoint(item.Caption));
    f.ShowModal;
    f.Destroy;
  end;
end;

procedure TFormInvoiceManager.RzEditCardNoChange(Sender: TObject);
begin
  if length(trim(self.RzEditCardNo.Text))>0 then begin
    whereString:=' and cardno like "%'+trim(self.RzEditCardNo.Text)+'%" ';
  end else begin
    whereString:='';
  end;
  self.loadInvoiceInfo;
end;

procedure TFormInvoiceManager.RzEditTelNoChange(Sender: TObject);
begin
  if length(trim(self.RzEditTelNo.Text))>0 then begin
    whereString:=' and invoicetel like "%'+trim(self.RzEditTelNo.Text)+'%" ';
  end else begin
    whereString:='';
  end;
  self.loadInvoiceInfo;
end;

procedure TFormInvoiceManager.RzListViewChange(Sender: TObject; Item:
    TListItem; Change: TItemChange);
begin
  if self.RzListView.Selected<>nil then begin
    self.RzButtonInvoice.Enabled:=true;
    self.RzButtonInvoiceLog.Enabled:=true;
    if strtoint(RzListView.Selected.SubItems[4])<0 then begin
      self.RzButtonInvoice.Enabled:=false;
    end;
  end else begin
    self.RzButtonInvoice.Enabled:=false;
    self.RzButtonInvoiceLog.Enabled:=false;
  end;
end;

procedure TFormInvoiceManager.RzListViewDblClick(Sender: TObject);
begin
  self.RzButtonInvoiceLogClick(self);
end;

procedure TFormInvoiceManager.RzRadioGroupInvoiceTypeClick(Sender: TObject);
begin
  self.RzPageControlKey.ActivePageIndex:=self.RzRadioGroupInvoiceType.ItemIndex;
  self.loadInvoiceInfo;
end;

end.
