unit fmOrderManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, RzButton, ExtCtrls, RzPanel, RzListVw, mysql, ImgList;

type
  TFormOrderManager = class(TForm)
    RzListView: TRzListView;
    RzPanel2: TRzPanel;
    RzButtonAdd: TRzButton;
    RzButtonDel: TRzButton;
    RzButtonClose: TRzButton;
    ImageList1: TImageList;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonAddClick(Sender: TObject);
    procedure RzButtonCloseClick(Sender: TObject);
    procedure RzButtonDelClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadOrderData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormOrderManager: TFormOrderManager;

implementation

uses myfunction, dbfunction, fmOrderInfo;

{$R *.dfm}

procedure TFormOrderManager.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormOrderManager.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  loadOrderData;
end;

procedure TFormOrderManager.loadOrderData;
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

  sql := 'select id,ordertablename,ordername,ordertel,orderusers,ordertime from orders ';
  sql := sql + 'where ';
  sql := sql + 'ordertime>now() ';
  sql := sql + 'order by ordertime';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
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
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
end;

procedure TFormOrderManager.RzButtonAddClick(Sender: TObject);
var
  f:TFormOrderInfo;
begin
  f:=TFormOrderInfo.Create(self);
  f.ShowModal;
  loadOrderData;
  f.Destroy;
end;

procedure TFormOrderManager.RzButtonCloseClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormOrderManager.RzButtonDelClick(Sender: TObject);
var
  res:integer;
  u,sql:string;
begin
  if (self.RzListView.ItemIndex=-1) then begin
    MessageBox(self.Handle,'请选择你要删除的预订记录！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  u:=self.RzListView.Selected.Caption;
  res := MessageBox(self.Handle, PWideChar('是否确定要删除预订记录：'+u), '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    sql := Format('DELETE FROM orders WHERE id=%s',[u]);
    execMySql(sql,LibHandle);
    //self.loadMenuData;
    self.RzListView.Selected.Delete;
  end;
end;

end.
