unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, RzButton, ExtCtrls, RzPanel, myRzToolbar, AppEvnts, RzSplit,
  RzBckgnd, myRzToolButton, ComCtrls, RzListVw, Menus, RzCommon, RzBHints,
  WideStrings, DBXMySql, DB, SqlExpr, mysql, mfmCheckout, mfmBarManager,
  mfmKitchenManager, RzStatus, StdCtrls, RzLabel, jpeg;

type
  TFormMain = class(TForm)
    MyRzToolbarMain: TMyRzToolbar;
    RzToolButtonMemberManager: TRzToolButton;
    ImageListMainToolbar: TImageList;
    RzToolButtonReportManager: TRzToolButton;
    RzToolButtonWareHouseManager: TRzToolButton;
    RzToolButtonActivityManager: TRzToolButton;
    RzToolButtonUserManager: TRzToolButton;
    RzToolButtonSystemTools: TRzToolButton;
    RzSpacer3: TRzSpacer;
    RzSpacer1: TRzSpacer;
    RzToolButtonTableManager: TRzToolButton;
    RzToolButtonMenuManager: TRzToolButton;
    RzToolButtonExit: TRzToolButton;
    RzToolButtonEditPass: TRzToolButton;
    ApplicationEvents1: TApplicationEvents;
    RzToolButtonBarTable: TRzToolButton;
    RzToolButtonKitchen: TRzToolButton;
    RzSpacer2: TRzSpacer;
    RzToolButtonCheckOut: TRzToolButton;
    RzToolButtonClose: TRzToolButton;
    RzBalloonHints1: TRzBalloonHints;
    RzToolButtonOrderManager: TRzToolButton;
    RzMenuController1: TRzMenuController;
    PopupMenuSystemTools: TPopupMenu;
    pmenuMakeNetTicket: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    RzToolButtonInvoiceManager: TRzToolButton;
    RzStatusBar1: TRzStatusBar;
    RzClockStatus1: TRzClockStatus;
    RzVersionInfoStatus1: TRzVersionInfoStatus;
    RzVersionInfo1: TRzVersionInfo;
    RzURLLabel1: TRzURLLabel;
    RzStatusPaneWelcome: TRzStatusPane;
    RzStatusPaneUserName: TRzStatusPane;
    RzToolButtonBuyManager: TRzToolButton;
    RzToolButtonAssetsManager: TRzToolButton;
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure RzToolButtonCheckOutClick(Sender: TObject);
    procedure RzToolButtonExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure pmenuMakeNetTicketClick(Sender: TObject);
    procedure RzToolButtonMenuManagerClick(Sender: TObject);
    procedure RzToolButtonCloseClick(Sender: TObject);
    procedure RzToolButtonInvoiceManagerClick(Sender: TObject);
    procedure RzToolButtonActivityManagerClick(Sender: TObject);
    procedure RzToolButtonAssetsManagerClick(Sender: TObject);
    procedure RzToolButtonSystemToolsClick(Sender: TObject);
    procedure RzToolButtonBarTableClick(Sender: TObject);
    procedure RzToolButtonBuyManagerClick(Sender: TObject);
    procedure RzToolButtonEditPassClick(Sender: TObject);
    procedure RzToolButtonKitchenClick(Sender: TObject);
    procedure RzToolButtonMemberManagerClick(Sender: TObject);
    procedure RzToolButtonOrderManagerClick(Sender: TObject);
    procedure RzToolButtonReportManagerClick(Sender: TObject);
    procedure RzToolButtonTableManagerClick(Sender: TObject);
    procedure RzToolButtonUserManagerClick(Sender: TObject);
    procedure RzToolButtonWareHouseManagerClick(Sender: TObject);
    procedure RzURLLabel1Click(Sender: TObject);
  private
    FClientInstance:Pointer;
    procedure CreateDefWndProc();
  public
    isLogined:boolean;
    FormCheckOut:TFormCheckOut;
    FormBar:TFormBarManager;
    FormKitchen:TFormKitchenManager;
    procedure setButtonEnableWithAccess(acc: Integer);
　　procedure ClientWndProc(var Message:TMessage);
    procedure WndProc(var Message: TMessage); override;
  end;

var
  FormMain: TFormMain;

implementation

