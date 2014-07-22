unit fmReportManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxPreview, ComCtrls, RzListVw, ExtCtrls, RzPanel, RzSplit,
  RzGroupBar, ImgList, RzButton, frxDesgn, StdCtrls, RzLabel, Clipbrd, mysql,
  frxChart, DateUtils;

type
  TFormReportManager = class(TForm)
    RzSplitter1: TRzSplitter;
    RzPanel1: TRzPanel;
    frxPreview: TfrxPreview;
    RzPanel2: TRzPanel;
    RzGroupBar: TRzGroupBar;
    RzGroupTradeType: TRzGroup;
    RzGroupPayType: TRzGroup;
    RzGroupMenuType: TRzGroup;
    RzGroupOtherType: TRzGroup;
    ImageList1: TImageList;
    RzGroupMemberType: TRzGroup;
    RzGroupInvoiceType: TRzGroup;
    RzGroupStock: TRzGroup;
    frxReport: TfrxReport;
    frxDesigner1: TfrxDesigner;
    RzPanel3: TRzPanel;
    RzToolButtonDesignReport: TRzToolButton;
    RzToolButtonReload: TRzToolButton;
    RzLabel1: TRzLabel;
    RzLabelReportFileName: TRzLabel;
    frxUserDataSetTradeList: TfrxUserDataSet;
    frxChartObject: TfrxChartObject;
    frxUserDataSetTradeDay: TfrxUserDataSet;
    frxUserDataSetPayType: TfrxUserDataSet;
    frxUserDataSetMenuType: TfrxUserDataSet;
    frxUserDataSetMenuMonth: TfrxUserDataSet;
    frxUserDataSetMember: TfrxUserDataSet;
    frxUserDataSetMemberPut: TfrxUserDataSet;
    frxUserDataSetWorderDetail: TfrxUserDataSet;
    RzGroup1: TRzGroup;
    frxUserDataSetSellerNotPay: TfrxUserDataSet;
    frxUserDataSetWorkerAwardDetail: TfrxUserDataSet;
    frxUserDataSetWorkerWageMonth: TfrxUserDataSet;
    frxUserDataSetAssetsDetail: TfrxUserDataSet;
    frxUserDataSetBuyType: TfrxUserDataSet;
    frxUserDataSetStoreDetail: TfrxUserDataSet;
    frxUserDataSetStoreWarning: TfrxUserDataSet;
    frxUserDataSetBuyForType: TfrxUserDataSet;
    frxUserDataSetMakeFromType: TfrxUserDataSet;
    RzToolButtonPrint: TRzToolButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta:
        Integer; MousePos: TPoint; var Handled: Boolean);
    procedure frxPreviewClick(Sender: TObject);
    procedure frxReportDblClickObject(Sender: TfrxView; Button: TMouseButton;
        Shift: TShiftState; var Modified: Boolean);
    procedure frxReportGetValue(const VarName: string; var Value: Variant);
    procedure frxUserDataSetAssetsDetailGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetBuyForTypeGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetBuyTypeGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetMakeFromTypeGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetMemberGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetMemberPutGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetMenuMonthGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetMenuTypeGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetPayTypeGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetSellerNotPayGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetStoreDetailGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetStoreWarningGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetTradeDayGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetTradeListGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetWorderDetailGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetWorkerAwardDetailGetValue(const VarName: string; var
        Value: Variant);
    procedure frxUserDataSetWorkerWageMonthGetValue(const VarName: string; var
        Value: Variant);
    procedure RzGroupTradeTypeCanOpen(Sender: TObject; var CanOpen: Boolean);
    procedure RzLabelReportFileNameDblClick(Sender: TObject);
    procedure RzToolButtonPrintClick(Sender: TObject);
    procedure RzToolButtonDesignReportClick(Sender: TObject);
    procedure RzToolButtonReloadClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    function chgWageData(v: TfrxMemoView; field, id, hint, oldv: string): Boolean;
    function getAccessItem: Integer;
    procedure getAssetsDetailData;
    procedure getBuyDataOfMonth;
    procedure getBuyDataOfYear;
    procedure getBuyForDataOfMonth;
    procedure getBuyTypeDataOfMonth;
    procedure getInvoiceDataOfMonth;
    procedure getInvoiceDataOfYear;
    procedure getMemberData;
    procedure getMemberPutData;
    procedure getMenuDataOfMonth;
    procedure getMenuMakeFromDataOfDay;
    procedure getMenuMakeFromDataOfMonth;
    procedure getMenuTypeDataOfMonth;
    procedure getPayTypeDataOfMonth;
    procedure getReportData(Tag: Integer);
    function getReportDate: TDate;
    function getReportMonth: Variant;
    function getReportYear: Variant;
    procedure getSellerNotPayData;
    procedure getStoreDetailData;
    procedure getStoreJoinDayData;
    procedure getStoreJoinMonthData;
    procedure getStorePartDayData;
    procedure getStorePartMonthData;
    procedure getStoreWarningData;
    procedure getStoreWhereMonthData;
    procedure getTicketDataOfMonth;
    procedure getTradeDataOfDay;
    procedure getTradeDataOfMonth;
    procedure getTradeDataOfYear;
    procedure getUsersCountMonthData;
    procedure getWorkerAwardDetailMonthData;
    procedure getWorkerAwardMonthData;
    procedure getWorkerDetailData;
    procedure getWorkerWageMonthData;
    procedure initWorkerWageMonthRecord(y, m: integer);
    procedure OnGroupItemClick(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormReportManager: TFormReportManager;

implementation

uses dbfunction, myfunction, fmGetYear, fmGetMonth, fmGetDay, fmGetDate, fmChangeReportData, fmGetAccess;
{$R *.dfm}

function TFormReportManager.chgWageData(v: TfrxMemoView; field, id, hint, oldv:
    string): Boolean;
var
  f:TFormChangeReportData;
  res:TModalResult;
  sql:string;
begin
  Result:=false;
  f:=TFormChangeReportData.Create(self);
  f.RzLabelTips.Caption:=hint;
  f.RzNumericEditValue.Text:=oldv;
  res:=f.ShowModal;
  if res=mrOk then begin
    v.Text:=f.RzNumericEditValue.Text;
    sql:=Format('update wages set %s=%f where id=%s',[field,f.RzNumericEditValue.Value,id]);
    execMySql(sql,LibHandle);
    Result:=true;
  end;
  f.Destroy;
end;

procedure TFormReportManager.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormReportManager.FormCreate(Sender: TObject);
var
  i,j:integer;
  g:TRzGroup;
  item:TRzGroupItem;
begin
  connectMySql(LibHandle);
  for i := 0 to self.RzGroupBar.GroupCount - 1 do begin
    g:=RzGroupBar.Groups[i];
    for j := 0 to g.Items.Count - 1 do begin
      item:=g.Items.Items[j];
      item.OnClick:=OnGroupItemClick;
    end;
    g.Close;
  end;
  RzGroupBar.Groups[0].Open;

  if ACCESS>=8 then begin
    self.RzToolButtonDesignReport.Visible:=true;
  end else begin
    self.RzToolButtonDesignReport.Visible:=false;
  end;
end;

procedure TFormReportManager.FormMouseWheel(Sender: TObject; Shift:
    TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  frxPreview.MouseWheelScroll(WheelDelta);
end;

procedure TFormReportManager.frxPreviewClick(Sender: TObject);
begin
  self.frxPreview.SetFocus;
end;

procedure TFormReportManager.frxReportDblClickObject(Sender: TfrxView; Button:
    TMouseButton; Shift: TShiftState; var Modified: Boolean);
var
  v:TfrxMemoView;
  id:string;
  hint:string;
  oldv:string;
begin
  v:=TfrxMemoView(Sender);
  if CompareText(v.Name,'MemoOtherSubsidy') = 0 then begin
    id:=inttostr(v.Tag);
    hint:=v.TagStr;
    oldv:=v.Text;
    if chgWageData(v,'othersubsidy',id,hint,oldv) then begin
      //Modified:=true;
      getWorkerWageMonthData;
      frxReport.PrepareReport;
    end;
  end else if CompareText(v.Name,'MemoBonus') = 0 then begin
    id:=inttostr(v.Tag);
    hint:=v.TagStr;
    oldv:=v.Text;
    if chgWageData(v,'bonus',id,hint,oldv) then begin
      //Modified:=true;
      getWorkerWageMonthData;
      frxReport.PrepareReport;
    end;
  end else if CompareText(v.Name,'MemoCheckDeduct') = 0 then begin
    id:=inttostr(v.Tag);
    hint:=v.TagStr;
    oldv:=v.Text;
    if chgWageData(v,'checkdeduct',id,hint,oldv) then begin
      //Modified:=true;
      getWorkerWageMonthData;
      frxReport.PrepareReport;
    end;
  end else if CompareText(v.Name,'MemoBorrowDeduct') = 0 then begin
    id:=inttostr(v.Tag);
    hint:=v.TagStr;
    oldv:=v.Text;
    if chgWageData(v,'borrowdeduct',id,hint,oldv) then begin
      //Modified:=true;
      getWorkerWageMonthData;
      frxReport.PrepareReport;
    end;
  end else if CompareText(v.Name,'MemoOtherDeduct') = 0 then begin
    id:=inttostr(v.Tag);
    hint:=v.TagStr;
    oldv:=v.Text;
    if chgWageData(v,'otherdeduct',id,hint,oldv) then begin
      //Modified:=true;
      getWorkerWageMonthData;
      frxReport.PrepareReport;
    end;
  end;
end;

procedure TFormReportManager.frxReportGetValue(const VarName: string; var
    Value: Variant);
begin
  if CompareText(VarName,'misTitle') = 0 then begin
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

procedure TFormReportManager.frxUserDataSetAssetsDetailGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {select id,assetsname,assetsnums,assetsunit,assetsprice,assetsdesc,assetsseller from assets}
  mysql_data_seek(mySQL_Res,self.frxUserDataSetAssetsDetail.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'id') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[0]);
    end else if CompareText(VarName,'assetsname') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[1]);
    end else if CompareText(VarName,'assetsnums') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[2]));
    end else if CompareText(VarName,'assetsunit') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[3]);
    end else if CompareText(VarName,'assetsprice') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[4]));
    end else if CompareText(VarName,'assetsdesc') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[5]);
    end else if CompareText(VarName,'assetsseller') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[6]);
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetBuyForTypeGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {'select sum(paysum),forwhere from view_payitems '}
  mysql_data_seek(mySQL_Res,self.frxUserDataSetBuyForType.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'type') = 0 then begin
      Value := GetStringFromINI('ACCESSTYPE',getUTF8String(MYSQL_ROW^[1]),'前厅');
    end else if CompareText(VarName,'total') = 0 then begin
      Value :=Format('%2.2f',[strtofloat(getUTF8String(MYSQL_ROW^[0]))]);
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetBuyTypeGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {'select sum(paysum),paytype from view_payitems '}
  mysql_data_seek(mySQL_Res,self.frxUserDataSetBuyType.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'type') = 0 then begin
      Value := GetStringFromINI('BUYTYPE',getUTF8String(MYSQL_ROW^[1]),'水果');
    end else if CompareText(VarName,'total') = 0 then begin
      Value :=Format('%2.2f',[strtofloat(getUTF8String(MYSQL_ROW^[0]))]);
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetMakeFromTypeGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
  v:string;
