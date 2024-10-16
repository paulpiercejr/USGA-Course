use usga_course;

CREATE TABLE course (
	course_id INT UNSIGNED,
    course_name VARCHAR(150) NOT NULL,
    city VARCHAR(75) DEFAULT NULL,
    state VARCHAR(25) DEFAULT NULL,
    CONSTRAINT pk_course PRIMARY KEY (course_id)
) ENGINE=InnoDB;

CREATE TABLE coursetee (
	tee_id INT UNSIGNED, 
	course_id INT UNSIGNED NOT NULL,
	tee_name VARCHAR(50) NOT NULL, 
    gender CHAR(1),
    par INT UNSIGNED,
    course_rating DECIMAL(3,1), 
    bogey_rating DECIMAL(4,1),
    slope_rating INT UNSIGNED,
    front_nine_rating DECIMAL(3,1) DEFAULT NULL,
    front_nine_slope INT UNSIGNED DEFAULT NULL,
    back_nine_rating DECIMAL(3,1) DEFAULT NULL,
    back_nine_slope INT UNSIGNED DEFAULT NULL,
    yardage INT UNSIGNED DEFAULT NULL,
    front_nine_bogey DECIMAL(3,1) DEFAULT NULL,
    back_nine_bogey DECIMAL(3,1) DEFAULT NULL,
    CONSTRAINT pk_coursetee PRIMARY KEY (tee_id),
    CONSTRAINT fk_coursetee_course FOREIGN KEY (course_id) REFERENCES course(course_id)
) ENGINE=InnoDB;

LOAD DATA INFILE '/Users/paulpiercejr/Documents/Course_Rating_Web_Scrape/course-list-2024/course_list-2024.csv'
IGNORE INTO TABLE course
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- (course_id,course_name,@city,@state)
-- SET state = IF(@state='',NULL,@state);

LOAD DATA INFILE '/Users/paulpiercejr/Documents/Course_Rating_Web_Scrape/tee-info-2024/tee_info-2024.csv'
IGNORE INTO TABLE coursetee
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(tee_id,course_id,tee_name,gender,par,course_rating,bogey_rating,slope_rating,@front_nine_rating,@front_nine_slope,@back_nine_rating,@back_nine_slope,@yardage)
SET 
back_nine_rating = NULLIF(@back_nine_rating,''),
back_nine_slope = NULLIF(@back_nine_slope,''),
front_nine_rating = NULLIF(@front_nine_rating,''),
front_nine_slope = NULLIF(@front_nine_slope,''),
yardage = NULLIF(@yardage,''),
front_nine_bogey = NULLIF(@front_nine_bogey,''),
back_nine_bogey = NULLIF(@back_nine_bogey,'')
;


select c.course_id,c.course_name,c.city,c.state,ct.tee_name,ct.course_rating,ct.slope_rating
from coursetee ct
join course c on ct.course_id = c.course_id
WHERE course_rating = 69.8
AND slope_rating = 128
AND gender = 'M'
ORDER BY state;

-- 100 hardest courses by rating
select ct.tee_id,c.course_id, c.course_name,c.city,c.state,ct.tee_name,ct.par,ct.course_rating,ct.slope_rating, ct.bogey_rating, ct.yardage
from coursetee ct
left join course c on ct.course_id = c.course_id
where gender = 'M'
AND state = 'VA'
AND c.do_not_use = 'N'
AND ct.do_not_use = 'N'
group by ct.tee_id, c.course_id, c.course_name,c.city,c.state,ct.tee_name,ct.par,ct.course_rating,ct.slope_rating, ct.bogey_rating
order by ct.course_rating desc, ct.slope_rating desc, ct.bogey_rating desc
limit 500;

-- select c.course_id, c.course_name, c.city, c.state
-- from course c
-- where c.state = 'VA'
-- order by c.city asc;

select c.course_id, ct.tee_id, c.course_name, c.city, c.state,ct.tee_name, ct.par, ct.course_rating, ct.slope_rating, ct.bogey_rating, ct.yardage
from course c
join coursetee ct on c.course_id = ct.course_id
where LOWER(c.course_name) like '%erin hills%'
-- where LOWER(ct.tee_name) like '%shadow creek%'
AND ct.gender = 'M'
order by ct.course_rating desc;


-- updates
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

-- 
select course_id, course_name, city, state, do_not_use
from course
where (state IN ("AK","AL","AR","AZ","CA","CO","CT","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM")
or (state = 'DC'
and city = 'Washington'))
and do_not_use = 'N'
order by state asc, course_name asc, city asc;


select * from coursetee
where course_id = 24090;

select * from coursetee
order by tee_id desc
limit 20;


