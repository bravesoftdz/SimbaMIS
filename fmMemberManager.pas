unit fmMemberManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, RzListVw, StdCtrls, RzLabel, RzButton, ExtCtrls, RzPanel,
  mysql, ImgList, Mask, RzEdit, RzRadGrp, pngimage, RzRadChk, RzCmboBx;

type
  TFormMemberManager = class(TForm)
    RzListView: TRzListView;
    RzPanel1: TRzPanel;
    RzToolButtonMemberAdd: TRzToolButton;
    RzLabelTotal: TRzLabel;
    RzLabelTableName: TRzLabel;
    RzToolButtonMemberPutMoney: TRzToolButton;
    RzToolButtonMemberEdit: TRzToolButton;
    RzToolButtonMemberReadd: TRzToolButton;
    RzToolButtonMemberDel: TRzToolButton;
    RzToolButtonMemberMakeStatu: TRzToolButton;
    RzToolButtonMemberDetail: TRzToolButton;
    ImageList1: TImageList;
    RzPanel2: TRzPanel;
    Image1: TImage;
    RzRadioButtonQuaCardNo: TRzRadioButton;
    RzEditQuaCardNo: TRzEdit;
    RzRadioButtonQuaCardName: TRzRadioButton;
    RzEditQuaCardName: TRzEdit;
    RzRadioButtonQuaCardSex: TRzRadioButton;
    RzComboBoxQuaCardSex: TRzComboBox;
    RzEditQuaCardTel: TRzEdit;
    RzRadioButtonQuaCardTel: TRzRadioButton;
    RzRadioButtonQuaCardRate: TRzRadioButton;
    RzComboBoxQuaCardRate: TRzComboBox;
    RzRadioButtonQuaCardStatus: TRzRadioButton;
    RzComboBoxQuaCardStatus: TRzComboBox;
    RzRadioButtonQuaCardOver: TRzRadioButton;
    RzLabel1: TRzLabel;
    RzNumericEditQuaCardOver1: TRzNumericEdit;
    RzLabel2: TRzLabel;
    RzNumericEditQuaCardOver2: TRzNumericEdit;
    RzRadioButtonQuaCardTime: TRzRadioButton;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzDateTimeQuaCardTime1: TRzDateTimeEdit;
    RzDateTimeQuaCardTime2: TRzDateTimeEdit;
    RzRadioButtonAll: TRzRadioButton;
    RzToolButtonInvoiceInfo: TRzToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RzEditQuaCardNoChange(Sender: TObject);
    procedure RzListViewChange(Sender: TObject; Item: TListItem; Change:
        TItemChange);
    procedure RzListViewColumnClick(Sender: TObject; Column: TListColumn);
    procedure RzListViewDblClick(Sender: TObject);
    procedure RzRadioButtonQuaCardNoClick(Sender: TObject);
    procedure RzToolButtonInvoiceInfoClick(Sender: TObject);
    procedure RzToolButtonMemberAddClick(Sender: TObject);
    procedure RzToolButtonMemberDelClick(Sender: TObject);
    procedure RzToolButtonMemberDetailClick(Sender: TObject);
    procedure RzToolButtonMemberEditClick(Sender: TObject);
    procedure RzToolButtonMemberMakeStatuClick(Sender: TObject);
    procedure RzToolButtonMemberPutMoneyClick(Sender: TObject);
    procedure RzToolButtonMemberReaddClick(Sender: TObject);
  private
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    orderString: string;
    whereString: string;
    oldColumn: TListColumn;
    procedure loadMemberDetailData;
    procedure getWhereString;
    procedure initRateList;
    procedure updateControlsStatus;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMemberManager: TFormMemberManager;

implementation

uses myfunction, dbfunction, fmMemberAdd, fmMemberEdit, fmMemberReadd, fmMemberPutMoney,
fmMemberInvoice, fmMemberDetail;

{$R *.dfm}

procedure TFormMemberManager.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  initRateList;
  orderString:=' order by id desc ';
  updateControlsStatus;
end;

procedure TFormMemberManager.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormMemberManager.FormKeyDown(Sender: TObject; var Key: Word; Shift:
    TShiftState);
begin
  {if Key=VK_ESCAPE then begin
    self.Close;
  end;}
end;

procedure TFormMemberManager.loadMemberDetailData;
var
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
  item:TListItem;
  total:integer;
