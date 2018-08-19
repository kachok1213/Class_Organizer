using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for User
/// </summary>
public class User
{
    public int UserID { get; set; }
    public string Pass { get; set; }
    public Role Role { get; set; }

    public User(int userID, string pass, int roleID, string roleName)
    {
        UserID = userID;
        Pass = pass;
        Role = new Role(roleID, roleName);
    }
}