select c.course_id, c.course_name, ct.tee_id, ct.tee_name, ct.par, ct.course_rating, ct.slope_rating, ct.yardage, ct.gender
from course c
join coursetee ct using (course_id)
where c.course_id = 398
order by ct.gender desc, ct.course_rating desc;

select * from course
where LOWER(course_name) LIKE '%hartford%'
and state = 'CT';

select c.course_id, c.course_name, c.city, c.state, ct.tee_id, ct.tee_name, ct.par, ct.course_rating, ct.slope_rating, ct.yardage, ct.gender
from course c
left join coursetee ct using (course_id)
where LOWER(c.course_name) LIKE '%amateur%'
or lower(c.course_name) LIKE '%open%';

select c.course_id, c.course_name, ct.tee_name, c.city, c.state, ct.par, ct.course_rating, ct.slope_rating, ct.yardage, ct.gender
from course c
left join coursetee ct using (course_id)
where (LOWER(ct.tee_name) LIKE '%amateur%'
or lower(ct.tee_name) LIKE '%open%')
and c.state IN ("AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM");

select c.course_id, c.course_name, ct.tee_name, ct.tee_id, c.city, c.state, ct.par, ct.course_rating, ct.slope_rating, ct.yardage, ct.gender, ct.do_not_use
from course c
left join coursetee ct using (course_id)
where LOWER(ct.tee_name) LIKE '%test%'
and c.state IN ("AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM");


select count(tee_id) from coursetee;
select count(course_id) from course;


-- average length of longest M tee par 72
select c.course_id, ct.tee_id, c.course_name, c.city, c.state, ct.tee_name, ct.par, ct.course_rating, ct.slope_rating, ct.bogey_rating, ct.yardage, ct.gender
from course c
join coursetee ct on c.course_id = ct.course_id
where ct.par IN (72, 71)
and ct.gender = 'M'
LIMIT 200;

select AVG(max_yardage)
from (select MAX(ct.yardage) as max_yardage
	from course c
	join coursetee ct on c.course_id = ct.course_id
	where ct.par IN (73,72,71,70)
	and ct.gender = 'M'
    and c.state IN ("AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM")
	group by c.course_id) as yardages;


-- truncate coursetee;
-- SET FOREIGN_KEY_CHECKS=0;
-- truncate course;
-- SET FOREIGN_KEY_CHECKS=1;





select AVG(max_yardage), AVG(rating), AVG(slope)
from (select MAX(ct.yardage) as max_yardage, MAX(ct.course_rating) as rating, MAX(slope_rating) as slope
	from course c
	join coursetee ct on c.course_id = ct.course_id
	where ct.par IN (73,72,71,70)
	and ct.gender = 'M'
    and c.state IN ("AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM")
	group by c.course_id) as yardages;

select * from course;

commit;


-- top    
-- find average yarage, average par, and count of golf courses in each state    
select SUM(max_yardage) as total, AVG(max_yardage) as AVG_YARDAGE, SUM(ctpar) as totsum, AVG(ctpar) as AVG_PAR, COUNT(cid) as COUNT, cstate as STATE
from (select MAX(ct.yardage) as max_yardage, c.course_id as cid, c.state as cstate, MAX(ct.par) as cpar
	from course c
	join coursetee ct on c.course_id = ct.course_id
	where ct.gender = 'M'
	and (c.state IN ("AK","AL","AR","AZ","CA","CO","CT","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM")
	or (c.state = 'DC'
	and c.city = 'Washington'))
	and c.do_not_use = 'N'
	and ct.do_not_use = 'N'
    -- and ct.par NOT IN (73,72,71,70)
    group by c.course_id, c.state) as state_yardages
join (select cc.course_id as ccid, cct.yardage as ctyardage, cct.par as ctpar
	from course cc
	join coursetee cct using (course_id)
    where cct.gender = 'M'
	and (cc.state IN ("AK","AL","AR","AZ","CA","CO","CT","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM")
	or (cc.state = 'DC'
	and cc.city = 'Washington'))) as real_tees
    -- and cct.par NOT IN (73,72,71,70)) as real_tees
    on (max_yardage = ctyardage and cid = ccid)
group by cstate
order by AVG(max_yardage) desc;



