object FormStorePart: TFormStorePart
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #24211#23384#20986#24211
  ClientHeight = 383
  ClientWidth = 642
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
  object RzLabel2: TRzLabel
    Left = 12
    Top = 209
    Width = 60
    Height = 17
    Caption = #20986#24211#25968#37327#65306
  end
  object RzLabel7: TRzLabel
    Left = 12
    Top = 240
    Width = 60
    Height = 17
    Caption = #39046#29992#37096#38376#65306
  end
  object RzLabel9: TRzLabel
    Left = 24
    Top = 271
    Width = 48
    Height = 17
    Caption = #39046#29992#20154#65306
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 320
    Width = 642
    Height = 63
    Align = alBottom
    BorderOuter = fsFlat
    BorderSides = [sdTop]
    TabOrder = 2
    DesignSize = (
      642
      63)
    object RzButtonOk: TRzButton
      Left = 424
      Top = 14
      Width = 100
      Height = 33
      Anchors = [akRight, akBottom]
      Caption = #30830#23450
      TabOrder = 0
      OnClick = RzButtonOkClick
    end
    object RzButtonCancel: TRzButton
      Left = 530
      Top = 14
      Width = 100
      Height = 33
      Cancel = True
      Anchors = [akRight, akBottom]
      Caption = #21462#28040
      TabOrder = 1
      OnClick = RzButtonCancelClick
    end
  end
  object RzGroupBox1: TRzGroupBox
    Left = 16
    Top = 22
    Width = 609
    Height = 171
    Caption = #35831#36873#25321#20986#24211#21830#21697#30340#20837#24211#25209#27425
    GroupStyle = gsUnderline
    TabOrder = 0
    object RzListView: TRzListView
      AlignWithMargins = True
      Left = 1
      Top = 22
      Width = 607
      Height = 148
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alClient
      Columns = <
        item
          Caption = #24207#21495
        end
        item
          Caption = #21830#21697#21517#31216
          Width = 120
        end
        item
          Alignment = taCenter
          Caption = #24211#23384#37327
          Width = 60
        end
        item
          Alignment = taCenter
          Caption = #20837#24211#26085#26399
          Width = 100
        end
        item
          Alignment = taCenter
          Caption = #36807#26399#26085#26399
          Width = 100
        end
        item
          Caption = #21697#29260
          Width = 100
        end>
      FillLastColumn = False
      FlatScrollBars = True
      GridLines = True
      HideSelection = False
      HotTrack = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object RzNumericEditNum: TRzNumericEdit
    Left = 78
    Top = 206
    Width = 123
    Height = 25
    Color = clInfoBk
    TabOrder = 1
    IntegersOnly = False
    DisplayFormat = '0.00'
  end
  object RzComboBoxForWhere: TRzComboBox
    Left = 76
    Top = 237
    Width = 125
    Height = 25
    Style = csDropDownList
    ItemHeight = 17
    TabOrder = 3
    OnChange = RzComboBoxForWhereChange
    Values.Strings = (
      '0'
      '1')
  end
  object RzComboBoxForWho: TRzComboBox
    Left = 76
    Top = 268
    Width = 125
    Height = 25
    Style = csDropDownList
    ItemHeight = 17
    TabOrder = 4
    Values.Strings = (
      '0'
      '1')
  end
  object ImageList1: TImageList
    Left = 376
    Top = 240
  end
end
