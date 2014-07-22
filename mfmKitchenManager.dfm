object FormKitchenManager: TFormKitchenManager
  Left = 0
  Top = 0
  Caption = #21416#25151#20986#21697#31649#29702#31995#32479
  ClientHeight = 569
  ClientWidth = 1356
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 17
  object RzPanel2: TRzPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1350
    Height = 563
    Align = alClient
    BorderOuter = fsNone
    TabOrder = 0
    object RzPanelLeft: TRzPanel
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 721
      Height = 563
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 0
      Align = alLeft
      BorderOuter = fsNone
      TabOrder = 0
      object RzListView: TRzListView
        Left = 0
        Top = 0
        Width = 721
        Height = 514
        Margins.Left = 0
        Margins.Top = 8
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        Columns = <
          item
            Caption = #24207#21495
            Width = 40
          end
          item
            Alignment = taCenter
            Caption = #21488#20301
            Width = 60
          end
          item
            Alignment = taCenter
            Caption = #25968#37327
            Width = 60
          end
          item
            Caption = #33756#21517
            Width = 260
          end
          item
            Alignment = taCenter
            Caption = #28857#33756#26102#38388
            Width = 170
          end
          item
            Alignment = taCenter
            Caption = #26381#21153#21592
            Width = 110
          end>
        FlatScrollBars = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        GridLines = True
        HideSelection = False
        ParentFont = False
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnAdvancedCustomDrawItem = RzListViewAdvancedCustomDrawItem
        OnDblClick = RzListViewDblClick
      end
      object RzPanel4: TRzPanel
        Left = 0
        Top = 514
        Width = 721
        Height = 49
        Align = alBottom
        BorderOuter = fsFlat
        BorderSides = [sdLeft, sdRight, sdBottom]
        Color = clWhite
        FlatColorAdjustment = 0
        TabOrder = 1
        DesignSize = (
          721
          49)
        object RzToolButtonPassOver: TRzToolButton
          Left = 6
          Top = 10
          Width = 85
          Height = 30
          GradientColorStyle = gcsSystem
          ShowCaption = True
          UseToolbarButtonSize = False
          UseToolbarShowCaption = False
          UseToolbarVisualStyle = False
          VisualStyle = vsGradient
          Caption = #33756#21697#24050#20986
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
          OnClick = RzToolButtonPassOverClick
        end
        object RzToolButton1: TRzToolButton
          Left = 580
          Top = 10
          Width = 125
          Height = 30
          GradientColorStyle = gcsSystem
          ShowCaption = True
          UseToolbarButtonSize = False
          UseToolbarShowCaption = False
          UseToolbarVisualStyle = False
          VisualStyle = vsGradient
          Anchors = [akRight, akBottom]
          Caption = #25171#24320#21416#25151#23637#31034#23631
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
          OnClick = RzToolButton1Click
          ExplicitLeft = 612
        end
        object RzToolButtonTuiCai: TRzToolButton
          Left = 97
          Top = 10
          Width = 85
          Height = 30
          GradientColorStyle = gcsSystem
          ShowCaption = True
          UseToolbarButtonSize = False
          UseToolbarShowCaption = False
          UseToolbarVisualStyle = False
          VisualStyle = vsGradient
          Caption = #36864#33756
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
          OnClick = RzToolButtonTuiCaiClick
        end
      end
    end
    object RzPanelRight: TRzPanel
      AlignWithMargins = True
      Left = 723
      Top = 0
      Width = 627
      Height = 563
      Margins.Left = 1
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      BorderOuter = fsNone
      TabOrder = 1
      object RzListView1: TRzListView
        Left = 0
        Top = 0
        Width = 627
        Height = 514
        Margins.Left = 0
        Margins.Top = 8
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        Columns = <
          item
            Caption = #24207#21495
            Width = 40
          end
          item
            Caption = #21488#20301
            Width = 60
          end
          item
            Alignment = taCenter
            Caption = #25968#37327
            Width = 60
          end
          item
            Caption = #33756#21517
            Width = 260
          end
          item
            Alignment = taCenter
            Caption = #28857#33756#26102#38388
            Width = 170
          end
          item
            Alignment = taCenter
            Caption = #26381#21153#21592
            Width = 16
          end>
        FlatScrollBars = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        GridLines = True
        HideSelection = False
        ParentFont = False
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnAdvancedCustomDrawItem = RzListView1AdvancedCustomDrawItem
        OnDblClick = RzListViewDblClick
      end
      object RzPanel3: TRzPanel
        Left = 0
        Top = 514
        Width = 627
        Height = 49
        Align = alBottom
        BorderOuter = fsFlat
        BorderSides = [sdLeft, sdRight, sdBottom]
        Color = clWhite
        FlatColorAdjustment = 0
        TabOrder = 1
        object RzToolButtonPassOver1: TRzToolButton
          Left = 6
          Top = 10
          Width = 85
          Height = 30
          GradientColorStyle = gcsSystem
          ShowCaption = True
          UseToolbarButtonSize = False
          UseToolbarShowCaption = False
          UseToolbarVisualStyle = False
          VisualStyle = vsGradient
          Caption = #33756#21697#24050#20986
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
          OnClick = RzToolButtonPassOver1Click
        end
        object RzToolButtonTuiCai1: TRzToolButton
          Left = 97
          Top = 10
          Width = 85
          Height = 30
          GradientColorStyle = gcsSystem
          ShowCaption = True
          UseToolbarButtonSize = False
          UseToolbarShowCaption = False
          UseToolbarVisualStyle = False
          VisualStyle = vsGradient
          Caption = #36864#33756
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
          OnClick = RzToolButtonTuiCai1Click
        end
      end
    end
  end
  object ImageList1: TImageList
    Left = 80
    Top = 464
  end
  object Timer1: TTimer
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 32
    Top = 464
  end
end
