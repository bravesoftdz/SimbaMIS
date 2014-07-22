object FormTableDetail: TFormTableDetail
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #21488#20301#35814#24773
  ClientHeight = 680
  ClientWidth = 1280
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 17
  object RzListView: TRzListView
    AlignWithMargins = True
    Left = 1
    Top = 1
    Width = 1278
    Height = 372
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alTop
    BorderStyle = bsNone
    Columns = <
      item
        Caption = #24207#21495
      end
      item
        Alignment = taCenter
        Caption = #33756#21697#32534#21495
        Width = 60
      end
      item
        Caption = #21697#21517
        Width = 180
      end
      item
        Alignment = taRightJustify
        Caption = #20215#26684
        Width = 60
      end
      item
        Alignment = taCenter
        Caption = #29305#20215
        Width = 40
      end
      item
        Alignment = taCenter
        Caption = #25171#25240
        Width = 40
      end
      item
        Alignment = taCenter
        Caption = #20813
        Width = 40
      end
      item
        Alignment = taCenter
        Caption = #25968#37327
        Width = 40
      end
      item
        Alignment = taCenter
        Caption = #21333#20301
        Width = 40
      end
      item
        Caption = #23458#20154#35201#27714
        Width = 150
      end
      item
        Alignment = taCenter
        Caption = #28857#33756#26102#38388
        Width = 150
      end
      item
        Alignment = taCenter
        Caption = #19978#33756#26102#38388
        Width = 150
      end
      item
        Caption = #26381#21153#21592
        Width = 80
      end
      item
        Caption = #20256#33756#21592
        Width = 181
      end>
    ColumnClick = False
    FlatScrollBars = True
    GridLines = True
    HideSelection = False
    HotTrack = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 374
    Width = 1280
    Height = 36
    Align = alTop
    BorderOuter = fsFlat
    BorderSides = [sdTop, sdBottom]
    FlatColorAdjustment = 0
    TabOrder = 1
    Transparent = True
    object RzToolButtonTuiCai: TRzToolButton
      Left = 5
      Top = 4
      Width = 60
      Height = 28
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Caption = #36864#33756
      OnClick = RzToolButtonTuiCaiClick
    end
    object RzLabelTotal: TRzLabel
      AlignWithMargins = True
      Left = 1195
      Top = 1
      Width = 65
      Height = 34
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Align = alRight
      Caption = #21512#35745#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      Rotation = roFlat
      TextMargin = 10
      ExplicitHeight = 39
    end
    object RzLabelTableName: TRzLabel
      AlignWithMargins = True
      Left = 1110
      Top = 1
      Width = 65
      Height = 34
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Align = alRight
      Caption = #21488#20301#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      Rotation = roFlat
      TextMargin = 10
      ExplicitHeight = 39
    end
    object RzToolButtonPrintList: TRzToolButton
      Left = 138
      Top = 5
      Width = 90
      Height = 28
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Caption = #25171#21360#28040#36153#28165#21333
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      OnClick = RzToolButtonPrintListClick
    end
    object RzToolButtonDesignReport: TRzToolButton
      Left = 541
      Top = 5
      Width = 90
      Height = 28
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Caption = #28165#21333#25968#25454#26684#24335
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      OnClick = RzToolButtonDesignReportClick
    end
    object RzToolButtonPreviewList: TRzToolButton
      Left = 637
      Top = 5
      Width = 90
      Height = 28
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Caption = #39044#35272#28040#36153#28165#21333
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      OnClick = RzToolButtonPreviewListClick
    end
    object RzToolButtonPreviewFinal: TRzToolButton
      Tag = 1
      Left = 733
      Top = 5
      Width = 90
      Height = 28
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Caption = #39044#35272#25910#38134#23567#31080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      OnClick = RzToolButtonPreviewListClick
    end
    object RzToolButtonDesignMakefrom: TRzToolButton
      Left = 445
      Top = 5
      Width = 90
      Height = 28
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Caption = #20986#21697#25968#25454#26684#24335
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      OnClick = RzToolButtonDesignMakefromClick
    end
    object RzToolButtonPreviewMakefrom: TRzToolButton
      Tag = 1
      Left = 829
      Top = 5
      Width = 90
      Height = 28
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Caption = #39044#35272#20986#21697#23567#31080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      OnClick = RzToolButtonPreviewMakefromClick
    end
    object RzToolButtonPrintMakeFrom: TRzToolButton
      Left = 349
      Top = 5
      Width = 90
      Height = 28
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Caption = #25171#21360#24037#20301#20986#21697
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      OnClick = RzToolButtonPrintMakeFromClick
    end
    object RzToolButtonMian: TRzToolButton
      Left = 71
      Top = 5
      Width = 60
      Height = 28
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Caption = #20813#33756
      OnClick = RzToolButtonMianClick
    end
    object RzToolButtonPrintPre: TRzToolButton
      Left = 234
      Top = 5
      Width = 90
      Height = 28
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Caption = #25171#21360#39044#32467#36134#21333
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      OnClick = RzToolButtonPrintPreClick
    end
  end
  object RzPanelPay: TRzPanel
    Left = 0
    Top = 410
    Width = 1280
    Height = 270
    Align = alClient
    BorderOuter = fsNone
    TabOrder = 2
    object RzRadioGroupPayType: TRzRadioGroup
      AlignWithMargins = True
      Left = 6
      Top = 10
      Width = 222
      Height = 254
      Margins.Left = 6
      Margins.Top = 10
      Margins.Bottom = 6
      Align = alLeft
      Caption = #32467#24080#26041#24335
      FlatColorAdjustment = 0
      StartXPos = 20
      StartYPos = 8
      TabOrder = 0
      Transparent = True
      VerticalSpacing = 5
      OnClick = RzRadioGroupPayTypeClick
    end
    object RzPageControlRate: TRzPageControl
      Left = 231
      Top = 0
      Width = 462
      Height = 270
      ActivePage = TabSheet2
      Align = alLeft
      ShowCardFrame = False
      ShowFullFrame = False
      ShowShadow = False
      TabOrder = 1
      FixedDimension = 0
      object TabSheet1: TRzTabSheet
        TabVisible = False
        Caption = 'TabSheet1'
        object RzRadioGroupStoreCard: TRzRadioGroup
          AlignWithMargins = True
          Left = 6
          Top = 10
          Width = 222
          Height = 254
          Margins.Left = 6
          Margins.Top = 10
          Margins.Bottom = 6
          Align = alLeft
          Caption = #20648#20540#21345
          FlatColorAdjustment = 0
          StartXPos = 20
          StartYPos = 8
          TabOrder = 0
          Transparent = True
          VerticalSpacing = 5
          object RzLabel1: TRzLabel
            Left = 16
            Top = 64
            Width = 60
            Height = 17
            Caption = #20648#20540#21345#21495#65306
          end
          object RzLabel2: TRzLabel
            Left = 16
            Top = 32
            Width = 60
            Height = 17
            Caption = #26597#21345#26041#24335#65306
          end
          object RzEditSearchKey: TRzEdit
            Left = 82
            Top = 61
            Width = 103
            Height = 25
            TabOrder = 1
            OnChange = RzEditSearchKeyChange
          end
          object RzRadioGroupSearchType: TRzRadioGroup
            Left = 82
            Top = 30
            Width = 130
            Height = 23
            BannerHeight = 1
            Columns = 2
            Ctl3D = False
            GroupStyle = gsBanner
            ItemIndex = 0
            Items.Strings = (
              #21345#21495
              #25163#26426#21495)
            ParentCtl3D = False
            StartXPos = 0
            StartYPos = 0
            TabOrder = 0
            VerticalSpacing = 0
            OnClick = RzRadioGroupSearchTypeClick
          end
          object RzPanel2: TRzPanel
            AlignWithMargins = True
            Left = 4
            Top = 113
            Width = 214
            Height = 137
            Align = alBottom
            BorderOuter = fsFlat
            BorderSides = [sdTop]
            FlatColorAdjustment = 50
            TabOrder = 2
            object RzLabel3: TRzLabel
              Left = 12
              Top = 59
              Width = 48
              Height = 17
              Caption = #25345#21345#20154#65306
            end
            object RzLabel4: TRzLabel
              Left = 12
              Top = 82
              Width = 48
              Height = 17
              Caption = #25240#25187#29575#65306
            end
            object RzLabel5: TRzLabel
              Left = 12
              Top = 105
              Width = 48
              Height = 17
              Caption = #21345#20313#39069#65306
            end
            object RzLabel6: TRzLabel
              Left = 12
              Top = 11
              Width = 48
              Height = 17
              Caption = #21345#12288#21495#65306
            end
            object RzLabel7: TRzLabel
              Left = 12
              Top = 34
              Width = 48
              Height = 17
              Caption = #25163#26426#21495#65306
            end
            object RzLabelCardNo: TRzLabel
              Left = 76
              Top = 11
              Width = 4
              Height = 17
            end
            object RzLabelCardTel: TRzLabel
              Left = 76
              Top = 34
              Width = 4
              Height = 17
            end
            object RzLabelCardName: TRzLabel
              Left = 76
              Top = 57
              Width = 4
              Height = 17
            end
            object RzLabelCardRate: TRzLabel
              Left = 76
              Top = 82
              Width = 4
              Height = 17
            end
            object RzLabelCardOver: TRzLabel
              Left = 76
              Top = 105
              Width = 4
              Height = 17
            end
            object RzToolButtonPutMoney: TRzToolButton
              Left = 158
              Top = 100
              Width = 51
              Height = 28
              GradientColorStyle = gcsSystem
              ShowCaption = True
              UseToolbarButtonSize = False
              UseToolbarShowCaption = False
              UseToolbarVisualStyle = False
              VisualStyle = vsGradient
              Caption = #20805#20540
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #24494#36719#38597#40657
              Font.Style = []
              ParentFont = False
              OnClick = RzToolButtonPutMoneyClick
            end
          end
        end
      end
      object TabSheet2: TRzTabSheet
        TabVisible = False
        Caption = 'TabSheet2'
        object RzRadioGroup1: TRzRadioGroup
          AlignWithMargins = True
          Left = 237
          Top = 10
          Width = 222
          Height = 254
          Margins.Left = 6
          Margins.Top = 10
          Margins.Bottom = 6
          Align = alClient
          Caption = #20248#24800#21048
          Columns = 2
          FlatColorAdjustment = 0
          StartXPos = 20
          StartYPos = 8
          TabOrder = 0
          Transparent = True
          VerticalSpacing = 5
          object RzPageControlTicket: TRzPageControl
            Left = 8
            Top = 63
            Width = 209
            Height = 170
            ActivePage = TabSheet5
            FlatColorAdjustment = 50
            ShowFullFrame = False
            ShowShadow = False
            TabOrder = 0
            FixedDimension = 0
            object TabSheet5: TRzTabSheet
              TabVisible = False
              Caption = 'TabSheet5'
              object RzLabel19: TRzLabel
                Left = 6
                Top = 107
                Width = 194
                Height = 54
                AutoSize = False
                Caption = #25552#37266#65306#22914#26524#20351#29992#29616#37329#21048#25110#30005#23376#21048#26102#65292#25240#25187#29575#23558#33258#21160#21464#20026'1'#65292#22810#31181#20248#24800#19981#33021#21516#26102#20351#29992#12290
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clMaroon
                Font.Height = -12
                Font.Name = #24494#36719#38597#40657
                Font.Style = []
                ParentFont = False
                WordWrap = True
              end
            end
            object TabSheet3: TRzTabSheet
              TabVisible = False
              Caption = 'TabSheet3'
              object RzLabel8: TRzLabel
                Left = 3
                Top = 16
                Width = 36
                Height = 17
                Caption = #37329#39069#65306
              end
              object RzLabel9: TRzLabel
                Left = 132
                Top = 16
                Width = 12
                Height = 17
                Caption = #20803
              end
              object RzLabel10: TRzLabel
                Left = 4
                Top = 44
                Width = 36
                Height = 17
                Caption = #21048#21495#65306
              end
              object RzNumericEditCashTicket: TRzNumericEdit
                Left = 45
                Top = 13
                Width = 81
                Height = 25
                TabOrder = 0
                OnChange = RzNumericEditCashTicketChange
                DisplayFormat = '0;(0)'
              end
              object RzMemoCashTicketNoList: TRzMemo
                Left = 46
                Top = 44
                Width = 158
                Height = 121
                ScrollBars = ssVertical
                TabOrder = 1
              end
            end
            object TabSheet4: TRzTabSheet
              TabVisible = False
              Caption = 'TabSheet4'
              object RzLabel11: TRzLabel
                Left = 3
                Top = 16
                Width = 36
                Height = 17
                Caption = #21048#21495#65306
              end
              object RzLabel12: TRzLabel
                Left = 3
                Top = 44
                Width = 36
                Height = 17
                Caption = #37329#39069#65306
              end
              object RzLabelNetTicket: TRzLabel
                Left = 45
                Top = 42
                Width = 4
                Height = 17
              end
              object RzLabel15: TRzLabel
                Left = 3
                Top = 72
                Width = 36
                Height = 17
                Caption = #29366#24577#65306
              end
              object RzLabelNetTicketStatus: TRzLabel
                Left = 45
                Top = 72
                Width = 4
                Height = 17
              end
              object RzLabel17: TRzLabel
                Left = 3
                Top = 100
                Width = 36
                Height = 17
                Caption = #21457#34892#65306
              end
              object RzLabelNetTicketTime: TRzLabel
                Left = 45
                Top = 100
                Width = 4
                Height = 17
              end
              object RzLabel13: TRzLabel
                Left = 3
                Top = 126
                Width = 36
                Height = 17
                Caption = #32456#27490#65306
              end
              object RzLabelNetTicketEndTime: TRzLabel
                Left = 45
                Top = 126
                Width = 4
                Height = 17
              end
              object RzEditNetTicketNo: TRzEdit
                Left = 45
                Top = 11
                Width = 116
                Height = 25
                TabOrder = 0
                OnChange = RzEditNetTicketNoChange
              end
            end
          end
          object RzRadioGroupTicket: TRzRadioGroup
            Left = 10
            Top = 31
            Width = 199
            Height = 23
            BannerHeight = 1
            Columns = 3
            Ctl3D = False
            GroupStyle = gsBanner
            Items.Strings = (
              #19981#20351#29992
              #29616#37329#21048
              #30005#23376#21048)
            ParentCtl3D = False
            StartXPos = 0
            StartYPos = 0
            TabOrder = 1
            VerticalSpacing = 0
            OnClick = RzRadioGroupTicketClick
          end
        end
        object RzRadioGroupRate: TRzRadioGroup
          AlignWithMargins = True
          Left = 6
          Top = 10
          Width = 222
          Height = 254
          Margins.Left = 6
          Margins.Top = 10
          Margins.Bottom = 6
          Align = alLeft
          Caption = #25240#25187#29575
          Columns = 3
          FlatColorAdjustment = 0
          StartXPos = 20
          StartYPos = 8
          TabOrder = 1
          Transparent = True
          VerticalSpacing = 8
          OnClick = RzRadioGroup3Click
          object RzLabelRateTip: TRzLabel
            Left = 16
            Top = 171
            Width = 185
            Height = 54
            AutoSize = False
            Caption = #25552#37266#65306#29616#37329#32467#36134#25171#25240#65292#24517#39035#23558#25171#21360#20986#30340#25910#38134#23567#31080#20132#30001#39038#23458#31614#23383#26041#21487#32463#36807#36130#21153#23457#26680#12290
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = #24494#36719#38597#40657
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
        end
      end
    end
    object RzPageControlPay: TRzPageControl
      Left = 850
      Top = 0
      Width = 430
      Height = 270
      ActivePage = TabSheet6
      Align = alRight
      ShowCardFrame = False
      ShowFullFrame = False
      ShowShadow = False
      TabOrder = 2
      FixedDimension = 0
      object TabSheet6: TRzTabSheet
        TabVisible = False
        Caption = 'TabSheet6'
        object RzRadioGroup2: TRzRadioGroup
          AlignWithMargins = True
          Left = 0
          Top = 10
          Width = 427
          Height = 254
          Margins.Left = 6
          Margins.Top = 10
          Margins.Bottom = 6
          Align = alRight
          Caption = #32467#24080
          Columns = 2
          FlatColorAdjustment = 0
          StartXPos = 20
          StartYPos = 8
          TabOrder = 0
          Transparent = True
          VerticalSpacing = 5
          OnClick = RzRadioGroup3Click
          object RzPanel3: TRzPanel
            AlignWithMargins = True
            Left = 4
            Top = 205
            Width = 419
            Height = 45
            Align = alBottom
            BorderOuter = fsFlat
            BorderSides = [sdTop]
            FlatColorAdjustment = 50
            TabOrder = 3
            object RzToolButtonPayEnd: TRzToolButton
              Left = 312
              Top = 11
              Width = 85
              Height = 28
              GradientColorStyle = gcsSystem
              ShowCaption = True
              UseToolbarButtonSize = False
              UseToolbarShowCaption = False
              UseToolbarVisualStyle = False
              VisualStyle = vsGradient
              Caption = #29616#37329#25910#35755
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #24494#36719#38597#40657
              Font.Style = []
              ParentFont = False
              OnClick = RzToolButtonPayEndClick
            end
            object RzToolButtonViewAliPay: TRzToolButton
              Left = 16
              Top = 11
              Width = 85
              Height = 28
              GradientColorStyle = gcsSystem
              ShowCaption = True
              UseToolbarButtonSize = False
              UseToolbarShowCaption = False
              UseToolbarVisualStyle = False
              VisualStyle = vsGradient
              Caption = #25903#20184#23453#26597#35810
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #24494#36719#38597#40657
              Font.Style = []
              ParentFont = False
            end
          end
          object RzPanelStoreFunction: TRzPanel
            Left = 208
            Top = 111
            Width = 209
            Height = 72
            BorderOuter = fsNone
            TabOrder = 2
            object RzLabel22: TRzLabel
              Left = 30
              Top = 10
              Width = 72
              Height = 17
              Caption = #20648#20540#21345#23494#30721#65306
            end
            object RzToolButtonInputStoreCardPass: TRzToolButton
              Left = 21
              Top = 41
              Width = 85
              Height = 28
              GradientColorStyle = gcsSystem
              ShowCaption = True
              UseToolbarButtonSize = False
              UseToolbarShowCaption = False
              UseToolbarVisualStyle = False
              VisualStyle = vsGradient
              Caption = #36755#20837#23494#30721
            end
            object RzToolButtonDoPayOfStoreCard: TRzToolButton
              Left = 108
              Top = 41
              Width = 85
              Height = 28
              GradientColorStyle = gcsSystem
              ShowCaption = True
              UseToolbarButtonSize = False
              UseToolbarShowCaption = False
              UseToolbarVisualStyle = False
              VisualStyle = vsGradient
              Caption = #24320#22987#25187#27454
              OnClick = RzToolButtonDoPayOfStoreCardClick
            end
            object RzEditStoreCardPass: TRzEdit
              Left = 108
              Top = 6
              Width = 85
              Height = 25
              PasswordChar = '*'
              ReadOnlyColor = clWhite
              TabOrder = 0
            end
          end
          object RzPanelCashFunction: TRzPanel
            Left = 17
            Top = 114
            Width = 152
            Height = 71
            BorderOuter = fsNone
            TabOrder = 1
            object RzLabel21: TRzLabel
              Left = 8
              Top = 44
              Width = 60
              Height = 17
              Caption = #24212#35813#25214#38646#65306
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #24494#36719#38597#40657
              Font.Style = []
              ParentFont = False
            end
            object RzLabel20: TRzLabel
              Left = 8
              Top = 8
              Width = 60
              Height = 17
              Caption = #39038#23458#25903#20184#65306
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #24494#36719#38597#40657
              Font.Style = []
              ParentFont = False
            end
            object RzNumericEditTotal3: TRzNumericEdit
              Left = 72
              Top = 41
              Width = 65
              Height = 25
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #24494#36719#38597#40657
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              ReadOnlyColor = clWhite
              TabOrder = 1
              DisplayFormat = '0;(0)'
            end
            object RzNumericEditTotal2: TRzNumericEdit
              Left = 72
              Top = 5
              Width = 65
              Height = 25
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #24494#36719#38597#40657
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnExit = RzNumericEditTotal2Exit
              OnKeyDown = RzNumericEditTotal2KeyDown
              DisplayFormat = '0;(0)'
            end
          end
          object RzPanel4: TRzPanel
            AlignWithMargins = True
            Left = 4
            Top = 21
            Width = 419
            Height = 43
            Align = alTop
            BorderOuter = fsFlat
            BorderSides = [sdBottom]
            FlatColorAdjustment = 50
            TabOrder = 0
            object RzToolButtonSumTotal: TRzToolButton
              Left = 31
              Top = 8
              Width = 50
              Height = 28
              Hint = #35745#31639#24212#25910
              GradientColorStyle = gcsSystem
              ShowCaption = True
              UseToolbarButtonSize = False
              UseToolbarShowCaption = False
              UseToolbarVisualStyle = False
              VisualStyle = vsGradient
              Caption = #24212#25910':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = #24494#36719#38597#40657
              Font.Style = [fsBold]
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              OnClick = RzToolButtonSumTotalClick
            end
            object RzLabelFinalTotal: TRzLabel
              AlignWithMargins = True
              Left = 84
              Top = 12
              Width = 24
              Height = 19
              Margins.Right = 23
              Caption = '0'#20803
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = #24494#36719#38597#40657
              Font.Style = [fsBold]
              ParentFont = False
              Layout = tlCenter
            end
          end
          object RzPanelIntNoInvoice: TRzPanel
            Left = 1
            Top = 67
            Width = 425
            Height = 41
            Align = alTop
            BorderOuter = fsNone
            TabOrder = 4
            object RzLabel16: TRzLabel
              Left = 45
              Top = 14
              Width = 34
              Height = 19
              Caption = #23454#25910':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = #24494#36719#38597#40657
              Font.Style = [fsBold]
              ParentFont = False
            end
            object RzLabelLastFinalTotal: TRzLabel
              AlignWithMargins = True
              Left = 87
              Top = 14
              Width = 24
              Height = 19
              Margins.Right = 23
              Caption = '0'#20803
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = #24494#36719#38597#40657
              Font.Style = [fsBold]
              ParentFont = False
              Layout = tlCenter
            end
            object RzToolButtonIntNoInvoice: TRzToolButton
              Left = 312
              Top = 5
              Width = 102
              Height = 28
              GradientColorStyle = gcsSystem
              DropDownMenu = PopupMenuIntNoVoice
              ShowCaption = True
              UseToolbarButtonSize = False
              UseToolbarShowCaption = False
              UseToolbarVisualStyle = False
              ToolStyle = tsDropDown
              VisualStyle = vsGradient
              Caption = #25273#38646#19981#24320#21457#31080
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #24494#36719#38597#40657
              Font.Style = []
              ParentFont = False
            end
          end
        end
      end
      object TabSheet7: TRzTabSheet
        TabVisible = False
        Caption = 'TabSheet7'
        object RzRadioGroup3: TRzRadioGroup
          AlignWithMargins = True
          Left = 0
          Top = 10
          Width = 427
          Height = 254
          Margins.Left = 6
          Margins.Top = 10
          Margins.Bottom = 6
          Align = alRight
          Caption = #31614#21333'/'#20813#21333
          Columns = 2
          FlatColorAdjustment = 0
          StartXPos = 20
          StartYPos = 8
          TabOrder = 0
          Transparent = True
          VerticalSpacing = 5
          OnClick = RzRadioGroup3Click
          object RzLabel14: TRzLabel
            Left = 56
            Top = 96
            Width = 329
            Height = 33
            AutoSize = False
            Caption = #25552#37266#65306#31614#21333#19982#20813#21333#65292#24517#39035#23558#31245#21518#25171#21360#20986#28040#36153#21333#25454#20132#19982#39046#23548#31614#23383#26041#21487#36890#36807#36130#21153#23457#26597
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = #24494#36719#38597#40657
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object RzPanel5: TRzPanel
            AlignWithMargins = True
            Left = 4
            Top = 205
            Width = 419
            Height = 45
            Align = alBottom
            BorderOuter = fsFlat
            BorderSides = [sdTop]
            FlatColorAdjustment = 50
            TabOrder = 0
            object RzToolButtonLeaderOk: TRzToolButton
              Left = 312
              Top = 11
              Width = 85
              Height = 28
              GradientColorStyle = gcsSystem
              ShowCaption = True
              UseToolbarButtonSize = False
              UseToolbarShowCaption = False
              UseToolbarVisualStyle = False
              VisualStyle = vsGradient
              Caption = #30830#23450
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #24494#36719#38597#40657
              Font.Style = []
              ParentFont = False
              OnClick = RzToolButtonLeaderOkClick
            end
          end
        end
      end
    end
  end
  object ImageList1: TImageList
    Left = 552
    Top = 216
  end
  object frxReport: TfrxReport
    Version = '4.7.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #39044#35774
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 41425.981271157400000000
    ReportOptions.LastChange = 41428.704520266200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnBeginDoc = frxReportBeginDoc
    OnGetValue = frxReportGetValue
    Left = 584
    Top = 216
    Datasets = <
      item
        DataSet = frxUserDataSetConsDetail
        DataSetName = 'frxUserDataSetConsDetail'
      end>
    Variables = <
      item
        Name = ' tableDetailValue'
        Value = Null
      end
      item
        Name = 'tableName'
        Value = Null
      end
      item
        Name = 'useCashTicket'
        Value = Null
      end
      item
        Name = 'cashTicketTotal'
        Value = Null
      end
      item
        Name = 'useNetTicket'
        Value = Null
      end
      item
        Name = 'netTicketTotal'
        Value = Null
      end
      item
        Name = 'useRate'
        Value = Null
      end
      item
        Name = 'rateValue'
        Value = Null
      end
      item
        Name = 'payType'
        Value = Null
      end
      item
        Name = 'finalPaySum'
        Value = Null
      end
      item
        Name = 'printCount'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      PaperWidth = 80.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 256
      LeftMargin = 2.000000000000000000
      RightMargin = 2.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      EndlessHeight = True
      object PageHeader1: TfrxPageHeader
        Height = 26.456692910000000000
        Top = 94.488250000000000000
        Width = 287.244280000000000000
        object Memo5: TfrxMemoView
          Width = 287.244094490000000000
          Height = 22.677165350000000000
          ShowHint = False
          Frame.Typ = [ftBottom]
          Frame.BottomLine.Style = fsDot
        end
        object Memo6: TfrxMemoView
          Top = 3.779527560000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Memo.UTF8W = (
            #21697#21517)
        end
        object Memo7: TfrxMemoView
          Left = 117.165430000000000000
          Top = 3.779530000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            #25968#37327)
        end
        object Memo8: TfrxMemoView
          Left = 170.078850000000000000
          Top = 3.779530000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            #21333#20215)
        end
        object Memo9: TfrxMemoView
          Left = 222.992270000000000000
          Top = 3.779530000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            #23567#35745)
        end
      end
      object ReportTitle1: TfrxReportTitle
        Height = 52.913385830000000000
        Top = 18.897650000000000000
        Width = 287.244280000000000000
        object Memo1: TfrxMemoView
          Top = 26.456692910000000000
          Width = 287.244094490000000000
          Height = 22.677165350000000000
          ShowHint = False
          Frame.Typ = [ftBottom]
        end
        object Memo2: TfrxMemoView
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            #36763#24052#35199#39184#21654#21857#21381#28040#36153#28165#21333)
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 37.795300000000000000
          Top = 30.236240000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          Memo.UTF8W = (
            '[tableName]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Top = 30.236240000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          Memo.UTF8W = (
            #21488#20301':')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 151.181200000000000000
          Top = 30.236240000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.FormatStr = 'yyyy-mm-dd'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          Memo.UTF8W = (
            '[<Date>]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 226.771800000000000000
          Top = 30.236240000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          Memo.UTF8W = (
            '[<Time>]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        Height = 22.677180000000000000
        Top = 181.417440000000000000
        Width = 287.244280000000000000
        DataSet = frxUserDataSetConsDetail
        DataSetName = 'frxUserDataSetConsDetail'
        RowCount = 0
        object Memo10: TfrxMemoView
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'itemname'
          DataSet = frxUserDataSetConsDetail
          DataSetName = 'frxUserDataSetConsDetail'
          Memo.UTF8W = (
            '[frxUserDataSetConsList."itemname"]')
        end
        object Memo11: TfrxMemoView
          Left = 113.385900000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'nums'
          DataSet = frxUserDataSetConsDetail
          DataSetName = 'frxUserDataSetConsDetail'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserDataSetConsList."nums"]')
        end
        object Memo12: TfrxMemoView
          Left = 166.299320000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'price'
          DataSet = frxUserDataSetConsDetail
          DataSetName = 'frxUserDataSetConsDetail'
          DisplayFormat.FormatStr = '%2.1m'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[frxUserDataSetConsList."price"]')
        end
        object Memo13: TfrxMemoView
          Left = 219.212740000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxUserDataSetConsDetail
          DataSetName = 'frxUserDataSetConsDetail'
          DisplayFormat.FormatStr = '%2.1m'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[<frxUserDataSetConsList."nums">*<frxUserDataSetConsList."price"' +
              '>]')
        end
      end
      object ReportSummary1: TfrxReportSummary
        Height = 26.456692910000000000
        Top = 264.567100000000000000
        Width = 287.244280000000000000
        Child = frxReport.ChildPrintList
        object Memo14: TfrxMemoView
          Top = 3.779530000000000000
          Width = 287.244280000000000000
          Height = 22.677165350000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Frame.TopLine.Style = fsDot
          Frame.BottomLine.Style = fsDot
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Top = 7.559060000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Memo.UTF8W = (
            #24212#25910#21512#35745#65306)
        end
        object Memo16: TfrxMemoView
          Left = 188.976500000000000000
          Top = 7.559060000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxUserDataSetConsDetail
          DataSetName = 'frxUserDataSetConsDetail'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            
              '[SUM(<frxUserDataSetConsList."nums">*<frxUserDataSetConsList."pr' +
              'ice">)]')
        end
      end
      object ChildPrintList: TfrxChild
        Height = 30.236240000000000000
        Top = 313.700990000000000000
        Width = 287.244280000000000000
        object Memo20: TfrxMemoView
          Top = 11.338590000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Memo.UTF8W = (
            '[printCount]')
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 41.574830000000000000
        Top = 366.614410000000000000
        Width = 287.244280000000000000
        object Memo19: TfrxMemoView
          Top = 11.338590000000000000
          Width = 287.244280000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
          Frame.TopLine.Style = fsDot
          HAlign = haCenter
          Memo.UTF8W = (
            #27426#36814#20809#20020#36763#24052#35199#39184#21654#21857#21381#65281)
          VAlign = vaBottom
        end
      end
    end
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
    Left = 616
    Top = 216
  end
  object frxUserDataSetConsDetail: TfrxUserDataSet
    UserName = 'frxUserDataSetConsDetail'
    Fields.Strings = (
      'itemname'
      'nums'
      'price')
    OnGetValue = frxUserDataSetConsDetailGetValue
    Left = 648
    Top = 216
  end
  object PopupMenuIntNoVoice: TPopupMenu
    AutoHotkeys = maManual
    OwnerDraw = True
    Left = 720
    Top = 216
    object IntNoVoice1: TMenuItem
      Tag = 1
      Caption = '1'#20803
      OnClick = IntNoVoice1Click
    end
    object IntNoVoice2: TMenuItem
      Tag = 2
      Caption = '2'#20803
      OnClick = IntNoVoice1Click
    end
    object IntNoVoice3: TMenuItem
      Tag = 3
      Caption = '3'#20803
      OnClick = IntNoVoice1Click
    end
    object IntNoVoice4: TMenuItem
      Tag = 4
      Caption = '4'#20803
      OnClick = IntNoVoice1Click
    end
    object IntNoVoice5: TMenuItem
      Tag = 5
      Caption = '5'#20803
      OnClick = IntNoVoice1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object IntNoVoice6: TMenuItem
      Tag = 6
      Caption = '6'#20803
      OnClick = IntNoVoice1Click
    end
    object IntNoVoice7: TMenuItem
      Tag = 7
      Caption = '7'#20803
      OnClick = IntNoVoice1Click
    end
    object IntNoVoice8: TMenuItem
      Tag = 8
      Caption = '8'#20803
      OnClick = IntNoVoice1Click
    end
    object IntNoVoice9: TMenuItem
      Tag = 9
      Caption = '9'#20803
      OnClick = IntNoVoice1Click
    end
  end
  object RzMenuController1: TRzMenuController
    Left = 808
    Top = 224
  end
end