begin
  RzListView.Items.BeginUpdate;
  self.RzListView.Clear;
  RzListView.SmallImages:=ImageList1;
  ImageList1.Height:=26;
  ImageList1.Width:=0;
  total:=0;

  self.getWhereString;
  sql := 'select id,cardno,name,sex,mobileno,cardrate,cardover,scoreover,cardstatus,creationtime,address,lastpaytime from members '+whereString+orderString;
  queryMySql(sql,LibHandle, mySQL_Res);
  if mysql_num_rows(mySQL_Res)>0 then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        item:=self.RzListView.Items.Add;
        item.Caption:=getUTF8String(MYSQL_ROW^[0]);
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[1]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[2]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[3]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[4]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[5]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[6]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[7]));
        if getUTF8String(MYSQL_ROW^[8])='0' then begin
          item.SubItems.Add('正常');
        end else if getUTF8String(MYSQL_ROW^[8])='1' then begin
          item.SubItems.Add('挂失');
        end else begin
          item.SubItems.Add('未知');
        end;
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[9]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[11]));
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[10]));

        total:=total+strtoint(getUTF8String(MYSQL_ROW^[6]));
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
  self.RzLabelTotal.Caption:='余额合计：'+inttostr(total)+'元';
  self.RzLabelTableName.Caption:='会员数：'+inttostr(mysql_num_rows(mySQL_Res))+'人';
end;

procedure TFormMemberManager.RzListViewColumnClick(Sender: TObject; Column:
    TListColumn);
var
  colname:string;
begin
  if Column.Index=0 then
    colname:='id'
  else if Column.Index=1 then
    colname:='cardno'
  else if Column.Index=3 then
    colname:='sex'
  else if Column.Index=5 then
    colname:='cardrate'
  else if Column.Index=6 then
    colname:='cardover'
  else if Column.Index=7 then
    colname:='scoreover'
  else if Column.Index=9 then
    colname:='creationtime'
  else if Column.Index=10 then
    colname:='lastpaytime'
  else
    exit;

  self.orderString:=' order by '+colname;
  if Column=self.oldColumn then begin
    if Column.Tag=1 then begin
      orderString:=orderString+' asc ' ;
      Column.Tag:=0;
    end else begin
      orderString:=orderString+' desc ';
      Column.Tag:=1;
    end;
  end else begin
    Column.Tag:=1;
    orderString:=orderString+' desc ';
    oldColumn:=Column;
  end;

  self.loadMemberDetailData;
end;

procedure TFormMemberManager.RzRadioButtonQuaCardNoClick(Sender: TObject);
begin
  self.updateControlsStatus;
end;

procedure TFormMemberManager.getWhereString;
begin
  whereString:='';
  if (self.RzRadioButtonQuaCardNo.Checked) and (length(trim(self.RzEditQuaCardNo.Text))>0) then begin
    whereString:=' where cardno like "%'+trim(self.RzEditQuaCardNo.Text)+'%" ';
  end else if (self.RzRadioButtonQuaCardTel.Checked) and (length(trim(self.RzEditQuaCardTel.Text))>0) then begin
    whereString:=' where mobileno like "%'+trim(self.RzEditQuaCardTel.Text)+'%" ';
  end else if (self.RzRadioButtonQuaCardName.Checked) and (length(trim(self.RzEditQuaCardName.Text))>0) then begin
    whereString:=' where name like "%'+trim(self.RzEditQuaCardName.Text)+'%" ';
  end else if (self.RzRadioButtonQuaCardStatus.Checked) and (RzComboBoxQuaCardStatus.ItemIndex>=0) then begin
    whereString:=' where cardstatus='+inttostr(RzComboBoxQuaCardStatus.ItemIndex);
  end else if (self.RzRadioButtonQuaCardSex.Checked) and (RzComboBoxQuaCardSex.ItemIndex>=0) then begin
    whereString:=' where sex="'+RzComboBoxQuaCardSex.Text+'" ';
  end else if (self.RzRadioButtonQuaCardRate.Checked) and (RzComboBoxQuaCardRate.ItemIndex>=0) then begin
    whereString:=' where cardrate='+RzComboBoxQuaCardRate.Text;
  end else if (self.RzRadioButtonQuaCardOver.Checked) then begin
    if RzNumericEditQuaCardOver1.IntValue>0 then begin
      whereString:=' where cardover>'+inttostr(RzNumericEditQuaCardOver1.IntValue);
      if RzNumericEditQuaCardOver2.IntValue>0 then begin
        whereString:=whereString+' and cardover<'+inttostr(RzNumericEditQuaCardOver2.IntValue);
      end;
    end else if RzNumericEditQuaCardOver2.IntValue>0 then begin
      whereString:=' where cardover<'+inttostr(RzNumericEditQuaCardOver2.IntValue);
    end;
  end else if (self.RzRadioButtonQuaCardTime.Checked) then begin
    if length(RzDateTimeQuaCardTime1.Text)>0 then begin
      whereString:=' where creationtime<"'+RzDateTimeQuaCardTime1.Text+'"';
      if length(RzDateTimeQuaCardTime2.Text)>0 then begin
        whereString:=whereString+' and creationtime>'+RzDateTimeQuaCardTime2.Text;
      end;
    end else if length(RzDateTimeQuaCardTime2.Text)>0 then begin
      whereString:=' where creationtime>"'+RzDateTimeQuaCardTime2.Text+'"';
    end;
  end;
