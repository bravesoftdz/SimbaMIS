unit mfmCheckout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, RzListVw, RzSplit, ExtCtrls, RzPanel, mysql,
  Menus, RzCommon, StdCtrls, RzLstBox, RzLabel, frxClass, frxPreview, frxDesgn,
  RzButton, Buttons, Printers, frxChart;

type
  TFormCheckOut = class(TForm)
    RzPanel1: TRzPanel;
    RzSplitter1: TRzSplitter;
    RzPanel3: TRzPanel;
    RzListViewTableStatus: TRzListView;
    ImageListTableStatus: TImageList;
    TimerLoadTableStatus: TTimer;
    RzPanel4: TRzPanel;
    frxReport: TfrxReport;
    frxDesigner: TfrxDesigner;
    RzPanel2: TRzPanel;
    frxUserDataSetOfPayType: TfrxUserDataSet;
    frxUserDataSetOfMenuType: TfrxUserDataSet;
    frxPreview: TfrxPreview;
    RzPanel5: TRzPanel;
    RzToolButton1: TRzToolButton;
    RzToolButtonDesignReport: TRzToolButton;
    frxUserDataSetCashCount: TfrxUserDataSet;
    frxUserDataSetConsList: TfrxUserDataSet;
    frxReportPrintConsList: TfrxReport;
    RzPanel6: TRzPanel;
    RzLabelTableStatus: TRzLabel;
    RzLabelPrintStatus: TRzLabel;
    frxChartObject1: TfrxChartObject;
    PopupMenuDesign: TPopupMenu;
    popMenuDesignTrade: TMenuItem;
    N1: TMenuItem;
    popMenuDesignAutoDetail: TMenuItem;
    popMenuDesignSubItem: TMenuItem;
    popMenuDesignPasser: TMenuItem;
    popMenuHasten: TMenuItem;
    frxUserDataSetSubItems: TfrxUserDataSet;
    RzButton1: TRzButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frxReportDblClickObject(Sender: TfrxView; Button: TMouseButton;
        Shift: TShiftState; var Modified: Boolean);
    procedure frxReportPrintConsListGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetCashCountGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetConsListGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetOfMenuTypeGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetOfPayTypeGetValue(const VarName: string; var Value:
        Variant);
    procedure frxUserDataSetSubItemsGetValue(const VarName: string; var Value:
        Variant);
    procedure popMenuDesignAutoDetailClick(Sender: TObject);
    procedure popMenuDesignPasserClick(Sender: TObject);
    procedure popMenuDesignSubItemClick(Sender: TObject);
    procedure popMenuDesignTradeClick(Sender: TObject);
    procedure popMenuHastenClick(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure RzListViewTableStatusDblClick(Sender: TObject);
    procedure RzToolbarButton1Click(Sender: TObject);
    procedure TimerLoadTableStatusTimer(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;

    mySQL_Res_Pay: PMYSQL_RES;
    mySQL_Res_Menu: PMYSQL_RES;

    mySQL_Res_NewCommit: PMYSQL_RES;
    mySQL_Res_NewMenuItem: PMYSQL_RES;
    mySQL_Res_SubItem: PMYSQL_RES;

    ObjListPayType: TList;
    PayTypeList: TStringList;
    SumPayType: Integer;

    ObjListMenuType: TList;
    MenuTypeList: TStringList;
    SumMenuType: Integer;

    printingtablename:string;

    procedure checkHastenInfo;
    function getCashPayCount: Integer;
    function getCashStoreCount: Variant;
    function getListViewTableStatusItem(tname: string): TListItem;
    function getPayTypeRowItem(ptype: Integer): PMYSQL_ROW;
    function getMenuTypeRowItem(ptype: Integer): PMYSQL_ROW;
    procedure loadReportPayTypeData;
    procedure loadReportMenuTypeData;
    procedure loadTableItems;
    procedure loadTableStatus;
    function getPrintCountString: string;
    procedure printConsListOfTable(tablename: string);
    procedure printNewCommitList(tablename: string);
    procedure printNewCommitMenuItems;
    procedure printNewCommitMenuSubItems(tablename: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCheckOut: TFormCheckOut;

implementation

uses myfunction, dbfunction, fmMain, fmOrderItem, fmOrderInfo, fmTableDetail;

{$R *.dfm}

procedure TFormCheckOut.checkHastenInfo;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  sql := 'select id,tablename,creationtime from hasten where creationtime>date_add(timestamp(now()),INTERVAL -10 SECOND) order by id';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        loadReportDesignFile(self.frxReportPrintConsList,'hastenitem.fr3');

        frxReportPrintConsList.Variables['hastenTableName']:=''''+getUTF8String(MYSQL_ROW^[1])+'''';

        if frxReportPrintConsList.PrepareReport(true) then begin
          //frxReportPrintConsList.ShowPreparedReport;
          frxReportPrintConsList.PrintOptions.ShowDialog:=false;
          frxReportPrintConsList.PrintOptions.Printer:=getPrinter('0');
          frxReportPrintConsList.Print;
          frxReportPrintConsList.PrintOptions.Printer:=getPrinter('1');
          frxReportPrintConsList.Print;
          frxReportPrintConsList.PrintOptions.Printer:=getPrinter('2');
          frxReportPrintConsList.Print;
        end;
      end;
    until MYSQL_ROW=nil;
  end;
end;

procedure TFormCheckOut.FormActivate(Sender: TObject);
begin
  self.WindowState:=wsMaximized;
end;

procedure TFormCheckOut.FormCreate(Sender: TObject);
begin
  PayTypeList:=TStringList.create();
  getPayTypeSectionList('PAYTYPE',self.PayTypeList);
  MenuTypeList:=TStringList.Create;
  getSectionList('MENUTYPE',self.MenuTypeList);

  if ACCESS>=8 then
    self.RzToolButtonDesignReport.Visible:=true
  else
    self.RzToolButtonDesignReport.Visible:=false;


  connectMySql(LibHandle);
  loadTableItems;
  loadTableStatus;
  RzToolbarButton1Click(self);
end;

procedure TFormCheckOut.FormDestroy(Sender: TObject);
begin
  self.PayTypeList.Free;
  self.MenuTypeList.Free;
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if mySQL_Res_Pay<>nil then
    mysql_free_result(mySQL_Res_Pay);
  if mySQL_Res_Menu<>nil then
    mysql_free_result(mySQL_Res_Menu);
  if mySQL_Res_NewCommit<>nil then
    mysql_free_result(mySQL_Res_NewCommit);
  if mySQL_Res_NewMenuItem<>nil then
    mysql_free_result(mySQL_Res_NewMenuItem);
  if mySQL_Res_SubItem<>nil then
    mysql_free_result(mySQL_Res_SubItem);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);

  FormMain.FormCheckOut:=nil;
end;

procedure TFormCheckOut.frxReportDblClickObject(Sender: TfrxView; Button:
    TMouseButton; Shift: TShiftState; var Modified: Boolean);
begin
  //if length(TfrxMemoView(Sender).TagStr)>0 then
  //  showmessage(TfrxMemoView(Sender).TagStr);
end;

procedure TFormCheckOut.frxReportPrintConsListGetValue(const VarName: string;
    var Value: Variant);
begin
  if CompareText(VarName,'tableName') = 0 then begin
    Value := self.printingtablename;
  end else if CompareText(VarName,'printCount') = 0 then begin
    Value := getPrintCountString;
  end else if CompareText(VarName,'misTitle') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','misTitle','辛巴西餐咖啡厅');
  end else if CompareText(VarName,'misTel') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','mistel','15038003911');
  end else if CompareText(VarName,'misWeibo') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','misweibo','http://weibo.com/simbacafe');
  end else if CompareText(VarName,'misWeixin') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','misweixin','simbacafe');
  end else if CompareText(VarName,'misWeb') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','misweb','http://www.simbacafe.com');
  end;
end;

function TFormCheckOut.getPrintCountString: string;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  n:integer;
begin
  n:=0;
  sql := Format('select printtotal from tables where tablename="%s"',[self.printingtablename]);
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

procedure TFormCheckOut.frxUserDataSetCashCountGetValue(const VarName: string;
    var Value: Variant);
begin
  if frxUserDataSetCashCount.RecNo=0 then begin
    if VarName='type' then
      Value:='现金结账';
    if VarName='count' then
      Value:=getCashPayCount;
  end else begin
    if VarName='type' then
      Value:='现金储值';
    if VarName='count' then
      Value:=getCashStoreCount;
  end;
end;

procedure TFormCheckOut.frxUserDataSetConsListGetValue(const VarName: string;
    var Value: Variant);
var
  MYSQL_ROW,row: PMYSQL_ROW;
  idx:integer;
  sql,subtext:string;
begin
  {'select a.tablename,c.itemname,a.nums,a.price,a.usertips,a.creationtime,b.printtime,a.id from consumption a '}
  mysql_data_seek(mySQL_Res_NewMenuItem,self.frxUserDataSetConsList.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res_NewMenuItem);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'itemName') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[1]);
      if length(getUTF8String(MYSQL_ROW^[4]))>0 then begin
        Value := Value+'('+getUTF8String(MYSQL_ROW^[4])+')';
      end;
    end else if CompareText(VarName,'nums') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[2]));
    end else if CompareText(VarName,'price') = 0 then begin
      Value := strtoint(getUTF8String(MYSQL_ROW^[3]));
    end;
    //ready subitems data
    idx:=strtoint(getUTF8String(MYSQL_ROW^[7]));
    sql := 'select menuidx,subitemidx,freeitemidx from consumption where id='+inttostr(idx);

    self.frxUserDataSetSubItems.RangeEnd := reCount;
    self.frxUserDataSetSubItems.RangeEndCount := 0;
    subtext:='';
    queryMySql(sql,LibHandle, mySQL_Res_SubItem);
    if mysql_num_rows(mySQL_Res_SubItem)>0 then begin
      row:=mysql_fetch_row(mySQL_Res_SubItem);
      if row<>nil then begin
        if getUTF8String(row^[0])<>getUTF8String(row^[1]) then begin
          if getUTF8String(row^[2])='0' then begin
            subtext:= getUTF8String(row^[1]);
          end else begin
            subtext:=getUTF8String(row^[1])+','+getUTF8String(row^[2]);
          end;
        end else begin
          if getUTF8String(row^[2])<>'0' then begin
            subtext:=getUTF8String(row^[2]);
          end;
        end;

        if subtext<>'' then begin
          sql:='select itemname from menus where menuidx in('+subtext+')';
          queryMySql(sql,LibHandle, mySQL_Res_SubItem);
          if mysql_num_rows(mySQL_Res_SubItem)>0 then begin
            self.frxUserDataSetSubItems.RangeEnd := reCount;
            self.frxUserDataSetSubItems.RangeEndCount := mysql_num_rows(mySQL_Res_SubItem);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFormCheckOut.frxUserDataSetOfMenuTypeGetValue(const VarName: string;
    var Value: Variant);
