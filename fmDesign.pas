unit fmDesign;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, frxDesgn, frxClass, ExtCtrls, RzPanel, ComCtrls, RzListVw,
  StdCtrls, FileCtrl, RzFilSys, frxChart;

type
  TFormDesign = class(TForm)
    RzPanel1: TRzPanel;
    frxReport1: TfrxReport;
    frxDesigner1: TfrxDesigner;
    RzButtonDesign: TRzButton;
    RzButtonClose: TRzButton;
    RzFileListBox1: TRzFileListBox;
    frxChartObject1: TfrxChartObject;
    RzButtonUpdate: TRzButton;
    procedure FormCreate(Sender: TObject);
    procedure RzButtonDesignClick(Sender: TObject);
    procedure RzButtonCloseClick(Sender: TObject);
    procedure RzButtonUpdateClick(Sender: TObject);
    procedure RzFileListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDesign: TFormDesign;

implementation

{$R *.dfm}

procedure TFormDesign.FormCreate(Sender: TObject);
begin
  self.RzFileListBox1.Directory:=ExtractFilePath(Application.ExeName);
end;

procedure TFormDesign.RzButtonDesignClick(Sender: TObject);
var
  reportfile:string;
begin
  if length(self.RzFileListBox1.FileName)>0 then begin
    reportfile:=self.RzFileListBox1.FileName;
    self.frxReport1.LoadFromFile(reportfile);
  end;
  self.frxReport1.DesignReport();
  self.RzFileListBox1.Update;
end;

procedure TFormDesign.RzButtonCloseClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormDesign.RzButtonUpdateClick(Sender: TObject);
begin
  self.RzFileListBox1.Update;
end;

procedure TFormDesign.RzFileListBox1DblClick(Sender: TObject);
begin
  self.RzButtonDesignClick(self);
end;

end.
