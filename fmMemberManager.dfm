object FormMemberManager: TFormMemberManager
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #20250#21592#31649#29702#31995#32479
  ClientHeight = 672
  ClientWidth = 1199
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 17
  object RzListView: TRzListView
    AlignWithMargins = True
    Left = 1
    Top = 82
    Width = 1197
    Height = 549
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
        Caption = #21345#21495
        Width = 80
      end
      item
        Caption = #22995#21517
        Width = 80
      end
      item
        Alignment = taCenter
        Caption = #24615#21035
      end
      item
        Alignment = taCenter
        Caption = #25163#26426#21495
        Width = 100
      end
      item
        Alignment = taCenter
        Caption = #25240#25187#29575
      end
      item
        Alignment = taRightJustify
        Caption = #20313#39069
        Width = 80
      end
      item
        Alignment = taRightJustify
        Caption = #31215#20998
        Width = 80
      end
      item
        Alignment = taCenter
        Caption = #29366#24577
        Width = 80
      end
      item
        Alignment = taCenter
        Caption = #20837#20250#26102#38388
        Width = 150
      end
      item
        Alignment = taCenter
        Caption = #26368#21518#28040#36153#26102#38388
        Width = 150
      end
      item
        Caption = #36890#20449#22320#22336
        Width = 230
      end>
    FlatScrollBars = True
    GridLines = True
    HideSelection = False
    HotTrack = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnChange = RzListViewChange
    OnColumnClick = RzListViewColumnClick
    OnDblClick = RzListViewDblClick
  end
  object RzPanel1: TRzPanel
    Left = 0
    Top = 632
    Width = 1199
    Height = 40
    Align = alBottom
    BorderOuter = fsFlat
    BorderSides = [sdTop]
    FlatColorAdjustment = 0
    TabOrder = 1
    Transparent = True
    object RzToolButtonMemberAdd: TRzToolButton
      AlignWithMargins = True
      Left = 3
      Top = 6
      Width = 80
      Height = 30
      Margins.Top = 5
      Margins.Bottom = 4
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alLeft
      Caption = #28155#21152
      OnClick = RzToolButtonMemberAddClick
      ExplicitLeft = 5
      ExplicitTop = 4
      ExplicitHeight = 28
    end
    object RzLabelTotal: TRzLabel
      AlignWithMargins = True
      Left = 1084
      Top = 1
      Width = 95
      Height = 39
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Align = alRight
      Caption = #20313#39069#21512#35745#65306
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
      ExplicitLeft = 1049
    end
    object RzLabelTableName: TRzLabel
      AlignWithMargins = True
      Left = 984
      Top = 1
      Width = 80
      Height = 39
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 20
      Margins.Bottom = 0
      Align = alRight
      Caption = #20250#21592#25968#65306
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
      ExplicitLeft = 964
    end
    object RzToolButtonMemberPutMoney: TRzToolButton
      AlignWithMargins = True
      Left = 89
      Top = 6
      Width = 80
      Height = 30
      Margins.Top = 5
      Margins.Bottom = 4
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alLeft
      Caption = #20805#20540
      OnClick = RzToolButtonMemberPutMoneyClick
      ExplicitLeft = 61
      ExplicitTop = 5
    end
    object RzToolButtonMemberEdit: TRzToolButton
      AlignWithMargins = True
      Left = 261
      Top = 6
      Width = 80
      Height = 30
      Margins.Top = 5
      Margins.Bottom = 4
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alLeft
      Caption = #32534#36753
      OnClick = RzToolButtonMemberEditClick
      ExplicitLeft = 147
      ExplicitTop = 5
    end
    object RzToolButtonMemberReadd: TRzToolButton
      AlignWithMargins = True
      Left = 519
      Top = 6
      Width = 80
      Height = 30
      Margins.Top = 5
      Margins.Bottom = 4
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alLeft
      Caption = #34917#21345
      OnClick = RzToolButtonMemberReaddClick
      ExplicitLeft = 147
      ExplicitTop = 5
    end
    object RzToolButtonMemberDel: TRzToolButton
      AlignWithMargins = True
      Left = 347
      Top = 6
      Width = 80
      Height = 30
      Margins.Top = 5
      Margins.Bottom = 4
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alLeft
      Caption = #21024#38500
      OnClick = RzToolButtonMemberDelClick
      ExplicitLeft = 147
      ExplicitTop = 5
    end
    object RzToolButtonMemberMakeStatu: TRzToolButton
      AlignWithMargins = True
      Left = 433
      Top = 6
      Width = 80
      Height = 30
      Margins.Top = 5
      Margins.Bottom = 4
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alLeft
      Caption = #25346#22833
      OnClick = RzToolButtonMemberMakeStatuClick
      ExplicitLeft = 147
      ExplicitTop = 5
    end
    object RzToolButtonMemberDetail: TRzToolButton
      AlignWithMargins = True
      Left = 175
      Top = 6
      Width = 80
      Height = 30
      Margins.Top = 5
      Margins.Bottom = 4
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alLeft
      Caption = #26126#32454
      OnClick = RzToolButtonMemberDetailClick
      ExplicitTop = 14
    end
    object RzToolButtonInvoiceInfo: TRzToolButton
      AlignWithMargins = True
      Left = 605
      Top = 6
      Width = 80
      Height = 30
      Margins.Top = 5
      Margins.Bottom = 4
      GradientColorStyle = gcsSystem
      ShowCaption = True
      UseToolbarButtonSize = False
      UseToolbarShowCaption = False
      UseToolbarVisualStyle = False
      VisualStyle = vsGradient
      Align = alLeft
      Caption = #34917#24320#21457#31080
      OnClick = RzToolButtonInvoiceInfoClick
      ExplicitLeft = 631
      ExplicitTop = 5
    end
  end
  object RzPanel2: TRzPanel
    Left = 0
    Top = 0
    Width = 1199
    Height = 81
    Align = alTop
    BorderOuter = fsFlat
    BorderSides = [sdBottom]
    TabOrder = 2
    object Image1: TImage
      Left = 16
      Top = 9
      Width = 64
      Height = 64
      AutoSize = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000400000
        00400806000000AA6971DE0000001974455874536F6674776172650041646F62
        6520496D616765526561647971C9653C0000032469545874584D4C3A636F6D2E
        61646F62652E786D7000000000003C3F787061636B657420626567696E3D22EF
        BBBF222069643D2257354D304D7043656869487A7265537A4E54637A6B633964
        223F3E203C783A786D706D65746120786D6C6E733A783D2261646F62653A6E73
        3A6D6574612F2220783A786D70746B3D2241646F626520584D5020436F726520
        352E302D633036312036342E3134303934392C20323031302F31322F30372D31
        303A35373A30312020202020202020223E203C7264663A52444620786D6C6E73
        3A7264663D22687474703A2F2F7777772E77332E6F72672F313939392F30322F
        32322D7264662D73796E7461782D6E7323223E203C7264663A44657363726970
        74696F6E207264663A61626F75743D222220786D6C6E733A786D703D22687474
        703A2F2F6E732E61646F62652E636F6D2F7861702F312E302F2220786D6C6E73
        3A786D704D4D3D22687474703A2F2F6E732E61646F62652E636F6D2F7861702F
        312E302F6D6D2F2220786D6C6E733A73745265663D22687474703A2F2F6E732E
        61646F62652E636F6D2F7861702F312E302F73547970652F5265736F75726365
        526566232220786D703A43726561746F72546F6F6C3D2241646F62652050686F
        746F73686F70204353352E31204D6163696E746F73682220786D704D4D3A496E
        7374616E636549443D22786D702E6969643A3430383238373044354230443131
        4531393431394534424341463531373442312220786D704D4D3A446F63756D65
        6E7449443D22786D702E6469643A343038323837304535423044313145313934
        3139453442434146353137344231223E203C786D704D4D3A4465726976656446
        726F6D2073745265663A696E7374616E636549443D22786D702E6969643A3430
        3832383730423542304431314531393431394534424341463531373442312220
        73745265663A646F63756D656E7449443D22786D702E6469643A343038323837
        3043354230443131453139343139453442434146353137344231222F3E203C2F
        7264663A4465736372697074696F6E3E203C2F7264663A5244463E203C2F783A
        786D706D6574613E203C3F787061636B657420656E643D2272223F3E6CBD7636
        000005434944415478DAED9A6D88546514C7FFD775B5D274B3E80D2A5F4AB420
        2AB6C0C20AADC84CC25EC4CAA2902882DEA8A80C82FA2285BD28A21FC43E4429
        D4973E18A5245AC426BAF442D16E6D91954545D99659EEEEEC4EFF7FE7DCEEAC
        EEE89DE9CEDE3BE33DF06776662E779EE777CF79CE79CEB341B158C4E16C410E
        20079003487B0C39801C400E20079003C83C80D6D6D64AEE3B813A893A8E3ACA
        DFF753BF537F503F513F507FD56A62EDEDEDA900388B9A414DA24EA046530354
        F82323F49BD41EEA47EA736AAB03A96B0053A879D4993EE97E177CC281FF5D74
        200231B204461BB589FAA51E01CCA5AEA2C650BD54934FAEC7D58DC8D58FA65A
        A85154B35F0F87B68B5A477D5A2F0014DBD753B3604FBBE013D9ED93F884EAA4
        FEC6E0103816E629E750D34A4008CA3EEA556A4B3D00B895BACC07DDE49FC995
        DF842D70714C6BC6D50EA4C7EFA301ADA5DECF3200B9FC0D549F0F5A4FF9656A
        5B156395D75C475DBEDFFD9EA7BECA2280C9D483D411FE5E837D91FAA0DAC1C2
        1643019DE310140E5F522F507F660980067A1F2C7EC3056F0DAA7BF24399C26A
        96DF5B9EB19E7A2B4B0014ABF7FB471AE0BBB0784DCA94251E8115511AD86FD4
        13302FCB0480C5D4C5B0155F55DDD348BE88B984BA0DD17A20C06D5900700C5F
        1E823D1D0DEC1D58EC276DF28287A953606953E1B53A0B00A63B80B0B455ECEF
        A80100D94DD415FE3BDF51CB607B885401C835EF80C5A372FF63A872858E6117
        52B7C33C40BFF11CF54DDA0054B084B95F85CE9388EAFDA4ED34D862A8745874
        001D6903B8852FB37DD2CAD1CF0C0300ED29C63A807833AA2180857CB9729800
        9C4A3D0ADB278C76001FA50D40559A2028047E86E5E7428D004CA51E70007D0E
        A02B6D0017F1E52ED802A8413D056B6AD4C2146A37C22A4FADFECFC2B6CBA902
        50D3437B8051FED12B4860DB5AC6045A9D250DAECB01EC4B1BC01807A07697D2
        D3C7D40A241F06C7C3E27F3CACE052A7685DA537A955291C2E840A011544CBA9
        CF1206700D351F51B748F1DF99150027534B10B5B43A1C424F429357F9ABF4A7
        955F4F5FFD80A530D899002053992A2F5045A89EC04654E1A243D838EA5E5883
        350CAB95B050ABD86A09403D3DED094E8485823C416DB0D710F5FEAA99BC0AAD
        0B60DEA47B6A817DA95A9AB56E89A92F700F2C14540CA962DB4ABD8E0A372DB4
        89D422EA7444A124009B61992693006497FAC003872018CAD56F531FC2FA0507
        33AD27E7C31AAB2A777B4BBE0B1CAABA415579D6709D0B68D77633069F092845
        6A0BAB957B27F5BD5FAB85EC48D84277864BE1D4E7DF8FF48916FC3570A86F38
        84C0EF1DABFC1ECE8311F509AE8595AF617A6CF601F7954C10884E849A7DA2FD
        88CADDF7FCFDEC1208231C6A9BC353534665B8CE0E766705804C1E30D3073FC1
        273980A8793280E8882C40748E20AFD13E7F03A2D57E01ACED1EC29485DBE2A2
        03D399E22A58CF30130042D3533A8F3A1BD63A1BEF9F09909EEE5E58FAFC95FA
        1AD64AFF0207E6F9D21679B9DFE97408DD5902506A9A7C8B0F568B5CA104800E
        410F56DBCB4BD480D506ACB7CC352A96BA50C613B200E0FF9AD2ECB928EF05B2
        B29E50EF00B4463C0EEB0C1D6AB335A427D43B0085C09DB0341BE750E4004FA8
        7700326513F505A6C58430C8131A01804C79FF6E58D11467C7F99F271040778C
        EB330F40D6E210E27A8232CE7A02D8D02800649578C2BF5B740288B545AF1700
        B2389E1038809504B0BDD100C80EE5099ABC16C2E504B0A71101C886F2043D79
        65011DD5AB8BF46DA3648172167A821A330507A03D85FE4F69A72E68740032ED
        35B403553B4DCD53FD6BDEDEF0CBC40134AAE500720039801C40DA63C801E400
        72003980D4EC1F59E16C9F84E3DC7B0000000049454E44AE426082}
    end
    object RzLabel1: TRzLabel
      Left = 804
      Top = 15
      Width = 24
      Height = 17
      Caption = #22823#20110
    end
    object RzLabel2: TRzLabel
      Left = 892
      Top = 15
      Width = 36
      Height = 17
      Caption = #19988#23567#20110
    end
    object RzLabel3: TRzLabel
      Left = 940
      Top = 45
      Width = 36
      Height = 17
      Caption = #20043#21069#19988
    end
    object RzLabel4: TRzLabel
      Left = 1088
      Top = 45
      Width = 24
      Height = 17
      Caption = #20043#21518
    end
    object RzRadioButtonQuaCardNo: TRzRadioButton
      Left = 206
      Top = 14
      Width = 67
      Height = 19
      Caption = #21345#21495#21253#21547
      TabOrder = 0
      OnClick = RzRadioButtonQuaCardNoClick
    end
    object RzEditQuaCardNo: TRzEdit
      Left = 291
      Top = 12
      Width = 115
      Height = 25
      TabOrder = 1
      OnChange = RzEditQuaCardNoChange
    end
    object RzRadioButtonQuaCardName: TRzRadioButton
      Left = 427
      Top = 14
      Width = 67
      Height = 19
      Caption = #22995#21517#21253#21547
      TabOrder = 2
      OnClick = RzRadioButtonQuaCardNoClick
    end
    object RzEditQuaCardName: TRzEdit
      Left = 500
      Top = 12
      Width = 71
      Height = 25
      TabOrder = 3
      OnChange = RzEditQuaCardNoChange
    end
    object RzRadioButtonQuaCardSex: TRzRadioButton
      Left = 589
      Top = 14
      Width = 55
      Height = 19
      Caption = #24615#21035#26159
      TabOrder = 4
      OnClick = RzRadioButtonQuaCardNoClick
    end
    object RzComboBoxQuaCardSex: TRzComboBox
      Left = 665
      Top = 12
      Width = 68
      Height = 25
      Style = csDropDownList
      ItemHeight = 17
      TabOrder = 5
      OnChange = RzEditQuaCardNoChange
      Items.Strings = (
        #30007
        #22899)
    end
    object RzEditQuaCardTel: TRzEdit
      Left = 291
      Top = 42
      Width = 115
      Height = 25
      TabOrder = 6
      OnChange = RzEditQuaCardNoChange
    end
    object RzRadioButtonQuaCardTel: TRzRadioButton
      Left = 206
      Top = 44
      Width = 79
      Height = 19
      Caption = #25163#26426#21495#21253#21547
      TabOrder = 7
      OnClick = RzRadioButtonQuaCardNoClick
    end
    object RzRadioButtonQuaCardRate: TRzRadioButton
      Left = 589
      Top = 44
      Width = 67
      Height = 19
      Caption = #25240#25187#29575#26159
      TabOrder = 8
      OnClick = RzRadioButtonQuaCardNoClick
    end
    object RzComboBoxQuaCardRate: TRzComboBox
      Left = 665
      Top = 42
      Width = 68
      Height = 25
      Style = csDropDownList
      ItemHeight = 17
      TabOrder = 9
      OnChange = RzEditQuaCardNoChange
    end
    object RzRadioButtonQuaCardStatus: TRzRadioButton
      Left = 427
      Top = 44
      Width = 67
      Height = 19
      Caption = #21345#29366#24577#26159
      TabOrder = 10
      OnClick = RzRadioButtonQuaCardNoClick
    end
    object RzComboBoxQuaCardStatus: TRzComboBox
      Left = 500
      Top = 42
      Width = 71
      Height = 25
      Style = csDropDownList
      ItemHeight = 17
      TabOrder = 11
      OnChange = RzEditQuaCardNoChange
      Items.Strings = (
        #27491#24120
        #25346#22833)
    end
    object RzRadioButtonQuaCardOver: TRzRadioButton
      Left = 755
      Top = 14
      Width = 43
      Height = 19
      Caption = #20313#39069
      TabOrder = 12
      OnClick = RzRadioButtonQuaCardNoClick
    end
    object RzNumericEditQuaCardOver1: TRzNumericEdit
      Left = 834
      Top = 12
      Width = 51
      Height = 25
      TabOrder = 13
      OnChange = RzEditQuaCardNoChange
      DisplayFormat = '0;(0)'
    end
    object RzNumericEditQuaCardOver2: TRzNumericEdit
      Left = 932
      Top = 12
      Width = 51
      Height = 25
      TabOrder = 14
      OnChange = RzEditQuaCardNoChange
      DisplayFormat = '0;(0)'
    end
    object RzRadioButtonQuaCardTime: TRzRadioButton
      Left = 755
      Top = 44
      Width = 67
      Height = 19
      Caption = #20837#20250#26102#38388
      TabOrder = 15
      OnClick = RzRadioButtonQuaCardNoClick
    end
    object RzDateTimeQuaCardTime1: TRzDateTimeEdit
      Left = 834
      Top = 42
      Width = 100
      Height = 25
      CalendarElements = [ceYear, ceMonth, ceArrows, ceDaysOfWeek, ceFillDays, ceTodayButton]
      CaptionTodayBtn = #20170#22825
      EditType = etDate
      Format = 'yyyy-mm-dd'
      TabOrder = 16
      OnChange = RzEditQuaCardNoChange
    end
    object RzDateTimeQuaCardTime2: TRzDateTimeEdit
      Left = 982
      Top = 42
      Width = 100
      Height = 25
      CalendarElements = [ceYear, ceMonth, ceArrows, ceDaysOfWeek, ceFillDays, ceTodayButton]
      CaptionTodayBtn = #20170#22825
      EditType = etDate
      Format = 'yyyy-mm-dd'
      TabOrder = 17
      OnChange = RzEditQuaCardNoChange
    end
    object RzRadioButtonAll: TRzRadioButton
      Left = 102
      Top = 14
      Width = 67
      Height = 19
      Caption = #20840#37096#20250#21592
      Checked = True
      TabOrder = 18
      TabStop = True
      OnClick = RzRadioButtonQuaCardNoClick
    end
  end
  object ImageList1: TImageList
    Left = 344
    Top = 352
  end
end
