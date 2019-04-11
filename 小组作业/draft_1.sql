use db_university;

create view salary_list as
	select ID,percent_rank() over (order by (salary) desc) as s_rank
    from instructor
    order by s_rank;
    
create view student_num_list as
	select course_id,sec_id,semester,year,title,count(*) as s_num
    from course natural join takes
    group by course_id,sec_id,semester,year;

select ID,title,s_num
from salary_list natural join teaches natural join student_num_list
where s_rank<=0.1;