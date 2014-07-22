unit fmStorePart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, RzListVw, StdCtrls, Mask, RzEdit, RzLabel,
  RzPanel, RzButton, ExtCtrls, mysql, RzCmboBx;

type
  TFormStorePart = class(TForm)
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    RzGroupBox1: TRzGroupBox;
    RzLabel2: TRzLabel;
    RzNumericEditNum: TRzNumericEdit;
    RzListView: TRzListView;
    ImageList1: TImageList;
    RzLabel7: TRzLabel;
    RzComboBoxForWhere: TRzComboBox;
    RzLabel9: TRzLabel;
    RzComboBoxForWho: TRzComboBox;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
    procedure RzComboBoxForWhereChange(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    partId: Integer;
    procedure initForWhereList;
    procedure loadItemInfo;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; pid: Integer); reintroduce;
        overload;
    { Public declarations }
  end;

var
  FormStorePart: TFormStorePart;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

constructor TFormStorePart.Create(AOwner: TComponent; pid: Integer);
begin
  inherited Create(AOwner);
  self.partId:=pid;
end;

procedure TFormStorePart.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormStorePart.FormCreate(Sender: TObject);
begin
  initForWhereList;
  connectMySql(LibHandle);
  loadItemInfo;
end;

procedure TFormStorePart.initForWhereList;
var
  forList:TStringList;
  i: Integer;
  t:string;
begin
  forList:=TStringList.Create;
  getSectionList('ACCESSTYPE', forList);
  for i := 0 to forList.Count - 1 do begin
    t:=GetStringFromINI('ACCESSTYPE',forList[i],'前厅');
    self.RzComboBoxForWhere.AddItemValue(t,forList[i]);
  end;
  //if forList.Count>0 then
  //  self.RzComboBoxForWhere.ItemIndex:=0;
  forList.Free;
end;

procedure TFormStorePart.loadItemInfo;
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

  sql := Format('SELECT id,storename,overnums,cdate,joinqualitydate,joinbrands FROM view_storeitems WHERE storeid=%d and overnums>0',[self.partId]);
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
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
end;

procedure TFormStorePart.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormStorePart.RzButtonOkClick(Sender: TObject);
var
  sql:string;
begin
  if self.RzListView.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请先选择要出库的入库批次！','提示',MB_OK or MB_ICONWARNING);
    self.RzListView.SetFocus;
    exit;
  end;
  if self.RzNumericEditNum.Value=0 then begin
    MessageBox(self.Handle,'请先输入出库数量再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzNumericEditNum.SetFocus;
    exit;
  end;
  if self.RzComboBoxForWhere.Value='' then begin
    MessageBox(self.Handle,'请先选择领用部门再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxForWhere.SetFocus;
    exit;
  end;
  if self.RzComboBoxForWho.Value='' then begin
    MessageBox(self.Handle,'请先选择领用人再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxForWho.SetFocus;
    exit;
  end;
  if strtofloat(RzListView.Selected.SubItems[1])<self.RzNumericEditNum.Value then begin
    MessageBox(self.Handle,'输入的出库数量比当前库存数量大！','提示',MB_OK or MB_ICONWARNING);
    self.RzNumericEditNum.SetFocus;
    exit;
  end;

  sql := Format('INSERT INTO storeitems(partnums,partid,partwhere,partwho,loginname) values(%2.2f,%s,%s,%s,"%s")',
      [ self.RzNumericEditNum.Value,
        self.RzListView.Selected.Caption,
        self.RzComboBoxForWhere.Value,
        self.RzComboBoxForWho.Value,
        LOGINNAME
      ]);
  execMySql(sql,LibHandle);

  sql := Format('update storeitems set overnums=overnums-%2.2f where id=%s',
    [ self.RzNumericEditNum.Value,
      self.RzListView.Selected.Caption
    ]);
  execMySql(sql,LibHandle);

  self.Close;
end;

procedure TFormStorePart.RzComboBoxForWhereChange(Sender: TObject);
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  self.RzComboBoxForWho.Values.Clear;
  self.RzComboBoxForWho.Items.Clear;
  sql := 'SELECT username,id FROM users WHERE access='+self.RzComboBoxForWhere.Value;
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        self.RzComboBoxForWho.AddItemValue(getUTF8String(MYSQL_ROW^[0]),getUTF8String(MYSQL_ROW^[1]));
      end;
    until MYSQL_ROW=nil;
  end;
end;

end.
