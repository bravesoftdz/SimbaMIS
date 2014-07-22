object FormChangeReportData: TFormChangeReportData
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #25253#34920#25968#25454#20462#25913
  ClientHeight = 136
  ClientWidth = 325
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 17
  object RzLabelTips: TRzLabel
    Left = 32
    Top = 12
    Width = 36
    Height = 17
    Caption = #25552#31034#65306
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 82
    Width = 325
    Height = 54
    Align = alBottom
    BorderOuter = fsFlat
    BorderSides = [sdTop]
    TabOrder = 0
    ExplicitTop = 77
    ExplicitWidth = 349
    DesignSize = (
      325
      54)
    object RzButtonOk: TRzButton
      Left = 56
      Top = 13
      Width = 100
      Height = 33
      Default = True
      ModalResult = 1
      Anchors = [akRight, akBottom]
      Caption = #30830#23450
      TabOrder = 0
    end
    object RzButtonCancel: TRzButton
      Left = 162
      Top = 13
      Width = 100
      Height = 33
      Cancel = True
      ModalResult = 2
      Anchors = [akRight, akBottom]
      Caption = #21462#28040
      TabOrder = 1
    end
  end
  object RzNumericEditValue: TRzNumericEdit
    Left = 32
    Top = 35
    Width = 201
    Height = 25
    TabOrder = 1
    IntegersOnly = False
    DisplayFormat = ',0.00;(,0.00)'
  end
end
