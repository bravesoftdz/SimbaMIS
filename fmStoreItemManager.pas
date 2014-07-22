unit fmStoreItemManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ImgList, StdCtrls, RzCmboBx, RzRadChk, pngimage, ExtCtrls,
  RzPanel, ComCtrls, RzListVw, mysql;

type
  TFormStoreItemManager = class(TForm)
    RzListView: TRzListView;
    RzPanel1: TRzPanel;
    RzToolButtonAdd: TRzToolButton;
    RzToolButtonEdit: TRzToolButton;
    RzPanel2: TRzPanel;
    Image1: TImage;
    RzRadioButtonType: TRzRadioButton;
    RzComboBoxType: TRzComboBox;
    RzRadioButtonAll: TRzRadioButton;
    ImageList1: TImageList;
    RzButtonCancel: TRzButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzComboBoxTypeChange(Sender: TObject);
    procedure RzListViewDblClick(Sender: TObject);
    procedure RzRadioButtonAllClick(Sender: TObject);
    procedure RzRadioButtonTypeClick(Sender: TObject);
    procedure RzToolButtonAddClick(Sender: TObject);
    procedure RzToolButtonEditClick(Sender: TObject);
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
  FormStoreItemManager: TFormStoreItemManager;

implementation

uses myfunction, dbfunction, fmStoreItemInfo;

{$R *.dfm}

procedure TFormStoreItemManager.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  loadStoreType;
  RzRadioButtonAllClick(self);
end;

procedure TFormStoreItemManager.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormStoreItemManager.loadStoreData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  item: TListItem;
begin
  RzListView.Items.BeginUpdate;
  self.RzListView.Clear;
  RzListView.SmallImages:=ImageList1;
  ImageList1.Height:=26;
  ImageList1.Width:=0;

  sql := 'SELECT id,storename,storetypename,storeunit,warningnums FROM stores';
  if length(strWhere)>0 then
    sql:=sql+strWhere;
  sql:=sql+' order by storetypeidx,id';

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
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
end;

procedure TFormStoreItemManager.loadStoreType;
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

procedure TFormStoreItemManager.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormStoreItemManager.RzComboBoxTypeChange(Sender: TObject);
begin
  if self.RzComboBoxType.ItemIndex<>-1 then begin
    strWhere:=' where storetypeidx='+self.RzComboBoxType.Value;
    self.loadStoreData;
  end;
end;

procedure TFormStoreItemManager.RzListViewDblClick(Sender: TObject);
begin
  self.RzToolButtonEditClick(self);
end;

procedure TFormStoreItemManager.RzRadioButtonAllClick(Sender: TObject);
begin
  self.RzComboBoxType.Enabled:=false;
  self.RzComboBoxType.ItemIndex:=-1;

  strWhere:='';
  self.loadStoreData;
end;

procedure TFormStoreItemManager.RzRadioButtonTypeClick(Sender: TObject);
begin
  self.RzComboBoxType.Enabled:=true;
  if self.RzComboBoxType.Items.Count>0 then begin
    self.RzComboBoxType.ItemIndex:=0;
    RzComboBoxTypeChange(self);
  end;
end;

procedure TFormStoreItemManager.RzToolButtonAddClick(Sender: TObject);
var
  f:TFormStoreItemInfo;
begin
  f:=TFormStoreItemInfo.Create(self);
  f.editInfoIdx:=0;
  f.setControlStatus('ADD');
  f.ShowModal;
  self.loadStoreData;
  f.Destroy;
end;

procedure TFormStoreItemManager.RzToolButtonEditClick(Sender: TObject);
var
  f:TFormStoreItemInfo;
begin
  if self.RzListView.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要编辑的商品条目！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  f:=TFormStoreItemInfo.Create(self);
  f.editInfoIdx:=strtoint(self.RzListView.Selected.Caption);
  f.setControlStatus('EDIT');
  f.ShowModal;
  self.loadStoreData;
  f.Destroy;
end;

end.