begin
  {'select sum(price*nums),makefrom from view_consumption '}
  mysql_data_seek(mySQL_Res,self.frxUserDataSetMakeFromType.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'from') = 0 then begin
      v := getUTF8String(MYSQL_ROW^[1]);
      if v='0' then
        Value := '吧台'
      else if v='1' then
        Value := '厨房'
      else if v='2' then
        Value := '凉菜间'
      else
        Value := '未知';
    end else if CompareText(VarName,'total') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[0]));
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetMemberGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {select cardno,name,sex,mobileno,address,cardrate,cardover,cardstatus,creationtime from members}
  mysql_data_seek(mySQL_Res,self.frxUserDataSetMember.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'cardno') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[0]);
    end else if CompareText(VarName,'name') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[1]);
    end else if CompareText(VarName,'sex') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[2]);
    end else if CompareText(VarName,'mobileno') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[3]);
    end else if CompareText(VarName,'address') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[4]);
    end else if CompareText(VarName,'cardrate') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[5]));
    end else if CompareText(VarName,'cardover') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[6]));
    end else if CompareText(VarName,'cardstatus') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[7]));
    end else if CompareText(VarName,'creationtime') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[8]);
    end else if CompareText(VarName,'bywho') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[9]);
    end else if CompareText(VarName,'cashrate') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[10]);
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetMemberPutGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {select cardno,paysum,paytype,invoicetotal,creationtime from memberdetail}
  mysql_data_seek(mySQL_Res,self.frxUserDataSetMemberPut.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'cardno') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[0]);
    end else if CompareText(VarName,'paysum') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[1]));
    end else if CompareText(VarName,'donatesum') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[2]));
    end else if CompareText(VarName,'paytype') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[3]));
    end else if CompareText(VarName,'invoicetotal') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[4]));
    end else if CompareText(VarName,'creationtime') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[5]);
    end else if CompareText(VarName,'cardname') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[6]);
    end else if CompareText(VarName,'bywho') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[7]);
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetMenuMonthGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {'select a.menuidx,a.itemname,a.maindesc,a.subdesc,b.totalprice,b.totalnums from menus a}
  mysql_data_seek(mySQL_Res,self.frxUserDataSetMenuMonth.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'menuidx') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[0]);
    end else if CompareText(VarName,'itemname') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[1]);
    end else if CompareText(VarName,'maindesc') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[2]);
    end else if CompareText(VarName,'subdesc') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[3]);
    end else if CompareText(VarName,'totalprice') = 0 then begin
      if length(getUTF8String(MYSQL_ROW^[4]))>0 then
        Value := strtoint(getUTF8String(MYSQL_ROW^[4]))
      else
        Value := 0;
    end else if CompareText(VarName,'totalnums') = 0 then begin
      if length(getUTF8String(MYSQL_ROW^[5]))>0 then
        Value := strtoint(getUTF8String(MYSQL_ROW^[5]))
      else
        Value := 0;
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetMenuTypeGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {'select sum(price*nums),mainidx,maindesc from view_consumption '}
  mysql_data_seek(mySQL_Res,self.frxUserDataSetMenuType.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'type') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[2]);
    end else if CompareText(VarName,'total') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[0]));
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetPayTypeGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {'select sum(paysum),paytype from view_payitems '}
  mysql_data_seek(mySQL_Res,self.frxUserDataSetPayType.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'type') = 0 then begin
      Value := GetStringFromINI('PAYTYPE',getUTF8String(MYSQL_ROW^[1]),'现金');
    end else if CompareText(VarName,'total') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[0]));
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetSellerNotPayGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {select sellername,sellertel,buytype,buypaysum,paystatus,creationtime from view_purchase}
  mysql_data_seek(mySQL_Res,self.frxUserDataSetSellerNotPay.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'sellername') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[0]);
    end else if CompareText(VarName,'sellertel') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[1]);
    end else if CompareText(VarName,'buytype') = 0 then begin
      Value := GetStringFromINI('BUYTYPE',getUTF8String(MYSQL_ROW^[2]),'水果');
    end else if CompareText(VarName,'buypaysum') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[3]));
    end else if CompareText(VarName,'paystatus') = 0 then begin
      if getUTF8String(MYSQL_ROW^[4])='0' then
        Value := '未结'
      else
        Value := '已结';
    end else if CompareText(VarName,'creationtime') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[5]);
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetStoreDetailGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {select storename,storetypename,joinbrands,storeunit,joinprice,overnums,cdate【partwhere】 from view_storeitems}
  mysql_data_seek(mySQL_Res,self.frxUserDataSetStoreDetail.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);

  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'storename') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[0]);
    end else if CompareText(VarName,'storetypename') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[1]);
    end else if CompareText(VarName,'storebrands') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[2]);
    end else if CompareText(VarName,'storeunit') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[3]);
    end else if CompareText(VarName,'storeprice') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[4]));
    end else if CompareText(VarName,'overnums') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[5]));
    end else if CompareText(VarName,'cdate') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[6]);
    end else if CompareText(VarName,'partwhere') = 0 then begin
      Value := GetStringFromINI('ACCESSTYPE',getUTF8String(MYSQL_ROW^[7]),'前厅');
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetStoreWarningGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {select storename,storetypename,storeunit,sum(overnums),warningnums from view_storeitems}
  mysql_data_seek(mySQL_Res,self.frxUserDataSetStoreWarning.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);

  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'storename') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[0]);
    end else if CompareText(VarName,'storetypename') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[1]);
    end else if CompareText(VarName,'storeunit') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[2]);
    end else if CompareText(VarName,'overnums') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[3]));
    end else if CompareText(VarName,'warningnums') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[4]));
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetTradeDayGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {select tablename,constotal,willpaysum,paysum,paytype,payrate,payticket,invoicetotal,loginname,creationtime}
  mysql_data_seek(mySQL_Res,self.frxUserDataSetTradeDay.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'tablename') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[0]);
    end else if CompareText(VarName,'constotal') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[1]));
    end else if CompareText(VarName,'willpaysum') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[2]));
    end else if CompareText(VarName,'paysum') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[3]));
    end else if CompareText(VarName,'paytype') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[4]);
    end else if CompareText(VarName,'payrate') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[5]);
    end else if CompareText(VarName,'payticket') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[6]));
    end else if CompareText(VarName,'invoicetotal') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[7]));
    end else if CompareText(VarName,'loginname') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[8]);
    end else if CompareText(VarName,'creationtime') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[9]);
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetTradeListGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {'select a.tablename,c.itemname,a.nums,a.price,a.usertips,a.creationtime,b.printtime from consumption a '}
  mysql_data_seek(mySQL_Res,self.frxUserDataSetTradeList.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'date') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[1]);
    end else if CompareText(VarName,'trade') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[0]));
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetWorderDetailGetValue(const VarName:
    string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {select username,sex,idcard,access,mobileno,address,email,creationtime from users }
  mysql_data_seek(mySQL_Res,self.frxUserDataSetWorderDetail.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'username') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[0]);
    end else if CompareText(VarName,'sex') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[1]);
    end else if CompareText(VarName,'idcard') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[2]);
    end else if CompareText(VarName,'access') = 0 then begin
      Value := getUserGroupTitle(strtoint(getUTF8String(MYSQL_ROW^[3])));
    end else if CompareText(VarName,'mobileno') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[4]);
    end else if CompareText(VarName,'address') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[5]);
    end else if CompareText(VarName,'email') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[6]);
    end else if CompareText(VarName,'creationtime') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[7]);
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetWorkerAwardDetailGetValue(const
    VarName: string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {select username,tablename,itemname,nums,price,award,nums*award as total,creationtime }
  mysql_data_seek(mySQL_Res,self.frxUserDataSetWorkerAwardDetail.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'username') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[0]);
    end else if CompareText(VarName,'tablename') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[1]);
    end else if CompareText(VarName,'itemname') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[2]);
    end else if CompareText(VarName,'nums') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[3]));
    end else if CompareText(VarName,'price') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[4]));
    end else if CompareText(VarName,'award') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[5]));
    end else if CompareText(VarName,'awardtotal') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[6]));
    end else if CompareText(VarName,'creationtime') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[7]);
    end;
  end;
