unit fmAssetsInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mysql, RzButton, ExtCtrls, RzPanel, StdCtrls, RzEdit, Mask, RzLabel,
  pngimage;

type
  TFormAssetsInfo = class(TForm)
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    Image1: TImage;
    RzLabel1: TRzLabel;
    RzEditAssetsName: TRzEdit;
    RzLabel2: TRzLabel;
    RzNumericEditAssetsNums: TRzNumericEdit;
    RzLabel3: TRzLabel;
    RzEditAssetsUnit: TRzEdit;
    RzLabel4: TRzLabel;
    RzNumericEditAssetsPrice: TRzNumericEdit;
    RzLabel5: TRzLabel;
    RzMemoAssetsDesc: TRzMemo;
    RzLabel6: TRzLabel;
    RzMemoAssetsSeller: TRzMemo;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    cmdAction: string;
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadAssetsItemData;
    { Private declarations }
  public
    editInfoIdx:Integer;
    procedure setControlStatus(action: string);
    { Public declarations }
  end;

var
  FormAssetsInfo: TFormAssetsInfo;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

procedure TFormAssetsInfo.FormActivate(Sender: TObject);
begin
  self.RzEditAssetsName.SetFocus;
end;

procedure TFormAssetsInfo.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
end;

procedure TFormAssetsInfo.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormAssetsInfo.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormAssetsInfo.loadAssetsItemData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  sql := Format('SELECT assetsname,assetsnums,assetsunit,assetsprice,assetsdesc,assetsseller FROM assets WHERE id=%d',[self.editInfoIdx]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      self.RzEditAssetsName.Text:=getUTF8String(MYSQL_ROW^[0]);
      self.RzNumericEditAssetsNums.IntValue:=strtoint(getUTF8String(MYSQL_ROW^[1]));
      self.RzEditAssetsUnit.Text:=getUTF8String(MYSQL_ROW^[2]);
      self.RzNumericEditAssetsPrice.Value:=strtofloat(getUTF8String(MYSQL_ROW^[3]));
      self.RzMemoAssetsDesc.Text:=getUTF8String(MYSQL_ROW^[4]);
      self.RzMemoAssetsSeller.Text:=getUTF8String(MYSQL_ROW^[5]);
    end;
  end;
end;

procedure TFormAssetsInfo.RzButtonOkClick(Sender: TObject);
var
  sql:string;
begin
  if length(trim(self.RzEditAssetsName.Text))=0 then begin
    MessageBox(self.Handle,'请先输入资产名称再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditAssetsName.SetFocus;
    exit;
  end;
  if self.RzNumericEditAssetsNums.IntValue=0 then begin
    MessageBox(self.Handle,'请先输入资产数量再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzNumericEditAssetsNums.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditAssetsUnit.Text))=0 then begin
    MessageBox(self.Handle,'请先输入资产单位再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditAssetsUnit.SetFocus;
    exit;
  end;
  if self.RzNumericEditAssetsPrice.Value=0 then begin
    MessageBox(self.Handle,'请先输入资产单价再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzNumericEditAssetsPrice.SetFocus;
    exit;
  end;

  if cmdAction='ADD' then begin
    sql := Format('INSERT INTO assets(assetsname,assetsnums,assetsunit,assetsprice,assetsdesc,assetsseller) values("%s",%d,"%s",%f,"%s","%s")',
      [ trim(self.RzEditAssetsName.Text),
        self.RzNumericEditAssetsNums.IntValue,
        trim(self.RzEditAssetsUnit.Text),
        self.RzNumericEditAssetsPrice.Value,
        trim(self.RzMemoAssetsDesc.Text),
        trim(self.RzMemoAssetsSeller.Text)
      ]);
  end else if cmdAction='EDIT' then begin
    sql := Format('UPDATE assets SET assetsname="%s",assetsnums=%d,assetsunit="%s",assetsprice=%f,assetsdesc="%s",assetsseller="%s" WHERE id=%d',
      [ trim(self.RzEditAssetsName.Text),
        self.RzNumericEditAssetsNums.IntValue,
        trim(self.RzEditAssetsUnit.Text),
        self.RzNumericEditAssetsPrice.Value,
        trim(self.RzMemoAssetsDesc.Text),
        trim(self.RzMemoAssetsSeller.Text),
        self.editInfoIdx
      ]);
  end;
  //showmessage(sql);
  execMySql(sql,LibHandle);
  self.Close;
end;

procedure TFormAssetsInfo.setControlStatus(action: string);
begin
  self.cmdAction:=action;
  if action='ADD' then begin
    self.Caption:='添加资产';
    self.RzButtonOk.Caption:='添加';
  end else if action='EDIT' then begin
    self.Caption:='编辑资产';
    self.RzButtonOk.Caption:='编辑';
    loadAssetsItemData;
  end;
end;

end.