var
  idx,count:integer;
  MYSQL_ROW: PMYSQL_ROW;
begin
  idx:=strtoint(self.MenuTypeList[frxUserDataSetOfMenuType.RecNo]);
  MYSQL_ROW:=getMenuTypeRowItem(idx);
  if (VarName='menutype') then begin
    Value:=GetStringFromINI('MENUTYPE',inttostr(idx),'酒水');
  end;
  if VarName='part' then begin
    if MYSQL_ROW<>nil then begin
      count:=strtoint(getUTF8String(MYSQL_ROW^[0]));
      Value:=count/SumMenuType;
    end else begin
      Value:=0;
    end;
  end;
  if (VarName='typetotal') then begin
    if MYSQL_ROW<>nil then begin
      count:=strtoint(getUTF8String(MYSQL_ROW^[0]));
      Value:=count;
    end else begin
      Value:=0;
    end;
  end;
end;

procedure TFormCheckOut.frxUserDataSetOfPayTypeGetValue(const VarName: string;
    var Value: Variant);
var
  idx,count:integer;
  MYSQL_ROW: PMYSQL_ROW;
begin
  idx:=strtoint(self.PayTypeList[frxUserDataSetOfPayType.RecNo]);
  MYSQL_ROW:=getPayTypeRowItem(idx);
  if (VarName='paytype') then begin
    Value:=GetStringFromINI('PAYTYPE',inttostr(idx),'现金');
  end;
  if VarName='part' then begin
    if MYSQL_ROW<>nil then begin
      count:=strtoint(getUTF8String(MYSQL_ROW^[0]));
      Value:=count/SumPayType;
    end else begin
      Value:=0;
    end;
  end;
  if (VarName='typetotal') then begin
    if MYSQL_ROW<>nil then begin
      count:=strtoint(getUTF8String(MYSQL_ROW^[0]));
      Value:=count;
    end else begin
      Value:=0;
    end;
  end;
