unit fmGetYear;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzPanel, StdCtrls, RzCmboBx, ExtCtrls, pngimage, DateUtils;

type
  TFormGetYear = class(TForm)
    Image1: TImage;
    RzGroupBox1: TRzGroupBox;
    RzComboBoxYearList: TRzComboBox;
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
  FormGetYear: TFormGetYear;

implementation

{$R *.dfm}

procedure TFormGetYear.FormCreate(Sender: TObject);
var
  I,J:integer;
begin
  J:=2013;
  for I := 0 to 19 do begin
    self.RzComboBoxYearList.AddItemValue(inttostr(J),inttostr(J));
    inc(J);
  end;
  self.RzComboBoxYearList.Value:=inttostr(yearOf(now()));
end;

procedure TFormGetYear.RzButtonOkClick(Sender: TObject);
begin
  self.Close;
end;

end.
