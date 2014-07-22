object FormSellerManager: TFormSellerManager
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #37319#36141#20379#24212#21830#31649#29702
  ClientHeight = 422
  ClientWidth = 599
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
  object RzListView: TRzListView
    AlignWithMargins = True
    Left = 1
    Top = 1
    Width = 597
    Height = 372
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alClient
    BorderStyle = bsNone
    Columns = <
      item
        Caption = #24207#21495
        Width = 80
      end
      item
        Caption = #20379#24212#21830#30005#35805
        Width = 120
      end
      item
        Caption = #20379#24212#21830#21517#31216
        Width = 350
      end>
    FlatScrollBars = True
    GridLines = True
    HideSelection = False
    HotTrack = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    ExplicitLeft = -237
    ExplicitTop = -23
    ExplicitWidth = 836
    ExplicitHeight = 445
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 374
    Width = 599
    Height = 48
    Align = alBottom
    BorderOuter = fsFlat
    BorderSides = [sdTop]
    FlatColorAdjustment = 0
    TabOrder = 1
    Transparent = True
    ExplicitLeft = -239
    ExplicitWidth = 838
    DesignSize = (
      599
      48)
    object RzButtonCancel: TRzButton
      Left = 510
      Top = 9
      Width = 80
      Height = 30
      Cancel = True
      Anchors = [akRight, akBottom]
      Caption = #20851#38381
      TabOrder = 2
      OnClick = RzButtonCancelClick
      ExplicitLeft = 749
    end
    object RzButtonDel: TRzButton
      Left = 424
      Top = 9
      Width = 80
      Height = 30
      Cancel = True
      Anchors = [akRight, akBottom]
      Caption = #21024#38500
      TabOrder = 1
      OnClick = RzButtonDelClick
      ExplicitLeft = 663
    end
    object RzButtonAdd: TRzButton
      Left = 338
      Top = 9
      Width = 80
      Height = 30
      Cancel = True
      Anchors = [akRight, akBottom]
      Caption = #28155#21152
      TabOrder = 0
      OnClick = RzButtonAddClick
      ExplicitLeft = 577
    end
    object RzButtonSumPay: TRzButton
      Left = 252
      Top = 9
      Width = 80
      Height = 30
      Cancel = True
      Anchors = [akRight, akBottom]
      Caption = #32467#31639
      TabOrder = 3
      OnClick = RzButtonSumPayClick
    end
  end
  object ImageList1: TImageList
    Left = 224
    Top = 512
  end
end
