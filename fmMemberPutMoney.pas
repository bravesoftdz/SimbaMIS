unit fmMemberPutMoney;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzPanel, StdCtrls, RzCmboBx, RzEdit, RzRadGrp, Mask,
  RzLabel, ExtCtrls, pngimage, mysql, frxClass, frxDesgn, Menus;

type
  TFormMemberPutMoney = class(TForm)
    Image1: TImage;
    RzGroupBox2: TRzGroupBox;
    RzLabel9: TRzLabel;
    RzEditCardNo: TRzEdit;
    RzLabel1: TRzLabel;
    RzRadioGroupPutType: TRzRadioGroup;
    RzNumericEditPutSum: TRzNumericEdit;
    RzLabel2: TRzLabel;
    RzComboBoxCardRate: TRzComboBox;
    RzGroupBox1: TRzGroupBox;
    RzLabel3: TRzLabel;
    RzRadioGroupPayType: TRzRadioGroup;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    RzLabelCardInfo: TRzLabel;
    RzToolButtonDesignReport: TRzToolButton;
    frxReport: TfrxReport;
    PopupMenuDesign: TPopupMenu;
    popMenuDesign: TMenuItem;
    popMenuPreview: TMenuItem;
    frxDesigner: TfrxDesigner;
    RzLabel4: TRzLabel;
    RzNumericEditDonSum: TRzNumericEdit;
    RzLabel5: TRzLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frxReportGetValue(const VarName: string; var Value: Variant);
    procedure popMenuDesignClick(Sender: TObject);
    procedure popMenuPreviewClick(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
    procedure RzEditCardNoChange(Sender: TObject);
    procedure RzNumericEditDonSumChange(Sender: TObject);
    procedure RzRadioGroupPutTypeClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    oldCardNo: string;
    function getCardOver: Variant;
    procedure loadMemberItemInfo;
    procedure initRateList;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; cno: string); reintroduce;
        overload;
    { Public declarations }
  end;

var
  FormMemberPutMoney: TFormMemberPutMoney;

implementation

uses myfunction, dbfunction, fmInvoiceMaker;


{$R *.dfm}

constructor TFormMemberPutMoney.Create(AOwner: TComponent; cno: string);
begin
  inherited Create(AOwner);
  self.oldCardNo:=cno;
end;

procedure TFormMemberPutMoney.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  self.initRateList;
  if length(self.oldCardNo)>0 then begin
    self.RzEditCardNo.Text:=oldCardNo;
    self.RzEditCardNo.ReadOnly:=true;
  end else begin
    self.loadMemberItemInfo;
  end;

  if ACCESS<5 then begin
    self.RzRadioGroupPayType.Items.Delete(3);
  end;

  if ACCESS>=8 then
    self.RzToolButtonDesignReport.Visible:=true
  else
    self.RzToolButtonDesignReport.Visible:=false;
end;

procedure TFormMemberPutMoney.initRateList;
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

