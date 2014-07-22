object FormOrderManager: TFormOrderManager
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #39044#35746#31649#29702
  ClientHeight = 496
  ClientWidth = 699
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
  object RzListView: TRzListView
    Left = 17
    Top = 16
    Width = 664
    Height = 409
    Columns = <
      item
        Caption = #32534#21495
      end
      item
        Alignment = taCenter
        Caption = #39044#35746#21488#20301#21495
        Width = 100
      end
      item
        Caption = #39044#35746#20154#22995#21517
        Width = 100
      end
      item
        Caption = #39044#35746#20154#30005#35805
        Width = 100
      end
      item
        Alignment = taCenter
        Caption = #20154#25968
      end
      item
        Alignment = taCenter
        Caption = #39044#35745#21040#24215#26102#38388
        Width = 243
      end>
    ColumnClick = False
    FlatScrollBars = True
    GridLines = True
    HideSelection = False
    HotTrack = True
    Items.ItemData = {
      03600000000200000000000000FFFFFFFFFFFFFFFF04000000FFFFFFFF000000
      0001610001620001630001640001650000000000FFFFFFFFFFFFFFFF04000000
      FFFFFFFF00000000014100014200014300014400014500FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF}
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object RzPanel2: TRzPanel
    Left = 0
    Top = 440
    Width = 699
    Height = 56
    Align = alBottom
    BorderOuter = fsFlat
    BorderSides = [sdTop]
    TabOrder = 1
    object RzButtonAdd: TRzButton
      Left = 16
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
    object RzButtonDel: TRzButton
      Left = 102
      Top = 12
      Width = 80
      Height = 33
      Caption = #21024#38500
      TabOrder = 1
      OnClick = RzButtonDelClick
    end
    object RzButtonClose: TRzButton
      Left = 601
      Top = 12
      Width = 80
      Height = 33
      Cancel = True
      Caption = #20851#38381
      TabOrder = 2
      OnClick = RzButtonCloseClick
    end
  end
  object ImageList1: TImageList
    Left = 280
    Top = 456
  end
end
