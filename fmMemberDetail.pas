unit fmMemberDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzRadChk, ComCtrls, RzListVw, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, mysql, pngimage, RzRadGrp, ImgList, frxDesgn, frxClass, Menus;

type
  TFormMemberDetail = class(TForm)
    RzPanel1: TRzPanel;
    RzLabelTotal: TRzLabel;
    RzLabelTableName: TRzLabel;
    RzListView: TRzListView;
    RzPanel2: TRzPanel;
    RzButtonCancel: TRzButton;
    ImageList1: TImageList;
    RzRadioGroupDetailType: TRzRadioGroup;
    Image1: TImage;
    RzToolButtonDesignReport: TRzToolButton;
    PopupMenuDesign: TPopupMenu;
    popMenuDesign: TMenuItem;
    popMenuPreview: TMenuItem;
    RzButtonPrint: TRzButton;
    frxReport: TfrxReport;
    frxUserDataSetMemberDetail: TfrxUserDataSet;
    frxDesigner: TfrxDesigner;
    RzButtonReturn: TRzButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxReportGetValue(const VarName: string; var Value: Variant);
    procedure frxUserDataSetMemberDetailGetValue(const VarName: string; var Value:
        Variant);
    procedure popMenuDesignClick(Sender: TObject);
    procedure popMenuPreviewClick(Sender: TObject);
    procedure RzButtonCancelClick(Sender: TObject);
    procedure RzButtonPrintClick(Sender: TObject);
    procedure RzButtonReturnClick(Sender: TObject);
    procedure RzRadioGroupDetailTypeClick(Sender: TObject);
  private
    oldCardNo:string;
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    procedure loadMemberDetailInfo;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; cno: string); reintroduce;
        overload;
    { Public declarations }
  end;

var
  FormMemberDetail: TFormMemberDetail;

implementation

uses myfunction, dbfunction, fmInvoiceMaker;

{$R *.dfm}

constructor TFormMemberDetail.Create(AOwner: TComponent; cno: string);
begin
  inherited Create(AOwner);
  self.oldCardNo:=cno;
end;

procedure TFormMemberDetail.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormMemberDetail.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  self.RzRadioGroupDetailType.ItemIndex:=0;

  if ACCESS>=8 then begin
    self.RzToolButtonDesignReport.Visible:=true;
  end else begin
    self.RzToolButtonDesignReport.Visible:=false;
  end;

  if ACCESS>3 then begin
    self.RzButtonReturn.Enabled:=true;
  end else begin
    self.RzButtonReturn.Enabled:=false;
  end;
end;

procedure TFormMemberDetail.frxReportGetValue(const VarName: string; var Value:
    Variant);
begin
  if CompareText(VarName,'memberno') = 0 then begin
    Value := self.oldCardNo;
  end else if CompareText(VarName,'misTitle') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','misTitle','辛巴西餐咖啡厅');
  end else if CompareText(VarName,'misTel') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','mistel','15038003911');
  end else if CompareText(VarName,'misWeibo') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','misweibo','http://weibo.cn/simbacafe');
  end else if CompareText(VarName,'misWeixin') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','misweixin','simbacafe');
  end else if CompareText(VarName,'misWeb') = 0 then begin
    Value:=GetStringFromINI('PUBLIC','misweb','http://www.simbacafe.com');
  end;
end;

procedure TFormMemberDetail.frxUserDataSetMemberDetailGetValue(const VarName:
    string; var Value: Variant);
var
  item:TListITem;
begin
  item:=RzListView.Items.Item[frxUserDataSetMemberDetail.RecNo];
  if CompareText(VarName,'date') = 0 then begin
    Value := item.SubItems[4];
  end else if CompareText(VarName,'nums') = 0 then begin
    Value := strtoint(item.SubItems[1])+strtoint(item.SubItems[2]);
  end else if CompareText(VarName,'type') = 0 then begin
    Value := item.SubItems[3];
  end;
end;

