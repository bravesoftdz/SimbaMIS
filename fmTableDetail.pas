unit fmTableDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mysql, ComCtrls, RzListVw, ImgList, StdCtrls, RzLabel, RzButton,
  ExtCtrls, RzPanel, RzRadGrp, Mask, RzEdit, RzTabs, Math, frxDesgn, frxClass,
  Menus, RzCommon;

type
  TFormTableDetail = class(TForm)
    RzListView: TRzListView;
    ImageList1: TImageList;
    RzPanel1: TRzPanel;
    RzToolButtonTuiCai: TRzToolButton;
    RzLabelTotal: TRzLabel;
    RzPanelPay: TRzPanel;
    RzRadioGroupPayType: TRzRadioGroup;
    RzLabelTableName: TRzLabel;
    RzPageControlRate: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    RzRadioGroupStoreCard: TRzRadioGroup;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzEditSearchKey: TRzEdit;
    RzRadioGroupSearchType: TRzRadioGroup;
    RzPanel2: TRzPanel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabelCardNo: TRzLabel;
    RzLabelCardTel: TRzLabel;
    RzLabelCardName: TRzLabel;
    RzLabelCardRate: TRzLabel;
    RzLabelCardOver: TRzLabel;
    RzRadioGroup1: TRzRadioGroup;
    RzPageControlTicket: TRzPageControl;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    RzLabel8: TRzLabel;
    RzNumericEditCashTicket: TRzNumericEdit;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzMemoCashTicketNoList: TRzMemo;
    RzLabel11: TRzLabel;
    RzLabel12: TRzLabel;
    RzLabelNetTicket: TRzLabel;
    RzLabel15: TRzLabel;
    RzLabelNetTicketStatus: TRzLabel;
    RzLabel17: TRzLabel;
    RzLabelNetTicketTime: TRzLabel;
    RzRadioGroupTicket: TRzRadioGroup;
    TabSheet5: TRzTabSheet;
    RzLabel19: TRzLabel;
    RzEditNetTicketNo: TRzEdit;
    RzRadioGroupRate: TRzRadioGroup;
    RzPageControlPay: TRzPageControl;
    TabSheet6: TRzTabSheet;
    TabSheet7: TRzTabSheet;
    RzRadioGroup2: TRzRadioGroup;
    RzRadioGroup3: TRzRadioGroup;
    RzPanel3: TRzPanel;
    RzToolButtonPayEnd: TRzToolButton;
    RzPanelStoreFunction: TRzPanel;
    RzLabel22: TRzLabel;
    RzEditStoreCardPass: TRzEdit;
    RzToolButtonInputStoreCardPass: TRzToolButton;
    RzToolButtonDoPayOfStoreCard: TRzToolButton;
    RzToolButtonViewAliPay: TRzToolButton;
    RzPanelCashFunction: TRzPanel;
    RzLabel21: TRzLabel;
    RzNumericEditTotal3: TRzNumericEdit;
    RzNumericEditTotal2: TRzNumericEdit;
    RzLabel20: TRzLabel;
    RzPanel4: TRzPanel;
    RzToolButtonSumTotal: TRzToolButton;
    RzLabelFinalTotal: TRzLabel;
    RzLabel13: TRzLabel;
    RzLabelNetTicketEndTime: TRzLabel;
    RzLabel14: TRzLabel;
    RzPanel5: TRzPanel;
    RzToolButtonLeaderOk: TRzToolButton;
    RzToolButtonPrintList: TRzToolButton;
    RzToolButtonDesignReport: TRzToolButton;
    frxReport: TfrxReport;
    frxDesigner1: TfrxDesigner;
    RzPanelIntNoInvoice: TRzPanel;
    RzLabel16: TRzLabel;
    RzLabelLastFinalTotal: TRzLabel;
    RzToolButtonIntNoInvoice: TRzToolButton;
    RzLabelRateTip: TRzLabel;
    RzToolButtonPutMoney: TRzToolButton;
    RzToolButtonPreviewList: TRzToolButton;
    frxUserDataSetConsDetail: TfrxUserDataSet;
    RzToolButtonPreviewFinal: TRzToolButton;
    RzToolButtonDesignMakefrom: TRzToolButton;
    RzToolButtonPreviewMakefrom: TRzToolButton;
    RzToolButtonPrintMakeFrom: TRzToolButton;
    RzToolButtonMian: TRzToolButton;
    RzToolButtonPrintPre: TRzToolButton;
    PopupMenuIntNoVoice: TPopupMenu;
    IntNoVoice1: TMenuItem;
    IntNoVoice2: TMenuItem;
    IntNoVoice3: TMenuItem;
    IntNoVoice4: TMenuItem;
    IntNoVoice5: TMenuItem;
    IntNoVoice6: TMenuItem;
    IntNoVoice7: TMenuItem;
    IntNoVoice8: TMenuItem;
    IntNoVoice9: TMenuItem;
    RzMenuController1: TRzMenuController;
    N1: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure frxReportBeginDoc(Sender: TObject);
    procedure frxReportGetValue(const VarName: string; var Value: Variant);
    procedure frxUserDataSetConsDetailGetValue(const VarName: string; var Value:
        Variant);
    procedure IntNoVoice1Click(Sender: TObject);
    procedure RzEditNetTicketNoChange(Sender: TObject);
    procedure RzEditSearchKeyChange(Sender: TObject);
    procedure RzNumericEditCashTicketChange(Sender: TObject);
    procedure RzNumericEditTotal2Exit(Sender: TObject);
    procedure RzNumericEditTotal2KeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure RzRadioGroupPayTypeClick(Sender: TObject);
    procedure RzRadioGroup3Click(Sender: TObject);
    procedure RzRadioGroupSearchTypeClick(Sender: TObject);
    procedure RzRadioGroupTicketClick(Sender: TObject);
    procedure RzToolButtonDesignMakefromClick(Sender: TObject);
    procedure RzToolButtonDesignReportClick(Sender: TObject);
    procedure RzToolButtonDoPayOfStoreCardClick(Sender: TObject);
    procedure RzToolButtonLeaderOkClick(Sender: TObject);
    procedure RzToolButtonMianClick(Sender: TObject);
    procedure RzToolButtonPayEndClick(Sender: TObject);
    procedure RzToolButtonPreviewListClick(Sender: TObject);
    procedure RzToolButtonPreviewMakefromClick(Sender: TObject);
    procedure RzToolButtonPrintListClick(Sender: TObject);
    procedure RzToolButtonPrintMakeFromClick(Sender: TObject);
    procedure RzToolButtonPrintPreClick(Sender: TObject);
    procedure RzToolButtonPutMoneyClick(Sender: TObject);
    procedure RzToolButtonSumTotalClick(Sender: TObject);
    procedure RzToolButtonTuiCaiClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    mySQL_Res_Detail: PMYSQL_RES;
    tablename:string;
    consTotal:integer;
    PayTypeList: TStringList;
    PayFinalTotal: integer;
    PayLastFinalTotal:integer;
    isPrintFinal: boolean;
    procedure doPayWithOther;
    procedure doPayWithStoreCard;
    function getFreeValue: integer;
    function getPrintCountString: string;
    procedure loadTableDetailData;
    procedure printConsList(isFinal: Boolean);
    procedure showCashRateTip;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; tname: string); reintroduce;
        overload;
    { Public declarations }
  end;

