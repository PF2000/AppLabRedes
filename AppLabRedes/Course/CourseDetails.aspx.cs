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
            //gets query string
            int idCourse = Convert.ToInt16(Request.QueryString["idCourse"]);
            //gets course information
            DataTable dt = SqlCode.PullDataToDataTable("select * from tblCourse c,tblLabs l, tblLabType t where c.lab=l.id and c.cType=t.id and c.id='" + idCourse + "'");
            DataRow row = dt.Rows[0];

            String name = Convert.ToString(row["cName"]);
            String numUsers = Convert.ToString(row["numUsers"]);
            String description = Convert.ToString(row["description"]);
            String lab = Convert.ToString(row["name"]);
            String type = Convert.ToString(row["type"]);

            //sets parameters
            txtCourseName.Text = name;
            txtLab.Text = lab;
            txtNumPods.Text = numUsers;
            txtDescription.Text = description;
            txtType.Text = type;

            //data from LoginTimes
            String begin = SqlCode.SelectForString("select min(tBegin) from tblCourse c,tblLOginTimes as lt where lt.course=c.id and c.id='" + idCourse + "'");
            String end = SqlCode.SelectForString("select max(tBegin) from tblCourse c,tblLOginTimes as lt where lt.course=c.id and c.id='" + idCourse + "'");
            //to get time
            String endTime = SqlCode.SelectForString("select max(tEnd) from tblCourse c,tblLOginTimes as lt where lt.course=c.id and c.id='" + idCourse + "'");

            //Converts to dateTime
            DateTime tBegin = Convert.ToDateTime(begin);
            DateTime tEnd = Convert.ToDateTime(end);
            DateTime tEndTime = Convert.ToDateTime(endTime);
            //begin
            txtnBDate.Text = tBegin.Date.ToString("d");
            txtnBTime.Text = tBegin.TimeOfDay+"";
            //end
            txtnEDate.Text = tEnd.Date.ToString("d");
            txtnETime.Text = tEndTime.TimeOfDay + "";

            //data from Users
            DataTable dt2 = SqlCode.PullDataToDataTable("select * from tblCourse c,tblUsers as u where u.course=c.id and c.id='" + idCourse + "'");

            lstUsers.DataSource = dt2;
            lstUsers.DataBind();
        }
    }
}