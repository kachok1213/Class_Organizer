using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Lecturer
/// </summary>
public class Lecturer : User
{
    public int LecturerID { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string Email { get; set; }
    public string Picture { get; set; }

    public Lecturer(int userID, string pass, int roleID, string roleName, int lecturerID, string firstName, string lastName, string email, string picture) : base(userID, pass, roleID, roleName)
    {
        LecturerID = lecturerID;
        FirstName = firstName;
        LastName = lastName;
        Email = email;
        Picture = picture;
    }
}