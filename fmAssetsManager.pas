unit fmAssetsManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, RzListVw, RzButton, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, mysql;

type
  TFormAssetsManager = class(TForm)
    RzPanel1: TRzPanel;
    RzLabelRows: TRzLabel;
    RzButtonCancel: TRzButton;
    RzListView: TRzListView;
    ImageList1: TImageList;
    RzButtonAdd: TRzButton;
    RzButtonEdit: TRzButton;
    RzButtonDel: TRzButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonAddClick(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonDelClick(Sender: TObject);
    procedure RzButtonEditClick(Sender: TObject);
    procedure RzListViewDblClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadAssetsData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAssetsManager: TFormAssetsManager;

implementation

uses myfunction, dbfunction, fmTableInfo, fmAssetsInfo;

{$R *.dfm}

procedure TFormAssetsManager.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormAssetsManager.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  loadAssetsData();
end;

procedure TFormAssetsManager.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormAssetsManager.loadAssetsData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  item: TListItem;
  total: real;
  yu:real;
begin
  RzListView.Items.BeginUpdate;
  self.RzListView.Clear;
  RzListView.SmallImages:=ImageList1;
  ImageList1.Height:=26;
  ImageList1.Width:=0;
  total:=0;

  sql := 'SELECT id,assetsname,assetsnums,assetsunit,assetsprice,assetsdesc,assetsseller,creationtime FROM assets order by id';
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
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[7]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[5]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[6]));
        yu:=strtofloat(getUTF8String(MYSQL_ROW^[2]))*strtofloat(getUTF8String(MYSQL_ROW^[4]));
        total:=total+yu;
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
  RzLabelRows.Caption:='资产总额：'+floattostr(total)+'元';
end;

procedure TFormAssetsManager.RzButtonAddClick(Sender: TObject);
var
  f:TFormAssetsInfo;
begin
  f:=TFormAssetsInfo.Create(self);
  f.editInfoIdx:=0;
  f.setControlStatus('ADD');
  f.ShowModal;
  self.loadAssetsData;
  f.Destroy;
end;

procedure TFormAssetsManager.RzButtonDelClick(Sender: TObject);
var
  res:integer;
  sql:string;
  item:TListItem;
begin
  if self.RzListView.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要删除的资产条目！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  item:=self.RzListView.Selected;
  res := MessageBox(self.Handle, PWideChar('确定要删除第'+item.Caption+'项'+item.SubItems[0]+'资产条目吗？'), '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    sql := Format('DELETE FROM assets WHERE id=%s',[item.Caption]);
    execMySql(sql,LibHandle);
    self.loadAssetsData;
  end;
end;

procedure TFormAssetsManager.RzButtonEditClick(Sender: TObject);
var
  f:TFormAssetsInfo;
begin
  if self.RzListView.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要编辑的资产条目！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  f:=TFormAssetsInfo.Create(self);
  f.editInfoIdx:=strtoint(self.RzListView.Selected.Caption);
  f.setControlStatus('EDIT');
  f.ShowModal;
  self.loadAssetsData;
  f.Destroy;
end;

procedure TFormAssetsManager.RzListViewDblClick(Sender: TObject);
begin
  self.RzButtonEditClick(self);
end;

end.
