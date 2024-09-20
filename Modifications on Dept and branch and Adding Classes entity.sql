use ExaminationDB;


ALTER TABLE [dbo].[Department]
ADD [branch_id] [int] ;


ALTER TABLE [dbo].[Department]  WITH CHECK ADD CONSTRAINT FK_Department_Branch
FOREIGN KEY([branch_id])
REFERENCES [dbo].[Branch] ([branch_id]);

CREATE TABLE Classes (
    class_id INT PRIMARY KEY ,
    course_id INT NOT NULL,
    instructor_id INT NOT NULL,
    Year INT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);



