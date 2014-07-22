object FormStoreDetail: TFormStoreDetail
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #24211#23384#26126#32454
  ClientHeight = 571
  ClientWidth = 864
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
  object RzGroupBox1: TRzGroupBox
    Left = 8
    Top = 8
    Width = 848
    Height = 219
    Caption = #24211#23384#21830#21697#20837#24211#25209#27425
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #24494#36719#38597#40657
    Font.Style = [fsBold]
    GroupStyle = gsUnderline
    ParentFont = False
    TabOrder = 0
    object RzListView: TRzListView
      AlignWithMargins = True
      Left = 1
      Top = 26
      Width = 846
      Height = 192
      Margins.Left = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alClient
      Columns = <
        item
          Caption = #24207#21495
        end
        item
          Caption = #21830#21697#21517#31216
          Width = 120
        end
        item
          Alignment = taCenter
          Caption = #20837#24211#37327
          Width = 60
        end
        item
          Alignment = taRightJustify
          Caption = #20837#24211#21333#20215
          Width = 60
        end
        item
          Alignment = taCenter
          Caption = #24211#23384#37327
          Width = 60
        end
        item
          Caption = #21697#29260
          Width = 100
        end
        item
          Alignment = taCenter
          Caption = #20837#24211#26085#26399
          Width = 100
        end
        item
          Alignment = taCenter
          Caption = #36807#26399#26085#26399
          Width = 100
        end
        item
          Caption = #22791#27880
          Width = 160
        end>
      FillLastColumn = False
      FlatScrollBars = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      GridLines = True
      HideSelection = False
      HotTrack = True
      ParentFont = False
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnChange = RzListViewChange
    end
  end
  object RzGroupBox2: TRzGroupBox
    Left = 8
    Top = 235
    Width = 848
    Height = 294
    Caption = #24211#23384#21830#21697#20986#24211#35760#24405
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #24494#36719#38597#40657
    Font.Style = [fsBold]
    GroupStyle = gsUnderline
    ParentFont = False
    TabOrder = 1
    object RzListView1: TRzListView
      AlignWithMargins = True
      Left = 1
      Top = 26
      Width = 846
      Height = 267
      Margins.Left = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alClient
      Columns = <
        item
          Caption = #39046#26009#37096#38376
          Width = 100
        end
        item
          Caption = #39046#26009#20154
          Width = 150
        end
        item
          Alignment = taRightJustify
          Caption = #20986#24211#25968#37327
          Width = 150
        end
        item
          Alignment = taCenter
          Caption = #20986#24211#26102#38388
          Width = 180
        end>
      FillLastColumn = False
      FlatScrollBars = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      GridLines = True
      HideSelection = False
      HotTrack = True
      ParentFont = False
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object RzButton1: TRzButton
    Left = 768
    Top = 538
    Width = 88
    Height = 28
    Cancel = True
    Caption = #20851#38381
    TabOrder = 2
    OnClick = RzButton1Click
  end
  object ImageList1: TImageList
    Left = 712
    Top = 224
  end
end
