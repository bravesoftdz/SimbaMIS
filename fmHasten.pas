unit fmHasten;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, RzLabel, RzPanel;

type
  TFormHasten = class(TForm)
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    Timer1: TTimer;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RzLabel1Click(Sender: TObject);
    procedure RzPanel1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHasten: TFormHasten;

implementation

{$R *.dfm}

procedure TFormHasten.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  if Key=VK_RETURN then begin
    self.Close;
  end;
  if Key=VK_ESCAPE then begin
    self.Close;
  end;
end;

procedure TFormHasten.RzLabel1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TFormHasten.RzPanel1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TFormHasten.Timer1Timer(Sender: TObject);
begin
  self.Close;
end;

end.
