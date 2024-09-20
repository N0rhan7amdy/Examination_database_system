--Function to calculate student's exam result--
CREATE FUNCTION dbo.CalculateStudentExamResult (@student_id INT, @exam_id INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @totalDegree FLOAT;
    SELECT @totalDegree = SUM(q.degree)
    FROM StudentTakeExam ste
    JOIN QuestionsPool q ON ste.question_id = q.question_id
    WHERE ste.student_id = @student_id AND ste.exam_id = @exam_id AND ste.question_result = 1;
    RETURN @totalDegree;
END;

--------------------------------------------------------
--Text Question Validation Using Regex
CREATE FUNCTION dbo.ValidateTextAnswer (@student_answer NVARCHAR(MAX), @correct_answer NVARCHAR(MAX))
RETURNS BIT
AS
BEGIN
    DECLARE @result BIT;
    IF @student_answer LIKE @correct_answer
        SET @result = 1;
    ELSE
        SET @result = 0;
    RETURN @result;
END;

--------------------------------------------------------
--Stored Procedure for adding a new question--
CREATE PROC dbo.AddQuestion
    @question_body NVARCHAR(MAX),
    @question_type NVARCHAR(20),
    @degree FLOAT,
    @correct_answer INT
AS
BEGIN
    INSERT INTO QuestionsPool (question_body, question_type, degree, correct_answer)
    VALUES (@question_body, @question_type, @degree, @correct_answer);
END;
--------------------------------------------------------
--Procedure to Add a New Instructor--
CREATE PROCEDURE AddInstructor
    @ins_name NVARCHAR(100),
    @phone NVARCHAR(11),
    @address NVARCHAR(255),
    @training_manager INT
AS
BEGIN
    INSERT INTO Instructor (ins_name, phone, address, training_manager)
    VALUES (@ins_name, @phone, @address, @training_manager);
END
--------------------------------------------------------
--Procedure to Add a New Course--
CREATE PROCEDURE AddCourse
    @course_name NVARCHAR(100),
    @description NVARCHAR(255),
    @min_degree FLOAT,
    @max_degree FLOAT,
    @duration INT
AS
BEGIN
    INSERT INTO Course (course_name, description, min_degree, max_degree, duration)
    VALUES (@course_name, @description, @min_degree, @max_degree, @duration);
END

--------------------------------------------------------
--Stored Procedure for creating an exam--
CREATE PROC dbo.CreateExam
    @exam_type NVARCHAR(20),
    @exam_degree INT,
    @allowance_option BIT,
    @instructor_id INT,
    @start_time TIME,
    @end_time TIME,
    @exam_date DATE,
    @year INT,
    @course_id INT
AS
BEGIN
    DECLARE @exam_id INT;
    
    INSERT INTO Exam (exam_type, exam_degree, allowance_option)
    VALUES (@exam_type, @exam_degree, @allowance_option);

    SET @exam_id = SCOPE_IDENTITY();

    INSERT INTO InstructorMakeExam (exam_id, instructor_id, start_time, end_time, exam_date, year)
    VALUES (@exam_id, @instructor_id, @start_time, @end_time, @exam_date, @year);

    INSERT INTO CourseExam (exam_id, course_id)
    VALUES (@exam_id, @course_id);

	INSERT INTO ExamQuestions (exam_id, question_id)
    VALUES (@exam_id, @course_id);
END;

--------------------------------------------------------
--Procedure to Assign Questions to an Exam by an Instructor
CREATE PROCEDURE AssignQuestionsToExam
    @exam_id INT,
    @instructor_id INT,
    @question_ids NVARCHAR(MAX)
AS
BEGIN
    -- Split the question_ids string into individual question_ids
    DECLARE @question_id INT
    DECLARE @questions_table TABLE (question_id INT)

    WHILE CHARINDEX(',', @question_ids) > 0
    BEGIN
        SET @question_id = LEFT(@question_ids, CHARINDEX(',', @question_ids) - 1)
        SET @question_ids = RIGHT(@question_ids, LEN(@question_ids) - CHARINDEX(',', @question_ids))
        INSERT INTO @questions_table (question_id) VALUES (@question_id)
    END
    INSERT INTO @questions_table (question_id) VALUES (@question_ids)

    -- Check if the instructor is allowed to add questions to this exam
    DECLARE @course_id INT
    SELECT @course_id = course_id FROM CourseExam WHERE exam_id = @exam_id
    IF NOT EXISTS (SELECT 1 FROM InstructorTeachCourse WHERE instructor_id = @instructor_id AND course_id = @course_id)
    BEGIN
        RAISERROR('Instructor is not allowed to add questions to this exam.', 16, 1)
        RETURN
    END

    -- Insert the questions into the ExamQuestions table
    INSERT INTO ExamQuestions (exam_id, question_id)
    SELECT @exam_id, question_id FROM @questions_table
END

--------------------------------------------------------
--Random Selection of Questions for Exams--
CREATE PROCEDURE dbo.SelectRandomQuestions
    @course_id INT,
    @mcq_count INT,
    @tf_count INT,
    @text_count INT
AS
BEGIN
    SELECT TOP (@mcq_count) qp.question_id 
    INTO #mcq_temp
    FROM QuestionsPool qp
	join CourseQuestions cq
	on qp.question_id = cq.question_id
    WHERE cq.course_id = @course_id AND qp.question_type = 'mcq'
    ORDER BY NEWID();
    
    SELECT TOP (@tf_count) qp.question_id 
    INTO #tf_temp
    FROM QuestionsPool qp
	join CourseQuestions cq
	on qp.question_id = cq.question_id
    WHERE cq.course_id = @course_id AND qp.question_type = 'true_false'
    ORDER BY NEWID();

    SELECT TOP (@text_count) qp.question_id 
    INTO #text_temp
    FROM QuestionsPool qp
	join CourseQuestions cq
	on qp.question_id = cq.question_id
    WHERE cq.course_id = @course_id AND qp.question_type = 'text_question'
    ORDER BY NEWID();

    SELECT question_id FROM #mcq_temp
    UNION ALL
    SELECT question_id FROM #tf_temp
    UNION ALL
    SELECT question_id FROM #text_temp;
END;
--------------------------------------------------------
--Stored Procedure for student registration--
CREATE PROCEDURE dbo.RegisterStudent
    @student_name NVARCHAR(50),
    @NID INT,
    @phone NVARCHAR(11),
    @age INT,
    @gender CHAR(1),
    @military_status NVARCHAR(30),
    @intake_id INT,
    @branch_id INT,
    @track_id INT
AS
BEGIN
    DECLARE @student_id INT;

    INSERT INTO Students (student_name, NID, phone, age, gender, military_status)
    VALUES (@student_name, @NID, @phone, @age, @gender, @military_status);

    SET @student_id = SCOPE_IDENTITY();

    INSERT INTO StudentIntake (student_id, intake_id)
    VALUES (@student_id, @intake_id);

    INSERT INTO StudentBranch (student_id, branch_id)
    VALUES (@student_id, @branch_id);

    INSERT INTO StudentTrack (student_id, track_id)
    VALUES (@student_id, @track_id);
END;

--------------------------------------------------------
--Stored Procedure for instructor assignment--
CREATE PROCEDURE dbo.AssignInstructor
    @instructor_id INT,
    @course_id INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM InstructorTeachCourse WHERE course_id = @course_id)
    BEGIN
        UPDATE InstructorTeachCourse
        SET instructor_id = @instructor_id
        WHERE course_id = @course_id;
    END
    ELSE
    BEGIN
        INSERT INTO InstructorTeachCourse (course_id, instructor_id)
        VALUES (@course_id, @instructor_id);
    END