procedure TFormMemberDetail.RzButtonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormMemberDetail.loadMemberDetailInfo;
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

  if self.RzRadioGroupDetailType.ItemIndex=1 then
    sql := Format('SELECT id,cardno,paysum,donatesum,payidx,creationtime FROM memberdetail WHERE cardno="%s" and payidx=0',[self.oldCardNo])
  else if self.RzRadioGroupDetailType.ItemIndex=2 then
    sql := Format('SELECT id,cardno,paysum,donatesum,payidx,creationtime FROM memberdetail WHERE cardno="%s" and payidx>0',[self.oldCardNo])
  else
    sql := Format('SELECT id,cardno,paysum,donatesum,payidx,creationtime FROM memberdetail WHERE cardno="%s"',[self.oldCardNo]);
  sql:=sql+' order by id';
  queryMySql(sql,LibHandle, mySQL_Res);
  if mySQL_Res<>nil then begin
    repeat
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        item:=self.RzListView.Items.Add;
        item.Caption:=getUTF8String(MYSQL_ROW^[0]);
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[1]));
        if strtoint(getUTF8String(MYSQL_ROW^[4]))=0 then begin
          total:=total+strtoint(getUTF8String(MYSQL_ROW^[2]));
          item.SubItems.Add('+'+getUTF8String(MYSQL_ROW^[2]));
          total:=total+strtoint(getUTF8String(MYSQL_ROW^[3]));
          item.SubItems.Add('+'+getUTF8String(MYSQL_ROW^[3]));
          item.SubItems.Add('充送');
        end else begin
          total:=total-strtoint(getUTF8String(MYSQL_ROW^[2]));
          item.SubItems.Add('-'+getUTF8String(MYSQL_ROW^[2]));
          item.SubItems.Add('0');
          item.SubItems.Add('消费');
        end;
        item.SubItems.Add(getUTF8String(MYSQL_ROW^[5]));
      end;
    until MYSQL_ROW=nil;
  end;
  RzListView.Items.EndUpdate;
  if self.RzRadioGroupDetailType.ItemIndex=1 then
    self.RzLabelTotal.Caption:='充送合计：'+inttostr(total)+'元'
  else if self.RzRadioGroupDetailType.ItemIndex=2 then
    self.RzLabelTotal.Caption:='消费合计：'+inttostr(total)+'元'
  else
    self.RzLabelTotal.Caption:='余额：'+inttostr(total)+'元';

  self.RzLabelTableName.Caption:='记录数：'+inttostr(mysql_num_rows(mySQL_Res));

  self.frxUserDataSetMemberDetail.RangeEnd := reCount;
  self.frxUserDataSetMemberDetail.RangeEndCount := mysql_num_rows(mySQL_Res);
end;

procedure TFormMemberDetail.popMenuDesignClick(Sender: TObject);
begin
  loadReportDesignFile(self.frxReport,'memberdetail.fr3');
  self.frxReport.DesignReport();
end;

procedure TFormMemberDetail.popMenuPreviewClick(Sender: TObject);
begin
  loadReportDesignFile(self.frxReport,'memberdetail.fr3');
  self.frxReport.ShowReport();
end;

procedure TFormMemberDetail.RzButtonPrintClick(Sender: TObject);
begin
  loadReportDesignFile(self.frxReport,'memberdetail.fr3');
  if self.frxReport.PrepareReport(true) then begin
    frxReport.PrintOptions.Printer:=getPrinter('4');
    frxReport.PrintOptions.ShowDialog:=false;
    self.frxReport.Print;
  end;
end;

procedure TFormMemberDetail.RzButtonReturnClick(Sender: TObject);
var
  res,val:integer;
  u,sql:string;
  item:TListItem;
begin
  if self.RzListView.ItemIndex=-1 then begin
    MessageBox(self.Handle,'请选择你要恢复的充值/消费记录！','提示',MB_OK or MB_ICONWARNING);
    exit;
  end;
  item:=self.RzListView.Selected;
  u:=item.SubItems[0];

  val:=strtoint(item.SubItems[1])+strtoint(item.SubItems[2]);
  if val>0 then begin
    res := MessageBox(self.Handle, PWideChar('确定要恢复卡号为'+u+'会员的该充值记录吗？'), '提示', MB_YESNO or MB_ICONWARNING);
  end else begin
    res := MessageBox(self.Handle, PWideChar('确定要恢复卡号为'+u+'会员的该消费记录吗？'), '提示', MB_YESNO or MB_ICONWARNING);
  end;

  if res = IDYES then begin
    sql := Format('UPDATE members SET cardover=cardover-%d where cardno="%s"',[val,u]);
    execMySql(sql,LibHandle);

    sql := Format('DELETE FROM memberdetail WHERE id=%s',[item.Caption]);
    execMySql(sql,LibHandle);
    self.loadMemberDetailInfo;
  end;
end;

procedure TFormMemberDetail.RzRadioGroupDetailTypeClick(Sender: TObject);
begin
  self.loadMemberDetailInfo;
end;

end.
