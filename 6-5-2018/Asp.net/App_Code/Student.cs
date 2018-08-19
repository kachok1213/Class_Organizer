using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Student
/// </summary>
public class Student : User
{
    public int StudentID { get; set; }
    public Department Department { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Email { get; set; }
    public string Picture { get; set; }

    public Student(int userID, string pass, int roleID, string roleName, int studentID, int departmentID, string departmentName, string firstName, string lastName, string email, string picture) : base(userID, pass, roleID, roleName)
    {
        StudentID = studentID;
        Department = new Department(departmentID, departmentName);
        FirstName = firstName;
        LastName = lastName;
        Email = email;
        Picture = picture;
    }


}