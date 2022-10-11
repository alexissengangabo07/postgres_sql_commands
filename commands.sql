BEGIN TRANSACTION;

CREATE DATABASE go_univ;

CREATE USER admin;

CREATE USER agent;

CREATE USER etudiant;

CREATE TABLE IF NOT EXISTS staff(
	staff_no serial PRIMARY KEY,
	name VARCHAR(30) UNIQUE NOT NULL,
	province VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS student(
	student_id serial PRIMARY KEY,
	name VARCHAR(30) UNIQUE NOT NULL,
	province VARCHAR(30),
	staff_no INT,
	FOREIGN KEY (staff_no) REFERENCES staff(staff_no)
);

CREATE TABLE IF NOT EXISTS course(
	course_code serial PRIMARY KEY,
	titre VARCHAR(30) UNIQUE NOT NULL,
	credit INT,
	quota INT,
	staff_no INT,
	FOREIGN KEY (staff_no) REFERENCES staff(staff_no)
);

CREATE TABLE IF NOT EXISTS enrollment(
	student_id INT NOT NULL,
	course_code INT NOT NULL,
	date_enrolled DATE DEFAULT CURRENT_DATE,
	final_grade INT,
	PRIMARY KEY(student_id, course_code),
	FOREIGN KEY (student_id) REFERENCES student(student_id),
	FOREIGN KEY (course_code) REFERENCES course(course_code)
);

CREATE TABLE IF NOT EXISTS assignment(
	student_id INT NOT NULL,
	course_code INT NOT NULL,
	assignment SERIAL,
	grade INT,
	PRIMARY KEY(student_id, course_code, assignment),
	FOREIGN KEY (student_id) REFERENCES student(student_id),
	FOREIGN KEY (course_code) REFERENCES course(course_code)
);


ALTER DATABASE gouniv OWNER  TO admin;

GRANT ALL PRIVILEGES ON TABLE student, Course TO agent;

GRANT SELECT ON TABLE staff TO agent;

GRANT SELECT ON TABLE student, course TO etudiant;

GRANT CONNECT ON DATABASE gouniv TO agent, etudiant;

INSERT INTO staff(name, province) VALUES ('Alexis Senga', 'Sud-kivu'), ('Senga Ngabo', 'Kasai'), ('Alexis Ngabo', 'Nord-kivu'), ('Senga Ngabo', 'Equateur'), ('Alexis Bahati Senga', 'Ituri'), ('Bahati Senga', 'Bandundu'), ('Alexis Baraka Senga', 'Kinshasa');

INSERT INTO student(name, province, staff_no) VALUES ('Junior Baraka','Maniema', 1), ('Junior Baraka2','Maniema', 1), ('Junior Baraka3','Maniema', 1), ('Junior Baraka4','Maniema', 1), ('Junior Baraka5','Maniema', 1);

INSERT INTO course(titre, credit, quota, staff_no) VALUES ('Informatique', 1, 1, 1), ('Mathematique', 1, 1, 1), ('Histoire', 1, 1, 1), ('Dessin', 1, 1, 1), ('Physique', 1, 1, 1);

INSERT INTO enrollment(student_id, course_code, final_grade) VALUES (1, 1, 2);

INSERT INTO assignment(student_id, course_code, grade) VALUES (1, 1, 2);

COMMIT;
