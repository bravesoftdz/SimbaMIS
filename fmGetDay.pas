unit fmGetDay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzPanel, StdCtrls, RzCmboBx, ExtCtrls, pngimage, DateUtils;

type
  TFormGetDay = class(TForm)
    Image1: TImage;
    RzGroupBox1: TRzGroupBox;
    RzComboBoxDayList: TRzComboBox;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    procedure FormCreate(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGetDay: TFormGetDay;

implementation

{$R *.dfm}

procedure TFormGetDay.FormCreate(Sender: TObject);
var
  I,J:integer;
begin
  J:=1;
  for I := 0 to 30 do begin
    self.RzComboBoxDayList.AddItemValue(inttostr(J),inttostr(J));
    inc(J);
  end;
  self.RzComboBoxDayList.Value:=inttostr(dayOf(now()));
end;

procedure TFormGetDay.RzButtonOkClick(Sender: TObject);
begin
  self.Close;
end;

end.
