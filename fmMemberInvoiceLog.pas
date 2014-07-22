unit fmMemberInvoiceLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mysql, ImgList, RzButton, ExtCtrls, RzPanel, ComCtrls, RzListVw;

type
  TFormMemberInvoiceLog = class(TForm)
    RzListView: TRzListView;
    RzPanel1: TRzPanel;
    RzButtonCancel: TRzButton;
    ImageList1: TImageList;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
  private
    payidx:integer;
    invoicType:integer;
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadMemberInvoiceLog;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; inType, idx: Integer); reintroduce;
        overload;
    { Public declarations }
  end;

var
  FormMemberInvoiceLog: TFormMemberInvoiceLog;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

constructor TFormMemberInvoiceLog.Create(AOwner: TComponent; inType, idx:
    Integer);
begin
  inherited Create(AOwner);
  self.invoicType:=inType;
  self.payidx:=idx;
end;

procedure TFormMemberInvoiceLog.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormMemberInvoiceLog.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  loadMemberInvoiceLog;
end;

procedure TFormMemberInvoiceLog.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormMemberInvoiceLog.loadMemberInvoiceLog;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  item:TListItem;
begin
  RzListView.Items.BeginUpdate;
  self.RzListView.Clear;
  RzListView.SmallImages:=ImageList1;
  ImageList1.Height:=26;
  ImageList1.Width:=0;

  sql := Format('SELECT id,invoicesum,creationtime,loginname FROM invoices WHERE invoicetype=%d and payidx=%d order by id',[self.invoicType,self.payidx]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        item:=self.RzListView.Items.Add;
        item.Caption:=getUTF8String(MYSQL_ROW^[0]);
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[1]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[2]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[3]));
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
end;

end.
