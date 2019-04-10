use db_university;
SET GLOBAL log_bin_trust_function_creators = 1;

    delimiter //
create function course_ratio(dept_name varchar(20))
returns float
	begin
		/*declare*/
        declare idx integer default 0;
        declare s_num integer;
        declare c_num integer default 0;
        declare cur_id varchar(5);
        declare cur cursor for select ID from student where student.dept_name=dept_name;
		
        select count(*) into s_num from student where student.dept_name=dept_name;
        
		open cur;
        read_loop:loop
        if idx >= s_num then
			leave read_loop;
		end if;
        fetch cur into cur_id;
        set c_num=c_num+(select count(*) from takes where takes.ID=cur_id);
        set idx=idx+1;
        end loop;
        close cur;
        
        return c_num/s_num;
	end
    //
delimiter ;

select dept_name,course_ratio(dept_name) 
from department;