var
  FormTableDetail: TFormTableDetail;

implementation

uses myfunction, dbfunction, fmInvoiceMaker, fmMemberPutMoney, fmTuiCai;

{$R *.dfm}

constructor TFormTableDetail.Create(AOwner: TComponent; tname: string);
begin
  inherited Create(AOwner);
  self.tablename:=tname;
  self.Caption:=self.Caption+':'+tname;
end;

procedure TFormTableDetail.doPayWithOther;
var
  sql:string;
  res:integer;
  inidx:integer;
  f:TFormInvoiceMaker;
begin
  if self.RzRadioGroupPayType.ItemIndex=0 then begin
    res := MessageBox(self.Handle, '确认您已完成现金收款操作？', '提示', MB_YESNO or MB_ICONWARNING);
    if res = IDNO then begin
      exit;
    end;
  end else if self.RzRadioGroupPayType.ItemIndex=2 then begin
    res := MessageBox(self.Handle, '确认您已完成银行卡刷卡操作？', '提示', MB_YESNO or MB_ICONWARNING);
    if res = IDNO then begin
      exit;
    end;
  end else if self.RzRadioGroupPayType.ItemIndex=3 then begin
    res := MessageBox(self.Handle, '确认支付宝款项已到帐？', '提示', MB_YESNO or MB_ICONWARNING);
    if res = IDNO then begin
      exit;
    end;
  end;
  //写入payitems
  sql:=Format('INSERT INTO payitems(tablename,constotal,willpaysum,paysum,paytype,payrate,loginname) values("%s",%d,%d,%d,%d,%f,"%s")',
      [ self.tablename,
        self.consTotal,
        self.PayFinalTotal,
        self.PayLastFinalTotal,
        strtoint(self.PayTypeList[self.RzRadioGroupPayType.ItemIndex]),
        strtofloat(self.RzRadioGroupRate.Items[self.RzRadioGroupRate.ItemIndex]),
        LOGINNAME
      ]);
  execMySql(sql,LibHandle);
  inidx:=mysql_insert_id(LibHandle);
  //写入现金券金额与券号
  if self.RzRadioGroupTicket.ItemIndex=1 then begin //现金券
    if self.RzNumericEditCashTicket.IntValue>0 then begin
      sql:=Format('UPDATE payitems set payticket=%d,ticketnumber="%s" where id=%d',
        [ self.RzNumericEditCashTicket.IntValue,
          self.RzMemoCashTicketNoList.Lines.ToString,
          inidx
        ]);
      execMySql(sql,LibHandle);
    end;
  end else if self.RzRadioGroupTicket.ItemIndex=2 then begin //电子券
    if length(self.RzLabelNetTicket.Caption)>0 then begin
      if strtoint(self.RzLabelNetTicket.Caption)>0 then begin
        sql:=Format('UPDATE payitems set payticket=%d,ticketnumber="%s" where id=%d',
          [ strtoint(self.RzLabelNetTicket.Caption),
            Uppercase(trim(self.RzEditNetTicketNo.Text)),
            inidx
          ]);
        execMySql(sql,LibHandle);
        sql:=Format('UPDATE nettickets set ticketstatus=1,ticketpayidx=%d where ticketno="%s"',
          [ inidx,
            Uppercase(trim(self.RzEditNetTicketNo.Text))
          ]);
        execMySql(sql,LibHandle);
      end;
    end;
  end;
  //补写点菜明细的payinx
  sql:=Format('UPDATE consumption set payidx=%d where tablename="%s" and payidx=0',
      [ inidx,
        self.tablename
      ]);
  execMySql(sql,LibHandle);
  //修改桌位的状态
  sql:=Format('UPDATE tables SET tablestatus=0,printtotal=0 where tablename="%s"',[self.tablename]);
  execMySql(sql,LibHandle);
  //打印小票
  printConsList(true);
  //写发票状态，抹零是不能开发票的
  if self.RzToolButtonIntNoInvoice.Tag>0 then begin
    sql:=Format('UPDATE payitems SET invoicestatus=3 where id=%d',[inidx]);
    execMySql(sql,LibHandle);
  end else begin
  //开发票
    f:=TFormInvoiceMaker.Create(self,0,inidx);
    f.ShowModal;
    f.Destroy;
  end;

  self.Close;
end;

procedure TFormTableDetail.doPayWithStoreCard;
var
  sql:string;
  res,score:integer;
  srate:double;
  inidx:integer;
begin
  res := MessageBox(self.Handle, '确认您已完成储值卡扣款操作？', '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDNO then begin
    exit;
  end;
  //写入payitems
  sql:=Format('INSERT INTO payitems(tablename,constotal,willpaysum,paysum,paytype,payrate,invoicestatus,loginname) values("%s",%d,%d,%d,%d,%f,3,"%s")',
      [ self.tablename,
        self.consTotal,
        self.PayFinalTotal,
        self.PayLastFinalTotal,
        strtoint(self.PayTypeList[self.RzRadioGroupPayType.ItemIndex]),
        strtofloat(self.RzLabelCardRate.Caption),
        LOGINNAME
      ]);
  execMySql(sql,LibHandle);
  inidx:=mysql_insert_id(LibHandle);
  //补写memberdetail扣款记录的payidx号
  sql:=Format('UPDATE memberdetail set payidx=%d where id=%d',
      [ inidx,
        self.RzToolButtonPayEnd.Tag
      ]);
  execMySql(sql,LibHandle);
  //补写点菜明细的payinx
  sql:=Format('UPDATE consumption set payidx=%d where tablename="%s" and payidx=0',
      [ inidx,
        self.tablename
      ]);
  execMySql(sql,LibHandle);
  //修改桌位的状态
  sql:=Format('UPDATE tables SET tablestatus=0,printtotal=0 where tablename="%s"',[self.tablename]);
  execMySql(sql,LibHandle);
  //打印小票
  printConsList(true);
  //写入消费积分记录
  srate:=GetFloatFromINI('SCORE', 'rate', 1);
  score:=trunc(PayLastFinalTotal/srate);
  sql:=Format('INSERT INTO scoredetail(cardno,scoresum,payidx,sdesc,loginname) values("%s",%d,%d,"%s","%s")',
      [ self.RzLabelCardNo.Caption,
        score,
        inidx,
        '消费自动积分',
        LOGINNAME
      ]);
  execMySql(sql,LibHandle);
  //修改积分余额
  sql:=Format('UPDATE members set scoreover=scoreover+%d where cardno="%s"',
      [ score,
        self.RzLabelCardNo.Caption
      ]);
  execMySql(sql,LibHandle);

  self.Close;
end;

procedure TFormTableDetail.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if mySQL_Res_Detail<>nil then
    mysql_free_result(mySQL_Res_Detail);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);

  self.PayTypeList.Free;
