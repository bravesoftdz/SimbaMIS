object FormMenuManager: TFormMenuManager
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #33756#21697#31649#29702
  ClientHeight = 717
  ClientWidth = 1088
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
  object RzTreeViewMenuList: TRzTreeView
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 329
    Height = 697
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
    OnChange = RzTreeViewMenuListChange
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
  end
  object RzPanel1: TRzPanel
    AlignWithMargins = True
    Left = 349
    Top = 10
    Width = 729
    Height = 697
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
      Caption = #33756#21697#32534#21495#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel2: TRzLabel
      Left = 176
      Top = 7
      Width = 60
      Height = 17
      Caption = #33756#21697#22823#31867#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel3: TRzLabel
      Left = 375
      Top = 7
      Width = 60
      Height = 17
      Caption = #33756#21697#23376#31867#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel4: TRzLabel
      Left = 16
      Top = 37
      Width = 60
      Height = 17
      Caption = #33756#21697#21517#31216#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel5: TRzLabel
      Left = 16
      Top = 64
      Width = 60
      Height = 17
      Caption = #33521#25991#21517#31216#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel6: TRzLabel
      Left = 16
      Top = 91
      Width = 60
      Height = 17
      Caption = #33756#21697#20215#26684#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel7: TRzLabel
      Left = 176
      Top = 91
      Width = 60
      Height = 17
      Caption = #33756#21697#29305#20215#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel8: TRzLabel
      Left = 552
      Top = 91
      Width = 60
      Height = 17
      Caption = #33756#21697#21333#20301#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel9: TRzLabel
      Left = 15
      Top = 465
      Width = 60
      Height = 17
      Caption = #25104#20221#25551#36848#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel10: TRzLabel
      Left = 15
      Top = 494
      Width = 60
      Height = 17
      Caption = #33829#20859#25551#36848#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabelIdx: TRzLabel
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
    object RzLabelMainType: TRzLabel
      Left = 242
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
    object RzLabelSubType: TRzLabel
      Left = 441
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
    object RzLabelName: TRzLabel
      Left = 82
      Top = 37
      Width = 4
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabelEName: TRzLabel
      Left = 82
      Top = 64
      Width = 4
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabelPrice: TRzLabel
      Left = 82
      Top = 91
      Width = 4
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabelSalePrice: TRzLabel
      Left = 242
      Top = 91
      Width = 4
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabelUnit: TRzLabel
      Left = 618
      Top = 91
      Width = 4
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabelDesc: TRzLabel
      Left = 81
      Top = 465
      Width = 4
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabelNut: TRzLabel
      Left = 81
      Top = 494
      Width = 4
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel12: TRzLabel
      Left = 375
      Top = 91
      Width = 60
      Height = 17
      Caption = #38144#21806#25552#25104#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabelAward: TRzLabel
      Left = 441
      Top = 91
      Width = 4
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel13: TRzLabel
      Left = 16
      Top = 520
      Width = 60
      Height = 17
      Caption = #21475#21619#29305#28857#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabelFeature: TRzLabel
      Left = 82
      Top = 520
      Width = 4
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel14: TRzLabel
      Left = 552
      Top = 7
      Width = 60
      Height = 17
      Caption = #20986#21697#24037#20301#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabelMakefrom: TRzLabel
      Left = 618
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
    object RzLabel15: TRzLabel
      Left = 15
      Top = 127
      Width = 60
      Height = 17
      Caption = #21253#21547#33756#21697#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel16: TRzLabel
      Left = 384
      Top = 127
      Width = 60
      Height = 17
      Caption = #36192#36865#33756#21697#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel17: TRzLabel
      Left = 15
      Top = 559
      Width = 60
      Height = 17
      Caption = #39184#29260#26174#31034#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel18: TRzLabel
      Left = 17
      Top = 288
      Width = 60
      Height = 17
      Caption = #21487#36873#33756#21697#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel25: TRzLabel
      Left = 15
      Top = 610
      Width = 60
      Height = 17
      Caption = #21442#19982#25171#25240#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzLabel19: TRzLabel
      Left = 15
      Top = 585
      Width = 60
      Height = 17
      Caption = #25163#26426#26174#31034#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
    end
    object RzSeparator1: TRzSeparator
      Left = 17
      Top = 118
      Width = 705
      ShowGradient = False
      Color = clBtnFace
    end
    object RzSeparator2: TRzSeparator
      Left = 17
      Top = 453
      Width = 705
      ShowGradient = False
      Color = clBtnFace
    end
    object RzPanel2: TRzPanel
      Left = 0
      Top = 645
      Width = 729
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
        Left = 637
        Top = 12
        Width = 80
        Height = 33
        Cancel = True
        Caption = #20851#38381
        TabOrder = 3
        OnClick = RzButtonCloseClick
      end
    end
    object RzListViewSubItem: TRzListView
      Left = 42
      Top = 150
      Width = 327
      Height = 129
      Columns = <
        item
          Caption = #33756#21697#32534#21495
          Width = 60
        end
        item
          Caption = #33756#21697#21517#31216
          Width = 246
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
    object RzListViewFreeItem: TRzListView
      Left = 410
      Top = 150
      Width = 311
      Height = 129
      Columns = <
        item
          Caption = #33756#21697#32534#21495
          Width = 60
        end
        item
          Caption = #33756#21697#21517#31216
          Width = 230
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 3
      ViewStyle = vsReport
    end
    object RzCheckBoxShowInMenu: TRzCheckBox
      Left = 87
      Top = 560
      Width = 175
      Height = 19
      Caption = #26159#65292#26174#31034#22312#39184#29260#19978#20379#23458#20154#28857#36873
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      State = cbUnchecked
      TabOrder = 4
    end
    object RzListViewSelectItem: TRzListView
      Left = 42
      Top = 311
      Width = 679
      Height = 130
      Columns = <
        item
          Caption = #33756#21697#32534#21495
          Width = 230
        end
        item
          Caption = #33756#21697#21517#31216
          Width = 428
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 2
      ViewStyle = vsReport
    end
    object RzCheckBoxCanRate: TRzCheckBox
      Left = 87
      Top = 609
      Width = 127
      Height = 19
      Caption = #26159#65292#35813#33756#21697#21442#19982#25171#25240
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 5
    end
    object RzCheckBoxShowInPhone: TRzCheckBox
      Left = 87
      Top = 586
      Width = 187
      Height = 19
      Caption = #26159#65292#26174#31034#22312#25163#26426#19978#20379#26381#21153#21592#19979#21333
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      State = cbUnchecked
      TabOrder = 6
    end
  end
end
