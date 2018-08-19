using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

/// <summary>
/// Summary description for Project
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Project : System.Web.Services.WebService
{

    public Project()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }


    [WebMethod]
    public string Login(int userId, string pass)
    {
        User user = DBServices.Login(userId, pass);
        string output = new JavaScriptSerializer().Serialize(user);
        return output;
    }


    [WebMethod]
    public string GetNextLectureForLecturer(string date, int LecturerID, string time)
    {
        Lecture nextLecture = DBServices.GetNextLectureForLecturer(date, LecturerID, time);

        string output = new JavaScriptSerializer().Serialize(nextLecture);
        return output;
    }

    [WebMethod]
    public string GetAllLectureForLecturerForSpecDate(string date, int LecturerID)
    {
        List<Lecture> lectureList = DBServices.GetAllLectureForLecturerForSpecDate(date, LecturerID);

        string output = new JavaScriptSerializer().Serialize(lectureList);
        return output;

    }

    [WebMethod]
    public string GetLecturesByStudentAndDate(string date, int id)
    {
        List<Lecture> lectures = DBServices.GetLecturesByStudentAndDate(date, id);

        string output = new JavaScriptSerializer().Serialize(lectures);
        return output;
    }

    [WebMethod]
    public string GetCurrentLectureByStudent(int id)
    {
        Lecture lecture = DBServices.GetCurrentLectureByStudent(id);

        string output = new JavaScriptSerializer().Serialize(lecture);
        return output;
    }

    [WebMethod]
    public bool ChangeStudentStatusToPresent(int studentID, int lectureID)
    {
        return DBServices.ChangeStudentStatusToPresent(studentID, lectureID);
    }

    [WebMethod]
    public bool ChangeStudentStatusToLate(int studentID, int lectureID)
    {
        return DBServices.ChangeStudentStatusToLate(studentID, lectureID);
    }

    [WebMethod]
    public string AllStudentsOnSpecLectur(int LectureID)
    {
        List<Student> students = DBServices.AllStudentsOnSpecLectur(LectureID);
        string output = new JavaScriptSerializer().Serialize(students);
        return output;
    }

    [WebMethod]
    public bool StartTimer(string TimeStarted, int LectureID)
    {
        DBServices.StartTimer(TimeStarted, LectureID);
        return true;
    }

    [WebMethod]
    public bool DeleteLecture(int LectureID)
    {
        DBServices.DeleteLecture(LectureID);
        return true;
    }
}