procedure TFormMemberPutMoney.loadMemberItemInfo;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  i:integer;
begin
  self.RzLabelCardInfo.Caption:='';
  sql := Format('SELECT cardrate,name,mobileno FROM members WHERE cardno="%s"',[trim(self.RzEditCardNo.Text)]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      for i := 0 to self.RzComboBoxCardRate.Items.Count - 1 do begin
        if strtofloat(self.RzComboBoxCardRate.Items[i])=strtofloat(getUTF8String(MYSQL_ROW^[0])) then begin
          self.RzComboBoxCardRate.ItemIndex:=i;
          self.RzLabelCardInfo.Caption:=' ('+getUTF8String(MYSQL_ROW^[1])+','+getUTF8String(MYSQL_ROW^[2])+')';
          break;
        end;
      end;
    end;
  end;
end;

procedure TFormMemberPutMoney.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormMemberPutMoney.frxReportGetValue(const VarName: string; var
    Value: Variant);
begin
  if CompareText(VarName,'memberno') = 0 then begin
    Value := trim(self.RzEditCardNo.Text);
  end else if CompareText(VarName,'putcount') = 0 then begin
    Value := self.RzNumericEditPutSum.IntValue;
  end else if CompareText(VarName,'cardover') = 0 then begin
    Value := self.getCardOver;
  end else if CompareText(VarName,'cardrate') = 0 then begin
    Value := strtofloat(self.RzComboBoxCardRate.Text);
  end else if CompareText(VarName,'donatecount') = 0 then begin
    Value := self.RzNumericEditDonSum.IntValue;
  end else if CompareText(VarName,'misTitle') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','misTitle','辛巴西餐咖啡厅');
  end else if CompareText(VarName,'misTel') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','mistel','15038003911');
  end else if CompareText(VarName,'misWeibo') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','misweibo','http://weibo.cn/simbacafe');
  end else if CompareText(VarName,'misWeixin') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','misweixin','simbacafe');
  end else if CompareText(VarName,'misWeb') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','misweb','http://www.simbacafe.com');
  end;
end;

function TFormMemberPutMoney.getCardOver: Variant;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  Result := 0;
  sql := Format('SELECT cardover FROM members WHERE cardno="%s"',[trim(self.RzEditCardNo.Text)]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      Result := strtoint(getUTF8String(MYSQL_ROW^[0]));
    end;
  end;
end;

procedure TFormMemberPutMoney.popMenuDesignClick(Sender: TObject);
begin
  loadReportDesignFile(self.frxReport,'memberputmoney.fr3');
  self.frxReport.DesignReport();
end;

procedure TFormMemberPutMoney.popMenuPreviewClick(Sender: TObject);
begin
  loadReportDesignFile(self.frxReport,'memberputmoney.fr3');
  self.frxReport.ShowReport();
end;

procedure TFormMemberPutMoney.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormMemberPutMoney.RzButtonOkClick(Sender: TObject);
var
  res:integer;
  sql:string;
  f:TFormInvoiceMaker;
  inid:integer;
begin
  if length(trim(self.RzEditCardNo.Text))=0 then begin
    MessageBox(self.Handle,'请先输入会员卡号再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditCardNo.SetFocus;
    exit;
  end;
  if length(trim(self.RzLabelCardInfo.Caption))=0 then begin
    MessageBox(self.Handle,'没有你输入的会员卡号，请核对后重新提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditCardNo.SetFocus;
    exit;
  end;
  if self.RzNumericEditPutSum.IntValue=0 then begin
    MessageBox(self.Handle,'请先输入充值金额再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzNumericEditPutSum.SetFocus;
    exit;
  end;
  if self.RzComboBoxCardRate.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请先选择卡折扣率再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxCardRate.SetFocus;
    exit;
  end;

  res := MessageBox(self.Handle, '充值操作是否已全部完成？', '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    //写充值明细记录
    sql := Format('INSERT INTO memberdetail SET cardno="%s",paysum=%d,donatesum=%d,payidx=0,paytype=%d,loginname="%s"',
      [ trim(self.RzEditCardNo.Text),
        self.RzNumericEditPutSum.IntValue,
        self.RzNumericEditDonSum.IntValue,
        self.RzRadioGroupPayType.ItemIndex,
        LOGINNAME
      ]);
    execMySql(sql,LibHandle);
    inid:=mysql_insert_id(LibHandle);
    //修改会员表余额与折扣率
    sql := Format('UPDATE members SET cardrate=%f,cashrate=(cashrate*cardover+%d)/(cardover+%d+%d),cardover=cardover+%d+%d where cardno="%s"',
      [ strtofloat(self.RzComboBoxCardRate.Text),
        self.RzNumericEditPutSum.IntValue,
        self.RzNumericEditPutSum.IntValue,
        self.RzNumericEditDonSum.IntValue,
        self.RzNumericEditPutSum.IntValue,
        self.RzNumericEditDonSum.IntValue,
        trim(self.RzEditCardNo.Text)
      ]);
    execMySql(sql,LibHandle);
    //打印充值单据
    if self.RzRadioGroupPayType.ItemIndex<3 then begin
      loadReportDesignFile(self.frxReport,'memberputmoney.fr3');
      if self.frxReport.PrepareReport(true) then begin
        frxReport.PrintOptions.Printer:=getPrinter('4');
        frxReport.PrintOptions.ShowDialog:=false;
        self.frxReport.Print;
      end;
    end;
    //开发票
    if self.RzRadioGroupPayType.ItemIndex<3 then begin
      f:=TFormInvoiceMaker.Create(self,1,inid);
      f.ShowModal;
      f.Destroy;
    end;

    self.Close;
  end;
end;

procedure TFormMemberPutMoney.RzEditCardNoChange(Sender: TObject);
begin
  loadMemberItemInfo;
end;

procedure TFormMemberPutMoney.RzNumericEditDonSumChange(Sender: TObject);
begin
  if self.RzNumericEditDonSum.IntValue>0 then begin
    self.RzComboBoxCardRate.ItemIndex:=0;
    self.RzComboBoxCardRate.ReadOnly:=true;
  end else begin
    self.RzComboBoxCardRate.ItemIndex:=0;
    self.RzComboBoxCardRate.ReadOnly:=false;
  end;
end;

procedure TFormMemberPutMoney.RzRadioGroupPutTypeClick(Sender: TObject);
var
  v:integer;
begin
  v:=strtoint(RzRadioGroupPutType.Items[RzRadioGroupPutType.ItemIndex]);
  self.RzNumericEditPutSum.IntValue:=v;

  self.RzNumericEditDonSum.IntValue:=0;
end;

end.
