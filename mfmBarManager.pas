unit mfmBarManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, RzListVw, mysql, RzButton, ExtCtrls, RzPanel, ImgList,
  DateUtils, fmKitchenColdInfo;

type
  TFormBarManager = class(TForm)
    ImageList1: TImageList;
    Timer1: TTimer;
    RzPanel2: TRzPanel;
    RzPanel4: TRzPanel;
    RzToolButtonPassOver: TRzToolButton;
    RzToolButtonTuiCai: TRzToolButton;
    RzToolButtonCold: TRzToolButton;
    RzListView: TRzListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RzListViewAdvancedCustomDrawItem(Sender: TCustomListView; Item:
        TListItem; State: TCustomDrawState; Stage: TCustomDrawStage; var
        DefaultDraw: Boolean);
    procedure RzListViewDblClick(Sender: TObject);
    procedure RzToolButtonColdClick(Sender: TObject);
    procedure RzToolButtonPassOverClick(Sender: TObject);
    procedure RzToolButtonTuiCaiClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    hastenTables:string;
    procedure checkHastenInfo;
    procedure loadBarItemsInfo;
    { Private declarations }
  public
    fmKitchenCold: TFormKitchenColdInfo;
    { Public declarations }
  end;

var
  FormBarManager: TFormBarManager;

implementation

uses myfunction, dbfunction, fmMain, fmKitchenInfo, fmHasten;

{$R *.dfm}

procedure TFormBarManager.checkHastenInfo;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  hastenTables:='';
  sql := 'select id,tablename,creationtime from hasten where creationtime>date_add(timestamp(now()),INTERVAL -10 SECOND) order by id';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        if length(hastenTables)>0 then
          hastenTables:=hastenTables+','+getUTF8String(MYSQL_ROW^[1])
        else
          hastenTables:=getUTF8String(MYSQL_ROW^[1]);
      end;
    until MYSQL_ROW=nil;
  end;
end;

procedure TFormBarManager.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  self.loadBarItemsInfo;
end;

procedure TFormBarManager.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);

  FormMain.FormBar:=nil;
end;

procedure TFormBarManager.FormActivate(Sender: TObject);
begin
  self.WindowState:=wsMaximized;
end;

procedure TFormBarManager.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if self.fmKitchenCold<>nil then begin
    fmKitchenCold.Close;
  end;
end;

procedure TFormBarManager.loadBarItemsInfo;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  item:TListItem;
  title:string;
begin
  RzListView.Items.BeginUpdate;
  self.RzListView.Clear;
  RzListView.SmallImages:=ImageList1;
  ImageList1.Height:=26;
  ImageList1.Width:=0;

  sql := 'select a.id,a.tablename,a.nums,b.itemunit,b.itemname,a.usertips,a.creationtime,a.loginname from consumption a left join menus b on b.menuidx=a.menuidx where b.makefrom=0 and a.payidx=0 and a.statusflag=0 order by a.creationtime';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        item:=self.RzListView.Items.Add;
        item.Caption:=getUTF8String(MYSQL_ROW^[0]);
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[1]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[2])+getUTF8String(MYSQL_ROW^[3]));
        title:=getUTF8String(MYSQL_ROW^[4]);
        if length(getUTF8String(MYSQL_ROW^[5]))>0 then
          title:=title+'（'+getUTF8String(MYSQL_ROW^[5])+'）';
        item.SubItems.Add(title);
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[6]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[7]));
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
end;

procedure TFormBarManager.RzListViewAdvancedCustomDrawItem(Sender:
    TCustomListView; Item: TListItem; State: TCustomDrawState; Stage:
    TCustomDrawStage; var DefaultDraw: Boolean);
var
  ls:TStringList;
  I: Integer;
begin
  Sender.Canvas.Font.Color:=clBlack;
  Sender.Canvas.Font.Style:=[];
  Sender.Canvas.Font.Size:=9;
  ls:=TStringList.Create;
  ls.Delimiter:=',';
  ls.DelimitedText:=hastenTables;
  for I := 0 to ls.Count - 1 do begin
    if ls[i]=Item.SubItems[0] then begin
      Sender.Canvas.Font.Color:=clRed;
      Sender.Canvas.Font.Style:=[fsBold];
      Sender.Canvas.Font.Size:=10;
      break;
    end;
  end;
  ls.Free;
end;

procedure TFormBarManager.RzListViewDblClick(Sender: TObject);
begin
  self.RzToolButtonPassOverClick(self);
end;

procedure TFormBarManager.RzToolButtonColdClick(Sender: TObject);
begin
  if self.fmKitchenCold=nil then begin
    fmKitchenCold:=TFormKitchenColdInfo.Create(self);
    fmKitchenCold.Show;
  end else begin
    fmKitchenCold.Show;
  end;
end;

procedure TFormBarManager.RzToolButtonPassOverClick(Sender: TObject);
var
  res:integer;
  sql:string;
  item:TListItem;
begin
  if (self.RzListView.ItemIndex=-1) then begin
    MessageBox(self.Handle,'请选择已经出品的菜品记录！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  item:=self.RzListView.Selected;
  res := MessageBox(self.Handle, PWideChar(Format('确定已出 %s 的 %s %s',[item.SubItems[0],item.SubItems[1],item.SubItems[2]])), '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    sql := Format('UPDATE consumption SET endtime=now(),passername="%s",statusflag=1 WHERE id=%s',[LOGINNAME,item.Caption]);
    execMySql(sql,LibHandle);
  end;
  Timer1Timer(Self);
end;

procedure TFormBarManager.RzToolButtonTuiCaiClick(Sender: TObject);
var
  res:integer;
  sql:string;
  item:TListItem;
begin
  if (self.RzListView.ItemIndex=-1) then begin
    MessageBox(self.Handle,'请选择你要退掉的菜品记录！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  item:=self.RzListView.Selected;
  res := MessageBox(self.Handle, PWideChar(Format('确定要退掉 %s 的 %s %s',[item.SubItems[0],item.SubItems[1],item.SubItems[2]])), '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    sql := Format('DELETE FROM consumption WHERE id=%s',[item.Caption]);
    execMySql(sql,LibHandle);
  end;
  Timer1Timer(Self);
end;

procedure TFormBarManager.Timer1Timer(Sender: TObject);
begin
  self.checkHastenInfo;
  self.loadBarItemsInfo;
end;

end.
