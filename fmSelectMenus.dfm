object FormSelectMenus: TFormSelectMenus
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #36873#25321#35201#21152#20837#30340#33756#21697
  ClientHeight = 663
  ClientWidth = 383
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
  object RzLabel23: TRzLabel
    Left = 8
    Top = 444
    Width = 60
    Height = 17
    Caption = #24050#36873#33756#21697#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
  end
  object RzURLLabel6: TRzURLLabel
    Left = 74
    Top = 444
    Width = 24
    Height = 17
    Caption = #21024#38500
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -12
    Font.Name = #24494#36719#38597#40657
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = RzURLLabel6Click
    FlyByColor = clRed
  end
  object RzLabel1: TRzLabel
    Left = 8
    Top = 620
    Width = 60
    Height = 17
    Caption = #21487#36873#25968#37327#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
  end
  object RzSeparator1: TRzSeparator
    Left = 5
    Top = 437
    Width = 373
    ShowGradient = False
    Color = clBtnFace
  end
  object RzTreeViewMenuList: TRzTreeView
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 373
    Height = 421
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    SelectionPen.Color = clBtnShadow
    Align = alTop
    HideSelection = False
    Indent = 25
    ItemHeight = 22
    ReadOnly = True
    RightClickSelect = True
    TabOrder = 0
    OnDblClick = RzTreeViewMenuListDblClick
    Items.NodeData = {
      0304000000220000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      000200000001025291346C220000000000000000000000FFFFFFFFFFFFFFFF00
      00000000000000000000000102A27E5291220000000000000000000000FFFFFF
      FFFFFFFFFF000000000000000000000000010264555291220000000000000000
      000000FFFFFFFFFFFFFFFF00000000000000000200000001026E999965220000
      000000000000000000FFFFFFFFFFFFFFFF000000000000000000000000010296
      546155220000000000000000000000FFFFFFFFFFFFFFFF000000000000000000
      00000001029C67416C220000000000000000000000FFFFFFFFFFFFFFFF000000
      00000000000000000001027F891099220000000000000000000000FFFFFFFFFF
      FFFFFF00000000000000000000000001022D4E1099}
    ExplicitWidth = 612
  end
  object RzButtonOk: TRzButton
    Left = 299
    Top = 625
    Height = 30
    ModalResult = 1
    Caption = #20851#38381
    TabOrder = 4
  end
  object RzListViewSelectItem: TRzListView
    Left = 5
    Top = 467
    Width = 373
    Height = 147
    Columns = <
      item
        Caption = #33756#21697#32534#21495
        Width = 60
      end
      item
        Caption = #33756#21697#21517#31216
        Width = 252
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
  object RzSpinner1: TRzSpinner
    Left = 74
    Top = 620
    Width = 58
    Max = 5
    Min = 1
    PageSize = 1
    ShowFocusRect = False
    Value = 1
    ParentColor = False
    TabOrder = 2
  end
  object RzButton1: TRzButton
    Left = 218
    Top = 625
    Height = 30
    Caption = #30830#23450
    TabOrder = 3
    OnClick = RzButton1Click
  end
end