select cc.course_id as ccid, cct.yardage as ctyardage, cct.par as ctpar
	from course cc
	join coursetee cct using (course_id)
    where cct.gender = 'M'
	and (cc.state IN ("AK"));
    -- and cct.par NOT IN (73,72,71,70




select c.course_id, ct.yardage, ct.par
from course c
join coursetee ct using (course_id)
limit 20;

-- bottom
select SUM(max_yardage), AVG(max_yardage), SUM(pars), AVG(pars), COUNT(ids), c_state
from (
	select 
	distinct(c.course_id) ids,
	FIRST_VALUE(ct.yardage) OVER (partition by ct.course_id order by ct.yardage desc) max_yardage,
	FIRST_VALUE(ct.par) OVER (partition by ct.course_id order by ct.yardage desc) pars,
	c.state as c_state
	from coursetee ct
	join course c on c.course_id = ct.course_id
	where ct.gender = 'M'
    and (c.state IN ("AK","AL","AR","AZ","CA","CO","CT","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM")
	or (c.state = 'DC'
	and c.city = 'Washington'))
    and ct.yardage != 0
    and ct.par != 0
	and ct.yardage IS NOT NULL
    and ct.par IS NOT NULL
    and c.do_not_use = 'N'
	and ct.do_not_use = 'N'
    ) as averages
GROUP BY c_state
ORDER BY c_state;
-- ORDER BY AVG(max_yardage) desc;

select 
	distinct(c.course_id) ids,
	FIRST_VALUE(ct.yardage) OVER (partition by ct.course_id order by ct.yardage desc) max_yardage,
	FIRST_VALUE(ct.par) OVER (partition by ct.course_id order by ct.yardage desc) pars,
	c.state as c_state
	from coursetee ct
	join course c on c.course_id = ct.course_id
	where ct.gender = 'M'
    and c.state IN ("MN")
    and c.do_not_use = 'N'
	and ct.do_not_use = 'N';
    
    
-- top    
-- find average yarage, average par, and count of golf courses in each state    
select SUM(max_yardage) as total, AVG(max_yardage) as AVG_YARDAGE, SUM(ctpar) as totsum, AVG(ctpar) as AVG_PAR, COUNT(cid) as COUNT, cstate as STATE
from (select MAX(ct.yardage) as max_yardage, c.course_id as cid, c.state as cstate, MAX(ct.par) as cpar
	from course c
	join coursetee ct on c.course_id = ct.course_id
	where ct.gender = 'M'
	and (c.state IN ("AK"))
    group by c.course_id, c.state) as state_yardages
join (select cc.course_id as ccid, cct.yardage as ctyardage, cct.par as ctpar
	from course cc
	join coursetee cct using (course_id)
    where cct.gender = 'M'
	and (cc.state IN ("AK"))) as real_tees
    on (max_yardage = ctyardage and cid = ccid)
group by cstate
order by AVG(max_yardage) desc;




-- USE for Average length
-- USE
-- bottom 2 -- use this for AVERAGES
select SUM(max_yardage), AVG(max_yardage), SUM(pars), AVG(pars), COUNT(ids), c_state
from (
	select 
	distinct(c.course_id) ids,
	FIRST_VALUE(ct.yardage) OVER (partition by ct.course_id order by ct.yardage desc) max_yardage,
	FIRST_VALUE(ct.par) OVER (partition by ct.course_id order by ct.yardage desc) pars,
	c.state as c_state
	from coursetee ct
	join course c on c.course_id = ct.course_id
	where ct.gender = 'M'
    and (c.state IN ("AK","AL","AR","AZ","CA","CO","CT","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM")
	or (c.state = 'DC'
	and c.city = 'Washington'))
    and ct.yardage != 0
    and ct.par != 0
    and ct.yardage IS NOT NULL
    and ct.par IS NOT NULL
    and c.do_not_use = 'N'
	and ct.do_not_use = 'N'
    ) as averages
GROUP BY c_state
ORDER BY c_state;







-- % of courses over 7000 yards
select cids, cids2, (cids2/cids)*100 as percentage
from (	
    select count(ids) as cids
    from(
    select 
	distinct(c.course_id) ids, 1,
	FIRST_VALUE(ct.yardage) OVER (partition by ct.course_id order by ct.yardage desc) max_yardage,
	FIRST_VALUE(ct.par) OVER (partition by ct.course_id order by ct.yardage desc) pars,
	c.state as c_state
	from coursetee ct
	join course c on c.course_id = ct.course_id
	where ct.gender = 'M'
    and (c.state IN ("AK","AL","AR","AZ","CA","CO","CT","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM")
	or (c.state = 'DC'
	and c.city = 'Washington'))
    and ct.yardage != 0
    and ct.par != 0
    and ct.yardage IS NOT NULL
    and ct.par IS NOT NULL
    and c.do_not_use = 'N'
	and ct.do_not_use = 'N') as total) as new_total
join (
	select count(ids2) as cids2
    from(
	select 
	distinct(ct.course_id) ids2, 2,
	FIRST_VALUE(ctt.yardage) OVER (partition by ctt.course_id order by ctt.yardage desc) max_yardage2,
	FIRST_VALUE(ctt.par) OVER (partition by ctt.course_id order by ctt.yardage desc) pars2,
	ct.state as c_state2
	from coursetee ctt
	join course ct on ct.course_id = ctt.course_id
	where ctt.gender = 'M'
    and (ct.state IN ("AK","AL","AR","AZ","CA","CO","CT","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM")
	or (ct.state = 'DC'
	and ct.city = 'Washington'))
    and ctt.yardage >= 7000
    and ctt.par != 0
    and ctt.yardage IS NOT NULL
    and ctt.par IS NOT NULL
    and ct.do_not_use = 'N'
	and ctt.do_not_use = 'N') as total2) new_total2;









select distinct(c.course_id) ids,
	FIRST_VALUE(ct.yardage) OVER (partition by ct.course_id order by ct.yardage desc) max_yardage,
	FIRST_VALUE(ct.par) OVER (partition by ct.course_id order by ct.yardage desc) pars,
	c.state as c_state
	from coursetee ct
	join course c on c.course_id = ct.course_id
	where ct.gender = 'M'
    and (c.state IN ("AK"))
    and ct.yardage != 0
    and ct.par != 0;

-- top 2
select SUM(max_yardage) as total_yardage, AVG(max_yardage) as avg_yardage, SUM(ctpar) as total_par, AVG(ctpar) as avg_par, COUNT(ccid) as total_courses, cstate as state
FROM 
	(select MAX(ct.yardage) as max_yardage, c.course_id as cid, c.state as cstate, MAX(ct.par) as cpar
	from course c
	join coursetee ct on c.course_id = ct.course_id
	where ct.gender = 'M'
	and (c.state IN ("AK","AL","AR","AZ","CA","CO","CT","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM")
	or (c.state = 'DC'
	and c.city = 'Washington'))
    and ct.yardage != 0
    and ct.par != 0
	and ct.yardage IS NOT NULL
    and ct.par IS NOT NULL
    and c.do_not_use = 'N'
	and ct.do_not_use = 'N'
    group by c.course_id, c.state) as max_courses
JOIN
    (select DISTINCT(cc.course_id) as ccid, cct.yardage as ctyardage, cct.par as ctpar
	from course cc
	join coursetee cct using (course_id)
    where cct.gender = 'M'
	and (cc.state IN ("AK","AL","AR","AZ","CA","CO","CT","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM")
	or (cc.state = 'DC'
	and cc.city = 'Washington'))
    and cct.yardage != 0
    and cct.par != 0
    and cct.yardage IS NOT NULL
    and cct.par IS NOT NULL
    and cc.do_not_use = 'N'
	and cct.do_not_use = 'N') as course_counts
on (max_yardage = ctyardage and cid = ccid)
group by cstate
order by cstate;

select MAX(ct.yardage) as max_yardage, c.course_id as cid, c.state as cstate, MAX(ct.par) as cpar
	from course c
	join coursetee ct on c.course_id = ct.course_id
	where ct.gender = 'M'
	and (c.state IN ("AK"))
    and ct.yardage != 0
    and ct.par != 0
	and ct.yardage IS NOT NULL
    and ct.par IS NOT NULL
    and c.do_not_use = 'N'
	and ct.do_not_use = 'N'
    group by c.course_id, c.state;
    
select DISTINCT(ccid), MAX(ctpar)
from (select DISTINCT(cc.course_id) as ccid, cct.yardage as ctyardage, cct.par as ctpar
	from course cc
	join coursetee cct using (course_id)
    where cct.gender = 'M'
	and (cc.state IN ("WI"))
    and cct.yardage != 0
    and cct.par != 0
    and cct.yardage IS NOT NULL
    and cct.par IS NOT NULL
    and cc.do_not_use = 'N'
	and cct.do_not_use = 'N') as test
group by ccid;
    
SELECT *
FROM coursetee
where course_id IN (
select dups.course_id
FROM (
	WITH duplicate_cte AS (
	select *,
	ROW_NUMBER() OVER(
	PARTITION BY course_id, gender, par, yardage) AS row_num
	FROM coursetee
	)
	SELECT *
	FROM duplicate_cte dc) dups
WHERE row_num > 1)
order by course_id;

select c.course_name, ct.tee_name, ct.yardage, ct.par, ct.course_rating, ct.slope_rating, ct.front_nine_rating, ct.front_nine_slope, ct.back_nine_rating, ct.back_nine_slope
from course c
join coursetee ct using (course_id)
where c.state = 'VA'
and c.course_name LIKE 'Robert Trent Jones%'
and ct.gender = 'M'
order by ct.yardage desc;

select * from coursetee
where course_id = 33307;