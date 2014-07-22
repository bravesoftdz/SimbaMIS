unit fmSellerManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ExtCtrls, RzPanel, ComCtrls, RzListVw, mysql, ImgList;

type
  TFormSellerManager = class(TForm)
    RzListView: TRzListView;
    RzPanel1: TRzPanel;
    RzButtonCancel: TRzButton;
    RzButtonDel: TRzButton;
    RzButtonAdd: TRzButton;
    ImageList1: TImageList;
    RzButtonSumPay: TRzButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonAddClick(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonDelClick(Sender: TObject);
    procedure RzButtonSumPayClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadSellerInfo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSellerManager: TFormSellerManager;

implementation

uses myfunction, dbfunction, fmSellerInfo, fmSellerClear;

{$R *.dfm}

procedure TFormSellerManager.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormSellerManager.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  loadSellerInfo;
end;

procedure TFormSellerManager.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormSellerManager.loadSellerInfo;
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

  sql:='SELECT id,sellername,sellertel from seller ';
  sql:=sql+'where sellerstatus=0 order by id';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        item:=self.RzListView.Items.Add;
        item.Caption:=getUTF8String(MYSQL_ROW^[0]);
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[2]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[1]));
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
end;

procedure TFormSellerManager.RzButtonAddClick(Sender: TObject);
var
  f:TFormSellerInfo;
begin
  f:=TFormSellerInfo.Create(self);
  f.ShowModal;
  f.Destroy;
  self.loadSellerInfo;
end;

procedure TFormSellerManager.RzButtonDelClick(Sender: TObject);
var
  res:integer;
  u:TListItem;
  sql:string;
begin
  if self.RzListView.Selected=nil then begin
    MessageBox(self.Handle,'请选择你要删除的条目！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  u:=self.RzListView.Selected;
  res := MessageBox(self.Handle, PWideChar('是否确定要删除条目：'+u.Caption), '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    sql := Format('UPDATE seller SET sellerstatus=1 WHERE id=%s',[u.Caption]);
    execMySql(sql,LibHandle);
    self.loadSellerInfo;
  end;
end;

procedure TFormSellerManager.RzButtonSumPayClick(Sender: TObject);
var
  f:TFormSellerClear;
begin
  f:=TFormSellerClear.Create(self);
  f.ShowModal;
  f.Destroy;
  self.loadSellerInfo;
end;

end.
