unit dbfunction;

interface

uses IniFIles, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, mysql,
myfunction;

function getMyStr(s: PAnsiChar): string;
procedure connectMySql(var hand:PMYSQL);
procedure queryMySql(sql: string; hand:PMYSQL; var res:PMYSQL_RES);
procedure execMySql(sql: string; hand:PMYSQL);

implementation

procedure connectMySql(var hand:PMYSQL);
var
  sql: AnsiString;
  serv,user,pass,dbase:PAnsiChar;
  port:integer;
begin
  serv:=PAnsiChar(AnsiString(GetStringFromIni('DB','server','localhost')));
  user:=PAnsiChar(AnsiString(GetStringFromIni('DB','user','')));
  pass:=PAnsiChar(AnsiString(GetStringFromIni('DB','pass','')));
  dbase:=PAnsiChar(AnsiString(GetStringFromIni('DB','database','')));
  port:=GetIntegerFromIni('DB','port',3306);

  if hand<>nil then begin
    mysql_close(hand);
    hand := nil;
  end;
  hand := mysql_init(nil);
  if hand=nil  then
    raise Exception.Create('mysql_init failed');
  if mysql_real_connect(hand, serv, user, pass, nil, port, nil, 0)=nil then
    raise Exception.Create(getMyStr(mysql_error(hand)));
  if mysql_select_db(hand, dbase)<>0 then
    raise Exception.Create(getMyStr(mysql_error(hand)));
  sql := AnsiString('set names utf8');
  if mysql_real_query(hand, PAnsiChar(sql), Length(sql))<>0 then
    raise Exception.Create(getMyStr(mysql_error(hand)));
end;

procedure queryMySql(sql: string; hand:PMYSQL; var res:PMYSQL_RES);
var
  my_sql:AnsiString;
begin
  if res<>nil then
    mysql_free_result(res);
  my_sql := AnsiString(UTF8String(sql));
  if mysql_real_query(hand, PAnsiChar(my_sql), Length(my_sql))<>0 then begin
    LOG('SQL ERROR BELOW:');
    LOG(sql);
    LOG(getMyStr(mysql_error(hand)));
    raise Exception.Create(getMyStr(mysql_error(hand)));
  end;

  res := mysql_store_result(hand);
end;

procedure execMySql(sql: string; hand:PMYSQL);
var
  my_sql:AnsiString;
begin
  //LOG(sql);
  my_sql := AnsiString(UTF8String(sql));
  if mysql_real_query(hand, PAnsiChar(my_sql), Length(my_sql))<>0 then begin
    LOG('SQL ERROR BELOW:');
    LOG(sql);
    LOG(getMyStr(mysql_error(hand)));
    raise Exception.Create(getMyStr(mysql_error(hand)));
  end;
end;

function getMyStr(s: PAnsiChar): string;
begin
  Result:=string(UTF8String(s));
end;


end.
