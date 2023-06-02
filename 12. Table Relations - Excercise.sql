/*1. One-To-One Relationship
Create two tables as follows. Use appropriate data types
Insert the data from the example above.
• Alter table people and make person_id a primary key.
• Create a foreign key between people and passports by using the passport_id column.
• Think about which passport field should be UNIQUE.
• Format salary to second digit after decimal point.
Submit your queries by using "MySQL run queries & check DB" strategy.*/

CREATE TABLE people (
    person_id INT UNIQUE NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10 , 2 ) DEFAULT 0,
    passport_id INT UNIQUE
);

CREATE TABLE passports (
    passport_id INT PRIMARY KEY AUTO_INCREMENT,
    passport_number VARCHAR(8) UNIQUE
);

ALTER TABLE people
ADD CONSTRAINT pk_people
PRIMARY KEY (person_id),
ADD CONSTRAINT fk_people_passports
FOREIGN KEY (passport_id)
REFERENCES passports(passport_id);

INSERT INTO passports(passport_id, passport_number)
VALUE (101, 'N34FG21B'), 
(102, 'K65LO4R7'), 
(103, 'ZE657QP2');

INSERT INTO people(first_name, salary, passport_id)
VALUEs ('Roberto', 43300.00, 102), ('Tom', 56100.00, 103), ('Yana', 60200.00, 101);

/*2. One-To-Many Relationship
Create two tables as follows. Use appropriate data types.
Insert the data from the example above.
• Add primary and foreign keys.
Submit your queries by using "MySQL run queries & check DB" strategy  */

CREATE TABLE manufacturers (
    manufacturer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL,
    established_on DATE NOT NULL
);

CREATE TABLE models (
    model_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL,
    manufacturer_id INT,
    CONSTRAINT fk_models_manufacturers FOREIGN KEY (manufacturer_id)
        REFERENCES manufacturers (manufacturer_id)
);

ALTER TABLE models AUTO_INCREMENT = 101;

INSERT INTO manufacturers (name, established_on) 
VALUES ('BMW', '1916-03-01'),
('Tesla', '2003-01-01'),
('Lada', '1966-05-01');

INSERT INTO models (name, manufacturer_id) 
VALUES ('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova', 3);

/*3. Many-To-Many Relationship
Create three tables as follows. Use appropriate data types.
Insert the data from the example above.
• Add primary and foreign keys.
• Have in mind that the table student_exams should have a
composite primary key.
Submit your queries by using "MySQL run queries & check DB" strategy.*/

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);
CREATE TABLE exams (
    exam_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
)  AUTO_INCREMENT=101;
CREATE TABLE students_exams (
    student_id INT,
    exam_id INT,
    CONSTRAINT pk_students_exams PRIMARY KEY (exam_id , student_id),
    CONSTRAINT fk_students_exams_exam FOREIGN KEY (exam_id)
        REFERENCES exams (exam_id),
    CONSTRAINT fk_exams_students FOREIGN KEY (student_id)
        REFERENCES students (student_id)
);
INSERT INTO students (name)
VALUES ('Mila'),
('Toni'),
('Ron');

INSERT INTO exams (name)
VALUES ('Spring MVC'),
('Neo4j'),
('Oracle 11g');

INSERT INTO students_exams
VALUE 
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);

/*4. Self-Referencing
Create a single table as follows. Use appropriate data types.
Insert the data from the example above.
• Add primary and foreign keys.
• The foreign key should be between manager_id and teacher_id.
Submit your queries by using " MySQL run queries & check DB" strategy.*/