end;

procedure TFormMemberManager.initRateList;
var
  l:TStringList;
  i:integer;
begin
  l:=TStringList.Create;
  getSectionList('RATETYPE',l);
  for i := 0 to l.Count - 1 do begin
    self.RzComboBoxQuaCardRate.Items.Add(GetStringFromINI('RATETYPE',l[i],'1'))
  end;
  l.Free;
end;

procedure TFormMemberManager.RzEditQuaCardNoChange(Sender: TObject);
begin
  self.loadMemberDetailData;
end;

procedure TFormMemberManager.RzListViewChange(Sender: TObject; Item: TListItem;
    Change: TItemChange);
begin
  if RzListView.Selected<>nil then begin
    if RzListView.Selected.SubItems[7]='正常' then begin
      self.RzToolButtonMemberReadd.Enabled:=false;
      self.RzToolButtonMemberMakeStatu.Caption:='挂失';
      self.RzToolButtonMemberMakeStatu.Tag:=0;
    end else begin
      self.RzToolButtonMemberReadd.Enabled:=true;
      self.RzToolButtonMemberMakeStatu.Caption:='取消挂失';
      self.RzToolButtonMemberMakeStatu.Tag:=1;
    end;
    self.RzToolButtonMemberEdit.Enabled:=true;
    self.RzToolButtonMemberDel.Enabled:=true;
    self.RzToolButtonMemberMakeStatu.Enabled:=true;
    self.RzToolButtonMemberDetail.Enabled:=true;
    self.RzToolButtonInvoiceInfo.Enabled:=true;
  end else begin
    self.RzToolButtonMemberEdit.Enabled:=false;
    self.RzToolButtonMemberDel.Enabled:=false;
    self.RzToolButtonMemberMakeStatu.Enabled:=false;
    self.RzToolButtonMemberReadd.Enabled:=false;
    self.RzToolButtonMemberDetail.Enabled:=false;
    self.RzToolButtonInvoiceInfo.Enabled:=false;
  end;
end;

procedure TFormMemberManager.RzListViewDblClick(Sender: TObject);
begin
  self.RzToolButtonMemberDetailClick(self);
end;

procedure TFormMemberManager.RzToolButtonInvoiceInfoClick(Sender: TObject);
var
  f:TFormMemberInvoice;
  item:TListItem;
begin
  if self.RzListView.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要进行发票查询的会员！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  item:=self.RzListView.Selected;

  f:=TFormMemberInvoice.Create(self,item.SubItems[0]);
  f.ShowModal;
  f.Destroy;
end;

procedure TFormMemberManager.RzToolButtonMemberAddClick(Sender: TObject);
var
  f:TFormMemberAdd;
begin
  f:=TFormMemberAdd.Create(self);
  f.ShowModal;
  self.loadMemberDetailData;
  f.Destroy;
end;

procedure TFormMemberManager.RzToolButtonMemberDelClick(Sender: TObject);
var
  res:integer;
  u,sql:string;
  item:TListItem;