end;

procedure TFormReportManager.frxUserDataSetWorkerWageMonthGetValue(const
    VarName: string; var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  { select username,access,wage,jobsubsidy,telsubsidy,housesubsidy,transsubsidy,othersubsidy,
  bonus,income,checkdeduct,borrowdeduct,otherdeduct from wages }
  mysql_data_seek(mySQL_Res,self.frxUserDataSetWorkerWageMonth.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'username') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[0]);
    end else if CompareText(VarName,'access') = 0 then begin
      Value := getUserGroupTitle(strtoint(getUTF8String(MYSQL_ROW^[1])));
    end else if CompareText(VarName,'wage') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[2]));
    end else if CompareText(VarName,'jobsubsidy') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[3]));
    end else if CompareText(VarName,'telsubsidy') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[4]));
    end else if CompareText(VarName,'housesubsidy') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[5]));
    end else if CompareText(VarName,'transsubsidy') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[6]));
    end else if CompareText(VarName,'othersubsidy') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[7]));
    end else if CompareText(VarName,'bonus') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[8]));
    end else if CompareText(VarName,'income') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[9]));
    end else if CompareText(VarName,'checkdeduct') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[10]));
    end else if CompareText(VarName,'borrowdeduct') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[11]));
    end else if CompareText(VarName,'otherdeduct') = 0 then begin
      Value := strtofloat(getUTF8String(MYSQL_ROW^[12]));
    end else if CompareText(VarName,'wageid') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[13]));
    end;
  end;
