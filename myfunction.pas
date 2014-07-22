unit myfunction;

interface

uses IniFIles, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, mysql, frxClass;

type

  TMenuData = class(TObject)
  private
    FmenuIdx: Integer;
  public
    property menuIdx: Integer read FmenuIdx write FmenuIdx;
  end;

  TTableItemData = class(TObject)
  private
    FIdx: Integer;
    FTableName: string;
  public
    property tableIdx: Integer read FIdx write FIdx;
    property tableName: String read FTablename write FTableName;
  end;

  function getUserGroupTitle(idx: Integer): string;
  function getTableGroupTitle(idx: Integer): string;
  function getSexIndex(s: string):Integer;
  function getMenuGroupTitle(idx: Integer): string;
  function getMenuSubGroupTitle(idx,subidx: Integer): string;
  procedure getSectionList(section: string; var slist: TStringList);
  procedure getSectionValueList(section: string; var slist: TStringList);
  procedure getPayTypeSectionList(section: string; var slist: TStringList);
  procedure getMenuSubItems(idx: Integer; var slist: TStringList);
  function getUTF8String(s: PAnsiChar): string;
  function GetStringFromINI(Section: string; key: string; def: string): string;
  function GetIntegerFromINI(Section: string; key: string; def: Integer): integer;
  function GetFloatFromINI(Section: string; key: string; def: double): double;
  procedure SetStringToINI(Section: string; key: string; val: string);
  procedure SetIntegerToINI(Section: string; key: string; val: Integer);
  procedure SetFloatToINI(Section: string; key: string; val: double);
  procedure LOG(str: string);

function loadReportDesignFile(report: TfrxReport; filename: string): Boolean;

function getPrinter(makefrom: string): string;

var
  LOGINNAME:string;
  USERNAME:string;
  ACCESS:integer;

implementation


function getUserGroupTitle(idx: Integer): string;
begin
  Result:=GetStringFromINI('ACCESSTYPE',inttostr(idx),'前厅');
end;

function getTableGroupTitle(idx: Integer): string;
begin
  Result:=GetStringFromINI('TABLETYPE',inttostr(idx),'包间');
end;

function getMenuGroupTitle(idx: Integer): string;
begin
  Result:=GetStringFromINI('MENUTYPE',inttostr(idx),'西餐');
end;

function getMenuSubGroupTitle(idx,subidx: Integer): string;
var
  t:string;
begin
  t:='MENUSUBTYPE-'+inttostr(idx);
  Result:=GetStringFromINI(t,inttostr(subidx),'');
end;

function getSexIndex(s: string):Integer;
begin
  if s='男' then
    Result:=0
  else
    Result:=1;
end;

procedure getSectionList(section: string; var slist: TStringList);
var
  inifile: TIniFile;
  filename: string;
begin
  filename := ExtractFilePath(Application.ExeName) + 'config.ini';
  inifile := TIniFile.Create(filename);
  inifile.ReadSection(section,slist);
  inifile.Free;
end;

procedure getSectionValueList(section: string; var slist: TStringList);
var
  inifile: TIniFile;
  filename: string;
begin
  filename := ExtractFilePath(Application.ExeName) + 'config.ini';
  inifile := TIniFile.Create(filename);
  inifile.ReadSectionValues(section,slist);
  inifile.Free;
end;

procedure getPayTypeSectionList(section: string; var slist: TStringList);
var
  inifile: TIniFile;
  filename: string;
  I: Integer;
begin
  filename := ExtractFilePath(Application.ExeName) + 'config.ini';
  inifile := TIniFile.Create(filename);
  inifile.ReadSection(section,slist);
  for I := slist.Count - 1 downto 0 do begin
    if strtoint(slist[I])<0 then
      slist.Delete(I);
  end;
  inifile.Free;
end;

procedure getMenuSubItems(idx: Integer; var slist: TStringList);
var
  t:string;
begin
  t:='MENUSUBTYPE-'+inttostr(idx);
  getSectionList(t,slist);
end;

function getUTF8String(s: PAnsiChar): string;
begin
  Result:=string(UTF8String(s));
end;

function GetStringFromINI(Section: string; key: string; def: string): string;
var
  inifile: TIniFile;
  filename: string;
  retVal: string;
begin
  filename := ExtractFilePath(Application.ExeName) + 'config.ini';
  inifile := TIniFile.Create(filename);
  retVal := inifile.ReadString(Section, key, def);
  inifile.Free;
  Result := retVal;
end;

function GetIntegerFromINI(Section: string; key: string; def: Integer): integer;
var
  inifile: TIniFile;
  filename: string;
  retVal: integer;
begin
  filename := ExtractFilePath(Application.ExeName) + '\config.ini';
  inifile := TIniFile.Create(filename);
  retVal := inifile.ReadInteger(Section, key, def);
  inifile.Free;
  Result := retVal;
end;

function GetFloatFromINI(Section: string; key: string; def: double): double;
var
  inifile: TIniFile;
  filename: string;
  retVal: double;
begin
  filename := ExtractFilePath(Application.ExeName) + '\config.ini';
  inifile := TIniFile.Create(filename);
  retVal := inifile.ReadFloat(Section, key, def);
  inifile.Free;
  Result := retVal;
end;

procedure SetStringToINI(Section: string; key: string; val: string);
var
  inifile: TIniFile;
  filename: string;
begin
  filename := ExtractFilePath(Application.ExeName) + 'config.ini';
  inifile := TIniFile.Create(filename);
  inifile.WriteString(Section, key, val);
  inifile.Free;
end;

procedure SetIntegerToINI(Section: string; key: string; val: Integer);
var
  inifile: TIniFile;
  filename: string;
begin
  filename := ExtractFilePath(Application.ExeName) + 'config.ini';
  inifile := TIniFile.Create(filename);
  inifile.WriteInteger(Section, key, val);
  inifile.Free;
end;

procedure SetFloatToINI(Section: string; key: string; val: double);
var
  inifile: TIniFile;
  filename: string;
begin
  filename := ExtractFilePath(Application.ExeName) + 'config.ini';
  inifile := TIniFile.Create(filename);
  inifile.WriteFloat(Section, key, val);
  inifile.Free;
end;

function loadReportDesignFile(report: TfrxReport; filename: string): Boolean;
var
  reportfile:string;
begin
  reportfile:=ExtractFilePath(Application.ExeName)+filename;
  if FileExists(reportfile) then begin
    report.LoadFromFile(reportfile);
    Result := true;
  end else begin
    MessageBox(0,PWideChar('找到不报表文件:'+reportfile),'提示',MB_OK or MB_ICONWARNING);
    Result := false;
  end;
end;

procedure LOG(str: string);
var
  FLogFile: TStreamWriter;
begin
  FLogFile := TStreamWriter.Create(ExtractFilePath(Application.ExeName) + 'sqllog.txt', true);

  try
    FLogFile.WriteLine(FormatdateTime('yyyy-mm-dd hh:nn:ss:zzz', now) + ' - ' + str);
    FLogFile.Flush;
  except on E: Exception do
    ;
  end;
  FLogFile.Close;
end;

function getPrinter(makefrom: string): string;
begin
  if makefrom='0' then
    Result := GetStringFromINI('PRINTER','ba','')
  else if makefrom='1' then
    Result := GetStringFromINI('PRINTER','chu','')
  else if makefrom='2' then
    Result := GetStringFromINI('PRINTER','liang','')
  else if makefrom='3' then
    Result := GetStringFromINI('PRINTER','chuan','')
  else if makefrom='4' then
    Result := GetStringFromINI('PRINTER','detail','')
  else
    Result := '';
end;



end.
