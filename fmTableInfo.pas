unit fmTableInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzCmboBx, Mask, RzEdit, RzButton, RzBckgnd, RzLabel,
  pngimage, ExtCtrls, RzRadChk, mysql, RzPanel;

type
  TFormTableInfo = class(TForm)
    Image1: TImage;
    RzLabel2: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    RzEditTableName: TRzEdit;
    RzComboBoxTableType: TRzComboBox;
    RzNumericMinCons: TRzNumericEdit;
    RzNumericMaxUser: TRzNumericEdit;
    RzRadioConsAll: TRzRadioButton;
    RzRadioConsPer: TRzRadioButton;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    RzLabel13: TRzLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    cmdAction: string;
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadTableItemData;
    procedure initTableType;
    { Private declarations }
  public
    editTableName:string;
    procedure setControlStatus(action: string);
    { Public declarations }
  end;

var
  FormTableInfo: TFormTableInfo;

implementation

uses myfunction, dbfunction;
{$R *.dfm}

procedure TFormTableInfo.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormTableInfo.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  initTableType;
end;

procedure TFormTableInfo.FormActivate(Sender: TObject);
begin
  self.RzEditTableName.SetFocus;
end;

procedure TFormTableInfo.initTableType;
var
  accList:TStringList;
  i: Integer;
begin
  accList:=TStringList.Create;
  getSectionList('TABLETYPE',accList);
  for i := 0 to accList.Count - 1 do begin
    self.RzComboBoxTableType.AddItemValue(getTableGroupTitle(strtoint(accList[i])),accList[i]);
  end;
  accList.Free;
end;

procedure TFormTableInfo.loadTableItemData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  sql := Format('SELECT tabletype,mincons,constype,maxuser FROM tables WHERE tablename="%s"',[self.editTableName]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      self.RzComboBoxTableType.ItemIndex:=strtoint(getUTF8String(MYSQL_ROW^[0]));
      self.RzNumericMinCons.Text:=getUTF8String(MYSQL_ROW^[1]);
      if getUTF8String(MYSQL_ROW^[2])='all' then begin
        self.RzRadioConsAll.Checked:=true;
        self.RzRadioConsPer.Checked:=false;
      end else begin
        self.RzRadioConsAll.Checked:=false;
        self.RzRadioConsPer.Checked:=true;
      end;
      self.RzNumericMaxUser.Text:=getUTF8String(MYSQL_ROW^[3]);
    end;
  end;
end;

procedure TFormTableInfo.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormTableInfo.RzButtonOkClick(Sender: TObject);
var
  sql:string;
  constype:string;
begin
  if length(trim(self.RzEditTableName.Text))=0 then begin
    MessageBox(self.Handle,'请先输入台位名称再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditTableName.SetFocus;
    exit;
  end;
  if self.RzComboBoxTableType.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请先选择台位类型再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxTableType.SetFocus;
    exit;
  end;

  if cmdAction='ADD' then begin
    if self.RzRadioConsAll.Checked then
      constype:='all'
    else
      constype:='per';
    sql := Format('INSERT INTO tables SET tablename="%s",tabletype=%d,typedesc="%s",mincons=%d,constype="%s",maxuser=%d',
      [ trim(self.RzEditTableName.Text),
        self.RzComboBoxTableType.ItemIndex,
        self.RzComboBoxTableType.Text,
        self.RzNumericMinCons.IntValue,
        constype,
        self.RzNumericMaxUser.IntValue
      ]);
  end else if cmdAction='EDIT' then begin
    if self.RzRadioConsAll.Checked then
      constype:='all'
    else
      constype:='per';
    sql := Format('UPDATE tables SET tabletype=%d,typedesc="%s",mincons=%d,constype="%s",maxuser=%d WHERE tablename="%s"',
      [ self.RzComboBoxTableType.ItemIndex,
        self.RzComboBoxTableType.Text,
        self.RzNumericMinCons.IntValue,
        constype,
        self.RzNumericMaxUser.IntValue,
        self.editTableName
      ]);
  end;
  //showmessage(sql);
  execMySql(sql,LibHandle);
  self.Close;
end;

procedure TFormTableInfo.setControlStatus(action: string);
begin
  self.cmdAction:=action;
  if action='ADD' then begin
    self.Caption:='添加台位';
    self.RzButtonOk.Caption:='添加';
    self.RzEditTableName.ReadOnly:=false;
  end else if action='EDIT' then begin
    self.Caption:='编辑台位';
    self.RzButtonOk.Caption:='编辑';
    self.RzEditTableName.ReadOnly:=true;
    self.RzEditTableName.Text:=self.editTableName;
    loadTableItemData;
  end;
end;

end.
