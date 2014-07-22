unit fmNetTicketMaker;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzPanel, StdCtrls, Mask, RzEdit, RzRadGrp, RzLabel,
  ExtCtrls, pngimage, mysql, DateUtils, Clipbrd;

type
  TFormNetTicketMaker = class(TForm)
    Image1: TImage;
    RzGroupBox2: TRzGroupBox;
    RzLabel4: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzRadioGroupTicketType: TRzRadioGroup;
    RzRadioGroupTicketDay: TRzRadioGroup;
    RzNumericEditTicketNums: TRzNumericEdit;
    RzLabel3: TRzLabel;
    RzEditTicketMemo: TRzEdit;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    noList: TStringList;
    allNoString: string;
    procedure makeTicketNo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNetTicketMaker: TFormNetTicketMaker;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

procedure TFormNetTicketMaker.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormNetTicketMaker.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  self.noList:=TStringList.Create;
end;

procedure TFormNetTicketMaker.makeTicketNo;
var
  i: Integer;
  no: string;
begin
  allNoString:='';
  for i := 0 to self.RzNumericEditTicketNums.IntValue - 1 do begin
    no:='N'+inttostr(DateTimeToUnix(Now))+inttostr(i);
    self.noList.Add(no);
    if i=0 then
      allNoString:=no
    else
      allNoString:=allNoString+','+no;
  end;
  Clipboard.SetTextBuf(PWideChar(allNoString));
end;

procedure TFormNetTicketMaker.RzButtonCancelClick(Sender: TObject);
begin
  self.noList.Free;
  self.Close;
end;

procedure TFormNetTicketMaker.RzButtonOkClick(Sender: TObject);
var
  sql:string;
  sum,days,i:integer;
  dstart,dend:string;
begin
  if self.RzNumericEditTicketNums.IntValue=0 then begin
    MessageBox(self.Handle,'请先输入生成数量再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzNumericEditTicketNums.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditTicketMemo.Text))=0 then begin
    MessageBox(self.Handle,'请先输入生成用途再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditTicketMemo.SetFocus;
    exit;
  end;

  makeTicketNo;
  sum:=strtoint(RzRadioGroupTicketType.Items[RzRadioGroupTicketType.ItemIndex]);
  days:=strtoint(RzRadioGroupTicketDay.Items[RzRadioGroupTicketDay.ItemIndex]);
  dstart:=datetostr(Date());
  dend:= datetostr(Date()+days);
  for i := 0 to self.noList.Count - 1 do begin
    sql := Format('INSERT INTO nettickets SET ticketno="%s",ticketstatus=0,ticketsum=%d,ticketstarttime="%s",ticketendtime="%s",ticketmaker="%s",ticketmemo="%s"',
      [
        self.noList[i],
        sum,
        dstart,
        dend,
        LOGINNAME,
        trim(self.RzEditTicketMemo.Text)
      ]);
    execMySql(sql,LibHandle);
  end;
  allNoString:='下列生成的电子消费券序号已经生效，并且置于剪贴板上，你可以直接粘贴到合适的地方进行使用。'+#13#10+allNoString;
  MessageBox(self.Handle,PWideChar(allNoString),'提示',MB_OK or MB_ICONINFORMATION);
  self.Close;
end;

end.