end;

function TFormReportManager.getAccessItem: Integer;
var
  f:TFormGetAccess;
begin
  f:=TFormGetAccess.Create(self);
  f.ShowModal;
  Result := strtoint(f.RzComboBoxAccessList.Value);
  f.Destroy;
end;

procedure TFormReportManager.getAssetsDetailData;
var
  sql: string;
begin
  sql:='select id,assetsname,assetsnums,assetsunit,assetsprice,assetsdesc,assetsseller from assets ';
  sql:=sql+'order by id';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetAssetsDetail.RangeEnd := reCount;
    self.frxUserDataSetAssetsDetail.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetAssetsDetail.RangeEnd := reCount;
    self.frxUserDataSetAssetsDetail.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getBuyDataOfMonth;
var
  sql: string;
  df,dt:string;
  y,m:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql := 'select sum(buypaysum),cdate from view_purchase ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql+'and buystatus=0 ';
  sql := sql+'group by cdate ';
  sql := sql+'order by cdate ';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getBuyDataOfYear;
var
  sql: string;
  df,dt:string;
  y:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  df:=Format('%d-01-01',[y]);
  dt:=Format('%d-01-01',[y+1]);

  sql := 'select sum(buypaysum),cmonth from view_purchase ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql+'and buystatus=0 ';
  sql := sql+'group by cmonth ';
  sql := sql+'order by cmonth ';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getBuyForDataOfMonth;
var
  sql: string;
  df,dt:string;
  y,m,i:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql := 'select sum(buypaysum),forwhere from view_purchase ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql + ' group by forwhere order by forwhere';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetBuyForType.RangeEnd := reCount;
    i:=mysql_num_rows(mySQL_Res);
    self.frxUserDataSetBuyForType.RangeEndCount := i;
  end else begin
    self.frxUserDataSetBuyForType.RangeEnd := reCount;
    self.frxUserDataSetBuyForType.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getBuyTypeDataOfMonth;
var
  sql: string;
  df,dt:string;
  y,m,i:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql := 'select sum(buypaysum),buytype from view_purchase ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql + ' group by buytype order by buytype';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetBuyType.RangeEnd := reCount;
    i:=mysql_num_rows(mySQL_Res);
    self.frxUserDataSetBuyType.RangeEndCount := i;
  end else begin
    self.frxUserDataSetBuyType.RangeEnd := reCount;
    self.frxUserDataSetBuyType.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getInvoiceDataOfMonth;
var
  sql: string;
  df,dt:string;
  y,m:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql := 'select sum(invoicesum),cdate from view_invoices ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql+'group by cdate ';
  sql := sql+'order by cdate ';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getInvoiceDataOfYear;
var
  sql: string;
  df,dt:string;
  y:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  df:=Format('%d-01-01',[y]);
  dt:=Format('%d-01-01',[y+1]);

  sql := 'select sum(invoicesum),cmonth from view_invoices ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql+'group by cmonth ';
  sql := sql+'order by cmonth ';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getMemberData;
var
  sql: string;
begin
  sql:='select a.cardno,a.name,a.sex,a.mobileno,a.address,a.cardrate,a.cardover,a.cardstatus,a.creationtime,b.username,a.cashrate from members a ';
  sql:=sql+'left join users b on b.id=a.addbywho ';
  sql:=sql+'order by creationtime';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetMember.RangeEnd := reCount;
    self.frxUserDataSetMember.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetMember.RangeEnd := reCount;
    self.frxUserDataSetMember.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getMemberPutData;
