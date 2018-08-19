using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DBServices
/// </summary>
public static class DBServices
{
    static string ConStr = @"Data Source=DESKTOP-I84F5L4\SQLEXPRESS;Initial Catalog=Project;Integrated Security=True";
    static SqlConnection con = new SqlConnection(ConStr);
    static SqlCommand command = new SqlCommand();
    static SqlDataReader reader;

    public static User Login(int id, string pass)
    {
        try
        {
            con.Open();
            command.Connection = con;
            command.CommandType = CommandType.StoredProcedure;

            command.CommandText = "GetStudent";
            command.Parameters.Clear();
            command.Parameters.Add(new SqlParameter("@StudentID", id));
            command.Parameters.Add(new SqlParameter("@Pass", pass));
            
            reader = command.ExecuteReader();
            if (reader.Read())
            {
                return new Student(int.Parse(reader["UserID"].ToString()), reader["Pass"].ToString(), int.Parse(reader["RoleID"].ToString()), reader["RoleName"].ToString(), int.Parse(reader["StudentID"].ToString()), int.Parse(reader["DepartmentID"].ToString()), reader["DepartmentName"].ToString(), reader["FirstName"].ToString(), reader["LastName"].ToString(), reader["Email"].ToString(), reader["Picture"].ToString());
            }
            reader.Close();
            command.CommandText = "GetLecturer";
            command.Parameters.Clear();
            command.Parameters.Add(new SqlParameter("@LecturerID", id));
            command.Parameters.Add(new SqlParameter("@Pass", pass));
            reader = command.ExecuteReader();
            if (reader.Read())
            {
                return new Lecturer(int.Parse(reader["UserID"].ToString()), reader["Pass"].ToString(), int.Parse(reader["RoleID"].ToString()), reader["RoleName"].ToString(), int.Parse(reader["LecturerID"].ToString()), reader["FirstName"].ToString(), reader["LastName"].ToString(), reader["Email"].ToString(), reader["Picture"].ToString());
            }
            reader.Close();
           
        }
        catch (Exception e)
        {
            File.AppendAllText("log.txt", e.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                reader.Close();
                con.Close();
            }
        }
        return null;
    }

    public static Lecture GetNextLectureForLecturer(string date, int LecturerID ,string time  )
    {
        try
        {
            con.Open();
            command.Connection = con;
            DateTime date2 = DateTime.Parse(date);
            
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "NextCourseForSpecLecturer";
            command.Parameters.Clear();
            command.Parameters.Add(new SqlParameter("@date", date2));
            command.Parameters.Add(new SqlParameter("@LecturerID", LecturerID));
            command.Parameters.Add(new SqlParameter("@time", time));
           
            reader = command.ExecuteReader();

           
            while (reader.Read())
            {
                return new Lecture(int.Parse(reader["LectureID"].ToString())
                                    , int.Parse(reader["DepartmentID"].ToString()), 
                                              reader["DepartmentName"].ToString(),
                                          int.Parse(reader["CourseID"].ToString()), 
                                                  reader["CourseName"].ToString(),
                               reader["OpenDate"].ToString(),
                               reader["EndDate"].ToString(),
                                int.Parse(reader["ClassID"].ToString()),
                               reader["ClassName"].ToString(),
                               reader["LectureDate"].ToString(),
                                reader["BeginHour"].ToString(),
                               reader["EndHour"].ToString(),
                                reader["IsActive"].ToString() == "1" ? true : false,
                                 reader["TimeStarted"].ToString());



            }
            return null;
        }
        catch (Exception e)
        {
            File.AppendAllText("log.txt", e.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                reader.Close();
                con.Close();
            }
        }
        return null;
    }

    public static List<Lecture> GetAllLectureForLecturerForSpecDate(string date, int LecturerID)
    {
        try
        {
            con.Open();
            command.Connection = con;
            DateTime date2 = DateTime.Parse(date);

            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "CoursesOnSpecDateForSpecLecturer";
            command.Parameters.Clear();
            command.Parameters.Add(new SqlParameter("@date", date2));
            command.Parameters.Add(new SqlParameter("@LecturerID", LecturerID));
            List<Lecture> list = new List<Lecture>();

            reader = command.ExecuteReader();


            while (reader.Read())
            {
                list.Add( new Lecture(int.Parse(reader["LectureID"].ToString())
                                    , int.Parse(reader["DepartmentID"].ToString()),
                                              reader["DepartmentName"].ToString(),
                                          int.Parse(reader["CourseID"].ToString()),
                                                  reader["CourseName"].ToString(),
                               reader["OpenDate"].ToString(),
                               reader["EndDate"].ToString(),
                                int.Parse(reader["ClassID"].ToString()),
                               reader["ClassName"].ToString(),
                               reader["LectureDate"].ToString(),
                                reader["BeginHour"].ToString(),
                               reader["EndHour"].ToString()));



            }
            return list;
        }
        catch (Exception e)
        {
            File.AppendAllText("log.txt", e.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                reader.Close();
                con.Close();
            }
        }
        return null;
    }

    //מתודות סטודנט
    //מתודות סטודנט

