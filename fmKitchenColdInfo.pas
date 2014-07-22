unit fmKitchenColdInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mysql, ExtCtrls, ImgList, DateUtils, ComCtrls, RzListVw;

type
  TFormKitchenColdInfo = class(TForm)
    RzListView: TRzListView;
    Timer1: TTimer;
    ImageList1: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzListViewAdvancedCustomDrawItem(Sender: TCustomListView; Item:
        TListItem; State: TCustomDrawState; Stage: TCustomDrawStage; var
        DefaultDraw: Boolean);
    procedure Timer1Timer(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    hastenTables:string;
    procedure checkHastenInfo;
    procedure loadBarItemsInfo;
    { Private declarations }
  public
    procedure CreateParams(var Params: TCreateParams); override;
    { Public declarations }
  end;

var
  FormKitchenColdInfo: TFormKitchenColdInfo;

implementation

uses myfunction, dbfunction, mfmBarManager;

{$R *.dfm}

procedure TFormKitchenColdInfo.checkHastenInfo;
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

procedure TFormKitchenColdInfo.FormDestroy(Sender: TObject);
var
  f:TFormBarManager;
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);

  f:= TFormBarManager(self.Owner);
  if f<>nil then
    f.fmKitchenCold:=nil;
end;

procedure TFormKitchenColdInfo.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  self.loadBarItemsInfo;
end;

procedure TFormKitchenColdInfo.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or {WS_EX_TOOLWINDOW;//}  WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

procedure TFormKitchenColdInfo.FormClose(Sender: TObject; var Action:
    TCloseAction);
begin
  self.Timer1.Enabled:=false;
  self.Destroy;
end;

procedure TFormKitchenColdInfo.loadBarItemsInfo;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  item:TListItem;
  dfs: TFormatSettings;
  d:TDateTime;
  title:string;
  t:integer;
  td:TTableItemData;
begin
  RzListView.Items.BeginUpdate;
  self.RzListView.Clear;
  RzListView.SmallImages:=ImageList1;
  ImageList1.Height:=58;
  ImageList1.Width:=0;

  sql := 'select a.id,a.menuidx,a.tablename,b.itemname,a.nums,b.itemunit,a.usertips,a.creationtime from consumption a left join menus b on b.menuidx=a.menuidx where b.makefrom=2 and a.payidx=0 and a.statusflag=0 order by a.creationtime';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        dfs.ShortDateFormat := 'yyyy-MM-dd';
        dfs.DateSeparator := '-';
        dfs.ShortTimeFormat := 'hh:mm:ss';
        dfs.TimeSeparator := ':';
        d:=strtodatetime(getUTF8String(MYSQL_ROW^[7]),dfs);
        t:=trunc((DateTimeToUnix(Now)-DateTimeToUnix(d))/60);

        {if length(inttostr(HourOf(d)))=1 then
          t:='0'+inttostr(HourOf(d))
        else
          t:=inttostr(HourOf(d));
        t:=t+':';
        if length(inttostr(MinuteOf(d)))=1 then
          t:=t+'0'+inttostr(MinuteOf(d))
        else
          t:=t+inttostr(MinuteOf(d)); }
        item:=self.RzListView.Items.Add;
        title:=getUTF8String(MYSQL_ROW^[2])+':';
        title:=title+getUTF8String(MYSQL_ROW^[4])+getUTF8String(MYSQL_ROW^[5])+':';
        title:=title+getUTF8String(MYSQL_ROW^[3]);

        if length(getUTF8String(MYSQL_ROW^[6]))>0 then
          title:=title+'_'+getUTF8String(MYSQL_ROW^[6]);
        title:=title+'('+inttostr(t)+'·ÖÖÓ)';
        item.Caption:=title;

        td:=TTableItemData.Create;
        td.tableIdx := strtoint(getUTF8String(MYSQL_ROW^[0]));
        td.tableName:=getUTF8String(MYSQL_ROW^[2]);
        item.Data:=td;
        {item:=self.RzListView.Items.Add;
        item.Caption:=' '+getUTF8String(MYSQL_ROW^[1]);
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[2]));
        item.SubItems.Add(t);
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[4])+getUTF8String(MYSQL_ROW^[5]));
        title:=getUTF8String(MYSQL_ROW^[3]);
        if length(getUTF8String(MYSQL_ROW^[6]))>0 then
          title:=title+'£¨'+getUTF8String(MYSQL_ROW^[6])+'£©';
        item.SubItems.Add(title);}
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
end;

procedure TFormKitchenColdInfo.RzListViewAdvancedCustomDrawItem(Sender:
    TCustomListView; Item: TListItem; State: TCustomDrawState; Stage:
    TCustomDrawStage; var DefaultDraw: Boolean);
var
  ls:TStringList;
  I: Integer;
  td:TTableItemData;
begin
  Sender.Canvas.Font.Color:=clBlack;
  Sender.Canvas.Font.Style:=[];
  Sender.Canvas.Font.Size:=28;
  td:=item.Data;
  ls:=TStringList.Create;
  ls.Delimiter:=',';
  ls.DelimitedText:=hastenTables;
  for I := 0 to ls.Count - 1 do begin
    if ls[i]=td.tableName then begin
      Sender.Canvas.Font.Color:=clRed;
      Sender.Canvas.Font.Style:=[fsBold];
      Sender.Canvas.Font.Size:=28;
      break;
    end;
  end;
  ls.Free;
end;

procedure TFormKitchenColdInfo.Timer1Timer(Sender: TObject);
begin
  checkHastenInfo;
  loadBarItemsInfo;
end;

end.
