object FormDesign: TFormDesign
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Simba Report File Designer'
  ClientHeight = 348
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object RzPanel1: TRzPanel
    Left = 0
    Top = 298
    Width = 575
    Height = 50
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 0
    object RzButtonDesign: TRzButton
      Left = 10
      Top = 14
      Height = 28
      Caption = 'Designer'
      TabOrder = 0
      OnClick = RzButtonDesignClick
    end
    object RzButtonClose: TRzButton
      Left = 480
      Top = 14
      Height = 28
      Cancel = True
      Caption = 'Close'
      TabOrder = 1
      OnClick = RzButtonCloseClick
    end
    object RzButtonUpdate: TRzButton
      Left = 91
      Top = 14
      Height = 28
      Caption = 'Update'
      TabOrder = 2
      OnClick = RzButtonUpdateClick
    end
  end
  object RzFileListBox1: TRzFileListBox
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 555
    Height = 288
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alClient
    ItemHeight = 25
    Mask = '*.fr3'
    TabOrder = 1
    OnDblClick = RzFileListBox1DblClick
    Columns = 2
  end
  object frxReport1: TfrxReport
    Version = '4.7.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #39044#35774
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41431.782013576390000000
    ReportOptions.LastChange = 41431.782013576390000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 312
    Top = 312
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    Left = 344
    Top = 312
  end
  object frxChartObject1: TfrxChartObject
    Left = 376
    Top = 312
  end
end
