object FormAssetsManager: TFormAssetsManager
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #22266#23450#36164#20135#31649#29702
  ClientHeight = 690
  ClientWidth = 1221
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
    Top = 642
    Width = 1221
    Height = 48
    Align = alBottom
    BorderOuter = fsFlat
    BorderSides = [sdTop]
    FlatColorAdjustment = 0
    TabOrder = 0
    Transparent = True
    DesignSize = (
      1221
      48)
    object RzLabelRows: TRzLabel
      AlignWithMargins = True
      Left = 0
      Top = 1
      Width = 95
      Height = 47
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Align = alLeft
      Caption = #36164#20135#24635#39069#65306
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
      Left = 1112
      Top = 9
      Width = 100
      Height = 33
      Cancel = True
      Anchors = [akRight, akBottom]
      Caption = #20851#38381
      TabOrder = 0
      OnClick = RzButtonCancelClick
    end
    object RzButtonAdd: TRzButton
      Left = 794
      Top = 9
      Width = 100
      Height = 33
      FrameColor = 7617536
      Caption = #28155#21152
      Color = 15791348
      HotTrack = True
      TabOrder = 1
      OnClick = RzButtonAddClick
    end
    object RzButtonEdit: TRzButton
      Left = 900
      Top = 9
      Width = 100
      Height = 33
      Caption = #32534#36753
      TabOrder = 2
      OnClick = RzButtonEditClick
    end
    object RzButtonDel: TRzButton
      Left = 1006
      Top = 9
      Width = 100
      Height = 33
      Caption = #21024#38500
      TabOrder = 3
      OnClick = RzButtonDelClick
    end
  end
  object RzListView: TRzListView
    AlignWithMargins = True
    Left = 1
    Top = 1
    Width = 1219
    Height = 640
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
        Caption = #36164#20135#21517#31216
        Width = 150
      end
      item
        Alignment = taCenter
        Caption = #25968#37327
      end
      item
        Alignment = taCenter
        Caption = #21333#20301
      end
      item
        Alignment = taRightJustify
        Caption = #21333#20215
        Width = 90
      end
      item
        Alignment = taCenter
        Caption = #36141#20837#26102#38388
        Width = 170
      end
      item
        Caption = #36164#20135#35828#26126
        Width = 250
      end
      item
        Caption = #20379#24212#21830#20449#24687
        Width = 350
      end>
    FillLastColumn = False
    FlatScrollBars = True
    GridLines = True
    HideSelection = False
    HotTrack = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnDblClick = RzListViewDblClick
  end
  object ImageList1: TImageList
    Left = 344
    Top = 352
  end
end