var
  sql: string;
  df,dt:string;
  y,m:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql:='select a.cardno,a.paysum,a.donatesum,a.paytype,a.invoicetotal,a.creationtime,b.name,c.username from memberdetail a ';
  sql:=sql+'left join members b on b.cardno=a.cardno ';
  sql:=sql+'left join users c on c.id=b.addbywho ';
  sql:=sql+Format('where a.creationtime>=timestamp("%s") and a.creationtime<timestamp("%s") ',[df,dt]);
  sql:=sql+'and a.payidx=0 ';
  sql:=sql+'order by a.creationtime';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetMemberPut.RangeEnd := reCount;
    self.frxUserDataSetMemberPut.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetMemberPut.RangeEnd := reCount;
    self.frxUserDataSetMemberPut.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getMenuDataOfMonth;
var
  sql: string;
  df,dt:string;
  y,m:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql:='CREATE OR REPLACE view temp_selltotal as ';
  sql:=sql+'select menuidx,itemname,sum(price*nums) as totalprice,sum(nums) as totalnums,maindesc,subdesc from view_consumption ';
  sql:=sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s")',[df,dt]);
  sql:=sql+'and payidx>0 group by menuidx order by totalnums desc; ';
  execMySql(sql,LibHandle);
  sql:='select a.menuidx,a.itemname,a.maindesc,a.subdesc,b.totalprice,b.totalnums from menus a ';
  sql:=sql+'left join temp_selltotal b on b.menuidx=a.menuidx ';
  sql:=sql+'order by b.totalnums desc;';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetMenuMonth.RangeEnd := reCount;
    self.frxUserDataSetMenuMonth.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetMenuMonth.RangeEnd := reCount;
    self.frxUserDataSetMenuMonth.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getMenuMakeFromDataOfDay;
var
  sql: string;
  rd:TDate;
  df,dt:string;
  y,m,d:integer;
  dfs: TFormatSettings;
begin
  rd:=getReportDate;
  y:=yearOf(rd);
  frxReport.Variables['year'] := y;
  m:=monthOf(rd);
  frxReport.Variables['month'] := m;
  d:=dayOf(rd);
  frxReport.Variables['day'] := d;

  dfs.ShortDateFormat := 'yyyy-MM-dd';
  dfs.DateSeparator := '-';
  df:=Format('%d-%d-%d',[y,m,d]);
  //dt:=Format('%d-%d-%d',[y,m,d+1]);
  dt:=datetostr(strtodate(df,dfs)+1,dfs);

  sql := 'select sum(price*nums),makefrom from view_consumption ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql + 'and payidx>0 group by makefrom order by makefrom';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetMakeFromType.RangeEnd := reCount;
    self.frxUserDataSetMakeFromType.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetMakeFromType.RangeEnd := reCount;
    self.frxUserDataSetMakeFromType.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getMenuMakeFromDataOfMonth;
var
  sql: string;
  df,dt:string;
  y,m:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql := 'select sum(price*nums),makefrom from view_consumption ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql + 'and payidx>0 group by makefrom order by makefrom';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetMakeFromType.RangeEnd := reCount;
    self.frxUserDataSetMakeFromType.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetMakeFromType.RangeEnd := reCount;
    self.frxUserDataSetMakeFromType.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getMenuTypeDataOfMonth;
var
  sql: string;
  df,dt:string;
  y,m:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql := 'select sum(price*nums),mainidx,maindesc from view_consumption ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql + 'and payidx>0 group by mainidx order by mainidx';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetMenuType.RangeEnd := reCount;
    self.frxUserDataSetMenuType.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetMenuType.RangeEnd := reCount;
    self.frxUserDataSetMenuType.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getPayTypeDataOfMonth;
var
  sql: string;
  df,dt:string;
  y,m,i:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql := 'select sum(paysum),paytype from view_payitems ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql + 'and paytype>=0 group by paytype order by paytype';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetPayType.RangeEnd := reCount;
    i:=mysql_num_rows(mySQL_Res);
    self.frxUserDataSetPayType.RangeEndCount := i;
  end else begin
    self.frxUserDataSetPayType.RangeEnd := reCount;
    self.frxUserDataSetPayType.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getReportData(Tag: Integer);
begin
  case Tag of
    0,2:getTradeDataOfMonth;
    1,3:getTradeDataOfYear;
    4:getTradeDataOfDay;

    10:getPayTypeDataOfMonth;
    11:getTicketDataOfMonth;

    20:getMenuTypeDataOfMonth;
    21:getMenuDataOfMonth;
    22:getMenuMakeFromDataOfDay;
    23:getMenuMakeFromDataOfMonth;

    30:getMemberData;
    31:getMemberPutData;

    40:getInvoiceDataOfMonth;
    41:getInvoiceDataOfYear;

    50:getStoreDetailData;
    51:getStoreWarningData;
    52:getStoreJoinMonthData;
    53:getStorePartMonthData;
    54:getStoreWhereMonthData;
    55:getStoreJoinDayData;
    56:getStorePartDayData;

    60:getBuyDataOfMonth;
    61:getBuyDataOfYear;
    62:getSellerNotPayData;
    63:getBuyTypeDataOfMonth;
    64:getBuyForDataOfMonth;

    80:getWorkerDetailData;
    81:getWorkerWageMonthData;
    82:getWorkerAwardMonthData;
    83:getWorkerAwardDetailMonthData;
    84:getAssetsDetailData;
    85:getUsersCountMonthData;
  end;
end;

function TFormReportManager.getReportDate: TDate;
var
  f:TFormGetDate;
begin
  f:=TFormGetDate.Create(self);
  f.ShowModal;
  Result := f.RzDateTimeEditDate.Date;
  f.Destroy;
end;

function TFormReportManager.getReportMonth: Variant;
var
  f:TFormGetMonth;
begin
  f:=TFormGetMonth.Create(self);
  f.ShowModal;
  Result := f.RzComboBoxMonthList.Value;
  f.Destroy;
end;

function TFormReportManager.getReportYear: Variant;
var
  f:TFormGetYear;
begin
  f:=TFormGetYear.Create(self);
  f.ShowModal;
  Result := f.RzComboBoxYearList.Value;
  f.Destroy;
end;

