unit fmChangeReportData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ExtCtrls, RzPanel, StdCtrls, Mask, RzEdit, RzLabel;

type
  TFormChangeReportData = class(TForm)
    RzLabelTips: TRzLabel;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    RzNumericEditValue: TRzNumericEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormChangeReportData: TFormChangeReportData;

implementation

{$R *.dfm}

end.
