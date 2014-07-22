object FormActivityManager: TFormActivityManager
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #33829#38144#27963#21160#31649#29702
  ClientHeight = 460
  ClientWidth = 819
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  object RzTreeViewList: TRzTreeView
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 329
    Height = 440
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 0
    Margins.Bottom = 10
    SelectionPen.Color = clBtnShadow
    Align = alLeft
    HideSelection = False
    Indent = 25
    ItemHeight = 22
    ReadOnly = True
    RightClickSelect = True
    TabOrder = 0
    OnChange = RzTreeViewListChange
    OnDblClick = RzTreeViewListDblClick
    Items.NodeData = {
      03030000002E0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      00000000000108F25DC78F1F678476258400953B6DA8522E0000000000000000
      000000FFFFFFFFFFFFFFFF0000000000000000000000000108DB8F4C882D4E84
      76258400953B6DA8522E0000000000000000000000FFFFFFFFFFFFFFFF000000
      00000000000000000001082A671F7548658476258400953B6DA852}
  end
  object RzPanel1: TRzPanel
    AlignWithMargins = True
    Left = 349
    Top = 10
    Width = 460
    Height = 440
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    BorderOuter = fsNone
    TabOrder = 1
    object RzLabel1: TRzLabel
      Left = 16
      Top = 7
      Width = 60
      Height = 17
      Caption = #27963#21160#26631#39064#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel2: TRzLabel
      Left = 16
      Top = 34
      Width = 60
      Height = 17
      Caption = #24320#22987#26102#38388#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabelTitle: TRzLabel
      Left = 82
      Top = 7
      Width = 4
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabelStartTime: TRzLabel
      Left = 82
      Top = 34
      Width = 4
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel3: TRzLabel
      Left = 16
      Top = 59
      Width = 60
      Height = 17
      Caption = #32467#26463#26102#38388#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabelEndTime: TRzLabel
      Left = 82
      Top = 59
      Width = 4
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel5: TRzLabel
      Left = 16
      Top = 84
      Width = 60
      Height = 17
      Caption = #27963#21160#20869#23481#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzPanel2: TRzPanel
      Left = 0
      Top = 388
      Width = 460
      Height = 52
      Align = alBottom
      BorderOuter = fsFlat
      BorderSides = [sdTop]
      TabOrder = 0
      object RzButtonAdd: TRzButton
        Left = 0
        Top = 12
        Width = 80
        Height = 33
        FrameColor = 7617536
        Caption = #28155#21152
        Color = 15791348
        HotTrack = True
        TabOrder = 0
        OnClick = RzButtonAddClick
      end
      object RzButtonEdit: TRzButton
        Left = 81
        Top = 12
        Width = 80
        Height = 33
        Caption = #32534#36753
        TabOrder = 1
        OnClick = RzButtonEditClick
      end
      object RzButtonDel: TRzButton
        Left = 162
        Top = 12
        Width = 80
        Height = 33
        Caption = #21024#38500
        TabOrder = 2
        OnClick = RzButtonDelClick
      end
      object RzButtonClose: TRzButton
        Left = 373
        Top = 12
        Width = 80
        Height = 33
        Cancel = True
        Caption = #20851#38381
        TabOrder = 3
        OnClick = RzButtonCloseClick
      end
    end
    object RzRichEditContent: TRzRichEdit
      Left = 16
      Top = 107
      Width = 441
      Height = 270
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
      ReadOnlyColor = clWindow
    end
  end
end