begin
  if self.RzListView.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要删除的会员！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  item:=self.RzListView.Selected;
  u:=item.SubItems[0];
  res := MessageBox(self.Handle, PWideChar('确定要删除卡号为'+u+'的会员吗？'), '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    sql := Format('DELETE FROM members WHERE id=%s',[item.Caption]);
    execMySql(sql,LibHandle);
    self.loadMemberDetailData;
  end;
end;

procedure TFormMemberManager.RzToolButtonMemberDetailClick(Sender: TObject);
var
  f:TFormMemberDetail;
begin
  if self.RzListView.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要查看的会员！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;

  f:=TFormMemberDetail.Create(self,RzListView.Selected.SubItems[0]);
  f.ShowModal;
  self.loadMemberDetailData;
  f.Destroy;
end;

procedure TFormMemberManager.RzToolButtonMemberEditClick(Sender: TObject);
var
  f:TFormMemberEdit;
begin
  if self.RzListView.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要编辑的会员！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  f:=TFormMemberEdit.Create(self,strtoint(RzListView.Selected.Caption));
  f.ShowModal;
  self.loadMemberDetailData;
  f.Destroy;
end;

procedure TFormMemberManager.RzToolButtonMemberMakeStatuClick(Sender: TObject);
var
  res:integer;
  u,sql:string;
  item:TListItem;
begin
  if self.RzToolButtonMemberMakeStatu.Tag=0 then begin
    if self.RzListView.ItemIndex=-1 then begin
      MessageBox(self.Handle,'请选择你要挂失的会员！','提示',MB_OK or MB_ICONWARNING);
      exit;
    end;
    item:=self.RzListView.Selected;
    u:=item.SubItems[0];
    res := MessageBox(self.Handle, PWideChar('确定要挂失卡号为'+u+'的会员卡吗？'), '提示', MB_YESNO or MB_ICONWARNING);
    if res = IDYES then begin
      sql := Format('UPDATE members SET cardstatus=1 WHERE id=%s',[item.Caption]);
      execMySql(sql,LibHandle);
      self.loadMemberDetailData;
    end;
  end else begin
    if self.RzListView.ItemIndex=-1 then begin
      MessageBox(self.Handle,'请选择你要取消挂失的会员！','提示',MB_OK or MB_ICONWARNING);
      exit;
    end;
    item:=self.RzListView.Selected;
    u:=item.SubItems[0];
    res := MessageBox(self.Handle, PWideChar('确定要取消卡号为'+u+'的会员卡挂失吗？'), '提示', MB_YESNO or MB_ICONWARNING);
    if res = IDYES then begin
      sql := Format('UPDATE members SET cardstatus=0 WHERE id=%s',[item.Caption]);
      execMySql(sql,LibHandle);
      self.loadMemberDetailData;
    end;
  end;
end;

procedure TFormMemberManager.RzToolButtonMemberPutMoneyClick(Sender: TObject);
var
  f:TFormMemberPutMoney;
begin
  if self.RzListView.ItemIndex=-1 then
    f:=TFormMemberPutMoney.Create(self,'')
  else
    f:=TFormMemberPutMoney.Create(self,RzListView.Selected.SubItems[0]);
  f.ShowModal;
  self.loadMemberDetailData;
  f.Destroy;
end;

procedure TFormMemberManager.RzToolButtonMemberReaddClick(Sender: TObject);
var
  f:TFormMemberReadd;
begin
  if self.RzListView.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要补卡的会员记录！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;

  f:=TFormMemberReadd.Create(self,RzListView.Selected.SubItems[0]);
  f.ShowModal;
  self.loadMemberDetailData;
  f.Destroy;
end;

procedure TFormMemberManager.updateControlsStatus;
begin
  self.RzEditQuaCardNo.Enabled:=self.RzRadioButtonQuaCardNo.Checked;
  self.RzEditQuaCardTel.Enabled:=self.RzRadioButtonQuaCardTel.Checked;
  self.RzEditQuaCardName.Enabled:=self.RzRadioButtonQuaCardName.Checked;
  self.RzComboBoxQuaCardStatus.Enabled:=self.RzRadioButtonQuaCardStatus.Checked;
  self.RzComboBoxQuaCardSex.Enabled:=self.RzRadioButtonQuaCardSex.Checked;
  self.RzComboBoxQuaCardRate.Enabled:=self.RzRadioButtonQuaCardRate.Checked;
  self.RzNumericEditQuaCardOver1.Enabled:=self.RzRadioButtonQuaCardOver.Checked;
  self.RzNumericEditQuaCardOver2.Enabled:=self.RzRadioButtonQuaCardOver.Checked;
  self.RzDateTimeQuaCardTime1.Enabled:=self.RzRadioButtonQuaCardTime.Checked;
  self.RzDateTimeQuaCardTime2.Enabled:=self.RzRadioButtonQuaCardTime.Checked;
  self.loadMemberDetailData;
end;

end.
