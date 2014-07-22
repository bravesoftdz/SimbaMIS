program simbaMIS;

uses
  Forms,
  Windows,
  fmMain in 'fmMain.pas' {FormMain},
  mfmCheckout in 'mfmCheckout.pas' {FormCheckOut},
  fmUserManager in 'fmUserManager.pas' {FormUserManager},
  fmUserInfo in 'fmUserInfo.pas' {FormUserInfo},
  mysql in 'mysql.pas',
  myfunction in 'myfunction.pas',
  fmEditPass in 'fmEditPass.pas' {FormEditPass},
  fmTableManager in 'fmTableManager.pas' {FormTableManager},
  dbfunction in 'dbfunction.pas',
  fmTableInfo in 'fmTableInfo.pas' {FormTableInfo},
  fmMenuManager in 'fmMenuManager.pas' {FormMenuManager},
  fmMenuInfo in 'fmMenuInfo.pas' {FormMenuInfo},
  fmActivityManager in 'fmActivityManager.pas' {FormActivityManager},
  fmActivityInfo in 'fmActivityInfo.pas' {FormActivityInfo},
  fmOrderItem in 'fmOrderItem.pas' {FormOrderItem},
  fmOrderManager in 'fmOrderManager.pas' {FormOrderManager},
  fmOrderInfo in 'fmOrderInfo.pas' {FormOrderInfo},
  fmTableDetail in 'fmTableDetail.pas' {FormTableDetail},
  fmMemberManager in 'fmMemberManager.pas' {FormMemberManager},
  fmMemberAdd in 'fmMemberAdd.pas' {FormMemberAdd},
  fmMemberEdit in 'fmMemberEdit.pas' {FormMemberEdit},
  fmMemberReadd in 'fmMemberReadd.pas' {FormMemberReadd},
  fmNetTicketMaker in 'fmNetTicketMaker.pas' {FormNetTicketMaker},
  fmMemberPutMoney in 'fmMemberPutMoney.pas' {FormMemberPutMoney},
  fmInvoiceMaker in 'fmInvoiceMaker.pas' {FormInvoiceMaker},
  fmMemberDetail in 'fmMemberDetail.pas' {FormMemberDetail},
  fmInvoiceManager in 'fmInvoiceManager.pas' {FormInvoiceManager},
  fmStoreManager in 'fmStoreManager.pas' {FormStoreManager},
  fmReportManager in 'fmReportManager.pas' {FormReportManager},
  fmKitchenInfo in 'fmKitchenInfo.pas' {FormKitchenInfo},
  mfmBarManager in 'mfmBarManager.pas' {FormBarManager},
  mfmKitchenManager in 'mfmKitchenManager.pas' {FormKitchenManager},
  fmMemberInvoice in 'fmMemberInvoice.pas' {FormMemberInvoice},
  fmMemberInvoiceLog in 'fmMemberInvoiceLog.pas' {FormMemberInvoiceLog},
  fmGetYear in 'fmGetYear.pas' {FormGetYear},
  fmGetMonth in 'fmGetMonth.pas' {FormGetMonth},
  fmGetDay in 'fmGetDay.pas' {FormGetDay},
  fmGetDate in 'fmGetDate.pas' {FormGetDate},
  fmKitchenColdInfo in 'fmKitchenColdInfo.pas' {FormKitchenColdInfo},
  fmHasten in 'fmHasten.pas' {FormHasten},
  fmLogin in 'fmLogin.pas' {FormLogin},
  fmAbout in 'fmAbout.pas' {FormAbout},
  fmBuyManager in 'fmBuyManager.pas' {FormBuyManager},
  fmSellerManager in 'fmSellerManager.pas' {FormSellerManager},
  fmBuyInfo in 'fmBuyInfo.pas' {FormBuyInfo},
  fmSellerInfo in 'fmSellerInfo.pas' {FormSellerInfo},
  fmSellerClear in 'fmSellerClear.pas' {FormSellerClear},
  fmChangeReportData in 'fmChangeReportData.pas' {FormChangeReportData},
  fmSelectMenus in 'fmSelectMenus.pas' {FormSelectMenus},
  fmAssetsManager in 'fmAssetsManager.pas' {FormAssetsManager},
  fmAssetsInfo in 'fmAssetsInfo.pas' {FormAssetsInfo},
  fmStoreJoin in 'fmStoreJoin.pas' {FormStoreJoin},
  fmStorePart in 'fmStorePart.pas' {FormStorePart},
  fmStoreDetail in 'fmStoreDetail.pas' {FormStoreDetail},
  fmStoreItemManager in 'fmStoreItemManager.pas' {FormStoreItemManager},
  fmStoreItemInfo in 'fmStoreItemInfo.pas' {FormStoreItemInfo},
  fmTuiCai in 'fmTuiCai.pas' {FormTuiCai},
  fmGetAccess in 'fmGetAccess.pas' {FormGetAccess};

{$R *.res}

var
  HMutex:Hwnd;
  fWnd:Hwnd;
  Ret:Integer;
  aTitle:string;
begin

  Application.Initialize;
  aTitle := 'simbaMIS';
  Application.Title := 'simbaMIS';

  HMutex:=CreateMutex(nil,False,Pchar(aTitle));  //建立互斥对象，名字为aTitle--'LiveAuction'
  Ret:=GetLastError;
  If Ret<>ERROR_ALREADY_EXISTS Then begin
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormTuiCai, FormTuiCai);
  Application.CreateForm(TFormGetAccess, FormGetAccess);
  Application.Run;
  end else begin
    ReleaseMutex(hMutex);  //防止创建多个程序实例
    fWnd := FindWindow(nil, PWideChar('辛巴咖啡管理系统'));
    if (IsWindow(fWnd)) then begin
      ShowWindow(fWnd, SW_SHOWNORMAL);
      SetForegroundWindow(fWnd);
    end;
  end;

end.
