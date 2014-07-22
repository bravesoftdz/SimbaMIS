unit fmMemberInvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ComCtrls, RzListVw, ExtCtrls, RzPanel, mysql, ImgList,
  StdCtrls, RzLabel;

type
  TFormMemberInvoice = class(TForm)
    RzPanel1: TRzPanel;
    RzButtonCancel: TRzButton;
    RzListView: TRzListView;
    ImageList1: TImageList;
    RzButtonInvoice: TRzButton;
    RzLabelTotal: TRzLabel;
    RzButtonInvoiceLog: TRzButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonInvoiceClick(Sender: TObject);
    procedure RzButtonInvoiceLogClick(Sender: TObject);
    procedure RzListViewChange(Sender: TObject; Item: TListItem; Change:
        TItemChange);
    procedure RzListViewColumnClick(Sender: TObject; Column: TListColumn);
    procedure RzListViewDblClick(Sender: TObject);
  private
    oldCardNo:string;
    orderString:string;
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadMemberInvoiceInfo;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; cno: string); reintroduce;
        overload;
    { Public declarations }
  end;

var
  FormMemberInvoice: TFormMemberInvoice;

implementation

uses myfunction, dbfunction, fmInvoiceMaker, fmMemberInvoiceLog;

{$R *.dfm}

constructor TFormMemberInvoice.Create(AOwner: TComponent; cno: string);
begin
  inherited Create(AOwner);
  self.oldCardNo:=cno;
end;

procedure TFormMemberInvoice.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  orderString:=' order by id';
  loadMemberInvoiceInfo;
end;

procedure TFormMemberInvoice.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormMemberInvoice.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormMemberInvoice.loadMemberInvoiceInfo;
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

  sql := Format('SELECT id,cardno,paysum,invoicetotal,creationtime FROM memberdetail WHERE cardno="%s" and payidx=0 and paytype<3',[self.oldCardNo]);
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
  self.RzLabelTotal.Caption:='可用额度合计：'+inttostr(total)+'元';
end;

procedure TFormMemberInvoice.RzButtonInvoiceClick(Sender: TObject);
var
  f:TFormInvoiceMaker;
  item:TListItem;
begin
  item:=self.RzListView.Selected;
  if item<>nil then begin
    f:=TFormInvoiceMaker.Create(self,1,strtoint(item.Caption));
    f.ShowModal;
    f.Destroy;
    self.loadMemberInvoiceInfo;
  end;
end;

procedure TFormMemberInvoice.RzButtonInvoiceLogClick(Sender: TObject);
var
  f:TFormMemberInvoiceLog;
  item:TListItem;
begin
  item:=self.RzListView.Selected;
  if item<>nil then begin
    f:=TFormMemberInvoiceLog.Create(self,1,strtoint(item.Caption));
    f.ShowModal;
    f.Destroy;
  end;
end;

procedure TFormMemberInvoice.RzListViewChange(Sender: TObject; Item: TListItem;
    Change: TItemChange);
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

procedure TFormMemberInvoice.RzListViewColumnClick(Sender: TObject; Column:
    TListColumn);
begin
  if Column.Index=0 then begin
    if Column.Tag=0 then begin
      orderString:=' order by id desc';
      Column.Tag:=1;
    end else begin
      orderString:=' order by id';
      Column.Tag:=0;
    end;
  end;
  self.loadMemberInvoiceInfo;
end;

procedure TFormMemberInvoice.RzListViewDblClick(Sender: TObject);
begin
  self.RzButtonInvoiceLogClick(self);
end;

end.