end;

procedure TFormTableDetail.FormCreate(Sender: TObject);
var
  i: Integer;
  ratelist:TStringList;
begin
  self.PayTypeList:=TStringList.Create;
  getSectionList('PAYTYPE',self.PayTypeList);
  for i := 0 to PayTypeList.Count - 1 do begin
    self.RzRadioGroupPayType.Items.Add(GetStringFromINI('PAYTYPE',PayTypeList[i],'现金'))
  end;

  ratelist:=TStringList.Create;
  getSectionList('RATETYPE',ratelist);
  for i := 0 to ratelist.Count - 1 do begin
    self.RzRadioGroupRate.Items.Add(GetStringFromINI('RATETYPE',ratelist[i],'1'));
  end;
  ratelist.Free;

  if ACCESS>=8 then begin
    self.RzToolButtonDesignReport.Visible:=true;
    self.RzToolButtonPreviewList.Visible:=true;
    self.RzToolButtonPreviewFinal.Visible:=true;
    self.RzToolButtonDesignMakefrom.Visible:=true;
    self.RzToolButtonPreviewMakefrom.Visible:=true;
  end else begin
    self.RzToolButtonDesignReport.Visible:=false;
    self.RzToolButtonPreviewList.Visible:=false;
    self.RzToolButtonPreviewFinal.Visible:=false;
    self.RzToolButtonDesignMakefrom.Visible:=false;
    self.RzToolButtonPreviewMakefrom.Visible:=false;
  end;

  connectMySql(LibHandle);
  self.loadTableDetailData;

  if self.RzRadioGroupPayType.Items.Count>0 then
    self.RzRadioGroupPayType.ItemIndex:=0;
  if self.RzRadioGroupRate.Items.Count>0 then
    self.RzRadioGroupRate.ItemIndex:=0;
  self.RzRadioGroupTicket.ItemIndex:=0;
end;

procedure TFormTableDetail.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  {if Key=VK_ESCAPE then begin
    self.Close;
  end;}
end;

procedure TFormTableDetail.frxReportBeginDoc(Sender: TObject);
var
  plist,pfinal,pparent:TfrxChild;
begin
  plist:=TfrxChild(frxReport.FindObject('childPrintList'));
  if plist<>nil then begin
    if self.isPrintFinal then begin
      plist.Visible:=false;
    end else begin
      plist.Visible:=true;
    end;
  end;
  pfinal:=TfrxChild(frxReport.FindObject('childPrintFinal'));
  if pfinal<>nil then begin
    if self.isPrintFinal then begin
      pfinal.Visible:=true;
    end else begin
      pfinal.Visible:=false;
    end;
  end;
  pparent:=TfrxChild(frxReport.FindObject('childPrintParent'));
  if pparent<>nil then begin

  end;
end;

procedure TFormTableDetail.frxReportGetValue(const VarName: string; var Value:
    Variant);
var
  t:string;
  v:integer;
begin
  if CompareText(VarName,'tableName') = 0 then begin
    Value := self.tablename;
  end else if CompareText(VarName,'Operator') = 0 then begin
    Value := USERNAME;
  end else if CompareText(VarName,'printCount') = 0 then begin
    Value := getPrintCountString;
  end else if CompareText(VarName,'payType') = 0 then begin
    Value := '　结账方式：'+RzRadioGroupPayType.Items[RzRadioGroupPayType.ItemIndex];
  end else if CompareText(VarName,'rateType') = 0 then begin
    if RzRadioGroupPayType.ItemIndex=1 then begin          //储值
      if length(self.RzLabelCardRate.Caption)>0 then begin
        t:=self.RzLabelCardRate.Caption;
      end else begin
        t:='1';
      end;
    end else if RzRadioGroupPayType.ItemIndex=4 then begin //签单
      t:='签单不打折';
    end else if RzRadioGroupPayType.ItemIndex=5 then begin //免单
      t:='免单不打折';
    end else begin                                         //现金，银行卡，支付宝
      t:=RzRadioGroupRate.Items[RzRadioGroupRate.ItemIndex];
    end;
    Value:='　　折扣率：'+t;
  end else if CompareText(VarName,'freeInfo') = 0 then begin //免菜
    Value:='　　　免计：'+inttostr(self.getFreeValue);
  end else if CompareText(VarName,'ticketInfo') = 0 then begin
    if RzRadioGroupPayType.ItemIndex=1 then begin          //储值
      Value:='　　优惠券：储值卡不能使用';
    end else if RzRadioGroupPayType.ItemIndex=4 then begin //签单
      Value:='　　优惠券：签单不能使用';
    end else if RzRadioGroupPayType.ItemIndex=5 then begin //免单
      Value:='　　优惠券：免单不能使用';
    end else begin                                         //现金，银行卡，支付宝
      if self.RzNumericEditCashTicket.IntValue>0 then begin
        v:=self.RzNumericEditCashTicket.IntValue;
        Value:='现金优惠券：'+inttostr(v);
      end else if length(self.RzLabelNetTicket.Caption)>0 then begin
        v:=strtoint(self.RzLabelNetTicket.Caption);
        Value:='电子优惠券：'+inttostr(v);
      end else begin
        Value:='　　优惠券：0';
      end;
    end;
  end else if CompareText(VarName,'finalPaySum') = 0 then begin
    if (RzRadioGroupPayType.ItemIndex=4) or (RzRadioGroupPayType.ItemIndex=5) then begin
      Value:=self.consTotal;
    end else begin
      Value:=self.PayLastFinalTotal;
    end;
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

procedure TFormTableDetail.frxUserDataSetConsDetailGetValue(const VarName:
    string; var Value: Variant);
var
  item:TListITem;
