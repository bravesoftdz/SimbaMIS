unit fmUserInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzBckgnd, StdCtrls, Mask, RzEdit, RzLabel, RzButton, pngimage,
  ExtCtrls, RzCmboBx, mysql, myfunction, dbfunction, RzPanel, RzRadGrp;

type
  TFormUserInfo = class(TForm)
    Image1: TImage;
    RzButtonCancel: TRzButton;
    RzButtonOk: TRzButton;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel12: TRzLabel;
    RzEditLoginName: TRzEdit;
    RzEditLoginPass: TRzEdit;
    RzEditUserName: TRzEdit;
    RzEditIdCard: TRzEdit;
    RzSeparator1: TRzSeparator;
    RzEditMobileNo: TRzEdit;
    RzEditAddress: TRzEdit;
    RzEditEmail: TRzEdit;
    RzComboBoxSex: TRzComboBox;
    RzComboBoxAccess: TRzComboBox;
    RzLabel13: TRzLabel;
    RzRadioGroupJobStatus: TRzRadioGroup;
    RzPanelWage: TRzPanel;
    RzLabel11: TRzLabel;
    RzNumericEditWage: TRzNumericEdit;
    RzLabel1: TRzLabel;
    RzNumericEditJobSubsidy: TRzNumericEdit;
    RzLabel5: TRzLabel;
    RzNumericEditTelSubsidy: TRzNumericEdit;
    RzLabel14: TRzLabel;
    RzNumericEditHouseSubsidy: TRzNumericEdit;
    RzLabel15: TRzLabel;
    RzNumericEditTransSubsidy: TRzNumericEdit;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
    procedure RzRadioGroupJobStatusClick(Sender: TObject);
  private
    cmdAction: string;
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure initAccessType;
    procedure loadUserItemData;
    { Private declarations }
  public
    editUserName:string;
    procedure setControlStatus(action: string);
    { Public declarations }
  end;

var
  FormUserInfo: TFormUserInfo;

implementation

{$R *.dfm}

procedure TFormUserInfo.FormActivate(Sender: TObject);
begin
  self.RzEditLoginName.SetFocus;
end;

procedure TFormUserInfo.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  initAccessType;
end;

procedure TFormUserInfo.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormUserInfo.initAccessType;
var
  accList:TStringList;
  i: Integer;
begin
  accList:=TStringList.Create;
  getSectionList('ACCESSTYPE', accList);
  for i := 0 to accList.Count - 1 do begin
    self.RzComboBoxAccess.AddItemValue(getUserGroupTitle(strtoint(accList[i])),accList[i]);
  end;
  accList.Free;
end;