CREATE TABLE `teachers` (
	`teacher_id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    `manager_id` INT UNSIGNED DEFAULT NULL
) AUTO_INCREMENT=101;

INSERT 
	INTO `teachers`
		(`name`, `manager_id`)
    VALUES
		('John', NULL),
        ('Maya', 106),
        ('Silvia', 106),
        ('Ted', 105),
        ('Mark', 101),
        ('Greta', 101);

ALTER TABLE `teachers`
	ADD CONSTRAINT `pk_teachers` 
		PRIMARY KEY (`teacher_id`),
	ADD CONSTRAINT `fk_teacher_manager_id`
		FOREIGN KEY (`manager_id`)
        REFERENCES `teachers`(`teacher_id`);
	
/*5. Online Store Database
Create a new database and design the following structure:
Submit your queries by using "MySQL run queries & check DB" strategy.*/

CREATE TABLE `item_types` (
	`item_type_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `items` (
	`item_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `item_type_id` INT NOT NULL,
    CONSTRAINT `fk_items_item_types` 
		FOREIGN KEY (`item_type_id`) 
        REFERENCES `item_types` (`item_type_id`)
);

CREATE TABLE `cities` (
	`city_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `customers` (
	`customer_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `birthday` DATE,
    `city_id` INT NOT NULL,
    CONSTRAINT `fk_customers_cities` 
		FOREIGN KEY (`city_id`) 
        REFERENCES `cities` (`city_id`)
);

CREATE TABLE `orders` (
	`order_id` INT PRIMARY KEY AUTO_INCREMENT,
    `customer_id` INT NOT NULL,
    CONSTRAINT `fk_orders_customers` 
		FOREIGN KEY (`customer_id`) 
        REFERENCES `customers` (`customer_id`)
);

CREATE TABLE `order_items` (
    `order_id` INT NOT NULL,
    `item_id` INT NOT NULL,
    CONSTRAINT `pk_order_items` PRIMARY KEY (`order_id` , `item_id`),
    CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`order_id`)
        REFERENCES `orders` (`order_id`),
    CONSTRAINT `fk_order_items_items` FOREIGN KEY (`item_id`)
        REFERENCES `items` (`item_id`)
);

/*6. University Database
Create a new database and design the following structure:
Submit your queries by using "MySQL run queries & check DB" strategy.*/

CREATE TABLE subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(50)
);
CREATE TABLE majors (
    major_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(50),
    student_number VARCHAR(12),
	major_id INT,
    CONSTRAINT fk_students_majors FOREIGN KEY (major_id)
        REFERENCES majors (major_id)
);
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_date DATE,
    payment_amount DECIMAL(8 , 2 ),
    student_id INT,
    CONSTRAINT fk_payments_students FOREIGN KEY (student_id)
        REFERENCES students (student_id)
);
CREATE TABLE agenda (
    student_id INT,
    subject_id INT,
    CONSTRAINT pk_agenda PRIMARY KEY (student_id , subject_id),
    CONSTRAINT fk_agenda_students FOREIGN KEY (student_id)
        REFERENCES students (student_id),
    CONSTRAINT fk_agenda_subjects FOREIGN KEY (subject_id)
        REFERENCES subjects (subject_id)
);

/*7. SoftUni Design
Create an E/R Diagram of the SoftUni Database. There are some special relations you should check out: employees
are self-referenced (manager_id) and departments have One-to-One with the employees (manager_id) while the
employees have One-to-Many (department_id). You might find it interesting how it looks on а diagram.*/

E/R Diagram

/*8. Geography Design
Create an E/R Diagram of the Geography Database.*/

E/R Diagram

/*9. Peaks in Rila
Display all peaks for "Rila" mountain_range. Include:
• mountain_range
© SoftUni – about.softuni.bg. Copyrighted document. Unauthorized copy, reproduction or use is not permitted.
 Follow us: Page 5 of 5
• peak_name
• peak_elevation
Peaks should be sorted by peak_elevation descending.*/

SELECT 
    m.mountain_range,
    p.peak_name,
    p.elevation AS 'peak_elevation'
FROM
    mountains AS m
        JOIN
    peaks AS p ON m.id = p.mountain_id
WHERE
    mountain_range = 'Rila'
ORDER BY `peak_elevation` DESC
