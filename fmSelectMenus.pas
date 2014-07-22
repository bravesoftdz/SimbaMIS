unit fmSelectMenus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, ComCtrls, RzTreeVw, mysql, RzListVw, RzLabel, StdCtrls,
  RzBckgnd, RzSpnEdt;

type
  TFormSelectMenus = class(TForm)
    RzTreeViewMenuList: TRzTreeView;
    RzButtonOk: TRzButton;
    RzLabel23: TRzLabel;
    RzURLLabel6: TRzURLLabel;
    RzListViewSelectItem: TRzListView;
    RzSpinner1: TRzSpinner;
    RzLabel1: TRzLabel;
    RzSeparator1: TRzSeparator;
    RzButton1: TRzButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure RzTreeViewMenuListDblClick(Sender: TObject);
    procedure RzURLLabel6Click(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    lview:TRzListView;
    isitem:boolean;
    function getMenuItemNode(mainidx, subidx: Integer): TTreeNode;
    procedure loadMenuData;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; lv: TRzListView; IsItem: boolean); reintroduce; overload;
    { Public declarations }
  end;

var
  FormSelectMenus: TFormSelectMenus;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

constructor TFormSelectMenus.Create(AOwner: TComponent; lv: TRzListView; IsItem: boolean);
begin
  self.lview:=lv;
  self.isitem:=IsItem;

  inherited Create(AOwner);
end;

procedure TFormSelectMenus.FormCreate(Sender: TObject);
begin
  if IsItem then begin
    self.RzLabel1.Visible:=false;
    self.RzSpinner1.Visible:=false;
  end else begin
    self.RzLabel1.Visible:=true;
    self.RzSpinner1.Visible:=true;
  end;

  connectMySql(LibHandle);
  loadMenuData;
end;

procedure TFormSelectMenus.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormSelectMenus.loadMenuData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  node,n:TTreeNode;
  md:TMenuData;
begin
  self.RzTreeViewMenuList.Items.Clear;
  sql := 'select menuidx,mainidx,subidx,itemname,price from menus order by mainidx,subidx,menuidx';
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

function TFormSelectMenus.getMenuItemNode(mainidx, subidx: Integer): TTreeNode;
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

procedure TFormSelectMenus.RzButton1Click(Sender: TObject);
var
  i: Integer;
  item,item2:TListItem;
  strId,strName:string;
begin
  if self.RzListViewSelectItem.Items.Count<=0 then begin
    self.Close;
  end else begin
    if self.isitem=true then begin
      for i := 0 to self.RzListViewSelectItem.Items.Count - 1 do begin
        item:=self.RzListViewSelectItem.Items.Item[i];
        item2:=self.lview.Items.Add;
        item2.Caption:=item.Caption;
        item2.SubItems.Add(item.SubItems[0]);
      end;
      self.Close;
    end else begin
      for i := 0 to self.RzListViewSelectItem.Items.Count - 1 do begin
        item:=self.RzListViewSelectItem.Items.Item[i];
        if length(strId)>0 then
          strId:=strId+'|'+item.Caption
        else
          strId:=item.Caption;

        if length(strName)>0 then
          strName:=strName+','+item.SubItems[0]
        else
          strName:=item.SubItems[0];
      end;
      strId:='['+strId+']'+inttostr(self.RzSpinner1.Value);

      item2:=self.lview.Items.Add;
      item2.Caption:=strId;
      item2.SubItems.Add(strName);

      self.Close;
    end;
  end;
end;

procedure TFormSelectMenus.RzTreeViewMenuListDblClick(Sender: TObject);
var
  md:TMenuData;
  node:TTreeNode;
  item:TListItem;
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  if (self.RzTreeViewMenuList.Selected=nil) or (self.RzTreeViewMenuList.Selected.Data=nil) then begin
    exit;
  end;
  node:=self.RzTreeViewMenuList.Selected;
  md:=TMenuData(node.Data);

  sql := Format('select menuidx,itemname,price from menus where menuidx=%d',[md.menuIdx]);
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    MYSQL_ROW := mysql_fetch_row(mySQL_Res);
    if MYSQL_ROW<>nil then begin

      item:=self.RzListViewSelectItem.Items.Add;
      item.Caption:=inttostr(md.menuIdx);
      item.SubItems.Add(getUTF8String(MYSQL_ROW^[1])+'('+getUTF8String(MYSQL_ROW^[2])+')');

      self.RzSpinner1.Max:=self.RzListViewSelectItem.Items.Count;
    end;
  end;
end;

procedure TFormSelectMenus.RzURLLabel6Click(Sender: TObject);
begin
  if self.RzListViewSelectItem.Selected<>nil then
    self.RzListViewSelectItem.Selected.Delete;
end;

end.
