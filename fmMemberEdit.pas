unit fmMemberEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzPanel, StdCtrls, RzCmboBx, Mask, RzEdit, RzLabel,
  ExtCtrls, pngimage, mysql;

type
  TFormMemberEdit = class(TForm)
    Image1: TImage;
    RzGroupBox1: TRzGroupBox;
    RzLabel8: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel10: TRzLabel;
    RzEditCardNo: TRzEdit;
    RzEditCardName: TRzEdit;
    RzComboBoxSex: TRzComboBox;
    RzEditCardTel: TRzEdit;
    RzEditCardAddr: TRzEdit;
    RzGroupBox2: TRzGroupBox;
    RzLabel9: TRzLabel;
    RzLabel4: TRzLabel;
    RzEditCardPass: TRzEdit;
    RzEditCardPass2: TRzEdit;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    RzComboBoxCardRate: TRzComboBox;
    RzLabel5: TRzLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    editMemberid:integer;
    procedure loadMemberItemInfo;
    procedure initRateList;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; cno: integer); reintroduce;
        overload;
    { Public declarations }
  end;

var
  FormMemberEdit: TFormMemberEdit;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

constructor TFormMemberEdit.Create(AOwner: TComponent; cno: integer);
begin
  inherited Create(AOwner);
  editMemberid:=cno;
end;

procedure TFormMemberEdit.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormMemberEdit.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  self.initRateList;
  self.loadMemberItemInfo;
end;

procedure TFormMemberEdit.initRateList;
var
  l:TStringList;
  i:integer;
begin
  l:=TStringList.Create;
  getSectionList('RATETYPE',l);
  for i := 0 to l.Count - 1 do begin
    self.RzComboBoxCardRate.Items.Add(GetStringFromINI('RATETYPE',l[i],'1'))
  end;
  l.Free;
end;

procedure TFormMemberEdit.loadMemberItemInfo;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  i:integer;
begin
  sql := Format('SELECT cardno,cardpass,name,sex,mobileno,address,cardrate FROM members WHERE id=%d',[self.editMemberid]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      self.RzEditCardNo.Text:=getUTF8String(MYSQL_ROW^[0]);
      self.RzEditCardNo.ReadOnly:=true;
      self.RzEditCardPass.Text:=getUTF8String(MYSQL_ROW^[1]);
      self.RzEditCardPass2.Text:=getUTF8String(MYSQL_ROW^[1]);
      self.RzEditCardName.Text:=getUTF8String(MYSQL_ROW^[2]);
      if getUTF8String(MYSQL_ROW^[3])='男' then
        self.RzComboBoxSex.ItemIndex:=0
      else
        self.RzComboBoxSex.ItemIndex:=1;
      self.RzEditCardTel.Text:=getUTF8String(MYSQL_ROW^[4]);
      self.RzEditCardAddr.Text:=getUTF8String(MYSQL_ROW^[5]);
      for i := 0 to self.RzComboBoxCardRate.Items.Count - 1 do begin
        if strtofloat(self.RzComboBoxCardRate.Items[i])=strtofloat(getUTF8String(MYSQL_ROW^[6])) then begin
          self.RzComboBoxCardRate.ItemIndex:=i;
          break;
        end;
      end;
    end;
  end;
end;

procedure TFormMemberEdit.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormMemberEdit.RzButtonOkClick(Sender: TObject);
var
  sql:string;
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

  sql := Format('UPDATE members SET cardno="%s",cardpass="%s",name="%s",sex="%s",mobileno="%s",address="%s",cardrate=%f where id=%d',
      [ trim(self.RzEditCardNo.Text),
        trim(self.RzEditCardPass.Text),
        trim(self.RzEditCardName.Text),
        self.RzComboBoxSex.Text,
        trim(self.RzEditCardTel.Text),
        trim(self.RzEditCardAddr.Text),
        strtofloat(self.RzComboBoxCardRate.Text),
        self.editMemberid
      ]);
  //showmessage(sql);
  execMySql(sql,LibHandle);
  self.Close;
end;

end.
