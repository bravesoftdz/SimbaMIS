object FormTuiCai: TFormTuiCai
  Left = 0
  Top = 0
  ActiveControl = RzSpinEditNums
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #36864#33756#25805#20316
  ClientHeight = 180
  ClientWidth = 389
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  object RzLabel1: TRzLabel
    Left = 40
    Top = 24
    Width = 36
    Height = 17
    Caption = #21488#20301#65306
  end
  object RzLabel2: TRzLabel
    Left = 40
    Top = 55
    Width = 36
    Height = 17
    Caption = #33756#21697#65306
  end
  object RzLabel3: TRzLabel
    Left = 40
    Top = 86
    Width = 120
    Height = 17
    Caption = #35831#36873#25321#35201#36864#25481#30340#25968#37327#65306
  end
  object RzLabelTno: TRzLabel
    Left = 81
    Top = 24
    Width = 4
    Height = 17
  end
  object RzLabelIname: TRzLabel
    Left = 81
    Top = 55
    Width = 4
    Height = 17
  end
  object RzLabelIunit: TRzLabel
    Left = 237
    Top = 86
    Width = 4
    Height = 17
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 131
    Width = 389
    Height = 49
    Align = alBottom
    BorderOuter = fsFlat
    BorderSides = [sdTop]
    TabOrder = 0
    DesignSize = (
      389
      49)
    object RzToolButtonDesignReport: TRzToolButton
      Left = 8
      Top = 13
      Width = 87
      Height = 28
      GradientColorStyle = gcsSystem
      DropDownMenu = PopupMenuDesign
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      ToolStyle = tsDropDown
      VisualStyle = vsGradient
      Caption = #25968#25454#26684#24335
    end
    object RzButtonOk: TRzButton
      Left = 219
      Top = 8
      Width = 78
      Height = 33
      Cancel = True
      Anchors = [akRight, akBottom]
      Caption = #30830#23450
      TabOrder = 0
      OnClick = RzButtonOkClick
    end
    object RzButton1: TRzButton
      Left = 303
      Top = 8
      Width = 78
      Height = 33
      Cancel = True
      Anchors = [akRight, akBottom]
      Caption = #21462#28040
      TabOrder = 1
      OnClick = RzButton1Click
    end
  end
  object RzSpinEditNums: TRzSpinEdit
    Left = 166
    Top = 83
    Width = 59
    Height = 25
    AllowKeyEdit = True
    CheckRange = True
    Max = 100.000000000000000000
    Min = 1.000000000000000000
    Value = 1.000000000000000000
    Alignment = taCenter
    TabOrder = 1
  end
  object PopupMenuDesign: TPopupMenu
    Left = 264
    Top = 8
    object popMenuDesign: TMenuItem
      Caption = #36864#33756#21333#25454#25968#25454#26684#24335
      OnClick = popMenuDesignClick
    end
    object popMenuPreview: TMenuItem
      Caption = #39044#35272#36864#33756#21333#25454
      OnClick = popMenuPreviewClick
    end
  end
  object frxReport: TfrxReport
    Version = '4.7.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #39044#35774
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41514.598718287040000000
    ReportOptions.LastChange = 41514.598718287040000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnGetValue = frxReportGetValue
    Left = 304
    Top = 8
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
    end
  end
  object frxDesigner: TfrxDesigner
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
    Top = 8
  end
end
