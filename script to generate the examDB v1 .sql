USE [master]
GO
/****** Object:  Database [ExaminationDB]    Script Date: 7/13/2024 5:25:14 PM ******/
CREATE DATABASE [ExaminationDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ExaminationDB_Data', FILENAME = N'E:\iti\ExaminationDB_Data.mdf' , SIZE = 10240KB , MAXSIZE = 102400KB , FILEGROWTH = 5120KB )
 LOG ON 
( NAME = N'ExaminationDB_Log', FILENAME = N'E:\iti\ExaminationDB_Log.ldf' , SIZE = 10240KB , MAXSIZE = 51200KB , FILEGROWTH = 5120KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ExaminationDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ExaminationDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ExaminationDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ExaminationDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ExaminationDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ExaminationDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ExaminationDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ExaminationDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ExaminationDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ExaminationDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ExaminationDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ExaminationDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ExaminationDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ExaminationDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ExaminationDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ExaminationDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ExaminationDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ExaminationDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ExaminationDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ExaminationDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ExaminationDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ExaminationDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ExaminationDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ExaminationDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ExaminationDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ExaminationDB] SET  MULTI_USER 
GO
ALTER DATABASE [ExaminationDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ExaminationDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ExaminationDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ExaminationDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ExaminationDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ExaminationDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ExaminationDB', N'ON'
GO
ALTER DATABASE [ExaminationDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [ExaminationDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ExaminationDB]
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch](
	[branch_id] [int] NOT NULL,
	[branch_name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[course_id] [int] NOT NULL,
	[course_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](255) NULL,
	[min_degree] [float] NULL,
	[max_degree] [float] NULL,
	[duration] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseExam]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseExam](
	[course_exam_id] [int] NOT NULL,
	[exam_id] [int] NULL,
	[course_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[course_exam_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseQuestions]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseQuestions](
	[question_id] [int] NULL,
	[course_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[dept_id] [int] NOT NULL,
	[dept_name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[dept_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DepartmentTracks]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepartmentTracks](
	[track_id] [int] NOT NULL,
	[dept_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[track_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[exam_id] [int] NOT NULL,
	[exam_type] [nvarchar](20) NULL,
	[exam_degree] [int] NULL,
	[allowance_option] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[exam_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExamQuestions]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExamQuestions](
	[ex_ques_id] [int] NOT NULL,
	[exam_id] [int] NULL,
	[question_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ex_ques_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[instructor_id] [int] NOT NULL,
	[ins_name] [nvarchar](100) NOT NULL,
	[phone] [char](11) NULL,
	[address] [nvarchar](255) NULL,
	[training_manager] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[instructor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstructorChoosesQuestion]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstructorChoosesQuestion](
	[question_id] [int] NOT NULL,
	[instructor_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[question_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstructorMakeExam]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstructorMakeExam](
	[exam_id] [int] NOT NULL,
	[instructor_id] [int] NULL,
	[start_time] [time](7) NULL,
	[end_time] [time](7) NULL,
	[exam_date] [date] NULL,
	[year] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[exam_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstructorSelectedStudents]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstructorSelectedStudents](
	[selected_std_id] [int] NOT NULL,
	[student_id] [int] NULL,
	[instructor_id] [int] NULL,
	[exam_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[selected_std_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InstructorTeachCourse]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstructorTeachCourse](
	[course_id] [int] NOT NULL,
	[instructor_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Intake]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Intake](
	[intake_id] [int] NOT NULL,
	[intake_name] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[intake_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Options]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Options](
	[option_id] [int] NOT NULL,
	[option_text] [nvarchar](300) NULL,
PRIMARY KEY CLUSTERED 
(
	[option_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionsPool]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionsPool](
	[question_id] [int] NOT NULL,
	[question_body] [nvarchar](max) NOT NULL,
	[question_type] [nvarchar](20) NULL,
	[degree] [float] NULL,
	[correct_answer] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[question_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentBranch]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentBranch](
	[student_id] [int] NOT NULL,
	[branch_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentIntake]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentIntake](
	[std_intake_id] [int] NOT NULL,
	[student_id] [int] NULL,
	[intake_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[std_intake_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[student_id] [int] NOT NULL,
	[student_name] [nvarchar](50) NULL,
	[NID] [int] NULL,
	[phone] [char](11) NULL,
	[age] [int] NULL,
	[gender] [char](1) NULL,
	[military_status] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentTakeExam]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentTakeExam](
	[std_ex_id] [int] NOT NULL,
	[student_id] [int] NULL,
	[exam_id] [int] NULL,
	[question_id] [int] NULL,
	[student_answer] [nvarchar](max) NULL,
	[question_result] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[std_ex_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentTrack]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentTrack](
	[student_id] [int] NOT NULL,
	[track_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Track]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Track](
	[track_id] [int] NOT NULL,
	[track_name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[track_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrackCourses]    Script Date: 7/13/2024 5:25:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrackCourses](
	[track_cr_id] [int] NOT NULL,
	[course_id] [int] NULL,
	[track_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[track_cr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CourseExam]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[Course] ([course_id])
GO
ALTER TABLE [dbo].[CourseExam]  WITH CHECK ADD FOREIGN KEY([exam_id])
REFERENCES [dbo].[Exam] ([exam_id])
GO
ALTER TABLE [dbo].[CourseQuestions]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[Course] ([course_id])
GO
ALTER TABLE [dbo].[CourseQuestions]  WITH CHECK ADD FOREIGN KEY([question_id])
REFERENCES [dbo].[QuestionsPool] ([question_id])
GO
ALTER TABLE [dbo].[DepartmentTracks]  WITH CHECK ADD FOREIGN KEY([dept_id])
REFERENCES [dbo].[Department] ([dept_id])
GO
ALTER TABLE [dbo].[DepartmentTracks]  WITH CHECK ADD FOREIGN KEY([track_id])
REFERENCES [dbo].[Track] ([track_id])
GO
ALTER TABLE [dbo].[ExamQuestions]  WITH CHECK ADD FOREIGN KEY([exam_id])
REFERENCES [dbo].[Exam] ([exam_id])
GO
ALTER TABLE [dbo].[ExamQuestions]  WITH CHECK ADD FOREIGN KEY([question_id])
REFERENCES [dbo].[QuestionsPool] ([question_id])
GO
ALTER TABLE [dbo].[Instructor]  WITH CHECK ADD FOREIGN KEY([training_manager])
REFERENCES [dbo].[Instructor] ([instructor_id])
GO
ALTER TABLE [dbo].[InstructorChoosesQuestion]  WITH CHECK ADD FOREIGN KEY([instructor_id])
REFERENCES [dbo].[Instructor] ([instructor_id])
GO
ALTER TABLE [dbo].[InstructorChoosesQuestion]  WITH CHECK ADD FOREIGN KEY([question_id])
REFERENCES [dbo].[QuestionsPool] ([question_id])
GO
ALTER TABLE [dbo].[InstructorMakeExam]  WITH CHECK ADD FOREIGN KEY([exam_id])
REFERENCES [dbo].[Exam] ([exam_id])
GO
ALTER TABLE [dbo].[InstructorMakeExam]  WITH CHECK ADD FOREIGN KEY([instructor_id])
REFERENCES [dbo].[Instructor] ([instructor_id])
GO
ALTER TABLE [dbo].[InstructorSelectedStudents]  WITH CHECK ADD FOREIGN KEY([exam_id])
REFERENCES [dbo].[Exam] ([exam_id])
GO
ALTER TABLE [dbo].[InstructorSelectedStudents]  WITH CHECK ADD FOREIGN KEY([instructor_id])
REFERENCES [dbo].[Instructor] ([instructor_id])
GO
ALTER TABLE [dbo].[InstructorSelectedStudents]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
GO
ALTER TABLE [dbo].[InstructorTeachCourse]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[Course] ([course_id])
GO
ALTER TABLE [dbo].[InstructorTeachCourse]  WITH CHECK ADD FOREIGN KEY([instructor_id])
REFERENCES [dbo].[Instructor] ([instructor_id])
GO
ALTER TABLE [dbo].[QuestionsPool]  WITH CHECK ADD FOREIGN KEY([correct_answer])
REFERENCES [dbo].[Options] ([option_id])
GO
ALTER TABLE [dbo].[StudentBranch]  WITH CHECK ADD FOREIGN KEY([branch_id])
REFERENCES [dbo].[Branch] ([branch_id])
GO
ALTER TABLE [dbo].[StudentBranch]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
GO
ALTER TABLE [dbo].[StudentIntake]  WITH CHECK ADD FOREIGN KEY([intake_id])
REFERENCES [dbo].[Intake] ([intake_id])
GO
ALTER TABLE [dbo].[StudentIntake]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
GO
ALTER TABLE [dbo].[StudentTakeExam]  WITH CHECK ADD FOREIGN KEY([exam_id])
REFERENCES [dbo].[Exam] ([exam_id])
GO
ALTER TABLE [dbo].[StudentTakeExam]  WITH CHECK ADD FOREIGN KEY([question_id])
REFERENCES [dbo].[QuestionsPool] ([question_id])
GO
ALTER TABLE [dbo].[StudentTakeExam]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
GO
ALTER TABLE [dbo].[StudentTrack]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[Students] ([student_id])
GO
ALTER TABLE [dbo].[StudentTrack]  WITH CHECK ADD FOREIGN KEY([track_id])
REFERENCES [dbo].[Track] ([track_id])
GO
ALTER TABLE [dbo].[TrackCourses]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[Course] ([course_id])
GO
ALTER TABLE [dbo].[TrackCourses]  WITH CHECK ADD FOREIGN KEY([track_id])
REFERENCES [dbo].[Track] ([track_id])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD CHECK  (([exam_type]='corrective_exam' OR [exam_type]='normal_exam'))
GO
ALTER TABLE [dbo].[Instructor]  WITH CHECK ADD  CONSTRAINT [CHK_Phone_Format] CHECK  (([phone] like '01[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Instructor] CHECK CONSTRAINT [CHK_Phone_Format]
GO
ALTER TABLE [dbo].[QuestionsPool]  WITH CHECK ADD CHECK  (([question_type]='mcq' OR [question_type]='true_false' OR [question_type]='text_question'))
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [CHK_Military_Status] CHECK  (([gender]='M' AND [military_status] IS NOT NULL OR [gender]='F' AND [military_status]='NA'))
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [CHK_Military_Status]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD CHECK  (([age]>=(23) AND [age]<=(33)))
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD CHECK  (([gender]='F' OR [gender]='M'))
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD CHECK  (([phone] like '01[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
USE [master]
GO
ALTER DATABASE [ExaminationDB] SET  READ_WRITE 
GO