end;

procedure TFormCheckOut.frxUserDataSetSubItemsGetValue(const VarName: string;
    var Value: Variant);
var
  MYSQL_ROW: PMYSQL_ROW;
begin
  {select menuidx,subitemidx,freeitemidx from consumption where id=}
  mysql_data_seek(mySQL_Res_SubItem,self.frxUserDataSetSubItems.RecNo);
  MYSQL_ROW := mysql_fetch_row(mySQL_Res_SubItem);
  if MYSQL_ROW<>nil then begin
    if CompareText(VarName,'itemName') = 0 then begin
      Value := getUTF8String(MYSQL_ROW^[0]);
    end;
  end;
end;

function TFormCheckOut.getCashPayCount: Integer;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  Result:=0;

  sql := 'select sum(paysum) from payitems ';
  sql := sql + 'where ';
  sql := sql + 'case when (now()<date_add(timestamp(date(now())),INTERVAL 6 HOUR)) then ';
  sql := sql + 'creationtime>date_add(timestamp(date(now())),INTERVAL -18 HOUR) ';
  sql := sql + 'ELSE ';
  sql := sql + 'creationtime>date_add(timestamp(date(now())),INTERVAL 6 HOUR) ';
  sql := sql + 'END ';
  sql := sql + 'and paytype=0';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      if length(getUTF8String(MYSQL_ROW^[0]))>0 then begin
        Result:=strtoint(getUTF8String(MYSQL_ROW^[0]));
      end else begin
        Result:=0;
      end;
    end;
  end;
