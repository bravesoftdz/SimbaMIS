object FormBarManager: TFormBarManager
  Left = 0
  Top = 0
  Caption = #21543#21488#20986#21697#31649#29702#31995#32479
  ClientHeight = 581
  ClientWidth = 1021
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  object RzPanel2: TRzPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 1015
    Height = 575
    Align = alClient
    BorderOuter = fsNone
    TabOrder = 0
    object RzPanel4: TRzPanel
      Left = 0
      Top = 526
      Width = 1015
      Height = 49
      Align = alBottom
      BorderOuter = fsFlat
      BorderSides = [sdLeft, sdRight, sdBottom]
      Color = clWhite
      FlatColorAdjustment = 0
      TabOrder = 0
      DesignSize = (
        1015
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
      object RzToolButtonCold: TRzToolButton
        Left = 882
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
        Caption = #25171#24320#20937#33756#38388#23637#31034#23631
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        OnClick = RzToolButtonColdClick
      end
    end
    object RzListView: TRzListView
      Left = 0
      Top = 0
      Width = 1015
      Height = 526
      Margins.Left = 0
      Margins.Top = 8
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      Columns = <
        item
          Caption = #24207#21495
          Width = 100
        end
        item
          Alignment = taCenter
          Caption = #21488#20301
          Width = 100
        end
        item
          Alignment = taCenter
          Caption = #25968#37327
          Width = 100
        end
        item
          Caption = #33756#21517
          Width = 300
        end
        item
          Alignment = taCenter
          Caption = #28857#33756#26102#38388
          Width = 170
        end
        item
          Alignment = taCenter
          Caption = #26381#21153#21592
          Width = 224
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
      TabOrder = 1
      ViewStyle = vsReport
      OnAdvancedCustomDrawItem = RzListViewAdvancedCustomDrawItem
      OnDblClick = RzListViewDblClick
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
