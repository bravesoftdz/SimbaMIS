unit fmGetMonth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzPanel, StdCtrls, RzCmboBx, ExtCtrls, pngimage, DateUtils;

type
  TFormGetMonth = class(TForm)
    Image1: TImage;
    RzGroupBox1: TRzGroupBox;
    RzComboBoxMonthList: TRzComboBox;
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
  FormGetMonth: TFormGetMonth;

implementation

{$R *.dfm}

procedure TFormGetMonth.FormCreate(Sender: TObject);
var
  I,J:integer;
begin
  J:=1;
  for I := 0 to 11 do begin
    self.RzComboBoxMonthList.AddItemValue(inttostr(J),inttostr(J));
    inc(J);
  end;
  self.RzComboBoxMonthList.Value:=inttostr(monthOf(now()));
end;

procedure TFormGetMonth.RzButtonOkClick(Sender: TObject);
begin
  self.Close;
end;

end.
