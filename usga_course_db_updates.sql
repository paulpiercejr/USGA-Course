-- usga_updates

update coursetee
set course_id = 20971
where tee_id = 654583;

update course
set city = 'Erin'
where course_id = 32025;

update course
set state = 'WI'
where course_id = 32025;

update course
set city = 'University Place'
where course_id = 31218;

update course
set state = 'WA'
where course_id = 31218;

update course
set city = 'University Place'
where course_id = 32350;

update coursetee
set course_id = 1456
where tee_id = 749105;

update coursetee
set par = 73
where tee_id = 749105;

insert into coursetee
VALUES(900000,1456,'2015 U.S. Open','M',70,78.1,NULL,146,NULL,NULL,NULL,NULL,7695,NULL,NULL);

update coursetee
set course_id = 398
where tee_id = 399652;

update course
set city = 'Chapel Hill'
where course_id = 28754;

update course
set state = 'NC'
where course_id = 28754;

alter table coursetee
add column do_not_use char(1) DEFAULT 'N' NOT NULL;

alter table course
add column do_not_use char(1) DEFAULT 'N' NOT NULL;

update coursetee
set do_not_use = 'Y'
where tee_id = 543788;

update coursetee
set do_not_use = 'Y'
where tee_id = 346429;

update coursetee
set do_not_use = 'Y'
where tee_id = 666093;

update coursetee
set do_not_use = 'Y'
where tee_id = 666095;

update coursetee
set do_not_use = 'Y'
where tee_id = 666097;

update coursetee
set do_not_use = 'Y'
where tee_id = 666100;

update coursetee
set do_not_use = 'Y'
where tee_id = 764019;

update coursetee
set do_not_use = 'Y'
where tee_id = 764859;

update coursetee
set do_not_use = 'Y'
where tee_id = 714577;

update coursetee
set do_not_use = 'Y'
where tee_id = 714957;

update course
set do_not_use = 'Y'
where course_id = 26490;

update course
set do_not_use = 'Y'
where course_id = 24213;

update course
set do_not_use = 'Y'
where course_id = 24126;

update course
set do_not_use = 'Y'
where course_id = 32721;

update course
set do_not_use = 'Y'
where course_id = 32783;

update course
set do_not_use = 'Y'
where course_id = 33724;





use usga_course;


update course
set do_not_use = 'Y'
where course_id = 28224;

update course
set state = 'AE'
where course_id = 26368;

update course
set state = 'AE'
where course_id = 34193;

update course
set state = 'AE'
where course_id = 34194;

update course
set state = 'AE'
where course_id = 34195;

update course
set state = 'AE'
where course_id = 34196;

update course
set state = 'AE'
where course_id = 26369;

update course
set state = 'AE'
where course_id = 31497;

update course
set state = 'AE'
where course_id = 31498;

update course
set state = 'AE'
where course_id = 31537;

update course
set state = 'AE'
where course_id = 31505;

update course
set state = 'AE'
where course_id = 31762;

update course
set state = 'AE'
where course_id = 26244;

update course
set city = 'San Martin'
where course_id = 24090;

update coursetee
set tee_name = "White - 2016 US Women's Open"
where tee_id = 334007;

update coursetee
set course_id = 7776
where tee_id = 334007;

update coursetee
set par = 72
where tee_id = 334007;

insert into coursetee (tee_id, course_id, tee_name, gender, par, course_rating, bogey_rating, slope_rating, front_nine_rating, front_nine_slope, back_nine_rating, back_nine_slope, yardage, front_nine_bogey, back_nine_bogey, do_not_use)
	select 900001, course_id, "White - 2016 US Women's Open (77)", gender, 77, course_rating, bogey_rating, slope_rating, front_nine_rating, front_nine_slope, back_nine_rating, back_nine_slope, yardage, front_nine_bogey, back_nine_bogey, do_not_use
    from coursetee
    where tee_id = 334007;
    
update course
set do_not_use = 'Y'
where course_id = 26027;

update coursetee
set course_id = 23635
where tee_id = 413027;

update course
set do_not_use = 'Y'
where course_id = 24225;

update course
set do_not_use = 'Y'
where course_id = 24241;

update course
set do_not_use = 'Y'
where course_id = 33864;

update course
set do_not_use = 'Y'
where course_id = 33865;

