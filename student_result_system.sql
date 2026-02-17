CREATE DATABASE StudentResultSystem;
USE StudentResultSystem;

CREATE TABLE Students (
student_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
class VARCHAR(20),
roll_no INT UNIQUE
);

CREATE TABLE Subjects (
subject_id INT PRIMARY KEY AUTO_INCREMENT,
subject_name VARCHAR(50)
);

CREATE TABLE Marks (
mark_id INT PRIMARY KEY AUTO_INCREMENT,
student_id INT,
subject_id INT,
marks INT,
FOREIGN KEY (student_id) REFERENCES Students(student_id),
FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

CREATE TABLE Grades (
grade_id INT PRIMARY KEY AUTO_INCREMENT,
min_marks INT, 
max_marks INT,
grade CHAR(2)
);

INSERT INTO Students (name, class, roll_no)
VALUES
('Amit', 'BCA', 1),
('Divya', 'BCA', 2),
('Riya', 'BCA', 3);

INSERT INTO Subjects (subject_name)
VALUES
('HTML'), ('Java'), ('Python');

INSERT Marks (student_id, subject_id, marks)
VALUES
(1,1,85), (1,2,90), (1,3,78),
(2,1,88), (2,2,86), (2,3,98),
(3,1,60), (3,2,78), (3,3,82);

INSERT INTO Grades (min_marks, max_marks, grade)
VALUES
(90,100,'A+'),
(80,89,'A'),
(70,79,'B'),
(60,69,'C'),
(0,59,'F');

-- JOIN operations
SELECT s.name, sub.subject_name, m.marks FROM Marks m
JOIN Students s ON m.student_id= s.student_id
JOIN Subjects sub ON m.subject_id= sub.subject_id;

-- Calculate average marks
SELECT s.name, AVG(m.marks) AS average_marks
FROM Marks m JOIN Students s ON m.student_id=
s.student_id GROUP BY s.name;

-- finding top performer
SELECT s.name, SUM(m.marks) AS total_marks
FROM Marks m JOIN Students s ON m.student_id=
s.student_id GROUP BY s.name
ORDER BY total_marks DESC LIMIT 1;

-- Assign grades
SELECT s.name, sub.subject_name, m.marks, g.grade
FROM Marks m JOIN Students s ON m.student_id=
s.student_id JOIN Subjects sub ON m.subject_id=
sub.subject_id JOIN Grades g ON m.marks BETWEEN 
g.min_marks AND g.max_marks;

-- Having clause
SELECT s.name, AVG(m.marks) AS avg_marks 
FROM Marks m JOIN 
Students s ON m.student_id=
s.student_id GROUP BY s.name 
HAVING avg_marks >80;

-- Subquery
SELECT name FROM Students
WHERE student_id IN (
SELECT student_id FROM Marks 
GROUP BY student_id HAVING AVG(marks) >
(SELECT AVG(marks) FROM Marks)
);