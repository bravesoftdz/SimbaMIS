unit fmMenuInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mysql, StdCtrls, RzCmboBx, Mask, RzEdit, RzButton, ExtCtrls, RzPanel,
  RzLabel, pngimage, comCtrls, RzListVw, RzRadChk, RzSpnEdt, RzBckgnd, StrUtils;

type
  TFormMenuInfo = class(TForm)
    Image1: TImage;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButtonCancel: TRzButton;
    RzLabel13: TRzLabel;
    RzNumericPrice: TRzNumericEdit;
    RzNumericSalePrice: TRzNumericEdit;
    RzEditName: TRzEdit;
    RzEditEName: TRzEdit;
    RzEditUnit: TRzEdit;
    RzEditDesc: TRzEdit;
    RzEditNut: TRzEdit;
    RzComboBoxMainType: TRzComboBox;
    RzComboBoxSubType: TRzComboBox;
    RzEditIdx: TRzNumericEdit;
    RzLabel11: TRzLabel;
    RzNumericEditAward: TRzNumericEdit;
    RzLabel14: TRzLabel;
    RzLabel15: TRzLabel;
    RzLabel16: TRzLabel;
    RzLabel17: TRzLabel;
    RzEditFeature: TRzEdit;
    RzLabel18: TRzLabel;
    RzComboBoxMakeFrom: TRzComboBox;
    RzLabel19: TRzLabel;
    RzCheckBoxShowInMenu: TRzCheckBox;
    RzLabel20: TRzLabel;
    RzListViewSubItem: TRzListView;
    RzLabel21: TRzLabel;
    RzListViewFreeItem: TRzListView;
    RzURLLabel1: TRzURLLabel;
    RzURLLabel2: TRzURLLabel;
    RzURLLabel3: TRzURLLabel;
    RzURLLabel4: TRzURLLabel;
    RzLabel22: TRzLabel;
    RzLabel23: TRzLabel;
    RzURLLabel5: TRzURLLabel;
    RzURLLabel6: TRzURLLabel;
    RzListViewSelectItem: TRzListView;
    RzCheckBoxCanRate: TRzCheckBox;
    RzLabel25: TRzLabel;
    RzLabel26: TRzLabel;
    RzCheckBoxShowInPhone: TRzCheckBox;
    RzSeparator1: TRzSeparator;
    RzSeparator2: TRzSeparator;
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
    procedure RzComboBoxMainTypeChange(Sender: TObject);
    procedure RzComboBoxSubTypeChange(Sender: TObject);
    procedure RzEditIdxExit(Sender: TObject);
    procedure RzNumericSalePriceChange(Sender: TObject);
    procedure RzURLLabel1Click(Sender: TObject);
    procedure RzURLLabel2Click(Sender: TObject);
    procedure RzURLLabel3Click(Sender: TObject);
    procedure RzURLLabel4Click(Sender: TObject);
    procedure RzURLLabel5Click(Sender: TObject);
    procedure RzURLLabel6Click(Sender: TObject);
  private
    cmdAction: string;
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure AddMenuItemToViewList(ListView: TRzListView; IsItem: boolean);
    function getFreeItemIdx: string;
    function getSelectItemIdx: string;
    function getSubItemIdx: string;
    procedure initMenuMainType;
    procedure loadFreeItemIdx(freeidx: string);
    procedure loadMenuItemData;
    procedure loadSelectIdx(selectidx: string);
    procedure loadSubItemIdx(subidx: string);
    { Private declarations }
  public
    editMenuIdx:Integer;
    procedure setControlStatus(action: string);
    { Public declarations }
  end;

var
  FormMenuInfo: TFormMenuInfo;

implementation

uses myfunction, dbfunction, fmMenuManager, fmSelectMenus;

{$R *.dfm}

procedure TFormMenuInfo.AddMenuItemToViewList(ListView: TRzListView; IsItem: boolean);
var
  f:TFormSelectMenus;
