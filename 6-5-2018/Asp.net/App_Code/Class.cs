using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Class
/// </summary>
public class Class
{
    public int ClassID { get; set; }
    public string ClassName { get; set; }

    public Class(int classID, string className)
    {
        ClassID = classID;
        ClassName = className;
    }
}