    static public List<Lecture> GetLecturesByStudentAndDate(string date, int id)
    {

        try
        {
            con.Open();
            command = new SqlCommand("GetLecturesByStudentAndDate", con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add(new SqlParameter("@date", date));
            command.Parameters.Add(new SqlParameter("@StudentID", id));
            reader = command.ExecuteReader();
            List<Lecture> lectures = new List<Lecture>();
            while (reader.Read())
            {
                lectures.Add(new Lecture(int.Parse(reader["LectureID"].ToString()), int.Parse(reader["DepartmentID"].ToString()), reader["DepartmentName"].ToString(), int.Parse(reader["LecturerID"].ToString()), reader["FirstName"].ToString(), reader["LastName"].ToString(), int.Parse(reader["CourseID"].ToString()), reader["CourseName"].ToString(), reader["OpenDate"].ToString(), reader["EndDate"].ToString(), int.Parse(reader["ClassID"].ToString()), reader["ClassName"].ToString(), reader["LectureDate"].ToString(), reader["BeginHour"].ToString(), reader["EndHour"].ToString(), int.Parse(reader["StatusID"].ToString()), reader["StatusName"].ToString()));
            }
            return lectures;
        }
        catch (Exception e)
        {
            File.AppendAllText("log.txt", e.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                reader.Close();
                con.Close();
            }
        }
        return null;
    }

    static public Lecture GetCurrentLectureByStudent(int id)
    {

        try
        {
            Lecture lecture = null;
            con.Open();
            command = new SqlCommand("GetCurrentLectureByStudent", con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Clear();
            command.Parameters.Add(new SqlParameter("@StudentID", id));
            reader = command.ExecuteReader();
            if (reader.Read())
            {
                lecture = new Lecture(int.Parse(reader["LectureID"].ToString()), int.Parse(reader["DepartmentID"].ToString()), reader["DepartmentName"].ToString(), int.Parse(reader["LecturerID"].ToString()), reader["FirstName"].ToString(), reader["LastName"].ToString(), int.Parse(reader["CourseID"].ToString()), reader["CourseName"].ToString(), reader["OpenDate"].ToString(), reader["EndDate"].ToString(), int.Parse(reader["ClassID"].ToString()), reader["ClassName"].ToString(), reader["LectureDate"].ToString(), reader["BeginHour"].ToString(), reader["EndHour"].ToString(), int.Parse(reader["StatusID"].ToString()), reader["StatusName"].ToString());
            }
            reader.Close();
            con.Close();
            return lecture;
        }
        catch (Exception e)
        {
            File.AppendAllText("log.txt", e.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

        }
        return null;
    }

    static public bool ChangeStudentStatusToPresent(int studentID, int lectureID)
    {
        try
        {
            con.Open();
            command = new SqlCommand("ChangeStudentStatusToPresent", con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Clear();
            command.Parameters.Add(new SqlParameter("@StudentID", studentID));
            command.Parameters.Add(new SqlParameter("@LectureID", lectureID));
            command.ExecuteNonQuery();
        }
        catch (Exception e)
        {
            File.AppendAllText("log.txt", e.Message);
            return false;
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        return true;
    }

    static public bool ChangeStudentStatusToLate(int studentID, int lectureID)
    {
        try
        {
            con.Open();
            command = new SqlCommand("ChangeStudentStatusToLate", con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Clear();
            command.Parameters.Add(new SqlParameter("@StudentID", studentID));
            command.Parameters.Add(new SqlParameter("@LectureID", lectureID));
            command.ExecuteNonQuery();
        }
        catch (Exception e)
        {
            File.AppendAllText("log.txt", e.Message);
            return false;
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        return true;
    }



    static public List<Student> AllStudentsOnSpecLectur(int LectureID)
    {
        try
        {
            con.Open();
            command = new SqlCommand("AllStudentsOnSpecLectur", con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Clear();
            command.Parameters.Add(new SqlParameter("@LectureID", LectureID));
            reader = command.ExecuteReader();
            List<Student> students = new List<Student>();
            while (reader.Read())
            {
                students.Add(new Student(int.Parse(reader["UserID"].ToString()),
                     reader["Pass"].ToString(),
                     int.Parse(reader["RoleID"].ToString()),
                    reader["RoleName"].ToString(),
                      int.Parse(reader["studentID"].ToString()),
                                 int.Parse(reader["DepartmentID"].ToString()),
                                 reader["DepartmentName"].ToString(),
                             reader["firstName"].ToString(),
                             reader["lastName"].ToString(),
                              reader["Email"].ToString(),
                              reader["picture"].ToString()
                    ));
            }
            return students;
        }
        catch (Exception e)
        {
            File.AppendAllText("log.txt", e.Message);
            
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        return null;
        
    }



    static public bool StartTimer(string TimeStarted, int LectureID)
    {
        try
        {
            con.Open();
            command = new SqlCommand("StartTimer", con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Clear();
            command.Parameters.Add(new SqlParameter("@TimeStarted", TimeStarted));
            command.Parameters.Add(new SqlParameter("@LectureID", LectureID));
            command.ExecuteNonQuery();
        }
        catch (Exception e)
        {
            File.AppendAllText("log.txt", e.Message);
            return false;
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        return true;
    }


    static public bool DeleteLecture(int LectureID)
    {
        try
        {
            con.Open();
            command = new SqlCommand("Delete_Lecture", con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Clear();
            command.Parameters.Add(new SqlParameter("@LectureID", LectureID));
            command.ExecuteNonQuery();
        }
        catch (Exception e)
        {
            File.AppendAllText("log.txt", e.Message);
            return false;
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        return true;
    }
}