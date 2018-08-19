using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Course
/// </summary>
public class Course
{
    public int CourseID { get; set; }
    public string CourseName { get; set; }
    public string OpenDate { get; set; }
    public string EndDate { get; set; }

    public Course(int courseID, string courseName, string openDate, string endDate)
    {
        CourseID = courseID;
        CourseName = courseName;
        OpenDate = openDate;
        EndDate = endDate;
    }
}