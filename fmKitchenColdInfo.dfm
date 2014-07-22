object FormKitchenColdInfo: TFormKitchenColdInfo
  Left = 0
  Top = 0
  Caption = #21416#25151#20937#33756#38388#20986#39184#23637#31034#23631
  ClientHeight = 536
  ClientWidth = 833
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  object RzListView: TRzListView
    Left = 0
    Top = 0
    Width = 833
    Height = 536
    Margins.Left = 0
    Align = alClient
    Columns = <
      item
        Caption = #32534#21495
        Width = 130
      end
      item
        Alignment = taCenter
        Caption = #21488#20301
        Width = 120
      end
      item
        Alignment = taCenter
        Caption = #28857#33756#26102#38388
        Width = 150
      end
      item
        Alignment = taCenter
        Caption = #25968#37327
        Width = 140
      end
      item
        Caption = #33756#21517
        Width = 272
      end>
    FlatScrollBars = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    GridLines = True
    HideSelection = False
    ParentFont = False
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsList
    OnAdvancedCustomDrawItem = RzListViewAdvancedCustomDrawItem
    ExplicitLeft = -105
    ExplicitTop = -13
    ExplicitWidth = 938
    ExplicitHeight = 549
  end
  object Timer1: TTimer
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 32
    Top = 464
  end
  object ImageList1: TImageList
    Left = 80
    Top = 464
  end
end
