unit fmStoreManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, StdCtrls, RzCmboBx, RzButton, RzRadChk, pngimage, ExtCtrls,
  RzLabel, RzPanel, ComCtrls, RzListVw, mysql;

type
  TFormStoreManager = class(TForm)
    RzListView: TRzListView;
    RzPanel1: TRzPanel;
    RzToolButtonJoin: TRzToolButton;
    RzLabelTotal: TRzLabel;
    RzToolButtonPart: TRzToolButton;
    RzPanel2: TRzPanel;
    Image1: TImage;
    RzRadioButtonType: TRzRadioButton;
    RzComboBoxType: TRzComboBox;
    RzRadioButtonAll: TRzRadioButton;
    ImageList1: TImageList;
    RzToolButtonDetail: TRzToolButton;
    RzURLLabel1: TRzURLLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzComboBoxTypeChange(Sender: TObject);
    procedure RzListViewDblClick(Sender: TObject);
    procedure RzRadioButtonAllClick(Sender: TObject);
    procedure RzRadioButtonTypeClick(Sender: TObject);
    procedure RzToolButtonDetailClick(Sender: TObject);
    procedure RzToolButtonJoinClick(Sender: TObject);
    procedure RzToolButtonPartClick(Sender: TObject);
    procedure RzURLLabel1Click(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    strWhere:string;
    procedure loadStoreData;
    procedure loadStoreType;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormStoreManager: TFormStoreManager;

implementation

uses myfunction, dbfunction, fmStoreJoin, fmStorePart, fmStoreDetail, fmStoreItemManager;

{$R *.dfm}

procedure TFormStoreManager.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormStoreManager.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  loadStoreType;
  RzRadioButtonAllClick(self);
end;

procedure TFormStoreManager.loadStoreData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  item: TListItem;
  total:real;
begin
  RzListView.Items.BeginUpdate;
  self.RzListView.Clear;
  RzListView.SmallImages:=ImageList1;
  ImageList1.Height:=26;
  ImageList1.Width:=0;
  total:=0;

  sql := 'SELECT storeid,storename,storetypename,storeunit,sum(overnums),sum(overnums*joinprice) FROM view_storeitems ';
  sql := sql+ 'where partid=0 and overnums>0';
  sql:=sql+strWhere;
  sql:=sql+' group by storeid order by storetypeidx,storeid';

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
        total:=total+strtofloat(getUTF8String(MYSQL_ROW^[5]));
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
  RzLabelTotal.Caption:='库存总额：'+floattostr(total)+'元';
end;

procedure TFormStoreManager.loadStoreType;
var
  l:TStringList;
  i:integer;
begin
  l:=TStringList.Create;
  getSectionList('STORETYPE',l);
  for i := 0 to l.Count - 1 do begin
    self.RzComboBoxType.AddItemValue(GetStringFromINI('STORETYPE',l[i],'1'), l[i]);
  end;
  l.Free;
end;

procedure TFormStoreManager.RzComboBoxTypeChange(Sender: TObject);
begin
  if self.RzComboBoxType.ItemIndex<>-1 then begin
    strWhere:=' and storetypeidx='+self.RzComboBoxType.Value;
    self.loadStoreData;
  end;
end;

procedure TFormStoreManager.RzListViewDblClick(Sender: TObject);
begin
  self.RzToolButtonDetailClick(self);
end;

procedure TFormStoreManager.RzRadioButtonAllClick(Sender: TObject);
begin
  self.RzComboBoxType.Enabled:=false;
  self.RzComboBoxType.ItemIndex:=-1;

  strWhere:='';
  self.loadStoreData;
end;

procedure TFormStoreManager.RzRadioButtonTypeClick(Sender: TObject);
begin
  self.RzComboBoxType.Enabled:=true;
  if self.RzComboBoxType.Items.Count>0 then begin
    self.RzComboBoxType.ItemIndex:=0;
    RzComboBoxTypeChange(self);
  end;
end;

procedure TFormStoreManager.RzToolButtonDetailClick(Sender: TObject);
var
  f:TFormStoreDetail;
  pid:integer;
begin
  if self.RzListView.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要查看明细的商品条目！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  pid:=strtoint(self.RzListView.Selected.Caption);
  f:=TFormStoreDetail.Create(self,pid);
  f.ShowModal;
  //self.loadStoreData;
  f.Destroy;
end;

procedure TFormStoreManager.RzToolButtonJoinClick(Sender: TObject);
var
  f:TFormStoreJoin;
begin
  f:=TFormStoreJoin.Create(self);
  f.ShowModal;
  self.loadStoreData;
  f.Destroy;
end;

procedure TFormStoreManager.RzToolButtonPartClick(Sender: TObject);
var
  f:TFormStorePart;
  pid:integer;
begin
  if self.RzListView.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要出库的商品条目！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  pid:=strtoint(self.RzListView.Selected.Caption);
  f:=TFormStorePart.Create(self,pid);
  f.ShowModal;
  self.loadStoreData;
  f.Destroy;
end;

procedure TFormStoreManager.RzURLLabel1Click(Sender: TObject);
var
  f:TFormStoreItemManager;
begin
  f:=TFormStoreItemManager.Create(self);
  f.ShowModal;
  f.Destroy;
end;

end.