begin
  f:=TFormSelectMenus.Create(self,ListView, IsItem);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMenuInfo.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormMenuInfo.FormActivate(Sender: TObject);
begin
  if self.RzComboBoxMainType.ReadOnly then
    self.RzEditName.SetFocus
  else
    self.RzComboBoxMainType.SetFocus;
end;

procedure TFormMenuInfo.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  initMenuMainType;
end;

function TFormMenuInfo.getFreeItemIdx: string;
var
  item:TListItem;
  i:integer;
begin
  if self.RzListViewFreeItem.Items.Count>0 then begin
    for I := 0 to self.RzListViewFreeItem.Items.Count - 1 do begin
      item:=self.RzListViewFreeItem.Items.Item[I];
      if I=0 then begin
        Result := item.Caption;
      end else begin
        Result := Result + ',' + item.Caption;
      end;
    end;
  end else begin
    Result := '0';
  end;
end;

function TFormMenuInfo.getSelectItemIdx: string;
var
  item:TListItem;
  i:integer;
begin
  if self.RzListViewSelectItem.Items.Count>0 then begin
    for I := 0 to self.RzListViewSelectItem.Items.Count - 1 do begin
      item:=self.RzListViewSelectItem.Items.Item[I];
      if I=0 then begin
        Result := item.Caption;
      end else begin
        Result := Result + ',' + item.Caption;
      end;
    end;
  end else begin
    Result := '0';
  end;
end;

function TFormMenuInfo.getSubItemIdx: string;
var
  item:TListItem;
  i:integer;
begin
  if self.RzListViewSubItem.Items.Count>0 then begin
    for I := 0 to self.RzListViewSubItem.Items.Count - 1 do begin
      item:=self.RzListViewSubItem.Items.Item[I];
      if I=0 then begin
        Result := item.Caption;
      end else begin
        Result := Result + ',' + item.Caption;
      end;
    end;
  end else begin
    Result := '';
  end;
end;

