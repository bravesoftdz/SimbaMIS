object FormMemberInvoice: TFormMemberInvoice
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #20250#21592#20805#20540#21457#31080#31649#29702
  ClientHeight = 474
  ClientWidth = 723
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
  object RzPanel1: TRzPanel
    Left = 0
    Top = 424
    Width = 723
    Height = 50
    Align = alBottom
    BorderOuter = fsFlat
    BorderSides = [sdTop]
    TabOrder = 0
    DesignSize = (
      723
      50)
    object RzLabelTotal: TRzLabel
      AlignWithMargins = True
      Left = 0
      Top = 1
      Width = 125
      Height = 49
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Align = alLeft
      Caption = #21487#29992#39069#24230#21512#35745#65306
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
    object RzButtonCancel: TRzButton
      Left = 609
      Top = 8
      Width = 100
      Height = 33
      Cancel = True
      Anchors = [akRight, akBottom]
      Caption = #20851#38381
      TabOrder = 0
      OnClick = RzButtonCancelClick
    end
    object RzButtonInvoice: TRzButton
      Left = 503
      Top = 8
      Width = 100
      Height = 33
      Anchors = [akRight, akBottom]
      Caption = #34917#24320#21457#31080
      TabOrder = 1
      OnClick = RzButtonInvoiceClick
    end
    object RzButtonInvoiceLog: TRzButton
      Left = 397
      Top = 8
      Width = 100
      Height = 33
      Anchors = [akRight, akBottom]
      Caption = #24320#31080#35760#24405
      TabOrder = 2
      OnClick = RzButtonInvoiceLogClick
    end
  end
  object RzListView: TRzListView
    AlignWithMargins = True
    Left = 1
    Top = 1
    Width = 721
    Height = 422
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alClient
    BorderStyle = bsNone
    Columns = <
      item
        Caption = #24207#21495
      end
      item
        Alignment = taCenter
        Caption = #20250#21592#21345#21495
        Width = 120
      end
      item
        Alignment = taRightJustify
        Caption = #20805#20540#37329#39069
        Width = 80
      end
      item
        Alignment = taCenter
        Caption = #20805#20540#26085#26399
        Width = 180
      end
      item
        Alignment = taRightJustify
        Caption = #24050#24320#31080#37329#39069
        Width = 120
      end
      item
        Alignment = taRightJustify
        Caption = #21097#20313#21457#31080#39069#24230
        Width = 154
      end>
    FlatScrollBars = True
    GridLines = True
    HideSelection = False
    HotTrack = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnChange = RzListViewChange
    OnColumnClick = RzListViewColumnClick
    OnDblClick = RzListViewDblClick
  end
  object ImageList1: TImageList
    Left = 344
    Top = 352
  end
end
