unit fmStoreItemInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ExtCtrls, RzPanel, StdCtrls, RzCmboBx, RzEdit, Mask,
  RzLabel, pngimage, mysql;

type
  TFormStoreItemInfo = class(TForm)
    Image1: TImage;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzEditName: TRzEdit;
    RzNumericEditNums: TRzNumericEdit;
    RzEditUnit: TRzEdit;
    RzLabel8: TRzLabel;
    RzComboBoxStoreType: TRzComboBox;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    cmdAction: string;
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadStoreItemData;
    procedure loadStoreType;
    { Private declarations }
  public
    editInfoIdx:Integer;
    procedure setControlStatus(action: string);
    { Public declarations }
  end;

var
  FormStoreItemInfo: TFormStoreItemInfo;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

procedure TFormStoreItemInfo.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormStoreItemInfo.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  loadStoreType;
end;

procedure TFormStoreItemInfo.loadStoreType;
var
  l:TStringList;
  i:integer;
begin
  l:=TStringList.Create;
  getSectionList('STORETYPE',l);
  for i := 0 to l.Count - 1 do begin
    self.RzComboBoxStoreType.AddItemValue(GetStringFromINI('STORETYPE',l[i],'1'), l[i]);
  end;
  l.Free;
end;

procedure TFormStoreItemInfo.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormStoreItemInfo.loadStoreItemData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  sql := Format('SELECT storetypeidx,storename,storeunit,warningnums FROM stores WHERE id=%d',[self.editInfoIdx]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      self.RzComboBoxStoreType.Value:=getUTF8String(MYSQL_ROW^[0]);
      self.RzEditName.Text:=getUTF8String(MYSQL_ROW^[1]);
      self.RzEditUnit.Text:=getUTF8String(MYSQL_ROW^[2]);
      self.RzNumericEditNums.IntValue:=strtoint(getUTF8String(MYSQL_ROW^[3]));
    end;
  end;
end;

procedure TFormStoreItemInfo.RzButtonOkClick(Sender: TObject);
var
  sql:string;
begin
  if self.RzComboBoxStoreType.Value='' then begin
    MessageBox(self.Handle,'请先选择库存类型再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxStoreType.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditName.Text))=0 then begin
    MessageBox(self.Handle,'请先输入商品名称再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditName.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditUnit.Text))=0 then begin
    MessageBox(self.Handle,'请先输入商品计量单位再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditUnit.SetFocus;
    exit;
  end;
  if self.RzNumericEditNums.IntValue=0 then begin
    MessageBox(self.Handle,'请先输入报警界限值再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzNumericEditNums.SetFocus;
    exit;
  end;

  if cmdAction='ADD' then begin
    sql := Format('INSERT INTO stores(storetypeidx,storetypename,storename,storeunit,warningnums,loginname) values(%s,"%s","%s","%s",%d,"%s")',
      [ self.RzComboBoxStoreType.Value,
        self.RzComboBoxStoreType.Text,
        trim(self.RzEditName.Text),
        trim(self.RzEditUnit.Text),
        self.RzNumericEditNums.IntValue,
        LOGINNAME
      ]);
  end else if cmdAction='EDIT' then begin
    sql := Format('UPDATE stores SET storetypeidx=%s,storetypename="%s",storename="%s",storeunit="%s",warningnums=%d WHERE id=%d',
      [ self.RzComboBoxStoreType.Value,
        self.RzComboBoxStoreType.Text,
        trim(self.RzEditName.Text),
        trim(self.RzEditUnit.Text),
        self.RzNumericEditNums.IntValue,
        self.editInfoIdx
      ]);
  end;
  //showmessage(sql);
  execMySql(sql,LibHandle);
  self.Close;
end;

procedure TFormStoreItemInfo.setControlStatus(action: string);
begin
  self.cmdAction:=action;
  if action='ADD' then begin
    self.Caption:='添加商品';
    self.RzButtonOk.Caption:='添加';
  end else if action='EDIT' then begin
    self.Caption:='编辑商品';
    self.RzButtonOk.Caption:='编辑';
    loadStoreItemData;
  end;
end;

end.
