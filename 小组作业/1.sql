 use db_university;
 
 create view s_salary as
	select ID,name,percent_rank() over (order by (salary) desc) as s_rank
    from instructor
    order by s_rank;

select * from s_salary;

select name,course_id,count(*) as pop
from (select * from salary_rank where s_rank<=0.1) as A 
natural join teaches 
natural join (select ID as s_ID,course_id,sec_id,semester,year from takes) as T 
natural join course
group by name,title;