update course
set do_not_use = 'Y'
where course_id = 32783;

update course
set do_not_use = 'Y'
where course_id = 32785;

update course
set do_not_use = 'Y'
where course_id = 32786;

update course
set do_not_use = 'Y'
where course_id = 32787;

update course
set do_not_use = 'Y'
where course_id = 32788;

update course
set do_not_use = 'Y'
where course_id = 31599;

update course
set do_not_use = 'Y'
where course_id = 32716;

update course
set do_not_use = 'Y'
where course_id = 32782;

update course
set do_not_use = 'Y'
where course_id = 32781;

update course
set do_not_use = 'Y'
where course_id = 32771;

update course
set do_not_use = 'Y'
where course_id = 33129;

update course
set do_not_use = 'Y'
where course_id = 31629;

update course
set do_not_use = 'Y'
where course_id = 32250;

update course
set do_not_use = 'Y'
where course_id = 31600;

update course
set do_not_use = 'Y'
where course_id = 31554;

update course
set do_not_use = 'Y'
where course_id = 31568;

update course
set do_not_use = 'Y'
where course_id = 29129;

update course
set do_not_use = 'Y'
where course_id = 32032;

update course
set do_not_use = 'Y'
where course_id = 31783;

update course
set city = 'Giza'
where course_id = 32125;

update course
set state = 'EG'
where course_id = 32125;

update course
set do_not_use = 'Y'
where course_id = 31546;

update course
set do_not_use = 'Y'
where course_id = 31609;

update course
set do_not_use = 'Y'
where course_id = 32223;

update course
set do_not_use = 'Y'
where course_id = 32224;

update course
set do_not_use = 'Y'
where course_id = 28214;

update course
set do_not_use = 'Y'
where course_id = 28237;

update course
set do_not_use = 'Y'
where course_id = 30308;

update course
set do_not_use = 'Y'
where course_id = 31737;

update course
set do_not_use = 'Y'
where course_id = 26414;

update course
set do_not_use = 'Y'
where course_id = 27098;

update course
set do_not_use = 'Y'
where course_id = 24100;

update course
set do_not_use = 'Y'
where course_id = 26446;

update course
set do_not_use = 'Y'
where course_id = 19418;

update course
set do_not_use = 'Y'
where course_id = 24099;

update course
set do_not_use = 'Y'
where course_id = 24164;

update course
set do_not_use = 'Y'
where course_id = 26147;

update course
set do_not_use = 'Y'
where course_id = 31628;

update course
set do_not_use = 'Y'
where course_id = 26775;

update course
set do_not_use = 'Y'
where course_id = 31522;

update course
set do_not_use = 'Y'
where course_id = 31525;

update course
set do_not_use = 'Y'
where course_id = 31379;

update course
set do_not_use = 'Y'
where course_id = 31494;

update course
set do_not_use = 'Y'
where course_id = 31495;

update course
set do_not_use = 'Y'
where course_id = 31594;

update course
set do_not_use = 'Y'
where course_id = 8780;

update course
set do_not_use = 'Y'
where course_id = 31218;

update course
set do_not_use = 'Y'
where course_id = 26301;

update course
set do_not_use = 'Y'
where course_id = 32025;

commit;
    
select * from coursetee where course_id = 32025;

select * from course where LOWER(course_name) LIKE '%vintage golf%';

select c.course_id, c.course_name, ct.tee_id, ct.tee_name, ct.par, ct.course_rating, ct.slope_rating, ct.yardage, ct.gender
from course c
join coursetee ct using (course_id)
where c.course_id = 28984
order by ct.gender desc, ct.course_rating desc;

select * from course
where course_name like '%katameya%';

select c.course_name, c.city, c.state, ct.tee_name, ct.gender, ct.yardage, ct.par
from course c
join coursetee ct using (course_id)
where (c.city = 'Gainesville'
or c.city = 'Bristow')
and c.state = 'VA';

select c.course_id, c.course_name, c.do_not_use, ct.tee_name, ct.yardage
from course c
join coursetee ct using (course_id)
where c.city = 'Washington'
and c.state = 'DC';

select c.course_id, c.course_name, ct.tee_name, ct.do_not_use, ct.yardage
from course c
left join coursetee ct using (course_id)
where c.city = 'Washington'
and c.state = 'DC'; 