procedure TFormUserInfo.loadUserItemData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  sql := Format('SELECT loginname,loginpass,sex,idcard,access,mobileno,email,address,jobstatus,wage,jobsubsidy,telsubsidy,housesubsidy,transsubsidy FROM users WHERE username="%s"',[self.editUserName]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      self.RzEditLoginName.Text:=getUTF8String(MYSQL_ROW^[0]);
      self.RzEditLoginPass.Text:=getUTF8String(MYSQL_ROW^[1]);
      self.RzComboBoxSex.ItemIndex:=getSexIndex(getUTF8String(MYSQL_ROW^[2]));
      self.RzEditIdCard.Text:=getUTF8String(MYSQL_ROW^[3]);
      self.RzComboBoxAccess.ItemIndex:=strtoint(getUTF8String(MYSQL_ROW^[4]));
      self.RzEditMobileNo.Text:=getUTF8String(MYSQL_ROW^[5]);
      self.RzEditAddress.Text:=getUTF8String(MYSQL_ROW^[6]);
      self.RzEditEmail.Text:=getUTF8String(MYSQL_ROW^[7]);

      if getUTF8String(MYSQL_ROW^[8])='0' then begin
        self.RzRadioGroupJobStatus.ItemIndex:=0;
        self.RzPanelWage.Enabled:=true;
        self.RzNumericEditWage.Value:=strtofloat(getUTF8String(MYSQL_ROW^[9]));
        self.RzNumericEditJobSubsidy.Value:=strtofloat(getUTF8String(MYSQL_ROW^[10]));
        self.RzNumericEditTelSubsidy.Value:=strtofloat(getUTF8String(MYSQL_ROW^[11]));
        self.RzNumericEditHouseSubsidy.Value:=strtofloat(getUTF8String(MYSQL_ROW^[12]));
        self.RzNumericEditTransSubsidy.Value:=strtofloat(getUTF8String(MYSQL_ROW^[13]));
      end else begin
        self.RzRadioGroupJobStatus.ItemIndex:=1;
        self.RzPanelWage.Enabled:=false;
      end;

    end;
  end;
end;

procedure TFormUserInfo.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormUserInfo.RzButtonOkClick(Sender: TObject);
var
  sql:string;
begin
  if length(trim(self.RzEditLoginName.Text))=0 then begin
    MessageBox(self.Handle,'请先输入用户名再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditLoginName.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditLoginPass.Text))=0 then begin
    MessageBox(self.Handle,'请先输入用户登录密码再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditLoginPass.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditUserName.Text))=0 then begin
    MessageBox(self.Handle,'请先输入用户姓名再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditUserName.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditIdCard.Text))=0 then begin
    MessageBox(self.Handle,'请先输入用户身份证号再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditIdCard.SetFocus;
    exit;
  end;
  if self.RzComboBoxSex.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请先选择用户性别再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxSex.SetFocus;
    exit;
  end;
  if self.RzComboBoxAccess.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请先选择用户职位再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxAccess.SetFocus;
    exit;
  end;

  if cmdAction='ADD' then begin
    sql := Format('INSERT INTO users SET loginname="%s",loginpass="%s",username="%s",sex="%s",idcard="%s",access=%s,mobileno="%s",address="%s",email="%s",wage=%f,jobsubsidy=%f,telsubsidy=%f,housesubsidy=%f,transsubsidy=%f,jobstatus=%d',
      [ trim(self.RzEditLoginName.Text),
        trim(self.RzEditLoginPass.Text),
        trim(self.RzEditUserName.Text),
        self.RzComboBoxSex.Text,
        trim(self.RzEditIdCard.Text),
        self.RzComboBoxAccess.Value,
        trim(self.RzEditMobileNo.Text),
        trim(self.RzEditAddress.Text),
        trim(self.RzEditEmail.Text),
        self.RzNumericEditWage.Value,
        self.RzNumericEditJobSubsidy.Value,
        self.RzNumericEditTelSubsidy.Value,
        self.RzNumericEditHouseSubsidy.Value,
        self.RzNumericEditTransSubsidy.Value,
        self.RzRadioGroupJobStatus.ItemIndex
      ]);
  end else if cmdAction='EDIT' then begin
    sql := Format('UPDATE users SET loginname="%s",loginpass="%s",sex="%s",idcard="%s",access=%s,mobileno="%s",address="%s",email="%s",wage=%f,jobsubsidy=%f,telsubsidy=%f,housesubsidy=%f,transsubsidy=%f,jobstatus=%d WHERE username="%s"',
      [ trim(self.RzEditLoginName.Text),
        trim(self.RzEditLoginPass.Text),
        self.RzComboBoxSex.Text,
        trim(self.RzEditIdCard.Text),
        self.RzComboBoxAccess.Value,
        trim(self.RzEditMobileNo.Text),
        trim(self.RzEditAddress.Text),
        trim(self.RzEditEmail.Text),
        self.RzNumericEditWage.Value,
        self.RzNumericEditJobSubsidy.Value,
        self.RzNumericEditTelSubsidy.Value,
        self.RzNumericEditHouseSubsidy.Value,
        self.RzNumericEditTransSubsidy.Value,
        self.RzRadioGroupJobStatus.ItemIndex,
        self.editUserName
      ]);
  end;
  //showmessage(sql);
  execMySql(sql,LibHandle);
  self.Close;
end;

procedure TFormUserInfo.RzRadioGroupJobStatusClick(Sender: TObject);
begin
  if self.RzRadioGroupJobStatus.ItemIndex=0 then
    self.RzPanelWage.Enabled:=true
  else
    self.RzPanelWage.Enabled:=false;
end;

procedure TFormUserInfo.setControlStatus(action: string);
begin
  self.cmdAction:=action;
  if action='ADD' then begin
    self.Caption:='添加职员';
    self.RzButtonOk.Caption:='添加';
    self.RzEditUserName.ReadOnly:=false;
  end else if action='EDIT' then begin
    self.Caption:='编辑职员';
    self.RzButtonOk.Caption:='编辑';
    self.RzEditUserName.ReadOnly:=true;
    self.RzEditUserName.Text:=self.editUserName;
    loadUserItemData;
  end;
end;

end.
