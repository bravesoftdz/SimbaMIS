program reportDesigner;

uses
  Forms,
  fmDesign in 'fmDesign.pas' {FormDesign};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormDesign, FormDesign);
  Application.Run;
end.
