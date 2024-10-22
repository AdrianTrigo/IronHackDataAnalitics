USE ironhack_dapt;
CREATE SCHEMA ironhack_school;

CREATE TABLE school (
    school_id INTEGER NOT NULL PRIMARY KEY,
    school_name VARCHAR(34),
    city  VARCHAR(34)
);

CREATE TABLE student (
    student_id INTEGER NOT NULL PRIMARY KEY,
    student_name VARCHAR(34),
    city  VARCHAR(34),
    school_id INTEGER,
    GPA FLOAT,
    FOREIGN KEY (school_id) REFERENCES school(school_id)
);

INSERT INTO school 
	(school_id,school_name,city) 
VALUES
(1,	'Stanford',	'Stanford'),
(2,	'University of California',	'San Francisco'),
(3,	'Harvard University',	'New York'),
(4,	'MIT',	'Boston'),
(5,	'Yale',	'New Haven'),
(6,	'University of Westminster',	'London'),
(7,	'Corvinus University',	'Budapest');


INSERT INTO student 
	(student_id,student_name,city,school_id,GPA) 
VALUES
(1001, 'Peter Brebec','New York',		1,	4	),
(1002, 'John Goorgy','San Francisco',	2,	3.1	),
(2003, 'Brad Smith','New York',			3,	2.9	),
(1004, 'Fabian Johns','Boston',			5,	2.1	),
(1005, 'Brad Cameron','Stanford',		1,	2.3	),
(1006, 'Geoff Firby','Boston',			5,	1.2	),
(1007, 'Johnny Blue','New Haven',		2,	3.8	),
(1008, 'Johse Brook','Miami',			2,	3.4	);




