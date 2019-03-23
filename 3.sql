use db_university;

/*
 *3.1
 */
select title
from course
where dept_name="Comp. Sci." and credits=3;

select count(distinct student.ID)
from (student join takes using (ID))
join (instructor join teaches using (ID))
using (course_id,sec_id,semester,year)
where instructor.name="Lembr";

select L.salary
from (instructor as L
left outer join instructor as R
on L.salary<R.salary)
where R.salary is null;

select ID,name
from instructor
where salary =
(select max(salary)
from instructor);

select course_id,sec_id,count(ID)
from takes
where year=2009 and semester="Fall"
group by course_id,sec_id;

select max(Cnt)
from (	select count(ID) as Cnt
		from takes
		where year=2009 and semester="Fall"
		group by course_id,sec_id) as alias;

select course_id,sec_id
from (select course_id,sec_id,count(ID) as Cnt
	 from takes
	 where year=2009 and semester="Fall"
	 group by course_id,sec_id) as popCnt
where Cnt=(select max(Cnt)
from (select course_id,sec_id,count(ID) as Cnt
	 from takes
	 where year=2009 and semester="Fall"
	 group by course_id,sec_id) as popCnt);

/*
 *3.2
 */
SET SQL_SAFE_UPDATES = 0;
 
create table grade_points
	(grade varchar(2),
     points numeric(2,1) check (points>0),
     primary key(grade)
     );

insert into grade_points values("A+",4.3);
insert into grade_points values("A ",4.0);
insert into grade_points values("A-",3.7);
insert into grade_points values("B+",3.4);
insert into grade_points values("B ",3.0);
insert into grade_points values("B-",2.7);
insert into grade_points values("C+",2.4);
insert into grade_points values("C ",2.0);
insert into grade_points values("C-",1.7);

alter table takes add foreign key (grade) references grade_points(grade);

select sum(credits*points)
from (takes natural join course) natural join grade_points
where ID="123";

select sum(credits*points)/sum(credits) as GPA
from (takes natural join course) natural join grade_points
where ID="123";

select ID,sum(credits*points)/sum(credits) as GPA
from (takes natural join course) natural join grade_points
group by ID;