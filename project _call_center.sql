/*project 1*/
select *  from project.dbo.call_center
select count(*) from call_center
select  count(*) as column_name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= 'call_center'
select  column_name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= 'call_center'
select call_timestamp , convert (date , call_timestamp)
from call_center

alter table call_center 
add from call_center_converted  date

select call_timestamp , format(call_timestamp , 'dddd') as name_day 
from call_center

select call_time_converted  , format(call_time_converted , 'MMMM' ) from call_center



alter table call_center 
add name_day varchar(10)

update call_center
set name_day = format(call_timestamp , 'dddd') 


update call_center
set call_time_converted = convert (date , call_timestamp)

alter table call_center
drop column call_timestamp

select distinct sentiment from call_center
select distinct  reason from  call_center
select distinct channel from  call_center
select distinct call_center from  call_center
select distinct city from  call_center
select distinct csat_score from  call_center

select csat_score , isnull(csat_score , 0) as csat_score_update
from call_center

alter table call_center 
add csat_score_update int 

update call_center
set csat_score_update = isnull(csat_score , 0)


select column_name  from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'call_center' 

select sentiment , count(*) as set_count    ,concat( count(*)*100 /(select  count(*) from call_center) , '%') as ptg 
from call_center
group by sentiment
order by set_count desc


select  reason, count(*) as c_count    ,concat( count(*)*100 /(select  count(*) from call_center) , '%') as ptg 
from call_center
group by reason
order by c_count desc

select channel , count(*) as c_count    ,concat( count(*)*100 /(select  count(*) from call_center) , '%') as ptg 
from call_center
group by channel
order by c_count desc


select call_center , count(*) as c_count    ,concat( count(*)*100 /(select  count(*) from call_center) , '%') as ptg 
from call_center
group by call_center
order by c_count desc


select name_day , count(*) as c_count    ,concat( count(*)*100 /(select  count(*) from call_center) , '%') as ptg 
from call_center
group by name_day
order by c_count desc

--aggregations :
select min(call_time_converted) as earliest_date   , max( call_time_converted) as most_recet from call_center

select min(csat_score) as min_score , max(csat_score) as max_score , round(avg(csat_score), 1)  as avg_score from call_center
where csat_score <> 0

select min([call duration in minutes]) as min_cal_dur , 
max([call duration in minutes]) as max_cal_dur,
avg([call duration in minutes]) as avg_cal_dur
from call_center

select call_center , response_time , count (*)
from call_center
group by call_center , response_time
order by 1 ,3 desc


select call_center ,avg([call duration in minutes]) as avg_cal_dur  
from call_center
group by call_center 
order by  2 desc


select channel ,avg([call duration in minutes]) as avg_cal_dur  
from call_center
group by channel 
order by  2 desc


select state , count(*) as sta_count   from  call_center 
group by state 
order by 2 desc

select state , response_time , count(*) as sta_count   from  call_center 
group by state , response_time
order by  1,2,3  desc


select state , sentiment , count(*) as sta_count   from  call_center 
group by state , sentiment
order by  1,2,3  desc

select state , round(avg(csat_score), 1)as avg_cast_score   
from  call_center 
where csat_score <>0
group by state 
order by  2 desc ;

select state , sentiment , count(*) as sta_count   from  call_center 
group by state , sentiment
order by  1,2,3  desc

select sentiment, avg([call duration in minutes])  as avg_call_dur   from  call_center 
group by state , sentiment
--having avg([call duration in minutes]) < 20
order by 1, 2 desc

select call_time_converted , max([call duration in minutes]) as max
from call_center
group by call_time_converted
order by 2 