uses fmUserManager, fmEditPass, fmTableManager, fmMenuManager, fmActivityManager, fmOrderManager,
fmMemberManager, myfunction, fmNetTicketMaker, fmInvoiceManager, fmStoreManager, fmReportManager,
fmLogin, fmAbout, fmBuyManager, fmAssetsManager;

{$R *.dfm}

procedure TFormMain.FormDestroy(Sender: TObject);
var
  i:integer;
  t:TForm;
begin
  for i := self.get_MDIChildCount - 1 downto 0 do begin
    t:=self.get_MDIChildren(i);
    t.Destroy;
  end;

  libmysql_free;
end;

procedure TFormMain.CreateDefWndProc;
var
　hWnd1:HWND;
　ccs:TClientCreateStruct;
begin
　ccs.hWindowMenu:=0;
　ccs.idFirstChild:=$FF00;
　hWnd1:=CreateWindowEx(WS_EX_CLIENTEDGE,'MDICLIENT','', WS_CHILD or WS_VISIBLE or WS_GROUP or WS_TABSTOP or WS_CLIPCHILDREN or WS_HSCROLL or WS_VSCROLL or WS_CLIPSIBLINGS or MDIS_ALLCHILDSTYLES,0,0,ClientWidth,ClientHeight,Handle,0,HInstance,@ccs);
　FClientInstance:=pointer(GetWindowLong(hWnd1,GWL_WNDPROC));
　DestroyWindow(hWnd1);
end;

procedure TFormMain.ClientWndProc(var Message:TMessage);
begin
  if(Message.Msg=WM_ERASEBKGND) then begin
    FillRect(HDC(Message.WParam), ClientRect, Brush.Handle);
    Message.Result:=1;
  end else begin
    Message.Result:=CallWindowProc(FClientInstance, ClientHandle, Message.Msg, message.WParam, Message.LParam);
  end;
end;
　　
procedure TFormMain.FormCreate(Sender:TObject);
var
  cR,cG,cB:integer;
begin
  InsertMenu (GetSystemMenu (self.Handle, False), SC_CLOSE, MF_BYCOMMAND + MF_STRING, 100, '关于辛巴咖啡餐饮管理系统...');
  InsertMenu (GetSystemMenu (self.Handle, False), SC_CLOSE, MF_BYCOMMAND + MF_SEPARATOR, 101, '');
  self.RzStatusPaneWelcome.Caption:='欢迎进入'+GetStringFromINI('PUBLIC','misTitle','辛巴西餐咖啡厅')+'管理系统';
  self.Caption:=GetStringFromINI('PUBLIC','misTitle','辛巴西餐咖啡厅')+'管理系统';
  libmysql_fast_load(nil);
