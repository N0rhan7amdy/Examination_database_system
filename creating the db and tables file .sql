



CREATE DATABASE ExaminationDB
ON PRIMARY
(
    NAME = 'ExaminationDB_Data',
    FILENAME = 'E:\iti\ExaminationDB_Data.mdf',  
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)

LOG ON
(
    NAME = 'ExaminationDB_Log',
    FILENAME = 'E:\iti\ExaminationDB_Log.ldf',  
    SIZE = 10MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 5MB
);


USE ExaminationDB;

CREATE TABLE Course
(
    course_id INT IDENTITY(1,1) PRIMARY KEY,
    course_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(255),
    min_degree FLOAT not null ,
    max_degree FLOAT not null,
    duration INT not null --  hours
);



CREATE TABLE Instructor
(
    instructor_id INT IDENTITY(1,1) PRIMARY KEY,
    ins_name NVARCHAR(100) NOT NULL,
   phone nvarchar(11)  not null,
    address NVARCHAR(255),
    training_manager INT,
    FOREIGN KEY (training_manager) REFERENCES Instructor(instructor_id)
);

ALTER TABLE Instructor
ALTER COLUMN phone CHAR(11);

ALTER TABLE Instructor
ADD CONSTRAINT CHK_Phone_Format CHECK (phone LIKE '01[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');


CREATE TABLE InstructorTeachCourse
(
    course_id INT PRIMARY KEY,
    instructor_id INT not null,
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);

CREATE TABLE Options 
(
option_id INT IDENTITY(1,1) PRIMARY KEY ,
option_text NVARCHAR(300) not null
);

CREATE TABLE QuestionsPool
(
    question_id INT IDENTITY (1,1) PRIMARY KEY,
    question_body NVARCHAR(MAX) NOT NULL,
    question_type NVARCHAR(20) CHECK (question_type IN ('text_question', 'true_false', 'mcq')) not null,
    degree FLOAT not null,
    correct_answer INT not null,
    FOREIGN KEY (correct_answer) REFERENCES Options(option_id)
);


create table Exam 
(
exam_id int identity(1,1) primary key ,
exam_type nvarchar(20) check (exam_type in ('normal_exam' , 'corrective_exam')) not null,
exam_degree int not null,
allowance_option bit not null
);



create table Students 
(
student_id int identity(1,1) primary key ,
student_name nvarchar(50) not null,
NID int not null ,
phone nvarchar(11)  not null,
age int check (age between 20 and 33) not null,

gender char(1) check (gender in ('M' , 'F' )) not null,
military_status nvarchar(30) not null,
--constraint CHK_Military_Status check (
        --(gender = 'M' AND military_status IS NOT NULL) OR
      --  (gender = 'F' AND military_status = 'NA')
   -- )

);

create table Intake 
(
intake_id int identity(1,1) primary key ,
intake_name nvarchar(30) not null,

);

create table Branch 
(
branch_id int identity(1,1) primary key ,
branch_name nvarchar(50) not null
);

create table Track 
(
track_id int identity(1,1) primary key ,
track_name nvarchar(50) not null
);

create table Department 
(
dept_id int identity(1,1) primary key ,
dept_name nvarchar(50) not null
);


create table StudentTakeExam 
(
std_ex_id int primary key ,
student_id int not null,
exam_id int not null ,
question_id int not null,
student_answer nvarchar(max) ,
question_result int ,

FOREIGN KEY (student_id) REFERENCES Students(student_id),
foreign key (exam_id) references Exam(exam_id),
foreign key (question_id) references QuestionsPool(question_id)

);

CREATE TABLE InstructorSelectedStudents 
(
selected_std_id int primary key ,
student_id int not null ,
instructor_id int  not null,
exam_id int  not null,
FOREIGN KEY (student_id) REFERENCES Students(student_id),
FOREIGN KEY (instructor_id) references Instructor(instructor_id),
foreign key (exam_id) references Exam(exam_id)

);

create table ExamQuestions
(
ex_ques_id int primary key ,
exam_id int not null ,
question_id int not null ,
foreign key (exam_id) references Exam(exam_id),
foreign key (question_id) references QuestionsPool(question_id)

)
;

create table CourseExam 
(
course_exam_id int primary key ,
exam_id int not null,
course_id int not null ,
foreign key (exam_id) references Exam(exam_id),
foreign key (course_id) references Course(course_id)

);

CREATE TABLE InstructorMakeExam
(
    exam_id INT not null,
    instructor_id INT not null,
    start_time TIME not null,
    end_time TIME not null,
    exam_date DATE,
    year INT not null,
    PRIMARY KEY (exam_id),
    FOREIGN KEY (exam_id) REFERENCES Exam(exam_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);

create table InstructorChoosesQuestion
(
question_id int not null ,
instructor_id int not null ,
primary key (question_id),
foreign key (question_id) references QuestionsPool(question_id),
foreign key (instructor_id) references Instructor(instructor_id)
);


create table DepartmentTracks 
(
track_id int not null ,
dept_id int  not null,
primary key (track_id),
foreign key (track_id) references Track(track_id),
foreign key (dept_id) references Department(dept_id)

);

create table CourseQuestions 
(
question_id int not null,
course_id int not null ,
primary key (course_id),
foreign key (question_id) references QuestionsPool(question_id),
foreign key (course_id) references Course(course_id)

);

create table StudentIntake 
(
std_intake_id int primary key ,
student_id int not null ,
intake_id int not null ,
foreign key (student_id) references Students(student_id),
foreign key (intake_id) references Intake(intake_id)

);


create table StudentBranch

(
student_id int not null ,
branch_id int not null ,
primary key (student_id) ,
foreign key (student_id) references Students(student_id),
foreign key (branch_id) references Branch(branch_id)
);

create table StudentTrack

(
student_id int not null,
track_id int  not null,
primary key (student_id) ,
foreign key (student_id) references Students(student_id),
foreign key (track_id) references Track(track_id)

);

create table TrackCourses 

(
track_cr_id int primary key ,
course_id int not null ,
track_id int not null,
foreign key (course_id) references Course(course_id),
foreign key (track_id) references Track(track_id)


);

ALTER TABLE [dbo].[Department]
ADD [branch_id] [int] ;


ALTER TABLE [dbo].[Department]  WITH CHECK ADD CONSTRAINT FK_Department_Branch
FOREIGN KEY([branch_id])
REFERENCES [dbo].[Branch] ([branch_id]);

CREATE TABLE Classes (
    class_id INT identity(1,1) PRIMARY KEY ,
    course_id INT NOT NULL,
    instructor_id INT NOT NULL,
    Year INT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);


