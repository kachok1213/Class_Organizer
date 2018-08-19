using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Department
/// </summary>
public class Department
{
    public int DepartmentID { get; set; }
    public string DepartmentName { get; set; }

    public Department(int departmentID, string departmentName)
    {
        DepartmentID = departmentID;
        DepartmentName = departmentName;
    }
}