end;

function TFormCheckOut.getCashStoreCount: Variant;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  Result:=0;

  sql := 'select sum(paysum) from memberdetail ';
  sql := sql + 'where ';
  sql := sql + 'case when (now()<date_add(timestamp(date(now())),INTERVAL 6 HOUR)) then ';
  sql := sql + 'creationtime>date_add(timestamp(date(now())),INTERVAL -18 HOUR) ';
  sql := sql + 'ELSE ';
  sql := sql + 'creationtime>date_add(timestamp(date(now())),INTERVAL 6 HOUR) ';
  sql := sql + 'END ';
  sql := sql + 'and payidx=0 and paytype=0';

  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      if length(getUTF8String(MYSQL_ROW^[0]))>0 then begin
        Result:=strtoint(getUTF8String(MYSQL_ROW^[0]));
      end else begin
        Result:=0;
      end;
    end;
  end;
end;

function TFormCheckOut.getListViewTableStatusItem(tname: string): TListItem;
var
  item:TListItem;
  i:integer;
begin
  Result := nil;
  for i := 0 to self.RzListViewTableStatus.Items.Count - 1 do begin
    item:=self.RzListViewTableStatus.Items.Item[i];
    if item.Caption=tname then begin
      Result:=item;
      exit;
    end;
  end;
end;

function TFormCheckOut.getPayTypeRowItem(ptype: Integer): PMYSQL_ROW;
var
  I: Integer;
  row: PMYSQL_ROW;
begin
  Result:=nil;
  for I := 0 to self.ObjListPayType.Count - 1 do begin
    row:=self.ObjListPayType.Items[I];
    if strtoint(getUTF8String(row^[1]))=ptype then begin
      Result:=row;
      break;
    end;
  end;
end;

function TFormCheckOut.getMenuTypeRowItem(ptype: Integer): PMYSQL_ROW;
var
  I: Integer;
  row: PMYSQL_ROW;
begin
  Result:=nil;
  for I := 0 to self.ObjListMenuType.Count - 1 do begin
    row:=self.ObjListMenuType.Items[I];
    if strtoint(getUTF8String(row^[1]))=ptype then begin
      Result:=row;
      break;
    end;
  end;
end;

