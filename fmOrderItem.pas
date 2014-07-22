unit fmOrderItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ExtCtrls, RzPanel, StdCtrls, RzLabel, pngimage, mysql;

type
  TFormOrderItem = class(TForm)
    Image1: TImage;
    RzLabel1: TRzLabel;
    RzLabelOrdername: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabelOrdertel: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabelOrdertime: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabelOrderusers: TRzLabel;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzLabel3: TRzLabel;
    RzLabelTablename: TRzLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    tablename:string;
    procedure loadInfoItemData;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; tname: string); reintroduce;
        overload;
    { Public declarations }
  end;

var
  FormOrderItem: TFormOrderItem;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

constructor TFormOrderItem.Create(AOwner: TComponent; tname: string);
begin
  inherited Create(AOwner);
  self.tablename:=tname;
end;

procedure TFormOrderItem.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  self.loadInfoItemData;
end;

procedure TFormOrderItem.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormOrderItem.RzButtonOkClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormOrderItem.loadInfoItemData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  sql := Format('SELECT ordername,ordertel,ordertime,orderusers FROM orders WHERE ordertablename="%s" and ordertime>now() and ordertime<(date(now())+1) order by ordertime limit 0,1',[self.tablename]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      self.RzLabelTablename.Caption:=self.tablename;
      self.RzLabelOrdername.Caption:=getUTF8String(MYSQL_ROW^[0]);
      self.RzLabelOrdertel.Caption:=getUTF8String(MYSQL_ROW^[1]);
      self.RzLabelOrdertime.Caption:=getUTF8String(MYSQL_ROW^[2]);
      self.RzLabelOrderusers.Caption:=getUTF8String(MYSQL_ROW^[3])+'»À';
    end;
  end;
end;

end.
