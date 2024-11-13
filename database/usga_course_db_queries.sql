use usga_course;

-- select 100 hardest courses by course_rating
select ct.tee_id,c.course_id, c.course_name,c.city,c.state,ct.tee_name,ct.par,ct.course_rating,ct.slope_rating, ct.bogey_rating, ct.yardage
from coursetee ct
left join course c on ct.course_id = c.course_id
where gender = 'M'
AND state = 'VA'
AND c.do_not_use = 'N'
AND ct.do_not_use = 'N'
group by ct.tee_id, c.course_id, c.course_name,c.city,c.state,ct.tee_name,ct.par,ct.course_rating,ct.slope_rating, ct.bogey_rating
order by ct.course_rating desc, ct.slope_rating desc, ct.bogey_rating desc
limit 100;

-- run queries to test specific courses by name (type names in lowercase)
select c.course_id, ct.tee_id, c.course_name, c.city, c.state,ct.tee_name, ct.par, ct.course_rating, ct.slope_rating, ct.bogey_rating, ct.yardage
from course c
join coursetee ct on c.course_id = ct.course_id
where LOWER(c.course_name) like '%erin hills%'
AND ct.gender = 'M'
order by ct.course_rating desc;

-- run queries for test cases (change course_rating, slope_rating, and gender to test different outcomes)
select c.course_id,c.course_name,c.city,c.state,ct.tee_name,ct.course_rating,ct.slope_rating
from coursetee ct
join course c on ct.course_id = c.course_id
WHERE course_rating = 69.8
AND slope_rating = 128
AND gender = 'M'
ORDER BY state;

-- find all courses that are rated for Open or Amateur events in US territories
select c.course_id, c.course_name, ct.tee_name, c.city, c.state, ct.par, ct.course_rating, ct.slope_rating, ct.yardage, ct.gender
from course c
left join coursetee ct using (course_id)
where (LOWER(ct.tee_name) LIKE '%amateur%'
or lower(ct.tee_name) LIKE '%open%')
and c.state IN ("AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM");

-- count tees and courses
select count(tee_id) from coursetee;
select count(course_id) from course;

-- average length of longest M tee with par 70-73
select AVG(max_yardage)
from (select MAX(ct.yardage) as max_yardage
	from course c
	join coursetee ct on c.course_id = ct.course_id
	where ct.par IN (73,72,71,70)
	and ct.gender = 'M'
    	and c.state IN ("AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM")
	group by c.course_id) as yardages;

-- average length, rating, and slope of longest M tee with par 70-73
select AVG(max_yardage), AVG(rating), AVG(slope)
from (select MAX(ct.yardage) as max_yardage, MAX(ct.course_rating) as rating, MAX(slope_rating) as slope
	from course c
	join coursetee ct on c.course_id = ct.course_id
	where ct.par IN (73,72,71,70)
	and ct.gender = 'M'
    	and c.state IN ("AK","AL","AR","AZ","CA","CO","CT","DC","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM")
	group by c.course_id) as yardages;
  
-- find average yardage, average par, and count of golf courses in each state    
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
    group by c.course_id, c.state) as state_yardages
join (select cc.course_id as ccid, cct.yardage as ctyardage, cct.par as ctpar
	from course cc
	join coursetee cct using (course_id)
    where cct.gender = 'M'
	and (cc.state IN ("AK","AL","AR","AZ","CA","CO","CT","DE","FL","GA","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MS","MO","MT","NC","NE","NH","NJ","NM","NV","NY","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY","AS","GU","MP","PR","VI","UM")
	or (cc.state = 'DC'
	and cc.city = 'Washington'))) as real_tees
    on (max_yardage = ctyardage and cid = ccid)
group by cstate
order by AVG(max_yardage) desc;

-- select course id, yardage and par of each set of tees, list 20 to confirm records
select c.course_id, ct.yardage, ct.par
from course c
join coursetee ct using (course_id)
limit 20;

-- select the longest yardage and the corresponding par of each unique course in Minnesota where the tees are rated for men and the course and tees are legitimate
select distinct(c.course_id) ids,
	FIRST_VALUE(ct.yardage) OVER (partition by ct.course_id order by ct.yardage desc) max_yardage,
	FIRST_VALUE(ct.par) OVER (partition by ct.course_id order by ct.yardage desc) pars,
	c.state as c_state
from coursetee ct
join course c on c.course_id = ct.course_id
where ct.gender = 'M'
	and c.state IN ("MN")
	and c.do_not_use = 'N'
	and ct.do_not_use = 'N';
       
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


-- list total number of courses, number of courses over 7000 yards, and % of courses over 7000 yards in the United States from the longest mens tees
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


-- USE for Average length as more accurate
-- list the total yardage, average yardage, total par, average par, and total number of courses in each state from the longest set on mens tees
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


-- list the total yardage, average yardage, total par, average par, and total number of courses in each state from the longest set on mens tees
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


-- bottom - same as above, but another way to compare
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


-- list the max yardage and par of every course in Alaska for men where the length is not ZERO
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


-- list the max yardage and par of very course in Alaska for men
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


-- get the highest par of each course by course id in Wisconsin where tee has legitimate par and distance values   
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
    

-- select all duplicate records in the course tee table where course_id, gender, par, and yardage are the same
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


-- get records on each Mens tee at Robert Trent Jones Golf Club in Virginia and order them by yardage longest to shortest
select c.course_name, ct.tee_name, ct.yardage, ct.par, ct.course_rating, ct.slope_rating, ct.front_nine_rating, ct.front_nine_slope, ct.back_nine_rating, ct.back_nine_slope
from course c
join coursetee ct using (course_id)
where c.state = 'VA'
and c.course_name LIKE 'Robert Trent Jones%'
and ct.gender = 'M'
order by ct.yardage desc;

