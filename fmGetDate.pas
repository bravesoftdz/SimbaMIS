unit fmGetDate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, RzButton, RzPanel, ExtCtrls, pngimage;

type
  TFormGetDate = class(TForm)
    Image1: TImage;
    RzGroupBox1: TRzGroupBox;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzDateTimeEditDate: TRzDateTimeEdit;
    procedure FormCreate(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGetDate: TFormGetDate;

implementation

{$R *.dfm}

procedure TFormGetDate.FormCreate(Sender: TObject);
begin
  self.RzDateTimeEditDate.Date:=Date();
end;

procedure TFormGetDate.RzButtonOkClick(Sender: TObject);
begin
  self.Close;
end;

end.
