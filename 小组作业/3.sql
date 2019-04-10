use db_university;

delimiter //
create function switch_to_points(grade_symbol varchar(2))
returns int
	begin
		declare grade int;
        case grade_symbol
			when "A+" then set grade=100;
			when "A " then set grade=95;
			when "A-" then set grade=90;
			when "B+" then set grade=85;
			when "B " then set grade=80;
			when "B-" then set grade=75;
			when "C+" then set grade=70;
			when "C " then set grade=65;
			when "C-" then set grade=60;
			else set grade=0;
		end case;
        return grade;
    end;

create function switch_to_level(g_rank float,dept_name varchar(20))
returns char(1)
	begin
		declare symbol char(1);
        declare dept_num int;
        
        select count(*) into dept_num from student where student.dept_name=dept_name;
        
		if(ceil(dept_num*0.2)>=g_rank) then set symbol="A";
        elseif(ceil(dept_num*0.4)>=g_rank) then set symbol="B";
        else set symbol="C";
        end if;
        return symbol;
    end;

create function avg_grade(ID varchar(5))
returns float
	begin
		declare grade_symbol varchar(2);
        declare course_num int;
        declare tot_grade float default 0;
        declare idx int default 0;
        declare cur cursor for
			select grade from takes where takes.ID=ID;
		
        select count(*) into course_num
		from takes
        where takes.ID=ID;
        
        open cur;
        read_loop:loop
			if idx>=course_num then 
				leave read_loop;
			end if;
			fetch cur into grade_symbol;
			set tot_grade=tot_grade+switch_to_points(grade_symbol);
			set idx=idx+1;
        end loop;
        close cur;
        return tot_grade/course_num;
    end;
//
delimiter ;

create view score_list as
	select ID as s_ID,dept_name,avg_grade(ID) as avg_score,name as s_name
    from student
    order by dept_name,avg_score desc,s_name,s_ID;

create view ranking_list as
	select s_ID,dept_name,rank() over (partition by dept_name order by avg_score desc) as ranking,s_name,avg_score
    from score_list;
    
create view level_list as
	select dept_name,switch_to_level(ranking,dept_name) as level,s_ID,s_name,avg_score
	from ranking_list;

select *
from level_list
where level="A" or level="B";