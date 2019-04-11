use db_university;

create view num_list as
	select dept_name,count(*) as num
    from department natural join student natural join takes
    group by dept_name,ID;
    
delimiter //
create function course_ratio(dept_name varchar(20))
returns float
	begin
		declare idx int default 0;
		declare cur_num int;
		declare tot_student int;
        declare tot_course int default 0;
        declare cur cursor for 
			select num from num_list where num_list.dept_name=dept_name;
        
        select count(*) into tot_student from num_list where num_list.dept_name=dept_name;
        
        open cur;
        read_loop:loop
			if(idx>=tot_student) then
				leave read_loop;
			end if;
            fetch cur into cur_num;
            set tot_course=tot_course+cur_num;
            set idx=idx+1;
		end loop;
        close cur;
        return tot_course/tot_student;
    end;
	//
delimiter ;

select dept_name,course_ratio(dept_name) 
from department; 