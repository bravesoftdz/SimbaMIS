unit fmMenuManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ExtCtrls, RzPanel, ComCtrls, RzTreeVw, mysql, StdCtrls,
  RzLabel, RzListVw, RzRadChk, RzBckgnd, StrUtils;

type
  TFormMenuManager = class(TForm)
    RzTreeViewMenuList: TRzTreeView;
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzButtonAdd: TRzButton;
    RzButtonEdit: TRzButton;
    RzButtonDel: TRzButton;
    RzButtonClose: TRzButton;
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
    RzLabelIdx: TRzLabel;
    RzLabelMainType: TRzLabel;
    RzLabelSubType: TRzLabel;
    RzLabelName: TRzLabel;
    RzLabelEName: TRzLabel;
    RzLabelPrice: TRzLabel;
    RzLabelSalePrice: TRzLabel;
    RzLabelUnit: TRzLabel;
    RzLabelDesc: TRzLabel;
    RzLabelNut: TRzLabel;
    RzLabel12: TRzLabel;
    RzLabelAward: TRzLabel;
    RzLabel13: TRzLabel;
    RzLabelFeature: TRzLabel;
    RzLabel14: TRzLabel;
    RzLabelMakefrom: TRzLabel;
    RzLabel15: TRzLabel;
    RzLabel16: TRzLabel;
    RzListViewSubItem: TRzListView;
    RzListViewFreeItem: TRzListView;
    RzLabel17: TRzLabel;
    RzCheckBoxShowInMenu: TRzCheckBox;
    RzListViewSelectItem: TRzListView;
    RzLabel18: TRzLabel;
    RzLabel25: TRzLabel;
    RzCheckBoxCanRate: TRzCheckBox;
    RzLabel19: TRzLabel;
    RzCheckBoxShowInPhone: TRzCheckBox;
    RzSeparator1: TRzSeparator;
    RzSeparator2: TRzSeparator;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButtonAddClick(Sender: TObject);
    procedure RzButtonCloseClick(Sender: TObject);
    procedure RzButtonDelClick(Sender: TObject);
    procedure RzButtonEditClick(Sender: TObject);
    procedure RzTreeViewMenuListChange(Sender: TObject; Node: TTreeNode);
    procedure RzTreeViewMenuListDblClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadFreeItemIdx(freeidx: string);
    procedure loadMenuData;
    procedure loadSelectItemIdx(selectidx: string);
    procedure loadSubItemIdx(subIdx: string);
    { Private declarations }
  public
    function getMenuItemNode(mainidx, subidx: Integer): TTreeNode;
    { Public declarations }
  end;

var
  FormMenuManager: TFormMenuManager;

implementation

uses myfunction, dbfunction, fmMenuInfo;

{$R *.dfm}

procedure TFormMenuManager.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  loadMenuData;
end;

procedure TFormMenuManager.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

function TFormMenuManager.getMenuItemNode(mainidx, subidx: Integer): TTreeNode;
var
  maintype,subtype:string;
  mainnode,subnode:TTreeNode;
  mn,sn:TTreeNode;
  i:integer;
begin
  maintype:=getMenuGroupTitle(mainidx);
  subtype:=getMenuSubGroupTitle(mainidx,subidx);

  mainnode:=nil;
  subnode:=nil;

  for i := 0 to RzTreeViewMenuList.Items.Count-1 do begin
    mn:=RzTreeViewMenuList.Items.Item[i];
    if mn.Text=maintype then begin
      mainnode:=mn;
      sn:=mn.getFirstChild;
      while sn<>nil do begin
        if sn.Text=subtype then begin
          subnode:=sn;
          break;
        end;
        sn:=sn.getNextSibling;
      end;
      break;
    end else begin
      mainnode:=nil;
    end;
  end;

  if mainnode=nil then begin
    mainnode:=RzTreeViewMenuList.Items.AddChild(nil,maintype);
    subnode:=RzTreeViewMenuList.Items.AddChild(mainnode,subtype);
  end;

  if subnode=nil then begin
    subnode:=RzTreeViewMenuList.Items.AddChild(mainnode,subtype);
  end;

  Result := subnode;
end;

procedure TFormMenuManager.loadFreeItemIdx(freeidx: string);
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

procedure TFormMenuManager.loadMenuData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  node,n:TTreeNode;
  md:TMenuData;
begin
  self.RzTreeViewMenuList.Items.Clear;
  sql := 'select menuidx,mainidx,subidx,itemname from menus order by mainidx,subidx,menuidx';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        node:=getMenuItemNode(strtoint(getUTF8String(MYSQL_ROW^[1])),strtoint(getUTF8String(MYSQL_ROW^[2])));
        if node<>nil then begin
          n:=self.RzTreeViewMenuList.Items.AddChild(node,getUTF8String(MYSQL_ROW^[0])+':'+getUTF8String(MYSQL_ROW^[3]));
          md:=TMenuData.Create;
          md.menuIdx:=strtoint(getUTF8String(MYSQL_ROW^[0]));
          n.Data:=md;
        end;
      end;
    until MYSQL_ROW=nil;
  end;
end;

procedure TFormMenuManager.loadSelectItemIdx(selectidx: string);
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

procedure TFormMenuManager.loadSubItemIdx(subIdx: string);
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

procedure TFormMenuManager.RzButtonAddClick(Sender: TObject);
var
  f:TFormMenuInfo;
