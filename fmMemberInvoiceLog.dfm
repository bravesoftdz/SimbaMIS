object FormMemberInvoiceLog: TFormMemberInvoiceLog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #21457#31080#35760#24405
  ClientHeight = 290
  ClientWidth = 514
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
    Width = 512
    Height = 238
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
        Alignment = taRightJustify
        Caption = #24320#31080#37329#39069
        Width = 120
      end
      item
        Alignment = taCenter
        Caption = #24320#31080#26102#38388
        Width = 180
      end
      item
        Caption = #24320#31080#20154
        Width = 115
      end>
    FlatScrollBars = True
    GridLines = True
    HideSelection = False
    HotTrack = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    ExplicitWidth = 413
    ExplicitHeight = 195
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 240
    Width = 514
    Height = 50
    Align = alBottom
    BorderOuter = fsFlat
    BorderSides = [sdTop]
    TabOrder = 1
    ExplicitTop = 197
    ExplicitWidth = 415
    DesignSize = (
      514
      50)
    object RzButtonCancel: TRzButton
      Left = 400
      Top = 8
      Width = 100
      Height = 33
      Cancel = True
      Anchors = [akRight, akBottom]
      Caption = #20851#38381
      TabOrder = 0
      OnClick = RzButtonCancelClick
      ExplicitLeft = 301
    end
  end
  object ImageList1: TImageList
    Left = 344
    Top = 352
  end
end