procedure TFormCheckOut.loadReportPayTypeData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  if self.ObjListPayType<>nil then begin
    self.ObjListPayType.Clear;
    self.ObjListPayType.Free;
    self.ObjListPayType:=nil;
  end;
  SumPayType:=0;

  self.ObjListPayType:=TList.Create;
  sql := 'select sum(paysum),paytype from payitems ';
  sql := sql + 'where ';
  sql := sql + 'case when (now()<date_add(timestamp(date(now())),INTERVAL 6 HOUR)) then ';
  sql := sql + 'creationtime>date_add(timestamp(date(now())),INTERVAL -18 HOUR) ';
  sql := sql + 'ELSE ';
  sql := sql + 'creationtime>date_add(timestamp(date(now())),INTERVAL 6 HOUR) ';
  sql := sql + 'END ';
  sql := sql + 'and paytype>=0 group by paytype order by paytype';

  queryMySql(sql,LibHandle, mySQL_Res_Pay);
  if mysql_num_rows(mySQL_Res_Pay)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res_Pay);
      if MYSQL_ROW<>nil then begin
        self.ObjListPayType.Add(MYSQL_ROW);
        SumPayType:=SumPayType+strtoint(getUTF8String(MYSQL_ROW^[0]));
      end;
    until MYSQL_ROW=nil;
  end;
  self.frxUserDataSetOfPayType.RangeEnd := reCount;
  self.frxUserDataSetOfPayType.RangeEndCount := self.PayTypeList.Count;
end;

procedure TFormCheckOut.loadReportMenuTypeData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  if self.ObjListMenuType<>nil then begin
    self.ObjListMenuType.Clear;
    self.ObjListMenuType.Free;
    self.ObjListMenuType:=nil;
  end;
  self.SumMenuType:=0;

  self.ObjListMenuType:=TList.Create;
  sql := 'select sum(a.price*a.nums),b.mainidx from consumption a ';
  sql := sql + 'left join menus b on a.menuidx=b.menuidx ';
  sql := sql + 'left join payitems c on a.payidx=c.id ';
  sql := sql + 'where ';
  sql := sql + 'case when (now()<date_add(timestamp(date(now())),INTERVAL 6 HOUR)) then ';
  sql := sql + 'a.creationtime>date_add(timestamp(date(now())),INTERVAL -18 HOUR) ';
  sql := sql + 'ELSE ';
  sql := sql + 'a.creationtime>date_add(timestamp(date(now())),INTERVAL 6 HOUR) ';
  sql := sql + 'END ';
  sql := sql + 'and a.payidx>0 and c.paytype>=0 group by b.mainidx order by b.mainidx';

  queryMySql(sql,LibHandle, mySQL_Res_Menu);
  if mysql_num_rows(mySQL_Res_Menu)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res_Menu);
      if MYSQL_ROW<>nil then begin
        self.ObjListMenuType.Add(MYSQL_ROW);
        SumMenuType:=SumMenuType+strtoint(getUTF8String(MYSQL_ROW^[0]));
      end;
    until MYSQL_ROW=nil;
  end;
  self.frxUserDataSetOfMenuType.RangeEnd := reCount;
  self.frxUserDataSetOfMenuType.RangeEndCount := self.MenuTypeList.Count;
end;

procedure TFormCheckOut.loadTableItems;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  tg: TListGroup;
  item: TListItem;
begin
  self.RzListViewTableStatus.Groups.Clear;
  self.RzListViewTableStatus.Items.Clear;
  //load group
  sql := 'select tabletype from tables group by tabletype';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        tg:=self.RzListViewTableStatus.Groups.Add;
        tg.GroupID:=strtoint(getUTF8String(MYSQL_ROW^[0]));
        tg.Header:= getTableGroupTitle(strtoint(getUTF8String(MYSQL_ROW^[0])))+'实时状态';
      end;
    until MYSQL_ROW=nil;
  end;
  //load user
  sql := 'select tablename,tabletype from tables';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        item:=self.RzListViewTableStatus.Items.Add;
        item.ImageIndex:=0;
        item.OverlayIndex:=0;
        item.GroupID:=strtoint(getUTF8String(MYSQL_ROW^[1]));
        item.Caption:=getUTF8String(MYSQL_ROW^[0]);
      end;
    until MYSQL_ROW=nil;
  end;
end;

