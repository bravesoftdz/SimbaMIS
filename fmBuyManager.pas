unit fmBuyManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, ImgList, RzButton, RzLabel, ComCtrls,
  RzListVw, pngimage, ExtCtrls, RzPanel, mysql;

type
  TFormBuyManager = class(TForm)
    RzPanel2: TRzPanel;
    Image1: TImage;
    RzListView: TRzListView;
    RzPanel1: TRzPanel;
    RzLabelTotal: TRzLabel;
    RzButtonCancel: TRzButton;
    ImageList1: TImageList;
    RzDateTimeBuyDate: TRzDateTimeEdit;
    RzLabel2: TRzLabel;
    RzButtonDel: TRzButton;
    RzButtonSeller: TRzButton;
    RzButtonAdd: TRzButton;
    RzButtonSellerPay: TRzButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButtonAddClick(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonDelClick(Sender: TObject);
    procedure RzButtonSellerClick(Sender: TObject);
    procedure RzButtonSellerPayClick(Sender: TObject);
    procedure RzDateTimeBuyDateChange(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadBuyInfo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBuyManager: TFormBuyManager;

implementation

uses myfunction, dbfunction, fmSellerManager, fmBuyInfo, fmSellerClear;

{$R *.dfm}

procedure TFormBuyManager.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  self.RzDateTimeBuyDate.Date:=Date();
end;

procedure TFormBuyManager.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormBuyManager.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormBuyManager.RzDateTimeBuyDateChange(Sender: TObject);
begin
  loadBuyInfo;
end;

procedure TFormBuyManager.loadBuyInfo;
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

  sql:='SELECT a.id,a.buytype,a.buydesc,a.buyprice,a.buynums,a.buypaysum,a.paystatus,b.sellername,a.forwhere,c.username,a.creationtime from purchase a ';
  sql:=sql+'left join seller b on b.id=a.buyselleridx ';
  sql:=sql+'left join users c on c.id=a.forwho ';
  sql:=sql+'where a.buystatus=0 and date(a.creationtime)="'+datetostr(self.RzDateTimeBuyDate.Date)+'" ';
  sql:=sql+'order by id';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        item:=self.RzListView.Items.Add;
        item.Caption:=getUTF8String(MYSQL_ROW^[0]);
        item.SubItems.Add(GetStringFromINI('BUYTYPE',getUTF8String(MYSQL_ROW^[1]),'水果'));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[2]));
        item.SubItems.Add(Format('%2.2f',[strtofloat(getUTF8String(MYSQL_ROW^[3]))]));
        item.SubItems.Add(Format('%2.2f',[strtofloat(getUTF8String(MYSQL_ROW^[4]))]));
        item.SubItems.Add(Format('%2.2f',[strtofloat(getUTF8String(MYSQL_ROW^[5]))]));
        if getUTF8String(MYSQL_ROW^[6])='0' then
          item.SubItems.Add('未结')
        else
          item.SubItems.Add('已结');
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[7]));
        item.SubItems.Add(GetStringFromINI('ACCESSTYPE',getUTF8String(MYSQL_ROW^[8]),'前厅'));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[9]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[10]));

        total:=total+strtofloat(getUTF8String(MYSQL_ROW^[5]));
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
  self.RzLabelTotal.Caption:='采购合计：'+Format('%2.2f',[total])+'元';
end;

procedure TFormBuyManager.RzButtonAddClick(Sender: TObject);
var
  f:TFormBuyInfo;
begin
  f:=TFormBuyInfo.Create(self);
  f.ShowModal;
  f.Destroy;
  self.loadBuyInfo;
end;

procedure TFormBuyManager.RzButtonDelClick(Sender: TObject);
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
    sql := Format('UPDATE purchase SET buystatus=1,delloginname="%s",deletetime=now() WHERE id=%s',[LOGINNAME,u.Caption]);
    execMySql(sql,LibHandle);
    self.loadBuyInfo;
  end;
end;

procedure TFormBuyManager.RzButtonSellerClick(Sender: TObject);
var
  f:TFormSellerManager;
begin
  f:=TFormSellerManager.Create(self);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormBuyManager.RzButtonSellerPayClick(Sender: TObject);
var
  f:TFormSellerClear;
begin
  f:=TFormSellerClear.Create(self);
  f.ShowModal;
  f.Destroy;
  self.loadBuyInfo;
end;

end.
