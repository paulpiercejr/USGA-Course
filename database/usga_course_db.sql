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

LOAD DATA INFILE '/course_files/course_list-2024.csv'
IGNORE INTO TABLE course
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/course_files/tee_info-2024.csv'
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