END;

--------------------------------------------------------
--Procedures for Adding and Editing Branch, Track, Department, Intake--
-- Add new Branch
CREATE PROCEDURE dbo.AddBranch
    @branch_name NVARCHAR(50)
AS
BEGIN
    INSERT INTO Branch (branch_name)
    VALUES (@branch_name);
END;

-- Add new Track
CREATE PROCEDURE dbo.AddTrack
    @track_name NVARCHAR(50)
AS
BEGIN
    INSERT INTO Track (track_name)
    VALUES (@track_name);
END;

-- Add new Department
CREATE PROCEDURE dbo.AddDepartment
    @dept_name NVARCHAR(50),
    @branch_id INT
AS
BEGIN
    INSERT INTO Department (dept_name, branch_id)
    VALUES (@dept_name, @branch_id);
END;

-- Add new Intake
CREATE PROCEDURE dbo.AddIntake
    @intake_name NVARCHAR(30)
AS
BEGIN
    INSERT INTO Intake (intake_name)
    VALUES (@intake_name);
END;

--------------------------------------------------------
--Trigger to ensure the total degree of an exam does not exceed the course max degree--
CREATE TRIGGER trg_ExamDegree
ON Exam
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @exam_id INT, @course_id INT, @exam_degree INT, @max_degree FLOAT;
    SELECT @exam_id = inserted.exam_id, @exam_degree = inserted.exam_degree
    FROM inserted;
    
    SELECT @course_id = course_id
    FROM CourseExam
    WHERE exam_id = @exam_id;
    
    SELECT @max_degree = max_degree
    FROM Course
    WHERE course_id = @course_id;
    
    IF @exam_degree > @max_degree
    BEGIN
        ROLLBACK;
        print 'The total degree of the exam exceeds the course max degree';
    END
END;

--------------------------------------------------------
--Trigger to prevent deletion of a course if it has associated exams--
CREATE TRIGGER trg_PreventCourseDeletion
ON Course
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM CourseExam WHERE course_id IN (SELECT course_id FROM deleted))
    BEGIN
        print 'Cannot delete a course with associated exams';
    END
    ELSE
    BEGIN
        DELETE FROM Course WHERE course_id IN (SELECT course_id FROM deleted);
    END
END;

--------------------------------------------------------
--View to display all courses with instructors--
CREATE VIEW vw_CourseInstructors AS
SELECT c.course_id, c.course_name, i.ins_name
FROM Course c
JOIN InstructorTeachCourse itc ON c.course_id = itc.course_id
JOIN Instructor i ON itc.instructor_id = i.instructor_id;

--------------------------------------------------------
--View to display student exam results--
CREATE VIEW vw_StudentExamResults AS
SELECT s.student_id, s.student_name, e.exam_id, e.exam_type, ste.question_id, ste.question_result
FROM Students s
JOIN StudentTakeExam ste ON s.student_id = ste.student_id
JOIN Exam e ON ste.exam_id = e.exam_id;

---------------------------------------------------------
--View to Display Exam Questions--
CREATE VIEW ExamDetails AS
SELECT 
    e.exam_id, e.exam_type, e.exam_degree, e.allowance_option, q.question_id, q.question_body, q.question_type, q.degree
FROM Exam e
JOIN ExamQuestions eq ON e.exam_id = eq.exam_id
JOIN QuestionsPool q ON eq.question_id = q.question_id