procedure TFormReportManager.getSellerNotPayData;
var
  sql: string;
begin
  sql := 'select sellername,sellertel,buytype,buypaysum,paystatus,creationtime from view_purchase ';
  sql := sql+'where paystatus=0 order by buyselleridx,id';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetSellerNotPay.RangeEnd := reCount;
    self.frxUserDataSetSellerNotPay.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetSellerNotPay.RangeEnd := reCount;
    self.frxUserDataSetSellerNotPay.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getStoreDetailData;
var
  sql: string;
begin
  sql:='select storename,storetypename,joinbrands,storeunit,joinprice,overnums,cdate from view_storeitems ';
  sql:=sql+'where partid=0 and overnums>0 ';
  sql:=sql+'order by storetypeidx,storeid';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetStoreDetail.RangeEnd := reCount;
    self.frxUserDataSetStoreDetail.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetStoreDetail.RangeEnd := reCount;
    self.frxUserDataSetStoreDetail.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getStoreJoinDayData;
var
  sql: string;
  rd:TDate;
  df,dt:string;
  y,m,d:integer;
  dfs: TFormatSettings;
begin
  rd:=getReportDate;
  y:=yearOf(rd);
  frxReport.Variables['year'] := y;
  m:=monthOf(rd);
  frxReport.Variables['month'] := m;
  d:=dayOf(rd);
  frxReport.Variables['day'] := d;

  dfs.ShortDateFormat := 'yyyy-MM-dd';
  dfs.DateSeparator := '-';
  df:=Format('%d-%d-%d',[y,m,d]);
  //dt:=Format('%d-%d-%d',[y,m,d+1]);
  dt:=datetostr(strtodate(df,dfs)+1,dfs);

  sql:='select storename,storetypename,joinbrands,storeunit,joinprice,joinnums,cdate from view_storeitems ';
  sql:=sql+'where partid=0 ';
  sql:=sql+Format('and cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql:=sql+'order by creationtime';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetStoreDetail.RangeEnd := reCount;
    self.frxUserDataSetStoreDetail.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetStoreDetail.RangeEnd := reCount;
    self.frxUserDataSetStoreDetail.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getStoreJoinMonthData;
var
  sql: string;
  df,dt:string;
  y,m:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql:='select storename,storetypename,joinbrands,storeunit,joinprice,joinnums,cdate from view_storeitems ';
  sql:=sql+'where partid=0 ';
  sql:=sql+Format('and cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql:=sql+'order by creationtime';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetStoreDetail.RangeEnd := reCount;
    self.frxUserDataSetStoreDetail.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetStoreDetail.RangeEnd := reCount;
    self.frxUserDataSetStoreDetail.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getStorePartDayData;
var
  sql,t: string;
  rd:TDate;
  df,dt:string;
  y,m,d,acc:integer;
  dfs: TFormatSettings;
begin
  rd:=getReportDate;
  y:=yearOf(rd);
  frxReport.Variables['year'] := y;
  m:=monthOf(rd);
  frxReport.Variables['month'] := m;
  d:=dayOf(rd);
  frxReport.Variables['day'] := d;
  acc:=self.getAccessItem;
  if acc<0 then begin
    frxReport.Variables['access'] := '''所有''';
  end else begin
    t:=GetStringFromINI('ACCESSTYPE',inttostr(acc),'前厅');
    frxReport.Variables['access'] := ''''+t+'''';
  end;

  dfs.ShortDateFormat := 'yyyy-MM-dd';
  dfs.DateSeparator := '-';
  df:=Format('%d-%d-%d',[y,m,d]);
  //dt:=Format('%d-%d-%d',[y,m,d+1]);
  dt:=datetostr(strtodate(df,dfs)+1,dfs);

  sql:='select b.storename,b.storetypename,b.joinbrands,b.storeunit,b.joinprice,a.partnums,a.cdate,a.partwhere from view_storeitems a ';
  sql:=sql+'left join view_storeitems b on a.partid=b.id ';
  sql:=sql+'where a.partid>0 ';
  if acc>=0 then begin
    sql:=sql+'and a.partwhere='+inttostr(acc)+' ';
  end;
  sql:=sql+Format('and a.cdate>=timestamp("%s") and a.cdate<timestamp("%s") ',[df,dt]);
  sql:=sql+'order by b.creationtime ';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetStoreDetail.RangeEnd := reCount;
    self.frxUserDataSetStoreDetail.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetStoreDetail.RangeEnd := reCount;
    self.frxUserDataSetStoreDetail.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getStorePartMonthData;
var
  sql,t: string;
  df,dt:string;
  y,m,acc:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  acc:=self.getAccessItem;
  if acc<0 then begin
    frxReport.Variables['access'] := '''所有''';
  end else begin
    t:=GetStringFromINI('ACCESSTYPE',inttostr(acc),'前厅');
    frxReport.Variables['access'] := ''''+t+'''';
  end;

  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql:='select b.storename,b.storetypename,b.joinbrands,b.storeunit,b.joinprice,a.partnums,a.cdate,a.partwhere from view_storeitems a ';
  sql:=sql+'left join view_storeitems b on a.partid=b.id ';
  sql:=sql+'where a.partid>0 ';
  if acc>=0 then begin
    sql:=sql+'and a.partwhere='+inttostr(acc)+' ';
  end;
  sql:=sql+Format('and a.cdate>=timestamp("%s") and a.cdate<timestamp("%s") ',[df,dt]);
  sql:=sql+'order by b.creationtime ';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetStoreDetail.RangeEnd := reCount;
    self.frxUserDataSetStoreDetail.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetStoreDetail.RangeEnd := reCount;
    self.frxUserDataSetStoreDetail.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getStoreWarningData;
var
  sql: string;
begin
  sql:='select * from (';
  sql:=sql+'select storename,storetypename,storeunit,sum(overnums) as overnums,warningnums from view_storeitems ';
  sql:=sql+'where partid=0 group by storeid order by storetypeidx,storeid)a ';
  sql:=sql+'where overnums<warningnums';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetStoreWarning.RangeEnd := reCount;
    self.frxUserDataSetStoreWarning.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetStoreWarning.RangeEnd := reCount;
    self.frxUserDataSetStoreWarning.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getStoreWhereMonthData;
var
  sql: string;
  df,dt:string;
  y,m,i:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql:='select sum(b.joinprice*a.partnums),a.partwhere from view_storeitems a ';
  sql:=sql+'left join view_storeitems b on a.partid=b.id ';
  sql:=sql+'where a.partid>0 ';
  sql:=sql+Format('and a.cdate>=timestamp("%s") and a.cdate<timestamp("%s") ',[df,dt]);
  sql:=sql+'group by a.partwhere ';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetBuyForType.RangeEnd := reCount;
    i:=mysql_num_rows(mySQL_Res);
    self.frxUserDataSetBuyForType.RangeEndCount := i;
  end else begin
    self.frxUserDataSetBuyForType.RangeEnd := reCount;
    self.frxUserDataSetBuyForType.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getTicketDataOfMonth;
var
  sql: string;
  df,dt:string;
  y,m:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql := 'select tablename,constotal,willpaysum,paysum,paytype,payrate,payticket,invoicetotal,loginname,creationtime from view_payitems ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql+'and paytype>=0 and payticket>0 ';
  sql := sql+'order by creationtime ';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetTradeDay.RangeEnd := reCount;
    self.frxUserDataSetTradeDay.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetTradeDay.RangeEnd := reCount;
    self.frxUserDataSetTradeDay.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getTradeDataOfDay;
var
  sql: string;
  rd:TDate;
  df,dt:string;
  y,m,d:integer;
  dfs: TFormatSettings;
begin
  rd:=getReportDate;
  y:=yearOf(rd);
  frxReport.Variables['year'] := y;
  m:=monthOf(rd);
  frxReport.Variables['month'] := m;
  d:=dayOf(rd);
  frxReport.Variables['day'] := d;

  dfs.ShortDateFormat := 'yyyy-MM-dd';
  dfs.DateSeparator := '-';
  df:=Format('%d-%d-%d',[y,m,d]);
  //dt:=Format('%d-%d-%d',[y,m,d+1]);
  dt:=datetostr(strtodate(df,dfs)+1,dfs);

  sql := 'select tablename,constotal,willpaysum,paysum,paytype,payrate,payticket,invoicetotal,loginname,creationtime from view_payitems ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql+'and paytype>=0 ';
  sql := sql+'order by creationtime ';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetTradeDay.RangeEnd := reCount;
    self.frxUserDataSetTradeDay.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetTradeDay.RangeEnd := reCount;
    self.frxUserDataSetTradeDay.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getTradeDataOfMonth;
var
  sql: string;
  df,dt:string;
  y,m:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql := 'select sum(paysum),cdate from view_payitems ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql+'and paytype>=0 ';
  sql := sql+'group by cdate ';
  sql := sql+'order by cdate ';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getTradeDataOfYear;
var
  sql: string;
  df,dt:string;
  y:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  df:=Format('%d-01-01',[y]);
  dt:=Format('%d-01-01',[y+1]);

  sql := 'select sum(paysum),cmonth from view_payitems ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql+'and paytype>=0 ';
  sql := sql+'group by cmonth ';
  sql := sql+'order by cmonth ';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getUsersCountMonthData;
var
  sql: string;
  df,dt:string;
  y,m:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql := 'select sum(users),cdate from view_tableusers ';
  sql := sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql := sql+'group by cdate ';
  sql := sql+'order by cdate ';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getWorkerAwardDetailMonthData;
var
  sql: string;
  df,dt:string;
  y,m:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql:='select username,tablename,itemname,nums,price,award,nums*award as total,creationtime from view_award ';
  sql:=sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql:=sql+'and payidx>0 and paytype>=0 and award>0 ';
  sql:=sql+'order by username,creationtime';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetWorkerAwardDetail.RangeEnd := reCount;
    self.frxUserDataSetWorkerAwardDetail.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetWorkerAwardDetail.RangeEnd := reCount;
    self.frxUserDataSetWorkerAwardDetail.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getWorkerAwardMonthData;
var
  sql: string;
  df,dt:string;
  y,m:integer;
begin
  y:=self.getReportYear;
  frxReport.Variables['year'] := y;
  m:=self.getReportMonth;
  frxReport.Variables['month'] := m;
  df:=Format('%d-%d-01',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql:='select sum(award*nums) as total,username from view_award ';
  sql:=sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[df,dt]);
  sql:=sql+'and payidx>0 and paytype>=0 and award>0 ';
  sql:=sql+'group by username ';
  sql:=sql+'order by total desc';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetTradeList.RangeEnd := reCount;
    self.frxUserDataSetTradeList.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getWorkerDetailData;
var
  sql: string;
begin
  sql:='select username,sex,idcard,access,mobileno,address,email,creationtime from users ';
  sql:=sql+'where delflag=0 ';
  sql:=sql+'order by access,creationtime';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetWorderDetail.RangeEnd := reCount;
    self.frxUserDataSetWorderDetail.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetWorderDetail.RangeEnd := reCount;
    self.frxUserDataSetWorderDetail.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.getWorkerWageMonthData;
var
  sql: string;
  df:string;
  y,m:integer;
begin
  if frxReport.Variables['year']='' then begin
    y:=self.getReportYear;
    frxReport.Variables['year'] := y;
  end else begin
    y:=frxReport.Variables['year'];
  end;
  if frxReport.Variables['month']='' then begin
    m:=self.getReportMonth;
    frxReport.Variables['month'] := m;
  end else begin
    m:=frxReport.Variables['month'];
  end;
  df:=Format('%d-%d',[y,m]);

  initWorkerWageMonthRecord(y,m);

  sql:='select username,access,wage,jobsubsidy,telsubsidy,housesubsidy,transsubsidy,othersubsidy,bonus,income,checkdeduct,borrowdeduct,otherdeduct,id from wages ';
  sql:=sql+Format('where wagemonth="%s" ',[df]);
  sql:=sql+'order by access';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    self.frxUserDataSetWorkerWageMonth.RangeEnd := reCount;
    self.frxUserDataSetWorkerWageMonth.RangeEndCount := mysql_num_rows(mySQL_Res);
  end else begin
    self.frxUserDataSetWorkerWageMonth.RangeEnd := reCount;
    self.frxUserDataSetWorkerWageMonth.RangeEndCount := 0;
  end;
end;

procedure TFormReportManager.initWorkerWageMonthRecord(y, m: integer);
var
  sql,df,dt,inf,int: string;
  MYSQL_ROW: PMYSQL_ROW;
  mySQL_Res_temp: PMYSQL_RES;
begin
  //写职员信息记录到工资表
  df:=Format('%d-%d',[y,m]);
  if m=12 then
    dt:=Format('%d-01-01',[y+1])
  else
    dt:=Format('%d-%d-01',[y,m+1]);

  sql:='select loginname,username,access,wage,jobsubsidy,telsubsidy,housesubsidy,transsubsidy from users ';
  sql:=sql+'where delflag=0 and jobstatus=0 ';
  sql:=sql+Format('and date(creationtime)<timestamp("%s") ',[dt]);
  sql:=sql+'order by id';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        sql:=Format('select loginname from wages where loginname="%s" and wagemonth="%s"',[getMyStr(MYSQL_ROW^[0]),df]);
        queryMySql(sql,LibHandle, mySQL_Res_temp);
        if mysql_num_rows(mySQL_Res_temp)=0 then begin
          sql:='insert into wages(loginname,username,access,wage,jobsubsidy,telsubsidy,housesubsidy,transsubsidy,wagemonth) ';
          sql:=sql+Format('values("%s","%s",%s,%s,%s,%s,%s,%s,"%s")',
              [ getMyStr(MYSQL_ROW^[0]),
                getMyStr(MYSQL_ROW^[1]),
                getMyStr(MYSQL_ROW^[2]),
                getMyStr(MYSQL_ROW^[3]),
                getMyStr(MYSQL_ROW^[4]),
                getMyStr(MYSQL_ROW^[5]),
                getMyStr(MYSQL_ROW^[6]),
                getMyStr(MYSQL_ROW^[7]),
                df
              ]);
          execMySql(sql,LibHandle);
        end else begin
          sql:=Format('update wages set access=%s,wage=%s,jobsubsidy=%s,telsubsidy=%s,housesubsidy=%s,transsubsidy=%s where loginname="%s" and wagemonth="%s" ',
              [ getMyStr(MYSQL_ROW^[2]),
                getMyStr(MYSQL_ROW^[3]),
                getMyStr(MYSQL_ROW^[4]),
                getMyStr(MYSQL_ROW^[5]),
                getMyStr(MYSQL_ROW^[6]),
                getMyStr(MYSQL_ROW^[7]),
                getMyStr(MYSQL_ROW^[0]),
                df
              ]);
          execMySql(sql,LibHandle);
        end;
      end;
    until MYSQL_ROW=nil;
  end;
  //统计提成信息，写入工资表
  inf:=Format('%d-%d-01',[y,m]);
  if m=12 then
    int:=Format('%d-01-01',[y+1])
  else
    int:=Format('%d-%d-01',[y,m+1]);


  sql:='select sum(award*nums) as total,loginname from view_award ';
  sql:=sql+Format('where cdate>=timestamp("%s") and cdate<timestamp("%s") ',[inf,int]);
  sql:=sql+'and payidx>0 and paytype>=0 and award>0 ';
  sql:=sql+'group by username ';

  queryMySql(sql,LibHandle, mySQL_Res_temp);
  if mysql_num_rows(mySQL_Res_temp)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res_temp);
      if MYSQL_ROW<>nil then begin
        sql:=Format('update wages set income=%s where loginname="%s" and wagemonth="%s" ',
            [ getMyStr(MYSQL_ROW^[0]),
              getMyStr(MYSQL_ROW^[1]),
              df
            ]);
        execMySql(sql,LibHandle);
      end;
    until MYSQL_ROW=nil;
  end;

  if mySQL_Res_temp<>nil then
    mysql_free_result(mySQL_Res_temp);
end;

procedure TFormReportManager.OnGroupItemClick(Sender: TObject);
var
  i,j:integer;
  g:TRzGroup;
  it,item:TRzGroupItem;
begin
  item:=TRzGroupItem(Sender);
  for i := 0 to self.RzGroupBar.GroupCount - 1 do begin
    g:=RzGroupBar.Groups[i];
    for j := 0 to g.Items.Count - 1 do begin
      it:=g.Items.Items[j];
      if it<>item then begin
        it.Selected:=false;
      end;
    end;
  end;
  self.RzToolButtonReload.Tag:=item.Tag;
  self.RzLabelReportFileName.Caption:=item.Hint;
  self.RzToolButtonReloadClick(self);
end;

procedure TFormReportManager.RzGroupTradeTypeCanOpen(Sender: TObject; var
    CanOpen: Boolean);
var
  i:integer;
  g:TRzGroup;
begin
  g:=TRzGroup(Sender);
  for i := 0 to self.RzGroupBar.GroupCount - 1 do begin
    if RzGroupBar.Groups[i]<>g then begin
      RzGroupBar.Groups[i].Close;
    end;
  end;
end;

procedure TFormReportManager.RzLabelReportFileNameDblClick(Sender: TObject);
begin
  Clipboard.SetTextBuf(PWideChar(RzLabelReportFileName.Caption));
end;

procedure TFormReportManager.RzToolButtonPrintClick(Sender: TObject);
begin
  self.frxReport.Print;
end;

procedure TFormReportManager.RzToolButtonDesignReportClick(Sender: TObject);
begin
  self.frxReport.DesignReport();
end;

procedure TFormReportManager.RzToolButtonReloadClick(Sender: TObject);
begin
  if loadReportDesignFile(self.frxReport,RzLabelReportFileName.Caption) then begin
    frxReport.Variables['year']:='';
    frxReport.Variables['month']:='';
    frxReport.Variables['day']:='';
    self.RzToolButtonPrint.Enabled:=false;
    self.frxReport.Preview:=self.frxPreview;
    self.frxPreview.SetFocus;
    getReportData(RzToolButtonReload.Tag);
    if self.frxReport.PrepareReport(true) then begin
      self.frxReport.ShowPreparedReport;
      self.RzToolButtonPrint.Enabled:=true;
    end;
  end;
end;

end.