procedure TFormCheckOut.loadTableStatus;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  item: TListItem;
begin
  //load user
  sql := 'select a.tablename,a.tablestatus,b.ordertime from tables a left join orders b on b.ordertablename=a.tablename and b.ordertime>now() and b.ordertime<(date_add(timestamp(date(now())),INTERVAL 1 DAY)) group by a.tablename order by a.tablename';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        item:=self.getListViewTableStatusItem(getUTF8String(MYSQL_ROW^[0]));
        if item<>nil then begin
          item.ImageIndex:=strtoint(getUTF8String(MYSQL_ROW^[1]));
          item.OverlayIndex:=strtoint(getUTF8String(MYSQL_ROW^[1]));
          if (strtoint(getUTF8String(MYSQL_ROW^[1]))=0) and (length(getUTF8String(MYSQL_ROW^[2]))>0) then begin
             item.ImageIndex:=2;                 //预订
             item.OverlayIndex:=2;
          end;
        end;
      end;
    until MYSQL_ROW=nil;
  end;
  self.RzLabelTableStatus.Caption:='台位状态装载完毕，装载时间:'+datetimetostr(now());
end;

procedure TFormCheckOut.popMenuDesignAutoDetailClick(Sender: TObject);
begin
  loadReportDesignFile(self.frxReportPrintConsList,'tableconslistauto.fr3');
  self.frxReportPrintConsList.DesignReport();
end;

procedure TFormCheckOut.popMenuDesignPasserClick(Sender: TObject);
begin
  loadReportDesignFile(self.frxReportPrintConsList,'tableconsnewitem.fr3');
  self.frxReportPrintConsList.DesignReport();
end;

procedure TFormCheckOut.popMenuDesignSubItemClick(Sender: TObject);
begin
  loadReportDesignFile(self.frxReportPrintConsList,'makefrom.fr3');
  self.frxReportPrintConsList.DesignReport();
end;

procedure TFormCheckOut.popMenuDesignTradeClick(Sender: TObject);
begin
  loadReportDesignFile(self.frxReport,'formcheckout.fr3');
  self.frxReport.DesignReport();
end;

procedure TFormCheckOut.popMenuHastenClick(Sender: TObject);
begin
  loadReportDesignFile(self.frxReportPrintConsList,'hastenitem.fr3');
  self.frxReportPrintConsList.DesignReport();
end;

procedure TFormCheckOut.printConsListOfTable(tablename: string);
var
  sql: string;
  p:TPrinter;
begin
  sql := 'select a.tablename,c.itemname,a.nums,a.price,a.usertips,a.creationtime,b.printtime,a.id from consumption a ';
  sql := sql+'left join tables b on b.tablename=a.tablename ';
  sql := sql+'left join menus c on c.menuidx=a.menuidx ';
  sql := sql+'where a.tablename="'+tablename+'" and a.payidx=0 ';
  sql := sql+'order by a.creationtime';

  queryMySql(sql,LibHandle, mySQL_Res_NewMenuItem);
  if mysql_num_rows(mySQL_Res_NewMenuItem)>0 then begin
    self.printingtablename:=tablename;
    self.frxUserDataSetConsList.RangeEnd := reCount;
    self.frxUserDataSetConsList.RangeEndCount := mysql_num_rows(mySQL_Res_NewMenuItem);

    loadReportDesignFile(self.frxReportPrintConsList,'tableconslistauto.fr3');
    p:=TPrinter.Create;
    if p.Printers.Count>0 then begin
      if self.frxReportPrintConsList.PrepareReport(true) then begin
        //self.frxReportPrintConsList.ShowPreparedReport;
        frxReportPrintConsList.PrintOptions.Printer:=getPrinter('4');
        frxReportPrintConsList.PrintOptions.ShowDialog:=false;
        if self.frxReportPrintConsList.Print then begin
          sql:=Format('update tables set printtotal=printtotal+1,printtime=now() where tablename="%s"',[tablename]);
          execMySql(sql,LibHandle);
          self.RzLabelPrintStatus.Caption:='消费清单自动打印完毕';
        end else begin
          self.RzLabelPrintStatus.Caption:='消费清单自动打印失败';
        end;
      end else begin
        self.RzLabelPrintStatus.Caption:='消费清单初始化失败';
      end;
    end else begin
      self.RzLabelPrintStatus.Caption:='打印机未安装，自动打印失败';
    end;
  end;
end;

procedure TFormCheckOut.printNewCommitList(tablename: string);
var
  sql: string;