　//*******去除MDIchild粗边框**********
　{CreateDefWndProc();
　SetWindowLong(ClientHandle,GWL_WNDPROC,
　LongInt(MakeObjectInstance(ClientWndProc)));
　SetWindowLong(ClientHandle,GWL_EXSTYLE,GetWindowLong(ClientHandle,GWL_EXSTYLE)and(not WS_EX_CLIENTEDGE));
　SetWindowPos(ClientHandle,0,0,0,0,0,SWP_FRAMECHANGED or SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
　}//***********************************\
  self.isLogined:=false;

  cR:=GetIntegerFromINI('UI','bgcolorR',12);
  cG:=GetIntegerFromINI('UI','bgcolorG',67);
  cB:=GetIntegerFromINI('UI','bgcolorB',49);
  self.Color:=RGB(cR,cG,cB);
end;

procedure TFormMain.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  SetProcessWorkingSetSize(GetCurrentProcess(), $FFFFFFFF, $FFFFFFFF);
end;

procedure TFormMain.FormActivate(Sender: TObject);
var
  f:TFormLogin;
begin
  if not self.isLogined then begin
    f:=TFormLogin.Create(self);
    f.ShowModal;
    f.Destroy;
  end;
end;

procedure TFormMain.FormPaint(Sender: TObject);
var
  g:TBitmap;
  f:string;
  X,Y:integer;
begin
  if self.isLogined then begin
    g:=TBitmap.Create;
    f:=ExtractFilePath(Application.ExeName) + GetStringFromINI('UI','mislogo','logo.bmp');
    g.LoadFromFile(f);
    X := (self.ClientWidth - g.Width) div 2;
    Y := (self.ClientHeight - g.Height) div 2;
    self.Canvas.Draw(X, Y, g);
  end;
end;

procedure TFormMain.pmenuMakeNetTicketClick(Sender: TObject);
var
  f:TFormNetTicketMaker;
begin
  f:=TFormNetTicketMaker.Create(self);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMain.RzToolButtonMenuManagerClick(Sender: TObject);
var
  f:TFormMenuManager;
begin
  f:=TFormMenuManager.Create(self);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMain.RzToolButtonCloseClick(Sender: TObject);
var
  t:TForm;
begin
  t:=self.get_ActiveMDIChild;
  if t<>nil then begin
    t.Close;
    t.Destroy;
  end;
end;

procedure TFormMain.RzToolButtonInvoiceManagerClick(Sender: TObject);
var
  f:TFormInvoiceManager;
begin
  f:=TFormInvoiceManager.Create(self);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMain.RzToolButtonActivityManagerClick(Sender: TObject);
var
  f:TFormActivityManager;
begin
  f:=TFormActivityManager.Create(self);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMain.RzToolButtonAssetsManagerClick(Sender: TObject);
var
  f:TFormAssetsManager;
begin
  f:=TFormAssetsManager.Create(self);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMain.RzToolButtonSystemToolsClick(Sender: TObject);
var
  p:TPoint;
begin
  p.X:=RzToolButtonSystemTools.Left;
  p.Y:=RzToolButtonSystemTools.Top+RzToolButtonSystemTools.Height;
  p:=self.ClientToScreen(p);
  self.PopupMenuSystemTools.Popup(p.x,p.y);
end;

procedure TFormMain.RzToolButtonBarTableClick(Sender: TObject);
begin
  if self.FormBar=nil then begin
    FormBar:=TFormBarManager.Create(self);
    FormBar.Show;
  end else begin
    FormBar.Show;
  end;
end;

procedure TFormMain.RzToolButtonBuyManagerClick(Sender: TObject);
var
  f:TFormBuyManager;
begin
  f:=TFormBuyManager.Create(self);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMain.RzToolButtonUserManagerClick(Sender: TObject);
var
  f:TFormUserManager;
begin
  f:=TFormUserManager.Create(self);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMain.RzToolButtonCheckOutClick(Sender: TObject);
begin
  if self.FormCheckOut=nil then begin
    FormCheckOut:=TFormCheckOut.Create(self);
    FormCheckOut.Show;
  end else begin
    FormCheckOut.Show;
  end;
end;

procedure TFormMain.RzToolButtonEditPassClick(Sender: TObject);
var
  f:TFormEditPass;
begin
  f:=TFormEditPass.Create(self);
  f.setEditUserName(LOGINNAME);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMain.RzToolButtonExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormMain.RzToolButtonKitchenClick(Sender: TObject);
begin
  if self.FormKitchen=nil then begin
    FormKitchen:=TFormKitchenManager.Create(self);
    FormKitchen.Show;
  end else begin
    FormKitchen.Show;
  end;
end;

procedure TFormMain.RzToolButtonMemberManagerClick(Sender: TObject);
var
  f:TFormMemberManager;
begin
  f:=TFormMemberManager.Create(self);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMain.RzToolButtonOrderManagerClick(Sender: TObject);
var
  f:TFormOrderManager;
begin
  f:=TFormOrderManager.Create(self);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMain.RzToolButtonReportManagerClick(Sender: TObject);
var
  f:TFormReportManager;
begin
  f:=TFormReportManager.Create(self);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMain.RzToolButtonTableManagerClick(Sender: TObject);
var
  f:TFormTableManager;
begin
  f:=TFormTableManager.Create(self);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMain.RzToolButtonWareHouseManagerClick(Sender: TObject);
var
  f:TFormStoreManager;
begin
  f:=TFormStoreManager.Create(self);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMain.RzURLLabel1Click(Sender: TObject);
begin
  SendMessage(self.Handle,WM_SYSCOMMAND,100,0);
end;

procedure TFormMain.setButtonEnableWithAccess(acc: Integer);
begin
  self.RzToolButtonEditPass.Visible:=true;
  self.RzToolButtonClose.Visible:=true;
  self.RzToolButtonExit.Visible:=true;
  if acc=0 then begin
    self.RzToolButtonCheckOut.Visible:=false;
    self.RzToolButtonBarTable.Visible:=true;
    self.RzToolButtonKitchen.Visible:=false;

    self.RzSpacer1.Visible:=true;

    self.RzToolButtonMemberManager.Visible:=false;
    self.RzToolButtonBuyManager.Visible:=false;
    self.RzToolButtonWareHouseManager.Visible:=false;
    self.RzToolButtonReportManager.Visible:=false;
    self.RzToolButtonOrderManager.Visible:=false;
    self.RzToolButtonInvoiceManager.Visible:=false;

    self.RzSpacer2.Visible:=false;

    self.RzToolButtonUserManager.Visible:=false;
    self.RzToolButtonActivityManager.Visible:=false;
    self.RzToolButtonTableManager.Visible:=false;
    self.RzToolButtonMenuManager.Visible:=false;
    self.RzToolButtonAssetsManager.Visible:=false;

    self.RzSpacer3.Visible:=false;

    self.RzToolButtonSystemTools.Visible:=false;
  end else if (acc=1) or (acc=2) then begin
    self.RzToolButtonCheckOut.Visible:=false;
    self.RzToolButtonBarTable.Visible:=false;
    self.RzToolButtonKitchen.Visible:=true;

    self.RzSpacer1.Visible:=true;

    self.RzToolButtonMemberManager.Visible:=false;
    self.RzToolButtonBuyManager.Visible:=false;
    self.RzToolButtonWareHouseManager.Visible:=false;
    self.RzToolButtonReportManager.Visible:=false;
    self.RzToolButtonOrderManager.Visible:=false;
    self.RzToolButtonInvoiceManager.Visible:=false;

    self.RzSpacer2.Visible:=false;

    self.RzToolButtonUserManager.Visible:=false;
    self.RzToolButtonActivityManager.Visible:=false;
    self.RzToolButtonTableManager.Visible:=false;
    self.RzToolButtonMenuManager.Visible:=false;
    self.RzToolButtonAssetsManager.Visible:=false;

    self.RzSpacer3.Visible:=false;

    self.RzToolButtonSystemTools.Visible:=false;
  end else if acc=3 then begin
    self.RzToolButtonCheckOut.Visible:=true;
    self.RzToolButtonBarTable.Visible:=false;
    self.RzToolButtonKitchen.Visible:=false;

    self.RzSpacer1.Visible:=true;

    self.RzToolButtonMemberManager.Visible:=true;
    self.RzToolButtonBuyManager.Visible:=false;
    self.RzToolButtonWareHouseManager.Visible:=false;
    self.RzToolButtonReportManager.Visible:=false;
    self.RzToolButtonOrderManager.Visible:=true;
    self.RzToolButtonInvoiceManager.Visible:=true;

    self.RzSpacer2.Visible:=true;

    self.RzToolButtonUserManager.Visible:=false;
    self.RzToolButtonActivityManager.Visible:=false;
    self.RzToolButtonTableManager.Visible:=false;
    self.RzToolButtonMenuManager.Visible:=false;
    self.RzToolButtonAssetsManager.Visible:=false;

    self.RzSpacer3.Visible:=false;

    self.RzToolButtonSystemTools.Visible:=false;
  end else begin
    self.RzToolButtonCheckOut.Visible:=true;
    self.RzToolButtonBarTable.Visible:=true;
    self.RzToolButtonKitchen.Visible:=true;

    self.RzSpacer1.Visible:=true;

    self.RzToolButtonMemberManager.Visible:=true;
    self.RzToolButtonBuyManager.Visible:=true;
    self.RzToolButtonWareHouseManager.Visible:=true;
    self.RzToolButtonReportManager.Visible:=true;
    self.RzToolButtonOrderManager.Visible:=true;
    self.RzToolButtonInvoiceManager.Visible:=true;

    self.RzSpacer2.Visible:=true;

    self.RzToolButtonUserManager.Visible:=true;
    self.RzToolButtonActivityManager.Visible:=true;
    self.RzToolButtonTableManager.Visible:=true;
    self.RzToolButtonMenuManager.Visible:=true;
    self.RzToolButtonAssetsManager.Visible:=true;

    self.RzSpacer3.Visible:=true;

    self.RzToolButtonSystemTools.Visible:=true;
  end;


end;

procedure TFormMain.WndProc(var Message: TMessage);
var
  f:TFormAbout;
begin
  if message.Msg=WM_SYSCOMMAND then begin
    If message.WParam = 100 Then begin
      f:=TFormAbout.Create(self);
      f.ShowModal;
      f.Destroy;
    end;
  end;

  inherited WndProc(message);
end;

end.
