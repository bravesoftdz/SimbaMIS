unit fmSellerClear;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzCmboBx, RzButton, ImgList, ComCtrls, RzListVw, RzLabel,
  pngimage, ExtCtrls, RzPanel, mysql;

type
  TFormSellerClear = class(TForm)
    RzPanel2: TRzPanel;
    Image1: TImage;
    RzLabel2: TRzLabel;
    RzListView: TRzListView;
    ImageList1: TImageList;
    RzPanel1: TRzPanel;
    RzLabelPay: TRzLabel;
    RzButtonCancel: TRzButton;
    RzButtonAdd: TRzButton;
    RzComboBoxSellerList: TRzComboBox;
    RzLabelTotal: TRzLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButtonAddClick(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzComboBoxSellerListChange(Sender: TObject);
    procedure RzListViewItemChecked(Sender: TObject; Item: TListItem);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    sellerPayTotal:real;
    procedure initSellerList;
    procedure loadSellerInfo;
    procedure sumSellerPay;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSellerClear: TFormSellerClear;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

procedure TFormSellerClear.FormCreate(Sender: TObject);
begin
  self.sellerPayTotal:=0;
  connectMySql(LibHandle);
  initSellerList;
end;

procedure TFormSellerClear.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormSellerClear.initSellerList;
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
  if self.RzComboBoxSellerList.Items.Count>0 then begin
    self.RzComboBoxSellerList.ItemIndex:=0;
    self.loadSellerInfo;
  end;
end;

procedure TFormSellerClear.loadSellerInfo;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  item:TListItem;
  total:real;
begin
  RzListView.Items.BeginUpdate;
  self.RzListView.Clear;
  RzListView.SmallImages:=ImageList1;
  ImageList1.Height:=26;
  ImageList1.Width:=0;
  total:=0;

  sql:='SELECT id,buytype,buypaysum,cdate from view_purchase ';
  sql:=sql+Format('where buystatus=0 and paystatus=0 and buyselleridx=%s ',[self.RzComboBoxSellerList.Value]);
  sql:=sql+'order by id';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        item:=self.RzListView.Items.Add;
        item.Caption:=getUTF8String(MYSQL_ROW^[0]);
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[3]));
        item.SubItems.Add(GetStringFromINI('BUYTYPE',getUTF8String(MYSQL_ROW^[1]),'水果'));
        item.SubItems.Add(Format('%2.2f',[strtofloat(getUTF8String(MYSQL_ROW^[2]))]));

        total:=total+strtofloat(getUTF8String(MYSQL_ROW^[2]));

        item.Checked:=true;
        //self.sellerPayTotal:=total;
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
  self.RzLabelTotal.Caption:='采购合计:'+floattostr(total)+'元';
  //self.RzLabelPay.Caption:='结算合计:'+floattostr(sellerPayTotal)+'元';
end;

procedure TFormSellerClear.RzButtonAddClick(Sender: TObject);
var
  I,res: Integer;
  item:TListItem;
  sql:string;
begin
  res := MessageBox(self.Handle, PWideChar('确定已结算完毕?'), '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    for I := 0 to self.RzListView.Items.Count - 1 do begin
      item:=self.RzListView.Items.Item[I];
      if item.Checked then begin
        sql:=Format('UPDATE purchase set paystatus=1,payloginname="%s",paytime=now() where id=%s',[LOGINNAME,item.Caption]);
        execMySql(sql,LibHandle);
      end;
    end;
    self.Close;
  end;
end;

procedure TFormSellerClear.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormSellerClear.RzComboBoxSellerListChange(Sender: TObject);
begin
  self.loadSellerInfo;
end;

procedure TFormSellerClear.RzListViewItemChecked(Sender: TObject; Item:
    TListItem);
begin
  sumSellerPay;
end;

procedure TFormSellerClear.sumSellerPay;
var
  total:real;
  I: Integer;
  item:TListItem;
begin
  total:=0;
  for I := 0 to self.RzListView.Items.Count - 1 do begin
    item:=self.RzListView.Items.Item[I];
    if item.Checked then begin
      total:=total+strtofloat(item.SubItems[2]);
    end;
  end;

  self.RzLabelPay.Caption:='结算合计:'+floattostr(total)+'元';
  self.sellerPayTotal:=total;

  if self.sellerPayTotal=0 then
    self.RzButtonAdd.Enabled:=false
  else
    self.RzButtonAdd.Enabled:=true;
end;

end.