begin
  item:=RzListView.Items.Item[frxUserDataSetConsDetail.RecNo];
  if CompareText(VarName,'itemName') = 0 then begin
    Value := item.SubItems[1];
    if length(item.SubItems[8])>0 then begin
      Value := Value+'('+item.SubItems[8]+')';
    end;
    if item.SubItems[3]='1' then begin
      Value := Value+'(T)';
    end;
  end else if CompareText(VarName,'nums') = 0 then begin
    Value := item.SubItems[6];
  end else if CompareText(VarName,'price') = 0 then begin
    Value := item.SubItems[2];
  end;
end;

function TFormTableDetail.getFreeValue: integer;
var
  i,freecount:integer;
  price,nums,isfree:integer;
  item: TListItem;
begin
  freecount:=0;
  if RzListView.Items.Count>0 then begin
    for i := 0 to RzListView.Items.Count - 1 do begin
      item:=RzListView.Items.Item[i];
      price:=strtoint(item.SubItems.Strings[2]);
      isfree:=strtoint(item.SubItems.Strings[5]);
      nums:=strtoint(item.SubItems.Strings[6]);

      if(isfree=1) then begin
        freecount:=freecount+price*nums;
      end;
    end;
  end;
  Result := freecount;
end;

function TFormTableDetail.getPrintCountString: string;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  n:integer;
begin
  n:=0;
  sql := Format('select printtotal from tables where tablename="%s"',[self.tablename]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      n:=strtoint(getUTF8String(MYSQL_ROW^[0]));
    end;
  end;
  inc(n);
  Result := '消费清单第 '+inttostr(n)+' 次打印';
end;

procedure TFormTableDetail.IntNoVoice1Click(Sender: TObject);
var
  res,num:integer;
  mi:TMenuItem;
begin
  mi:=Sender as TMenuItem;
  num:=mi.Tag;
  res := MessageBox(self.Handle, PWideChar('抹零'+inttostr(num)+'元后将不能开具发票，是否继续？'), '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    //PayLastFinalTotal:=floor(PayLastFinalTotal/5)*5;
    PayLastFinalTotal:=PayLastFinalTotal-num;
    RzLabelLastFinalTotal.Caption:=inttostr(PayLastFinalTotal);
    RzNumericEditTotal2.IntValue:=PayLastFinalTotal;
    RzNumericEditTotal3.IntValue:=0;
    self.RzToolButtonIntNoInvoice.Tag:=1;
  end;
end;

procedure TFormTableDetail.loadTableDetailData;
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
  consTotal:=0;

  sql := 'select id,menuidx,itemname,price,issale,canrate,isfree,nums,itemunit,usertips,creationtime,endtime,loginname,passername,subitemidx,freeitemidx,makefrom from view_consumption where tablename="'+self.tablename+'" and payidx=0 order by creationtime';
  queryMySql(sql,LibHandle, mySQL_Res_Detail);
  if mysql_num_rows(mySQL_Res_Detail)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res_Detail);
      if MYSQL_ROW<>nil then begin
        item:=self.RzListView.Items.Add;
        item.Caption:=getUTF8String(MYSQL_ROW^[0]);
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[1]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[2]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[3]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[4]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[5]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[6]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[7]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[8]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[9]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[10]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[11]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[12]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[13]));

        consTotal:=consTotal+strtoint(getUTF8String(MYSQL_ROW^[3]))*strtoint(getUTF8String(MYSQL_ROW^[7]));
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
  self.RzLabelTotal.Caption:='合计：'+inttostr(consTotal)+'元';
  self.RzLabelTableName.Caption:='台位：'+self.tablename;
  self.RzToolButtonSumTotalClick(nil);

  self.frxUserDataSetConsDetail.RangeEnd := reCount;
  self.frxUserDataSetConsDetail.RangeEndCount := mysql_num_rows(mySQL_Res_Detail);
end;

procedure TFormTableDetail.printConsList(isFinal: Boolean);
begin
  self.isPrintFinal:=isFinal;
  loadReportDesignFile(self.frxReport,'tableconslist.fr3');
  if self.frxReport.PrepareReport(true) then begin
    frxReport.PrintOptions.Printer:=getPrinter('4');
    frxReport.PrintOptions.ShowDialog:=false;
    if not self.frxReport.Print then begin
      if isFinal then
        MessageBox(self.Handle,'收银小票打印失败，请联系管理员处理！','提示',MB_OK or MB_ICONWARNING)
      else
        MessageBox(self.Handle,'消费清单打印失败，请联系管理员处理！','提示',MB_OK or MB_ICONWARNING);
    end;
  end;
end;

procedure TFormTableDetail.RzEditNetTicketNoChange(Sender: TObject);
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  endtime: TDateTime;
  dfs: TFormatSettings;