begin
  f:=TFormMenuInfo.Create(self);
  f.editMenuIdx:=0;
  f.setControlStatus('ADD');
  f.ShowModal;
  //loadMenuData;
  f.Destroy;
end;

procedure TFormMenuManager.RzButtonCloseClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormMenuManager.RzButtonDelClick(Sender: TObject);
var
  res:integer;
  u,sql:string;
  md:TMenuData;
begin
  if (self.RzTreeViewMenuList.Selected=nil) or (self.RzTreeViewMenuList.Selected.Data=nil) then begin
    MessageBox(self.Handle,'请选择你要删除的菜品！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  md:= self.RzTreeViewMenuList.Selected.Data;
  u:=self.RzTreeViewMenuList.Selected.Text;
  res := MessageBox(self.Handle, PWideChar('是否确定要删除菜品'+u), '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    sql := Format('DELETE FROM menus WHERE menuidx=%d',[md.menuIdx]);
    execMySql(sql,LibHandle);
    //self.loadMenuData;
    self.RzTreeViewMenuList.Selected.Delete;
  end;
end;

procedure TFormMenuManager.RzButtonEditClick(Sender: TObject);
var
  f:TFormMenuInfo;
  md:TMenuData;
begin
  if (self.RzTreeViewMenuList.Selected=nil) or (self.RzTreeViewMenuList.Selected.Data=nil) then begin
    MessageBox(self.Handle,'请选择你要编辑的菜品！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  md:= self.RzTreeViewMenuList.Selected.Data;
  f:=TFormMenuInfo.Create(self);
  f.editMenuIdx:=md.menuIdx;
  f.setControlStatus('EDIT');
  f.ShowModal;
  //loadMenuData;
  f.Destroy;
end;

procedure TFormMenuManager.RzTreeViewMenuListChange(Sender: TObject; Node:
    TTreeNode);
var
  md:TMenuData;
  mt,st:integer;
  sql,subidx,freeidx,selectidx: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  if node.Data=nil then begin
    self.RzLabelIdx.Caption:='';
    self.RzLabelMainType.Caption:='';
    self.RzLabelSubType.Caption:='';
    self.RzLabelMakefrom.Caption:='';
    self.RzLabelName.Caption:='';
    self.RzLabelEName.Caption:='';
    self.RzLabelPrice.Caption:='';
    self.RzLabelSalePrice.Caption:='';
    self.RzLabelAward.Caption:='';
    self.RzLabelUnit.Caption:='';
    self.RzLabelDesc.Caption:='';
    self.RzLabelNut.Caption:='';
    self.RzLabelFeature.Caption:='';

    self.RzListViewSubItem.Clear;
    self.RzListViewFreeItem.Clear;
    self.RzListViewSelectItem.Clear;
    self.RzCheckBoxShowInMenu.Checked:=false;
    self.RzCheckBoxShowInPhone.Checked:=false;
    self.RzCheckBoxCanRate.Checked:=false;
  end else begin
    md:=node.Data;
    sql := Format('SELECT menuidx,mainidx,subidx,makefrom,itemname,ename,price,saleprice,award,itemunit,itemdesc,nutrition,feature,subitemidx,freeitemidx,selectidx,showinmenu,showinphone,canrate FROM menus WHERE menuidx=%d',[md.menuIdx]);
    queryMySql(sql,LibHandle, mySQL_Res);
    if mySQL_Res<>nil then begin
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        self.RzLabelIdx.Caption:=getUTF8String(MYSQL_ROW^[0]);
        mt:=strtoint(getUTF8String(MYSQL_ROW^[1]));
        st:=strtoint(getUTF8String(MYSQL_ROW^[2]));
        self.RzLabelMainType.Caption:=getMenuGroupTitle(mt);
        self.RzLabelSubType.Caption:=getMenuSubGroupTitle(mt,st);
        if getUTF8String(MYSQL_ROW^[3])='0' then
          self.RzLabelMakefrom.Caption:='吧台'
        else if getUTF8String(MYSQL_ROW^[3])='1' then
          self.RzLabelMakefrom.Caption:='厨房'
        else
          self.RzLabelMakefrom.Caption:='凉菜间';
        self.RzLabelName.Caption:=getUTF8String(MYSQL_ROW^[4]);
        self.RzLabelEName.Caption:=getUTF8String(MYSQL_ROW^[5]);
        self.RzLabelPrice.Caption:=getUTF8String(MYSQL_ROW^[6])+'元';
        self.RzLabelSalePrice.Caption:=getUTF8String(MYSQL_ROW^[7])+'元';
        self.RzLabelAward.Caption:=getUTF8String(MYSQL_ROW^[8])+'元';
        self.RzLabelUnit.Caption:=getUTF8String(MYSQL_ROW^[9]);
        self.RzLabelDesc.Caption:=getUTF8String(MYSQL_ROW^[10]);
        self.RzLabelNut.Caption:=getUTF8String(MYSQL_ROW^[11]);
        self.RzLabelFeature.Caption:=getUTF8String(MYSQL_ROW^[12]);

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
        loadSelectItemIdx(selectidx);

      end;
    end;
  end;
end;

procedure TFormMenuManager.RzTreeViewMenuListDblClick(Sender: TObject);
begin
  if self.RzTreeViewMenuList.Selected.Data<>nil then begin
    self.RzButtonEditClick(self);
  end;
end;

end.