begin
  sql := 'select a.tablename,c.itemname,a.nums,a.price,a.usertips,a.creationtime,b.printtime,a.id from consumption a ';
  sql := sql+'left join tables b on b.tablename=a.tablename ';
  sql := sql+'left join menus c on c.menuidx=a.menuidx ';
  sql := sql+'where a.tablename="'+tablename+'" and a.payidx=0 and a.creationtime>b.printtime ';
  sql := sql+'order by a.creationtime';

  queryMySql(sql,LibHandle, mySQL_Res_NewMenuItem);
  if mysql_num_rows(mySQL_Res_NewMenuItem)>0 then begin
    self.printingtablename:=tablename;
    self.frxUserDataSetConsList.RangeEnd := reCount;
    self.frxUserDataSetConsList.RangeEndCount := mysql_num_rows(mySQL_Res_NewMenuItem);

    loadReportDesignFile(self.frxReportPrintConsList,'tableconsnewitem.fr3');
    if self.frxReportPrintConsList.PrepareReport(true) then begin
      //self.frxReportPrintConsList.ShowPreparedReport;
      frxReportPrintConsList.PrintOptions.Printer:=getPrinter('3');
      frxReportPrintConsList.PrintOptions.ShowDialog:=false;
      self.frxReportPrintConsList.Print;
      frxReportPrintConsList.PrintOptions.Printer:=getPrinter('1');
      frxReportPrintConsList.PrintOptions.ShowDialog:=false;
      self.frxReportPrintConsList.Print;
    end;
  end;
end;

procedure TFormCheckOut.printNewCommitMenuItems;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  sql := 'select a.tablename,a.nums,a.price,a.creationtime,b.printtime from consumption a ';
  sql := sql+'left join tables b on b.tablename=a.tablename ';
  sql := sql+'where a.payidx=0 and b.tablestatus=1 and a.creationtime>b.printtime ';
  sql := sql+'GROUP by a.tablename order by a.creationtime';

  queryMySql(sql,LibHandle, mySQL_Res_NewCommit);
  if mysql_num_rows(mySQL_Res_NewCommit)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res_NewCommit);
      if MYSQL_ROW<>nil then begin
        self.printNewCommitMenuSubItems(getUTF8String(MYSQL_ROW^[0]));
        self.printNewCommitList(getUTF8String(MYSQL_ROW^[0]));
        self.printConsListOfTable(getUTF8String(MYSQL_ROW^[0]));
      end;
    until MYSQL_ROW=nil;
  end;
end;

procedure TFormCheckOut.printNewCommitMenuSubItems(tablename: string);
var
  sql,parentname: string;
  MYSQL_ROW: PMYSQL_ROW;
  MYSQL_ROW_SUB: PMYSQL_ROW;
  subidx,freeidx:string;
  list:TStringList;
  i:integer;