begin
  self.RzLabelNetTicket.Caption:='';
  self.RzLabelNetTicketStatus.Caption:='';
  self.RzLabelNetTicketTime.Caption:='';
  self.RzLabelNetTicketEndTime.Caption:='';

  sql := Format('SELECT ticketstatus,ticketsum,ticketstarttime,ticketendtime from nettickets WHERE ticketno="%s"',[uppercase(trim(self.RzEditNetTicketNo.Text))]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      self.RzLabelNetTicket.Caption:=getUTF8String(MYSQL_ROW^[1]);
      self.RzLabelNetTicketTime.Caption:=getUTF8String(MYSQL_ROW^[2]);
      self.RzLabelNetTicketEndTime.Caption:=getUTF8String(MYSQL_ROW^[3]);
      self.RzLabelNetTicketStatus.Caption:='正常';
      self.RzLabelNetTicketStatus.Font.Color:=$00000000;

      dfs.ShortDateFormat := 'yyyy-MM-dd';
      dfs.DateSeparator := '-';
      endtime:=StrToDate(getUTF8String(MYSQL_ROW^[3]),dfs);
      if endtime<Date() then begin
        self.RzLabelNetTicketStatus.Caption:='已经过期';
        self.RzLabelNetTicketStatus.Font.Color:=$000000FF;
        self.RzLabelNetTicket.Caption:='0';
      end;

      if getUTF8String(MYSQL_ROW^[0])='1' then begin
        self.RzLabelNetTicketStatus.Caption:='已被使用';
        self.RzLabelNetTicketStatus.Font.Color:=$00FF0000;
        self.RzLabelNetTicket.Caption:='0';
      end;
    end;
  end;
  RzToolButtonSumTotalClick(self);
end;

procedure TFormTableDetail.RzEditSearchKeyChange(Sender: TObject);
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  self.RzLabelCardNo.Caption:='';
  self.RzLabelCardNo.Font.Color:=$00000000;
  self.RzLabelCardTel.Caption:='';
  self.RzLabelCardName.Caption:='';
  self.RzLabelCardRate.Caption:='';
  self.RzLabelCardOver.Caption:='';

  if self.RzRadioGroupSearchType.ItemIndex=0 then begin
    sql := Format('SELECT cardno,name,mobileno,cardrate,cardover,cardstatus from members WHERE cardno="%s"',[trim(self.RzEditSearchKey.Text)]);
  end else begin
    sql := Format('SELECT cardno,name,mobileno,cardrate,cardover,cardstatus from members WHERE mobileno="%s"',[trim(self.RzEditSearchKey.Text)]);
  end;
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      self.RzLabelCardNo.Caption:=getUTF8String(MYSQL_ROW^[0]);
      self.RzLabelCardTel.Caption:=getUTF8String(MYSQL_ROW^[2]);
      self.RzLabelCardName.Caption:=getUTF8String(MYSQL_ROW^[1]);
      self.RzLabelCardRate.Caption:=getUTF8String(MYSQL_ROW^[3]);
      self.RzLabelCardOver.Caption:=getUTF8String(MYSQL_ROW^[4]);

      if getUTF8String(MYSQL_ROW^[5])='1' then begin
        self.RzLabelCardRate.Caption:='1';
        self.RzLabelCardNo.Caption:=RzLabelCardNo.Caption+' (已挂失)';
        self.RzLabelCardNo.Font.Color:=$000000FF;
      end;

    end;
  end;

  RzToolButtonSumTotalClick(self);
end;

procedure TFormTableDetail.RzNumericEditCashTicketChange(Sender: TObject);
begin
  RzToolButtonSumTotalClick(self);
end;

procedure TFormTableDetail.RzNumericEditTotal2Exit(Sender: TObject);
begin
  self.RzNumericEditTotal3.IntValue:=self.RzNumericEditTotal2.IntValue-self.PayLastFinalTotal;
end;

procedure TFormTableDetail.RzNumericEditTotal2KeyDown(Sender: TObject; var Key:
    Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then begin
    self.RzNumericEditTotal3.IntValue:=self.RzNumericEditTotal2.IntValue-self.PayLastFinalTotal;
  end;
end;

procedure TFormTableDetail.RzRadioGroupPayTypeClick(Sender: TObject);
begin
  if (self.RzRadioGroupPayType.ItemIndex=0) then begin             //现金
    self.RzPageControlRate.Visible:=true;
    self.RzPageControlRate.ActivePageIndex:=1;
    self.RzPageControlPay.ActivePageIndex:=0;
    self.RzToolButtonPayEnd.Caption:='现金收讫';
    self.RzPanelCashFunction.Visible:=true;
    self.RzPanelStoreFunction.Visible:=false;
    self.RzToolButtonViewAliPay.Visible:=false;
    self.RzToolButtonPayEnd.Enabled:=true;
    self.RzPanelIntNoInvoice.Visible:=true;
  end else if (self.RzRadioGroupPayType.ItemIndex=1) then begin    //储值卡
    self.RzPageControlRate.Visible:=true;
    self.RzPageControlRate.ActivePageIndex:=0;
    self.RzPageControlPay.ActivePageIndex:=0;
    self.RzToolButtonPayEnd.Caption:='扣款结束';
    self.RzPanelCashFunction.Visible:=false;
    self.RzPanelStoreFunction.Visible:=true;
    self.RzToolButtonViewAliPay.Visible:=false;
    self.RzToolButtonPayEnd.Enabled:=false;
    self.RzPanelIntNoInvoice.Visible:=false;
  end else if (self.RzRadioGroupPayType.ItemIndex=2) then begin    //银行卡
    self.RzPageControlRate.Visible:=true;
    self.RzPageControlRate.ActivePageIndex:=1;
    self.RzPageControlPay.ActivePageIndex:=0;
    self.RzToolButtonPayEnd.Caption:='刷卡完毕';
    self.RzPanelCashFunction.Visible:=false;
    self.RzPanelStoreFunction.Visible:=false;
    self.RzToolButtonViewAliPay.Visible:=false;
    self.RzToolButtonPayEnd.Enabled:=true;
    self.RzPanelIntNoInvoice.Visible:=true;
  end else if (self.RzRadioGroupPayType.ItemIndex=3) then begin    //支付宝
    self.RzPageControlRate.Visible:=true;
    self.RzPageControlRate.ActivePageIndex:=1;
    self.RzPageControlPay.ActivePageIndex:=0;
    self.RzToolButtonPayEnd.Caption:='收款结束';
    self.RzPanelCashFunction.Visible:=false;
    self.RzPanelStoreFunction.Visible:=false;
    self.RzToolButtonViewAliPay.Visible:=true;
    self.RzToolButtonPayEnd.Enabled:=true;
    self.RzPanelIntNoInvoice.Visible:=true;
  end else if (self.RzRadioGroupPayType.ItemIndex=4) then begin    //签单
    self.RzPageControlRate.Visible:=false;
    self.RzPageControlPay.ActivePageIndex:=1;
  end else if (self.RzRadioGroupPayType.ItemIndex=5) then begin    //免单
    self.RzPageControlRate.Visible:=false;
    self.RzPageControlPay.ActivePageIndex:=1;
  end;
  self.showCashRateTip;
  RzToolButtonSumTotalClick(self);
end;

procedure TFormTableDetail.RzRadioGroup3Click(Sender: TObject);
begin
  if self.RzRadioGroupRate.ItemIndex>0 then begin
    self.RzRadioGroupTicket.ItemIndex:=0;
  end;

  self.showCashRateTip;
  self.RzToolButtonSumTotalClick(self);
end;

procedure TFormTableDetail.RzRadioGroupSearchTypeClick(Sender: TObject);
begin
  self.RzEditSearchKey.Clear;
  self.RzLabelCardNo.Caption:='';
  self.RzLabelCardTel.Caption:='';
  self.RzLabelCardName.Caption:='';
  self.RzLabelCardRate.Caption:='';
  self.RzLabelCardOver.Caption:='';

  self.RzEditSearchKey.SetFocus;
  self.RzEditSearchKey.SelectAll;
end;

procedure TFormTableDetail.RzRadioGroupTicketClick(Sender: TObject);
begin
  if self.RzRadioGroupTicket.ItemIndex=0 then begin
    self.RzPageControlTicket.ActivePageIndex:=0;
  end else if self.RzRadioGroupTicket.ItemIndex=1 then begin
    self.RzRadioGroupRate.ItemIndex:=0;
    self.RzPageControlTicket.ActivePageIndex:=1;
    self.RzNumericEditCashTicket.SetFocus;
    self.RzNumericEditCashTicket.SelectAll;
  end else if self.RzRadioGroupTicket.ItemIndex=2 then begin
    self.RzRadioGroupRate.ItemIndex:=0;
    self.RzPageControlTicket.ActivePageIndex:=2;
    self.RzEditNetTicketNo.SetFocus;
    self.RzEditNetTicketNo.SelectAll;
  end;
  self.RzNumericEditCashTicket.IntValue:=0;
  self.RzMemoCashTicketNoList.Clear;

  self.RzEditNetTicketNo.Text:='';
  RzToolButtonSumTotalClick(self);
end;

procedure TFormTableDetail.RzToolButtonDesignMakefromClick(Sender: TObject);
begin
  loadReportDesignFile(self.frxReport,'makefrom.fr3');
  self.frxReport.DesignReport();
end;

procedure TFormTableDetail.RzToolButtonDesignReportClick(Sender: TObject);
begin
  loadReportDesignFile(self.frxReport,'tableconslist.fr3');
  self.frxReport.DesignReport();
end;

procedure TFormTableDetail.RzToolButtonDoPayOfStoreCardClick(Sender: TObject);
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  if self.RzLabelCardNo.Caption='' then begin
    MessageBox(self.Handle,'输入的会员卡不正确，扣款失败！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditSearchKey.SetFocus;
    exit;
  end;
  if length(trim(RzEditStoreCardPass.Text))=0 then begin
    MessageBox(self.Handle,'请输入会员卡密码！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditStoreCardPass.SetFocus;
    exit;
  end;

  sql := Format('SELECT cardpass,cardover FROM members WHERE cardno="%s"',[self.RzLabelCardNo.Caption]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      if getUTF8String(MYSQL_ROW^[0])<>self.RzEditStoreCardPass.Text then begin
        MessageBox(self.Handle,'会员卡密码错误，扣款失败！','提示',MB_OK or MB_ICONWARNING);
        self.RzEditStoreCardPass.SetFocus;
        exit;
      end;
      if strtoint(getUTF8String(MYSQL_ROW^[1]))<self.PayLastFinalTotal then begin
        MessageBox(self.Handle,'会员卡余额不足，扣款失败！','提示',MB_OK or MB_ICONWARNING);
        exit;
      end;
      //写会员卡消费记录
      sql:=Format('INSERT INTO memberdetail(cardno,paysum,loginname) values("%s",%d,"%s")',
        [ self.RzLabelCardNo.Caption,
          self.PayLastFinalTotal,
          LOGINNAME
        ]);
      execMySql(sql,LibHandle);
      //写insert id供结束时写入payidx字段值
      self.RzToolButtonPayEnd.Tag:=mysql_insert_id(LibHandle);
      //扣会员卡余额
      sql:=Format('UPDATE members set cardover=cardover-%d,lastpaytime=now() where cardno="%s"',
        [ self.PayLastFinalTotal,
          self.RzLabelCardNo.Caption
        ]);
      execMySql(sql,LibHandle);
      MessageBox(self.Handle,PWideChar(Format('扣款成功,卡号：%s，扣除金额：%d 元',[self.RzLabelCardNo.Caption,self.PayLastFinalTotal])),'提示',MB_OK or MB_ICONINFORMATION);
      self.RzToolButtonDoPayOfStoreCard.Enabled:=false;
      self.RzEditSearchKey.Enabled:=false;
      self.RzEditStoreCardPass.Enabled:=false;
      self.RzRadioGroupPayType.Enabled:=false;
      self.RzRadioGroupSearchType.Enabled:=false;
      self.RzToolButtonPayEnd.Enabled:=true;
    end else begin
      MessageBox(self.Handle,'会员卡查询失败失败！请检查卡状态','提示',MB_OK or MB_ICONWARNING);
    end;
  end;
end;

procedure TFormTableDetail.RzToolButtonLeaderOkClick(Sender: TObject);
var
  sql:string;
  inidx:integer;
  //res:integer;
begin
  {res := MessageBox(self.Handle, '是否领导签字已完成？', '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDNO then begin
    exit;
  end;}
  //写入payitems
  sql:=Format('INSERT INTO payitems(tablename,constotal,willpaysum,paysum,paytype,loginname) values("%s",%d,%d,%d,%d,"%s")',
      [ self.tablename,
        self.consTotal,
        self.consTotal,
        self.consTotal,
        strtoint(self.PayTypeList[self.RzRadioGroupPayType.ItemIndex]),
        LOGINNAME
      ]);
  execMySql(sql,LibHandle);
  inidx:=mysql_insert_id(LibHandle);
  //补写点菜明细的payinx
  sql:=Format('UPDATE consumption set payidx=%d where tablename="%s" and payidx=0',
      [ inidx,
        self.tablename
      ]);
  execMySql(sql,LibHandle);
  //修改桌位的状态
  sql:=Format('UPDATE tables SET tablestatus=0,printtotal=0 where tablename="%s"',[self.tablename]);
  execMySql(sql,LibHandle);
  //打印小票
  printConsList(true);

  self.Close;
end;

procedure TFormTableDetail.RzToolButtonMianClick(Sender: TObject);
var
  res:integer;
  u,sql:string;
begin
  if (self.RzListView.ItemIndex=-1) then begin
    MessageBox(self.Handle,'请选择你要操作的菜品记录！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  u:=self.RzListView.Selected.Caption;

  if(self.rzlistView.Selected.SubItems[5]='0')then begin
    res := MessageBox(self.Handle, PWideChar('是否确定要免掉菜品记录：'+u), '提示', MB_YESNO or MB_ICONWARNING);
    if res = IDYES then begin
      sql := Format('UPDATE consumption SET isfree=1 WHERE id=%s',[u]);
      execMySql(sql,LibHandle);
      self.loadTableDetailData;
    end;
  end else begin
    res := MessageBox(self.Handle, PWideChar('是否确定要恢复菜品记录：'+u), '提示', MB_YESNO or MB_ICONWARNING);
    if res = IDYES then begin
      sql := Format('UPDATE consumption SET isfree=0 WHERE id=%s',[u]);
      execMySql(sql,LibHandle);
      self.loadTableDetailData;
    end;
  end;
end;

procedure TFormTableDetail.RzToolButtonPayEndClick(Sender: TObject);
begin
  if self.RzRadioGroupPayType.ItemIndex=1 then  //储值卡
    doPayWithStoreCard
  else
    doPayWithOther;
end;

procedure TFormTableDetail.RzToolButtonPreviewListClick(Sender: TObject);
begin
  if TRzToolButton(Sender).Tag=0 then
    isPrintFinal:=false
  else
    isPrintFinal:=true;

  loadReportDesignFile(self.frxReport,'tableconslist.fr3');
  self.frxReport.ShowReport();
end;

procedure TFormTableDetail.RzToolButtonPreviewMakefromClick(Sender: TObject);
var
  subidx,freeidx:string;
  MYSQL_ROW: PMYSQL_ROW;
  MYSQL_ROW_SUB: PMYSQL_ROW;
  list:TStringList;
  i,j:integer;
  sql,parentname:string;
begin
  if (self.RzListView.ItemIndex=-1) then begin
    MessageBox(self.Handle,'请选择你要预览出品的菜品记录！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  j:=0;
  list:=TStringList.Create;

  mysql_data_seek(mySQL_Res_Detail,self.RzListView.ItemIndex);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res_Detail);
  if MYSQL_ROW<>nil then begin
    subidx:=getUTF8String(MYSQL_ROW^[14]);
    freeidx:=getUTF8String(MYSQL_ROW^[15]);

    list.Delimiter:=',';
    list.DelimitedText:=subidx;

    for i := 0 to list.Count - 1 do begin
      sql:=Format('select concat(itemname,"(点)"),itemunit,makefrom from menus where menuidx=%s',[list[i]]);
      queryMySql(sql,LibHandle, mySQL_Res);
      if mysql_num_rows(mySQL_Res)>0 then begin
        MYSQL_ROW_SUB := mysql_fetch_row(mySQL_Res);
        if MYSQL_ROW_SUB<>nil then begin
          loadReportDesignFile(self.frxReport,'makefrom.fr3');

          frxReport.Variables['mItemid']:=''''+self.RzListView.Selected.Caption+'''';
          parentname:=self.RzListView.Selected.SubItems[1];
          if length(self.RzListView.Selected.SubItems[8])>0 then
            parentname:=parentname+'('+self.RzListView.Selected.SubItems[8]+')';
          frxReport.Variables['mParentName']:=''''+parentname+'''';
          frxReport.Variables['mItemNum']:=''''+self.RzListView.Selected.SubItems[6]+getUTF8String(MYSQL_ROW_SUB^[1])+'''';
          frxReport.Variables['mItemName']:=''''+getUTF8String(MYSQL_ROW_SUB^[0])+'''';

          if j=0 then
            frxReport.PrepareReport(true)
          else
            frxReport.PrepareReport(false);
          inc(j);
        end;
      end;
    end;

    list.Delimiter:=',';
    list.DelimitedText:=freeidx;

    for i := 0 to list.Count - 1 do begin
      sql:=Format('select concat(itemname,"(送)"),itemunit,makefrom from menus where menuidx=%s',[list[i]]);
      queryMySql(sql,LibHandle, mySQL_Res);
      if mysql_num_rows(mySQL_Res)>0 then begin
        MYSQL_ROW_SUB := mysql_fetch_row(mySQL_Res);
        if MYSQL_ROW_SUB<>nil then begin
          loadReportDesignFile(self.frxReport,'makefrom.fr3');

          frxReport.Variables['mItemid']:=''''+self.RzListView.Selected.Caption+'''';
          parentname:=self.RzListView.Selected.SubItems[1];
          if length(self.RzListView.Selected.SubItems[8])>0 then
            parentname:=parentname+'('+self.RzListView.Selected.SubItems[8]+')';
          frxReport.Variables['mParentName']:=''''+parentname+'''';
          frxReport.Variables['mItemNum']:=''''+self.RzListView.Selected.SubItems[6]+getUTF8String(MYSQL_ROW_SUB^[1])+'''';
          frxReport.Variables['mItemName']:=''''+getUTF8String(MYSQL_ROW_SUB^[0])+'''';

          if j=0 then
            frxReport.PrepareReport(true)
          else
            frxReport.PrepareReport(false);
          inc(j);
        end;
      end;
    end;

    if j>0 then
      frxReport.ShowPreparedReport;
  end;

  list.Free;
end;

procedure TFormTableDetail.RzToolButtonPrintListClick(Sender: TObject);
begin
  printConsList(false);
end;

procedure TFormTableDetail.RzToolButtonPrintMakeFromClick(Sender: TObject);
var
  subidx,freeidx:string;
  MYSQL_ROW: PMYSQL_ROW;
  MYSQL_ROW_SUB: PMYSQL_ROW;
  list:TStringList;
  i:integer;
  sql,parentname:string;
begin
  if (self.RzListView.ItemIndex=-1) then begin
    MessageBox(self.Handle,'请选择你要打印出品的菜品记录！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  list:=TStringList.Create;

  mysql_data_seek(mySQL_Res_Detail,self.RzListView.ItemIndex);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res_Detail);
  if MYSQL_ROW<>nil then begin
    subidx:=getUTF8String(MYSQL_ROW^[14]);
    freeidx:=getUTF8String(MYSQL_ROW^[15]);

    list.Delimiter:=',';
    list.DelimitedText:=subidx;

    for i := 0 to list.Count - 1 do begin
      sql:=Format('select concat(itemname,"(点)"),itemunit,makefrom from menus where menuidx=%s',[list[i]]);
      queryMySql(sql,LibHandle, mySQL_Res);
      if mysql_num_rows(mySQL_Res)>0 then begin
        MYSQL_ROW_SUB := mysql_fetch_row(mySQL_Res);
        if MYSQL_ROW_SUB<>nil then begin
          loadReportDesignFile(self.frxReport,'makefrom.fr3');

          frxReport.Variables['mItemid']:=''''+self.RzListView.Selected.Caption+'''';
          parentname:=self.RzListView.Selected.SubItems[1];
          if length(self.RzListView.Selected.SubItems[8])>0 then
            parentname:=parentname+'('+self.RzListView.Selected.SubItems[8]+')';
          frxReport.Variables['mParentName']:=''''+parentname+'''';
          frxReport.Variables['mItemNum']:=''''+self.RzListView.Selected.SubItems[6]+getUTF8String(MYSQL_ROW_SUB^[1])+'''';
          frxReport.Variables['mItemName']:=''''+getUTF8String(MYSQL_ROW_SUB^[0])+'''';

          if frxReport.PrepareReport(true) then begin
            frxReport.PrintOptions.Printer:=getPrinter(getUTF8String(MYSQL_ROW_SUB^[2]));
            frxReport.PrintOptions.ShowDialog:=false;
            frxReport.Print;
          end;
        end;
      end;
    end;

    list.Delimiter:=',';
    list.DelimitedText:=freeidx;

    for i := 0 to list.Count - 1 do begin
      sql:=Format('select concat(itemname,"(送)"),itemunit,makefrom from menus where menuidx=%s',[list[i]]);
      queryMySql(sql,LibHandle, mySQL_Res);
      if mysql_num_rows(mySQL_Res)>0 then begin
        MYSQL_ROW_SUB := mysql_fetch_row(mySQL_Res);
        if MYSQL_ROW_SUB<>nil then begin
          loadReportDesignFile(self.frxReport,'makefrom.fr3');

          frxReport.Variables['mItemid']:=''''+self.RzListView.Selected.Caption+'''';
          parentname:=self.RzListView.Selected.SubItems[1];
          if length(self.RzListView.Selected.SubItems[8])>0 then
            parentname:=parentname+'('+self.RzListView.Selected.SubItems[8]+')';
          frxReport.Variables['mParentName']:=''''+parentname+'''';
          frxReport.Variables['mItemNum']:=''''+self.RzListView.Selected.SubItems[6]+getUTF8String(MYSQL_ROW_SUB^[1])+'''';
          frxReport.Variables['mItemName']:=''''+getUTF8String(MYSQL_ROW_SUB^[0])+'''';

          if frxReport.PrepareReport(true) then begin
            frxReport.PrintOptions.Printer:=getPrinter(getUTF8String(MYSQL_ROW_SUB^[2]));
            frxReport.PrintOptions.ShowDialog:=false;
            frxReport.Print;
          end;
        end;
      end;
    end;
  end;

  list.Free;
end;

procedure TFormTableDetail.RzToolButtonPrintPreClick(Sender: TObject);
begin
  printConsList(true);
end;

procedure TFormTableDetail.RzToolButtonPutMoneyClick(Sender: TObject);
var
  f:TFormMemberPutMoney;
begin
  if Length(self.RzLabelCardNo.Caption)>0 then begin
    f:=TFormMemberPutMoney.Create(self,self.RzLabelCardNo.Caption);
    f.ShowModal;
    f.Destroy;
    self.RzEditSearchKeyChange(self);
  end;
end;

procedure TFormTableDetail.RzToolButtonSumTotalClick(Sender: TObject);
var
  rate,itemtotal:real;
  i:integer;
  price,nums,issale,canrate,isfree,ismember:integer;
  item: TListItem;
begin
  if self.RzPageControlRate.ActivePageIndex=1 then begin
    if RzRadioGroupRate.ItemIndex<>-1 then begin
      rate:=strtofloat(RzRadioGroupRate.Items[RzRadioGroupRate.ItemIndex]);
    end else begin
      rate:=1;
    end;
    ismember:=0;
  end else begin
    if length(self.RzLabelCardRate.Caption)>0 then begin
      rate:=strtofloat(self.RzLabelCardRate.Caption);
    end else begin
      rate:=1;
    end;
    ismember:=1;
  end;

  PayFinalTotal:=0;
  PayLastFinalTotal:=0;
  if RzListView.Items.Count>0 then begin
    for i := 0 to RzListView.Items.Count - 1 do begin
      item:=RzListView.Items.Item[i];
      price:=strtoint(item.SubItems.Strings[2]);
      issale:=strtoint(item.SubItems.Strings[3]);
      canrate:=strtoint(item.SubItems.Strings[4]);
      isfree:=strtoint(item.SubItems.Strings[5]);
      nums:=strtoint(item.SubItems.Strings[6]);

      if(isfree=0) then begin
        if ((issale=1) or (canrate=0)) and (ismember=0)  then begin
          PayFinalTotal:=PayFinalTotal+price*nums;
          PayLastFinalTotal:=PayFinalTotal;
        end else if ((issale=1) or (canrate=0)) and ((ismember=1) and (rate<0.8))  then begin
          rate:=0.8;
          itemtotal:=price*nums*rate;
          PayFinalTotal:=PayFinalTotal+ceil(itemtotal);
          PayLastFinalTotal:=PayFinalTotal;
        end else begin
          //price:=ceil(price*rate);
          //PayFinalTotal:=PayFinalTotal+price*nums;
          itemtotal:=price*nums*rate;
          PayFinalTotal:=PayFinalTotal+ceil(itemtotal);
          PayLastFinalTotal:=PayFinalTotal;
        end;
      end;
    end;
  end;

  if self.RzPageControlTicket.ActivePageIndex=1 then begin
    PayFinalTotal:=PayFinalTotal-self.RzNumericEditCashTicket.IntValue;
    PayLastFinalTotal:=PayFinalTotal;
  end;
  if self.RzPageControlTicket.ActivePageIndex=2 then begin
    if length(self.RzLabelNetTicket.Caption)>0 then begin
      PayFinalTotal:=PayFinalTotal-strtoint(self.RzLabelNetTicket.Caption);
      PayLastFinalTotal:=PayFinalTotal;
    end;
  end;

  self.RzLabelFinalTotal.Caption:=inttostr(self.PayFinalTotal)+'元';
  self.RzLabelLastFinalTotal.Caption:=inttostr(self.PayLastFinalTotal)+'元';
  self.RzNumericEditTotal2.IntValue:=PayLastFinalTotal;
  self.RzToolButtonIntNoInvoice.Tag:=0;
  self.RzToolButtonPayEnd.Tag:=0;

  {if Sender<>nil then begin
    if self.RzPanelCashFunction.Visible=true then begin
      self.RzNumericEditTotal2.SetFocus;
      self.RzNumericEditTotal2.SelectAll;
    end;
  end;}
end;

procedure TFormTableDetail.RzToolButtonTuiCaiClick(Sender: TObject);
var
  u,num:integer;
  //sql:string;
  item:TListItem;
  fm:TFormTuiCai;
begin
  if (self.RzListView.ItemIndex=-1) then begin
    MessageBox(self.Handle,'请选择你要退掉的菜品记录！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  item:=self.RzListView.Selected;
  num:=strtoint(item.SubItems[6]);
  u:=strtoint(self.RzListView.Selected.Caption);

  fm:=TFormTuiCai.Create(self,u,num,self.tablename,item.SubItems[0],item.SubItems[1],item.SubItems[7]);
  fm.ShowModal;
  fm.Destroy;
  self.loadTableDetailData;

  {
  if num=1 then begin
    res := MessageBox(self.Handle, PWideChar('是否确定要退掉菜品记录：'+u), '提示', MB_YESNO or MB_ICONWARNING);
    if res = IDYES then begin
      sql := Format('DELETE FROM consumption WHERE id=%s',[u]);
      execMySql(sql,LibHandle);
      self.loadTableDetailData;
    end;
  end else if num>1 then begin

  end;
  }
end;

procedure TFormTableDetail.showCashRateTip;
begin
  if self.RzRadioGroupPayType.ItemIndex=0 then begin
    if self.RzRadioGroupRate.ItemIndex>0 then begin
      self.RzLabelRateTip.Visible:=true;
    end else begin
      self.RzLabelRateTip.Visible:=false;
    end;
  end else begin
    self.RzLabelRateTip.Visible:=false;
  end;
end;

end.
