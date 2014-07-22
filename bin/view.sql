# view_payitems

CREATE OR REPLACE view view_payitems AS
select Id,tablename,constotal,willpaysum,paysum,paytype,payrate,payticket,ticketnumber,invoicestatus,invoicetotal,invoicename,invoicetel,loginname,creationtime,
(creationtime + interval -(6) hour) AS ctime,cast((creationtime + interval -(6) hour) as date) AS cdate,date_format(cast((creationtime + interval -(6) hour) as date),'%Y-%m') AS cmonth
from payitems;


# view_consumption

CREATE OR REPLACE view view_consumption as 
select a.*,b.mainidx,b.maindesc,b.subidx,b.subdesc,b.makefrom,b.itemname,b.itemunit,c.paytype,
date_add(a.creationtime,INTERVAL -6 HOUR) as ctime,date(date_add(a.creationtime,INTERVAL -6 HOUR)) as cdate,
DATE_FORMAT(date(date_add(a.creationtime,INTERVAL -6 HOUR)),"%Y-%m") as cmonth
from consumption a 
left join menus b on a.menuidx=b.menuidx 
left join payitems c on a.payidx=c.id

# view_invoices

CREATE OR REPLACE view view_invoices as 
select *,date_add(creationtime,INTERVAL -6 HOUR) as ctime,date(date_add(creationtime,INTERVAL -6 HOUR)) as cdate,
DATE_FORMAT(date(date_add(creationtime,INTERVAL -6 HOUR)),"%Y-%m") as cmonth from invoices;

# view_purchase

CREATE OR REPLACE view view_purchase as 
select a.*,b.sellername,b.sellertel,date_add(a.creationtime,INTERVAL -6 HOUR) as ctime,
date(date_add(a.creationtime,INTERVAL -6 HOUR)) as cdate,
DATE_FORMAT(date(date_add(a.creationtime,INTERVAL -6 HOUR)),"%Y-%m") as cmonth
from purchase a 
left join seller b on b.id=a.buyselleridx

# view_award

CREATE OR REPLACE view view_award as 
select a.loginname,d.username,a.tablename,b.itemname,a.nums,b.itemunit,a.price,a.award,a.issale,a.payidx,c.paytype,a.creationtime,
date_add(a.creationtime,INTERVAL -6 HOUR) as ctime,date(date_add(a.creationtime,INTERVAL -6 HOUR)) as cdate,
DATE_FORMAT(date(date_add(a.creationtime,INTERVAL -6 HOUR)),"%Y-%m") as cmonth
from consumption a 
left join menus b on a.menuidx=b.menuidx 
left join payitems c on a.payidx=c.id
left join users d on a.loginname=d.loginname

# view_storeitems

CREATE OR REPLACE view view_storeitems as 
select a.*,b.storetypename,b.storename,b.storeunit,b.warningnums,date_add(a.creationtime,INTERVAL -6 HOUR) as ctime,
date(date_add(a.creationtime,INTERVAL -6 HOUR)) as cdate,
DATE_FORMAT(date(date_add(a.creationtime,INTERVAL -6 HOUR)),"%Y-%m") as cmonth
from storeitems a 
left join stores b on a.storeid=b.id

#view_tableusers

CREATE OR REPLACE view view_tableusers as 
select *,date_add(creationtime,INTERVAL -6 HOUR) as ctime,date(date_add(creationtime,INTERVAL -6 HOUR)) as cdate,
DATE_FORMAT(date(date_add(creationtime,INTERVAL -6 HOUR)),"%Y-%m") as cmonth from tableusers;