procedure TFormMenuInfo.loadMenuItemData;
var
  sql,subidx,freeidx,selectidx: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  sql := Format('SELECT menuidx,mainidx,subidx,makefrom,itemname,ename,price,saleprice,award,itemunit,itemdesc,nutrition,feature,subitemidx,freeitemidx,selectidx,showinmenu,showinphone,canrate FROM menus WHERE menuidx=%d',[self.editMenuIdx]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      self.RzEditIdx.IntValue:=strtoint(getUTF8String(MYSQL_ROW^[0]));
      self.RzComboBoxMainType.Value:=inttostr(strtoint(getUTF8String(MYSQL_ROW^[1])));
      self.RzComboBoxMainTypeChange(self);
      self.RzComboBoxSubType.Value:=inttostr(strtoint(getUTF8String(MYSQL_ROW^[2])));
      self.RzComboBoxMakeFrom.Value:=inttostr(strtoint(getUTF8String(MYSQL_ROW^[3])));
      self.RzEditName.Text:=getUTF8String(MYSQL_ROW^[4]);
      self.RzEditEName.Text:=getUTF8String(MYSQL_ROW^[5]);
      self.RzNumericPrice.IntValue:=strtoint(getUTF8String(MYSQL_ROW^[6]));
      self.RzNumericSalePrice.IntValue:=strtoint(getUTF8String(MYSQL_ROW^[7]));
      self.RzNumericEditAward.IntValue:=strtoint(getUTF8String(MYSQL_ROW^[8]));
      self.RzEditUnit.Text:=getUTF8String(MYSQL_ROW^[9]);
      self.RzEditDesc.Text:=getUTF8String(MYSQL_ROW^[10]);
      self.RzEditNut.Text:=getUTF8String(MYSQL_ROW^[11]);
      self.RzEditFeature.Text:=getUTF8String(MYSQL_ROW^[12]);

      if getUTF8String(MYSQL_ROW^[16])='1' then
        self.RzCheckBoxShowInMenu.Checked:=true
      else
        self.RzCheckBoxShowInMenu.Checked:=false;

      if getUTF8String(MYSQL_ROW^[17])='1' then
        self.RzCheckBoxShowInPhone.Checked:=true
      else
        self.RzCheckBoxShowInPhone.Checked:=false;

      subidx:=getUTF8String(MYSQL_ROW^[13]);
      freeidx:=getUTF8String(MYSQL_ROW^[14]);
      selectidx:=getUTF8String(MYSQL_ROW^[15]);

      if getUTF8String(MYSQL_ROW^[18])='1' then
        self.RzCheckBoxCanRate.Checked:=true
      else
        self.RzCheckBoxCanRate.Checked:=false;

      loadSubItemIdx(subidx);
      loadFreeItemIdx(freeidx);
      loadSelectIdx(selectidx);

    end;
  end;
end;

procedure TFormMenuInfo.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormMenuInfo.initMenuMainType;
var
  accList:TStringList;
  i: Integer;
begin
  accList:=TStringList.Create;
  getSectionList('MENUTYPE', accList);
  for i := 0 to accList.Count - 1 do begin
    self.RzComboBoxMainType.AddItemValue(getMenuGroupTitle(strtoint(accList[i])),accList[i]);
  end;
  accList.Free;
end;

procedure TFormMenuInfo.loadFreeItemIdx(freeidx: string);
var
  sql,key: string;
  MYSQL_ROW: PMYSQL_ROW;
  item:TListItem;
  name:string;
  idx:integer;
  list:TStringList;
  i: Integer;
begin
  self.RzListViewFreeItem.Clear;
  list:=TStringList.Create;
  list.Delimiter:=',';
  list.DelimitedText:=freeidx;
  for i := 0 to list.Count - 1 do begin
    key:=list[i];
    sql := Format('select menuidx,itemname,price from menus where menuidx=%s',[key]);
    queryMySql(sql,LibHandle, mySQL_Res);
    if mySQL_Res<>nil then begin
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        name:=getUTF8String(MYSQL_ROW^[1])+'('+getUTF8String(MYSQL_ROW^[2])+')';
        idx:=strtoint(getUTF8String(MYSQL_ROW^[0]));
        item:=self.RzListViewFreeItem.Items.Add;
        item.Caption:=inttostr(idx);
        item.SubItems.Add(name);
      end;
    end;
  end;
  list.Free;
end;

procedure TFormMenuInfo.loadSubItemIdx(subidx: string);
var
  sql,key: string;
  MYSQL_ROW: PMYSQL_ROW;
  item:TListItem;
  name:string;
  idx:integer;
  list:TStringList;
  i: Integer;
begin
  self.RzListViewSubItem.Clear;
  list:=TStringList.Create;
  list.Delimiter:=',';
  list.DelimitedText:=subidx;
  for i := 0 to list.Count - 1 do begin
    key:=list[i];
    sql := Format('select menuidx,itemname,price from menus where menuidx=%s',[key]);
    queryMySql(sql,LibHandle, mySQL_Res);
    if mySQL_Res<>nil then begin
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        name:=getUTF8String(MYSQL_ROW^[1])+'('+getUTF8String(MYSQL_ROW^[2])+')';
        idx:=strtoint(getUTF8String(MYSQL_ROW^[0]));
        item:=self.RzListViewSubItem.Items.Add;
        item.Caption:=inttostr(idx);
        item.SubItems.Add(name);
      end;
    end;
  end;
  list.Free;
end;

procedure TFormMenuInfo.loadSelectIdx(selectidx: string);
var
  sql,key,keyid: string;
  MYSQL_ROW: PMYSQL_ROW;
  item:TListItem;
  name:string;
  list,listid:TStringList;
  i,j: Integer;
begin
  self.RzListViewSelectItem.Clear;
  listid:=TStringList.Create;
  list:=TStringList.Create;

  list.Delimiter:=',';
  list.DelimitedText:=selectidx;

  for j := 0 to List.Count - 1 do begin
    name:='';
    keyid:=list[j];
    keyid:=MidStr(keyid,2,length(keyid)-3);

    listid.Delimiter:='|';
    listid.DelimitedText:=keyid;
    for i := 0 to listid.Count - 1 do begin
      key:=listid[i];
      sql := Format('select menuidx,itemname,price from menus where menuidx=%s',[key]);
      queryMySql(sql,LibHandle, mySQL_Res);
      if mySQL_Res<>nil then begin
        MYSQL_ROW := mysql_fetch_row(mySQL_Res);
        if MYSQL_ROW<>nil then begin
          if length(name)>0 then
            name:=name+','+getUTF8String(MYSQL_ROW^[1])+'('+getUTF8String(MYSQL_ROW^[2])+')'
          else
            name:=getUTF8String(MYSQL_ROW^[1])+'('+getUTF8String(MYSQL_ROW^[2])+')';
        end;
      end;
    end;
    item:=self.RzListViewSelectItem.Items.Add;
    item.Caption:=list[j];
    item.SubItems.Add(name);
  end;
  list.Free;
  listid.Free;
end;

procedure TFormMenuInfo.RzButtonOkClick(Sender: TObject);
var
  sql:string;
  f:TFormMenuManager;
  node,n:TTreeNode;
  md:TMenuData;
  show,phone,crate:integer;
  subidx,freeidx,selectidx:string;
begin
  if self.RzComboBoxMainType.Value='' then begin
    MessageBox(self.Handle,'请先选择菜品主类再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxMainType.SetFocus;
    exit;
  end;
  if self.RzComboBoxSubType.Value='' then begin
    MessageBox(self.Handle,'请先选择菜品子类再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxSubType.SetFocus;
    exit;
  end;
  if self.RzEditIdx.IntValue=0 then begin
    MessageBox(self.Handle,'请先输入菜品编号再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditIdx.SetFocus;
    exit;
  end;
  if self.RzComboBoxMakeFrom.Value='' then begin
    MessageBox(self.Handle,'请先选择出品工位再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzComboBoxMakeFrom.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditName.Text))=0 then begin
    MessageBox(self.Handle,'请先输入菜品名称再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditName.SetFocus;
    exit;
  end;
  if self.RzNumericPrice.IntValue=0 then begin
    MessageBox(self.Handle,'请先输入菜品价格再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzNumericPrice.SetFocus;
    exit;
  end;
  if length(trim(self.RzEditUnit.Text))=0 then begin
    MessageBox(self.Handle,'请先输入菜品单位再提交！','提示',MB_OK or MB_ICONWARNING);
    self.RzEditUnit.SetFocus;
    exit;
  end;

  if self.RzCheckBoxShowInMenu.Checked then
    show:=1
  else
    show:=0;

  if self.RzCheckBoxShowInPhone.Checked then
    phone:=1
  else
    phone:=0;

  if self.RzCheckBoxCanRate.Checked then
    crate:=1
  else
    crate:=0;

  subidx:=getSubItemIdx;
  freeidx:=getFreeItemIdx;
  selectidx:=getSelectItemIdx;

  if cmdAction='ADD' then begin
    sql := Format('INSERT INTO menus SET menuidx=%d,mainidx=%d,maindesc="%s",subidx=%d,subdesc="%s",makefrom=%d,itemname="%s",ename="%s",price=%d,saleprice=%d,award=%d,itemunit="%s",itemdesc="%s",feature="%s",nutrition="%s",showinmenu=%d,showinphone=%d',
      [ self.RzEditIdx.IntValue,
        strtoint(self.RzComboBoxMainType.Value),
        self.RzComboBoxMainType.Text,
        strtoint(self.RzComboBoxSubType.Value),
        self.RzComboBoxSubType.Text,
        strtoint(self.RzComboBoxMakeFrom.Value),
        trim(self.RzEditName.Text),
        trim(self.RzEditEName.Text),
        self.RzNumericPrice.IntValue,
        self.RzNumericSalePrice.IntValue,
        self.RzNumericEditAward.IntValue,
        trim(self.RzEditUnit.Text),
        trim(self.RzEditDesc.Text),
        trim(self.RzEditFeature.Text),
        trim(self.RzEditNut.Text),
        show,
        phone
      ]);
    execMySql(sql,LibHandle);

    if subidx='' then
      subidx:=inttostr(self.RzEditIdx.IntValue);

    sql := Format('UPDATE MENUS SET subitemidx="%s",freeitemidx="%s",selectidx="%s",canrate=%d where id=%d',
      [ subidx,
        freeidx,
        selectidx,
        crate,
        mysql_insert_id(LibHandle)
      ]);
    execMySql(sql,LibHandle);
  end else if cmdAction='EDIT' then begin
    sql := Format('UPDATE menus SET mainidx=%d,maindesc="%s",subidx=%d,subdesc="%s",makefrom=%d,itemname="%s",ename="%s",price=%d,saleprice=%d,award=%d,itemunit="%s",itemdesc="%s",nutrition="%s",feature="%s",showinmenu=%d,showinphone=%d WHERE menuidx=%d',
      [ strtoint(self.RzComboBoxMainType.Value),
        self.RzComboBoxMainType.Text,
        strtoint(self.RzComboBoxSubType.Value),
        self.RzComboBoxSubType.Text,
        strtoint(self.RzComboBoxMakeFrom.Value),
        trim(self.RzEditName.Text),
        trim(self.RzEditEName.Text),
        self.RzNumericPrice.IntValue,
        self.RzNumericSalePrice.IntValue,
        self.RzNumericEditAward.IntValue,
        trim(self.RzEditUnit.Text),
        trim(self.RzEditDesc.Text),
        trim(self.RzEditNut.Text),
        trim(self.RzEditFeature.Text),
        show,
        phone,
        self.editMenuIdx
      ]);
    execMySql(sql,LibHandle);

    if subidx='' then begin
      sql := Format('UPDATE MENUS SET subitemidx=menuidx,freeitemidx="%s",selectidx="%s",canrate=%d where menuidx=%d',
        [ freeidx,
          selectidx,
          crate,
          self.editMenuIdx
        ]);
    end else begin
      sql := Format('UPDATE MENUS SET subitemidx="%s",freeitemidx="%s",selectidx="%s",canrate=%d where menuidx=%d',
        [ subidx,
          freeidx,
          selectidx,
          crate,
          self.editMenuIdx
        ]);
    end;
    execMySql(sql,LibHandle);
  end;

  f:=TFormMenuManager(self.Owner);
  if cmdAction='ADD' then begin
    node:=f.getMenuItemNode(strtoint(RzComboBoxMainType.Value),strtoint(RzComboBoxSubType.Value));
    if node<>nil then begin
      n:=f.RzTreeViewMenuList.Items.AddChild(node,inttostr(RzEditIdx.IntValue)+':'+trim(self.RzEditName.Text));
      md:=TMenuData.Create;
      md.menuIdx:=RzEditIdx.IntValue;
      n.Data:=md;
      f.RzTreeViewMenuList.Selected:=n;
      f.RzTreeViewMenuListChange(f.RzTreeViewMenuList,n);
    end;
  end else if cmdAction='EDIT' then begin
    f.RzTreeViewMenuList.Selected.Text:=inttostr(self.editMenuIdx)+':'+trim(self.RzEditName.Text);
    f.RzTreeViewMenuListChange(f.RzTreeViewMenuList,f.RzTreeViewMenuList.Selected);
  end;

  self.Close;
end;

procedure TFormMenuInfo.RzComboBoxMainTypeChange(Sender: TObject);
var
  ts:TStringList;
  i:integer;
begin
  self.RzComboBoxSubType.Values.Clear;
  self.RzComboBoxSubType.Items.Clear;
  ts:=TStringList.Create;
  getMenuSubItems(strtoint(RzComboBoxMainType.Value),ts);
  for i := 0 to ts.Count - 1 do begin
    self.RzComboBoxSubType.AddItemValue(getMenuSubGroupTitle(strtoint(RzComboBoxMainType.Value),strtoint(ts[i])),ts[i]);
  end;
  self.RzComboBoxSubType.Value:='';
  if not self.RzEditIdx.ReadOnly then
    self.RzEditIdx.IntValue:=0;
  ts.Free;
end;

procedure TFormMenuInfo.RzComboBoxSubTypeChange(Sender: TObject);
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  max,min:integer;
begin
  min:=strtoint(RzComboBoxSubType.Value) * 100;
  max:=min+99;
  sql := Format('SELECT menuidx FROM menus WHERE menuidx>%d and menuidx<%d order by menuidx desc limit 0,1',[min,max]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      self.RzEditIdx.IntValue:= strtoint(getUTF8String(MYSQL_ROW^[0]))+1;
    end else begin
      self.RzEditIdx.IntValue:=min+1;
    end;
  end;
end;

procedure TFormMenuInfo.RzEditIdxExit(Sender: TObject);
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  if self.RzEditIdx.IntValue=0 then
    exit;
  if self.RzEditIdx.ReadOnly then
    exit;

  sql := Format('SELECT menuidx FROM menus WHERE menuidx=%d',[rzEditIdx.IntValue]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin
      MessageBox(self.Handle,PWideChar('编号为:'+inttostr(rzEditIdx.IntValue)+'的菜品已经存在，请重新输入菜品编号!'),'提示',MB_OK or MB_ICONWARNING);
      self.RzEditIdx.SetFocus;
    end;
  end;
end;

procedure TFormMenuInfo.RzNumericSalePriceChange(Sender: TObject);
begin
  if self.RzNumericSalePrice.IntValue>0 then
    self.RzCheckBoxCanRate.Checked:=false
  else
    self.RzCheckBoxCanRate.Checked:=true;
end;

procedure TFormMenuInfo.RzURLLabel1Click(Sender: TObject);
begin
  self.AddMenuItemToViewList(Self.RzListViewSubItem,true);
end;

procedure TFormMenuInfo.RzURLLabel2Click(Sender: TObject);
begin
  if self.RzListViewSubItem.Selected<>nil then
    self.RzListViewSubItem.Selected.Delete;
end;

procedure TFormMenuInfo.RzURLLabel3Click(Sender: TObject);
begin
  self.AddMenuItemToViewList(Self.RzListViewFreeItem,true);
end;

procedure TFormMenuInfo.RzURLLabel4Click(Sender: TObject);
begin
  if self.RzListViewFreeItem.Selected<>nil then
    self.RzListViewFreeItem.Selected.Delete;
end;

procedure TFormMenuInfo.RzURLLabel5Click(Sender: TObject);
begin
  self.AddMenuItemToViewList(Self.RzListViewSelectItem,false);
end;

procedure TFormMenuInfo.RzURLLabel6Click(Sender: TObject);
begin
  if self.RzListViewSelectItem.Selected<>nil then
    self.RzListViewSelectItem.Selected.Delete;
end;

procedure TFormMenuInfo.setControlStatus(action: string);
begin
  self.cmdAction:=action;
  if action='ADD' then begin
    self.Caption:='添加菜品';
    self.RzButtonOk.Caption:='添加';
    self.RzEditIdx.ReadOnly:=false;
    self.RzComboBoxMainType.ReadOnly:=false;
    self.RzComboBoxSubType.ReadOnly:=false;
  end else if action='EDIT' then begin
    self.Caption:='编辑菜品';
    self.RzButtonOk.Caption:='编辑';
    self.RzEditIdx.ReadOnly:=true;
    self.RzComboBoxMainType.ReadOnly:=true;
    self.RzComboBoxSubType.ReadOnly:=true;
    self.RzEditIdx.IntValue:=self.editMenuIdx;
    loadMenuItemData;
  end;
end;

end.
