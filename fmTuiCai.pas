unit fmTuiCai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, RzSpnEdt, RzButton, ExtCtrls, RzPanel,
  RzLabel, mysql, frxDesgn, frxClass, Menus;

type
  TFormTuiCai = class(TForm)
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzPanel1: TRzPanel;
    RzButtonOk: TRzButton;
    RzButton1: TRzButton;
    RzSpinEditNums: TRzSpinEdit;
    RzLabelTno: TRzLabel;
    RzLabelIname: TRzLabel;
    RzLabelIunit: TRzLabel;
    RzToolButtonDesignReport: TRzToolButton;
    PopupMenuDesign: TPopupMenu;
    popMenuDesign: TMenuItem;
    popMenuPreview: TMenuItem;
    frxReport: TfrxReport;
    frxDesigner: TfrxDesigner;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxReportGetValue(const VarName: string; var Value: Variant);
    procedure popMenuDesignClick(Sender: TObject);
    procedure popMenuPreviewClick(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure RzButtonOkClick(Sender: TObject);
  private
    id:Integer;
    num:Integer;
    tno:string;
    midx:string;
    iname:string;
    iunit:string;
    LibHandle: PMYSQL;
    mySQL_Res: PMYSQL_RES;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; id,num: Integer; tableno,menuidx,itemname,itemunit:string); reintroduce;
        overload;
    { Public declarations }
  end;

var
  FormTuiCai: TFormTuiCai;

implementation

uses myfunction, dbfunction;

{$R *.dfm}

constructor TFormTuiCai.Create(AOwner: TComponent; id,num: Integer; tableno,menuidx,itemname,itemunit:string);
begin
  inherited Create(AOwner);
  self.id:=id;
  self.num:=num;
  self.tno:=tableno;
  self.midx:=menuidx;
  self.iname:=itemname;
  self.iunit:=itemunit;
end;

procedure TFormTuiCai.FormDestroy(Sender: TObject);
begin
  if mySQL_Res<>nil then
    mysql_free_result(mySQL_Res);
  if libmysql_status=LIBMYSQL_READY then
    mysql_close(LibHandle);
end;

procedure TFormTuiCai.FormCreate(Sender: TObject);
begin
  connectMySql(LibHandle);
  self.RzLabelTno.Caption:=self.tno;
  self.RzLabelIname.Caption:=self.iname;
  self.RzSpinEditNums.Max:=self.num;
  self.RzSpinEditNums.Value:=self.num;
  self.RzLabelIunit.Caption:=self.iunit;

  if ACCESS>=8 then
    self.RzToolButtonDesignReport.Visible:=true
  else
    self.RzToolButtonDesignReport.Visible:=false;
end;

procedure TFormTuiCai.frxReportGetValue(const VarName: string; var Value:
    Variant);
begin
  if CompareText(VarName,'tableno') = 0 then begin
    Value := self.tno
  end else if CompareText(VarName,'itemname') = 0 then begin
    Value := self.iname;
  end else if CompareText(VarName,'nums') = 0 then begin
    Value := trunc(self.RzSpinEditNums.Value);
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

procedure TFormTuiCai.popMenuDesignClick(Sender: TObject);
begin
  loadReportDesignFile(self.frxReport,'tuicaiitem.fr3');
  self.frxReport.DesignReport();
end;

procedure TFormTuiCai.popMenuPreviewClick(Sender: TObject);
begin
  loadReportDesignFile(self.frxReport,'tuicaiitem.fr3');
  self.frxReport.ShowReport();
end;

procedure TFormTuiCai.RzButton1Click(Sender: TObject);
begin
  self.Close
end;

procedure TFormTuiCai.RzButtonOkClick(Sender: TObject);
var
  res: Integer;
  qnum: Integer;
  sql: string;
  MYSQL_ROW: PMYSQL_ROW;
begin
  qnum:=trunc(self.RzSpinEditNums.Value);
  res := MessageBox(self.Handle, PWideChar('是否确定要退掉'+self.iname+Format('%d',[qnum])+self.iunit+'?'), '提示', MB_YESNO or MB_ICONWARNING);
  if res = IDYES then begin
    if qnum=self.num then begin
      sql := Format('DELETE FROM consumption WHERE id=%d',[self.id]);
    end else if qnum<self.num then begin
      sql := Format('Update consumption set nums=nums-%d where id=%d',[qnum,self.id]);
    end;
    execMySql(sql,LibHandle);
    //打印单据
    sql:=Format('select makefrom from menus where menuidx=%s',[self.midx]);
    queryMySql(sql,LibHandle, mySQL_Res);
    if mysql_num_rows(mySQL_Res)>0 then begin
      MYSQL_ROW := mysql_fetch_row(mySQL_Res);
      if MYSQL_ROW<>nil then begin
        loadReportDesignFile(self.frxReport,'tuicaiitem.fr3');
        if self.frxReport.PrepareReport(true) then begin
          frxReport.PrintOptions.Printer:=getPrinter(getUTF8String(MYSQL_ROW^[0]));
          frxReport.PrintOptions.ShowDialog:=false;
          self.frxReport.Print;
        end;
      end;
    end;
  end;
  self.Close;
end;

end.
