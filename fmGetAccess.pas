unit fmGetAccess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzPanel, StdCtrls, RzCmboBx, ExtCtrls, pngimage;

type
  TFormGetAccess = class(TForm)
    Image1: TImage;
    RzGroupBox1: TRzGroupBox;
    RzComboBoxAccessList: TRzComboBox;
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
  FormGetAccess: TFormGetAccess;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

procedure TFormGetAccess.FormCreate(Sender: TObject);
var
  forList:TStringList;
  i: Integer;
  t:string;
begin
  self.RzComboBoxAccessList.AddItemValue('ËùÓÐ','-1');

  forList:=TStringList.Create;
  getSectionList('ACCESSTYPE', forList);
  for i := 0 to forList.Count - 1 do begin
    t:=GetStringFromINI('ACCESSTYPE',forList[i],'Ç°Ìü');
    self.RzComboBoxAccessList.AddItemValue(t,forList[i]);
  end;
  forList.Free;

  self.RzComboBoxAccessList.ItemIndex:=0;
end;

procedure TFormGetAccess.RzButtonOkClick(Sender: TObject);
begin
  self.Close;
end;

end.
