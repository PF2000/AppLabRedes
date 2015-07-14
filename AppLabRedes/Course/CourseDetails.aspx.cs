using AppLabRedes.Scripts.MyScripts;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppLabRedes.Course
{
    public partial class CDetails : System.Web.UI.Page
    {



        protected void Page_Load(object sender, EventArgs e)
        {
            int idCourse = Convert.ToInt16(Request.QueryString["idCourse"]);

            DataTable dt = SqlCode.PullDataToDataTable("select * from tblCourse c,tblLabs l, tblLabType t where c.lab=l.id and c.cType=t.id and c.id='" + idCourse + "'");
            DataRow row = dt.Rows[0];

            String name = Convert.ToString(row["cName"]);
            String numUsers = Convert.ToString(row["numUsers"]);
            String description = Convert.ToString(row["description"]);
            String lab = Convert.ToString(row["name"]);
            String type = Convert.ToString(row["type"]);


            txtCourseName.Text = name;
            txtLab.Text = lab;
            txtNumPods.Text = numUsers;
            txtDescription.Text = description;
            txtType.Text = type;


            //data from LoginTimes

            DataTable dt1 = SqlCode.PullDataToDataTable("select * from tblCourse c,tblLOginTimes as lt where lt.course=c.id and c.id='" + idCourse + "'");

            lstTimes.DataSource = dt1;
            lstTimes.DataBind();




            //data from Users
            DataTable dt2 = SqlCode.PullDataToDataTable("select * from tblCourse c,tblUsers as u where u.course=c.id and c.id='" + idCourse + "'");

            lstUsers.DataSource = dt2;
            lstUsers.DataBind();
        }
    }
}