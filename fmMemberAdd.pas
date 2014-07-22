unit fmMemberAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mysql, RzButton, RzPanel, StdCtrls, RzCmboBx, Mask, RzEdit, RzLabel,
  ExtCtrls, pngimage;

type
  TFormMemberAdd = class(TForm)
    Image1: TImage;
    RzGroupBox1: TRzGroupBox;
    RzLabel8: TRzLabel;
    RzEditCardNo: TRzEdit;
    RzLabel1: TRzLabel;
    RzEditCardName: TRzEdit;
    RzLabel3: TRzLabel;
    RzComboBoxSex: TRzComboBox;
    RzLabel2: TRzLabel;
    RzEditCardTel: TRzEdit;
    RzLabel10: TRzLabel;
    RzEditCardAddr: TRzEdit;
    RzGroupBox2: TRzGroupBox;
    RzLabel9: TRzLabel;
    RzEditCardPass: TRzEdit;
    RzLabel4: TRzLabel;
    RzEditCardPass2: TRzEdit;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    RzGroupBox3: TRzGroupBox;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzComboBoxForWhere: TRzComboBox;
    RzComboBoxForWho: TRzComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
    procedure RzComboBoxForWhereChange(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure initForWhereList;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMemberAdd: TFormMemberAdd;

implementation

uses myfunction, dbfunction, fmMemberPutMoney;

{$R *.dfm}

procedure TFormMemberAdd.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  initForWhereList;
end;

procedure TFormMemberAdd.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormMemberAdd.initForWhereList;
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

procedure TFormMemberAdd.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormMemberAdd.RzButtonOkClick(Sender: TObject);
var
  sql:string;
  res:integer;
  f:TFormMemberPutMoney;
begin
  if length(trim(self.RzEditCardNo.Text))=0 then begin
    MessageBox(self.Handle,'请先输入会员卡号再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditCardNo.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditCardName.Text))=0 then begin
    MessageBox(self.Handle,'请先输入会员姓名再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditCardName.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditCardTel.Text))=0 then begin
    MessageBox(self.Handle,'请先输入会员联系电话再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditCardTel.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditCardPass.Text))=0 then begin
    MessageBox(self.Handle,'请先输入会员卡密码再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditCardPass.SetFocus;
    exit;
  end;
  if trim(self.RzEditCardPass.Text)<>trim(self.RzEditCardPass2.Text) then begin
    MessageBox(self.Handle,'输入的卡密码与验证密码不一致！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditCardPass2.SetFocus;
    exit;
  end;
  {
  if self.RzComboBoxForWhere.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请先选择办卡服务人员部门','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxForWhere.SetFocus;
    exit;
  end;
  }
  if self.RzComboBoxForWho.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请先选择办卡服务人员','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxForWho.SetFocus;
    exit;
  end;

  sql := Format('INSERT INTO members SET cardno="%s",cardpass="%s",name="%s",sex="%s",mobileno="%s",address="%s",addbywho=%s,loginname="%s"',
      [ trim(self.RzEditCardNo.Text),
        trim(self.RzEditCardPass.Text),
        trim(self.RzEditCardName.Text),
        self.RzComboBoxSex.Text,
        trim(self.RzEditCardTel.Text),
        trim(self.RzEditCardAddr.Text),
        self.RzComboBoxForWho.Value,
        LOGINNAME
      ]);
  //showmessage(sql);
  execMySql(sql,LibHandle);

  res := MessageBox(self.Handle, '新会员添加完成，是否现在就进行充值？', '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    f:=TFormMemberPutMoney.Create(self,trim(self.RzEditCardNo.Text));
    f.ShowModal;
    f.Destroy;
  end;
  self.Close;
end;

procedure TFormMemberAdd.RzComboBoxForWhereChange(Sender: TObject);
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
