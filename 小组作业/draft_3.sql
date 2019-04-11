use db_university;

delimiter //
create function switch_to_points(grade varchar(2))
returns int
	begin
		declare points int default 0;
        case grade
			when "A+" then set points=100;
			when "A " then set points=95;
			when "A-" then set points=90;
			when "B+" then set points=85;
			when "B " then set points=80;
			when "B-" then set points=75;
			when "C+" then set points=70;
			when "C " then set points=65;
			when "C-" then set points=60;
		end case;
        return points;
    end;
    
create function get_score(ID varchar(5))
returns float
	begin
		declare idx int default 0;
        declare tot_course int;
        declare tot_score int default 0;
        declare cur_score float;
        declare cur cursor for
			select switch_to_points(grade) as score from takes where takes.ID=ID;
		
        select count(*) into tot_course
        from takes
        where takes.ID=ID;
        
        open cur;
        read_loop:loop
			if(idx>=tot_course) then
				leave read_loop;
			end if;
			fetch cur into cur_score;
			set tot_score=tot_score+cur_score;
			set idx=idx+1;
		end loop;
        close cur;
        return tot_score/tot_course;
    end;
    
create function switch_to_level(s_rank int,dept_name varchar(20))
returns char(1)
	begin
		declare symbol_level char(1);
		declare tot_student int;
        
		select count(*) into tot_student from student where student.dept_name=dept_name;
        
		if(ceil(0.2*tot_student)>=s_rank) then set symbol_level="A";
			elseif(ceil(0.4*tot_student)>=s_rank) then set symbol_level="B";
			else set symbol_level="C";
		end if;
		return symbol_level;
    end;
    //
delimiter ;

create view score_list as 
	select dept_name,ID,name,get_score(ID) as score
    from department natural join student
    order by dept_name,score desc;

create view rank_list as
	select dept_name,ID,name,rank() over(partition by dept_name order by(score) desc) as s_rank,score
    from score_list
    order by dept_name,score desc;
    
create view level_list as
	select dept_name,ID,name,switch_to_level(s_rank,dept_name) as level,score
    from rank_list;
    
select * from level_list where level="A" or level="B";