unit fmAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzLabel, RzStatus, StdCtrls, pngimage, ExtCtrls;

type
  TFormAbout = class(TForm)
    Image1: TImage;
    RzLabel1: TRzLabel;
    RzLabelVersion: TRzLabel;
    RzVersionInfo1: TRzVersionInfo;
    RzLabel3: TRzLabel;
    RzLabelUserInfo: TRzLabel;
    RzLabelCopy: TRzLabel;
    RzLabel2: TRzLabel;
    RzURLLabel1: TRzURLLabel;
    RzLabel4: TRzLabel;
    RzURLLabel2: TRzURLLabel;
    RzLabel5: TRzLabel;
    RzURLLabel3: TRzURLLabel;
    RzLabel6: TRzLabel;
    RzURLLabel4: TRzURLLabel;
    RzButton1: TRzButton;
    RzLabel7: TRzLabel;
    RzURLLabel5: TRzURLLabel;
    procedure FormCreate(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAbout: TFormAbout;

implementation

uses myfunction, dbfunction, fmMain;

{$R *.dfm}

procedure TFormAbout.FormCreate(Sender: TObject);
begin
  self.RzLabelUserInfo.Caption:= GetStringFromINI('PUBLIC','misTitle','ÐÁ°ÍÎ÷²Í¿§·ÈÌü');
  self.RzVersionInfo1.FilePath:=Application.ExeName;
  self.RzLabelVersion.Caption:='V'+self.RzVersionInfo1.FileVersion;
end;

procedure TFormAbout.RzButton1Click(Sender: TObject);
begin
  self.Close;
end;

end.
