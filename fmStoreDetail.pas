unit fmStoreDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ComCtrls, RzListVw, ExtCtrls, RzPanel, mysql, ImgList;

type
  TFormStoreDetail = class(TForm)
    RzGroupBox1: TRzGroupBox;
    RzListView: TRzListView;
    RzGroupBox2: TRzGroupBox;
    RzListView1: TRzListView;
    RzButton1: TRzButton;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure RzListViewChange(Sender: TObject; Item: TListItem; Change:
        TItemChange);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    partId: Integer;
    procedure loadItemInfo;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; pid: Integer); reintroduce;
        overload;
    { Public declarations }
  end;

var
  FormStoreDetail: TFormStoreDetail;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

constructor TFormStoreDetail.Create(AOwner: TComponent; pid: Integer);
begin
  inherited Create(AOwner);
  self.partId:=pid;
end;

procedure TFormStoreDetail.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  loadItemInfo;
end;

procedure TFormStoreDetail.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormStoreDetail.RzButton1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TFormStoreDetail.loadItemInfo;
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

  sql := Format('SELECT id,storename,joinnums,joinprice,overnums,joinbrands,cdate,joinqualitydate,storedesc FROM view_storeitems WHERE storeid=%d',[self.partId]);
  sql:=sql+' order by id desc';
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
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[4]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[5]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[6]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[7]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[8]));
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
end;

procedure TFormStoreDetail.RzListViewChange(Sender: TObject; Item: TListItem;
    Change: TItemChange);
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  if RzListView.Selected=nil then
    exit;

  RzListView1.Items.BeginUpdate;
  self.RzListView1.Clear;
  RzListView1.SmallImages:=ImageList1;
  ImageList1.Height:=26;
  ImageList1.Width:=0;

  sql := Format('SELECT partwhere,partwho,partnums,creationtime from storeitems WHERE partid=%s',[RzListView.Selected.Caption]);
  sql:=sql+' order by id desc';
  queryMySql(sql,LibHandle, mySQL_Res);

  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        item:=self.RzListView1.Items.Add;
        item.Caption:=getUTF8String(MYSQL_ROW^[0]);
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[1]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[2]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[3]));
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView1.Items.EndUpdate;
end;

end.