begin
  list:=TStringList.Create;
  self.printingtablename:=tablename;

  sql := 'select a.id,a.tablename,c.itemname,a.nums,a.usertips,a.subitemidx,a.freeitemidx,a.creationtime,b.printtime from consumption a ';
  sql := sql+'left join tables b on b.tablename=a.tablename ';
  sql := sql+'left join menus c on c.menuidx=a.menuidx ';
  sql := sql+'where a.tablename="'+tablename+'" and a.payidx=0 and a.creationtime>b.printtime ';
  sql := sql+'order by a.id';

  queryMySql(sql,LibHandle, mySQL_Res_NewMenuItem);
  if mysql_num_rows(mySQL_Res_NewMenuItem)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res_NewMenuItem);
      if MYSQL_ROW<>nil then begin
        subidx:=getUTF8String(MYSQL_ROW^[5]);
        freeidx:=getUTF8String(MYSQL_ROW^[6]);

        list.Delimiter:=',';
        list.DelimitedText:=subidx;

        for i := 0 to list.Count - 1 do begin
          sql:=Format('select concat(itemname,"(点)"),itemunit,makefrom from menus where menuidx=%s',[list[i]]);
          queryMySql(sql,LibHandle, mySQL_Res);
          if mysql_num_rows(mySQL_Res)>0 then begin
            MYSQL_ROW_SUB := mysql_fetch_row(mySQL_Res);
            if MYSQL_ROW_SUB<>nil then begin
              loadReportDesignFile(self.frxReportPrintConsList,'makefrom.fr3');

              frxReportPrintConsList.Variables['mItemid']:=getUTF8String(MYSQL_ROW^[0]);
              frxReportPrintConsList.Variables['mItemName']:=''''+getUTF8String(MYSQL_ROW_SUB^[0])+'''';
              frxReportPrintConsList.Variables['mItemNum']:=''''+getUTF8String(MYSQL_ROW^[3])+getUTF8String(MYSQL_ROW_SUB^[1])+'''';
              parentname:=getUTF8String(MYSQL_ROW^[2]);
              if length(getUTF8String(MYSQL_ROW^[4]))>0 then
                parentname:=parentname+'('+getUTF8String(MYSQL_ROW^[4])+')';
              frxReportPrintConsList.Variables['mParentName']:=''''+parentname+'''';

              if frxReportPrintConsList.PrepareReport(true) then begin
                //frxReportPrintConsList.ShowPreparedReport;
                frxReportPrintConsList.PrintOptions.Printer:=getPrinter(getUTF8String(MYSQL_ROW_SUB^[2]));
                frxReportPrintConsList.PrintOptions.ShowDialog:=false;
                frxReportPrintConsList.Print;
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
              loadReportDesignFile(self.frxReportPrintConsList,'makefrom.fr3');

              frxReportPrintConsList.Variables['mItemid']:=getUTF8String(MYSQL_ROW^[0]);
              frxReportPrintConsList.Variables['mItemName']:=''''+getUTF8String(MYSQL_ROW_SUB^[0])+'''';
              frxReportPrintConsList.Variables['mItemNum']:=''''+getUTF8String(MYSQL_ROW^[3])+getUTF8String(MYSQL_ROW_SUB^[1])+'''';
              parentname:=getUTF8String(MYSQL_ROW^[2]);
              if length(getUTF8String(MYSQL_ROW^[4]))>0 then
                parentname:=parentname+'('+getUTF8String(MYSQL_ROW^[4])+')';
              frxReportPrintConsList.Variables['mParentName']:=''''+parentname+'''';

              if frxReportPrintConsList.PrepareReport(true) then begin
                //frxReportPrintConsList.ShowPreparedReport;
                frxReportPrintConsList.PrintOptions.Printer:=getPrinter(getUTF8String(MYSQL_ROW_SUB^[2]));
                frxReportPrintConsList.PrintOptions.ShowDialog:=false;
                frxReportPrintConsList.Print;
              end;
            end;
          end;
        end;

      end;
    until MYSQL_ROW=nil;
  end;

  list.Free;
end;

procedure TFormCheckOut.RzButton1Click(Sender: TObject);
begin
  printNewCommitList('S8');
end;

procedure TFormCheckOut.RzListViewTableStatusDblClick(Sender: TObject);
var
  item:TListITem;
  f:TFormOrderItem;
  o:TFormOrderInfo;
  d:TFormTableDetail;
begin
  item:=self.RzListViewTableStatus.Selected;
  if(item<>nil)then begin
    if(item.ImageIndex=2)then begin        //order
      f:=TFormOrderItem.Create(self,item.Caption);
      f.ShowModal;
      f.Destroy;
    end else if item.ImageIndex=0 then begin  //null
      o:=TFormOrderInfo.Create(self,item.Caption);
      o.ShowModal;
      o.Destroy;
    end else if item.ImageIndex=1 then begin  //full
      d:=TFormTableDetail.Create(self,item.Caption);
      d.ShowModal;
      d.Destroy;
    end;
  end;
end;

procedure TFormCheckOut.RzToolbarButton1Click(Sender: TObject);
begin
  loadReportDesignFile(self.frxReport,'formcheckout.fr3');
  self.frxReport.Preview:=self.frxPreview;

  self.loadReportPayTypeData;
  self.loadReportMenuTypeData;

  self.frxUserDataSetCashCount.RangeEnd := reCount;
  self.frxUserDataSetCashCount.RangeEndCount := 2;

  if self.frxReport.PrepareReport(true) then
    self.frxReport.ShowPreparedReport;
end;

procedure TFormCheckOut.TimerLoadTableStatusTimer(Sender: TObject);
begin
  //self.TimerLoadTableStatus.Enabled:=false;
  //LOG('TimerLoadTableStatusTimer');
  self.loadTableStatus;
  if ACCESS=3 then begin
    self.printNewCommitMenuItems;
    self.checkHastenInfo;
  end;
end;

end.
