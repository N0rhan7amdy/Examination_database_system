

use ExaminationDB;
go


CREATE TRIGGER trg_SetMilitaryStatus
ON Students
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE Students
    SET military_status = 'NA'
    WHERE gender = 'F'
      AND military_status <> 'NA';
END;



insert into Branch values (1,'Beniseuif');




ALTER TABLE Students
ADD CONSTRAINT CK_PhoneNumberFormat
CHECK (phone LIKE '01[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' AND LEN(phone) = 11);


insert into [dbo].[Students]([student_id],[student_name],[NID],[phone],[age],[gender],military_status) values (1,'sarah ahmed' , 1234567 , '01234567891' , 23 , 'F' , 'NA' );

insert into Students values (2,'Ahmed tarek' , 29709 , '01025128390', 26 , 'M' , 'Completed');

insert into [dbo].[Students]([student_id],[student_name],[NID],[phone],[age],[gender],military_status) values (3,'Asalah' , 200100200 , '01234567899' , 22 , 'F' , '' );


insert into Course values (1,'SQL' , 'Learn DB and T-SQL to use SQLserver ',60.0,100.0,24);

insert into Department values (1,'Software Development');

insert into Intake values (1,'R3 .NET ');



