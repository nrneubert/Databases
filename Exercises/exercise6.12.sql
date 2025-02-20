USE exercise612;

/*
SELECT Course_name FROM Course WHERE Course.Department = 'CS';
*/
/*
SELECT DISTINCT Course_name, Instructor FROM Course, Section WHERE
	Section.Year = 08 AND
    Section.Semester = 'Fall' AND
    Section.Course_number = Course.course_number;
*/

SELECT Course.Course_name, Course.Course_number FROM Course, Section WHERE
	Section.Instructor = 'Anderson' AND
    Section.Semester = 'Fall' AND
    Course.Course_number = Section.Course_number;

    








