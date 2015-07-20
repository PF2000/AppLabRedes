using AppLabRedes.Scripts.MyScripts;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AppLabRedes.MyFolder.Classes;
using System.Data;
using System.Drawing;
using System.Text;

namespace AppLabRedes
{
    public partial class _Default : Page
    {
        List<DateTime> listDateTime = null;
        DataTable dt = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            //creates the list
            listDateTime = new List<DateTime>();
            //gets all the courses and respective information
            dt = SqlCode.PullDataToDataTable("select * from tblCourse as c, tblLOginTimes as lt where c.id = lt.course");
            try
            {
                //gets and sets the information: news, active users,sheduled users
                lblNotifications.Text = SqlCode.SelectForINT("select count(*) from EventLogger where NotSeen='true'") + "";
                lblActiveUsers.Text = SqlCode.SelectForINT("select Count(distinct c.id) from tblCourse c, tblLOginTimes lt where c.Id=lt.course and lt.active=1") + "";
                lblScheduleUsers.Text = SqlCode.SelectForINT("select Count(distinct c.id) from tblCourse c, tblLOginTimes lt where c.Id=lt.course and lt.active=0") + "";

                int idActiveCourse = SqlCode.SelectForINT("select distinct c.id from tblCourse c, tblLOginTimes lt where c.Id=lt.course and lt.active=1");
                btnActiveCourse.PostBackUrl = "~/Course/CourseDetails?idCourse=" + idActiveCourse + "";
            }
            catch (Exception ex)
            {

            }
            //updates the router status
            updateRouterStatus();
        }
        /// <summary>
        /// Check and updated the router status
        /// </summary>
        private void updateRouterStatus()
        {

            String str = Convert.ToString(Application["RouterStatus"]);
            String ping = Convert.ToString(Application["PingTime"]);

            if (str.Equals("True"))
            {
                divRouterPing.Attributes["class"] = "alert alert-success";
                lblRouterStatus.Text = "ON";
                lblPingAvegare.Text = ping;
            }
            else
            {
                divRouterPing.Attributes["class"] = "alert alert-danger";
                lblRouterStatus.Text = "OFF";
                lblPingAvegare.Text = "0";
            }
        }

        /// <summary>
        /// btn for pinging the router and update the information
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnPing_Click(object sender, EventArgs e)
        {
            try
            {
                //get the Router ip settings
                String RouterIP = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("RouterIP");
                //check if it pings
                Boolean itPings = Network.itPings(RouterIP);
                //get the previous status 
                Boolean StatusRouter = Convert.ToBoolean(Application["RouterStatus"]);
                //check ping time
                double pingAverage = Network.PingTimeAverage(RouterIP, 8);
                //get the old ping time
                double StatuspingAverage = Convert.ToDouble(Application["PingTime"]);

                if (itPings != StatusRouter || pingAverage != StatuspingAverage)
                {
                    Application.Lock();
                    if (itPings)
                    {
                        //updates the ping status 
                        Application["RouterStatus"] = itPings;
                        Application["PingTime"] = Network.PingTimeAverage(RouterIP, 8);
                    }
                    else
                    {
                        //updates the ping status 
                        Application["RouterStatus"] = itPings;
                        Application["PingTime"] = 0;
                    }
                    Application.UnLock();
                }
            }
            catch (Exception ex)
            {
                SqlCode.copyDataEventLogger("Error Pingging router", "danger", ex.Message);
            }
            updateRouterStatus();
        }
        /// <summary>
        /// For calendar rendering. All days execute this code
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            //create a line break
            Literal lineBreak = new Literal();
            lineBreak.Text = "<br />";
            //gets the row number 
            int ro = dt.Rows.Count;
            IEnumerable<int> strr;
            try
            {
                IEnumerable<String> courses;
                List<String> lst = new List<string>();
                List<int> lstId = new List<int>();
                try
                {
                    //gets all the users active in the day
                    courses = (from DataRow dr in dt.Rows
                               where (DateTime)dr["tbegin"] <= e.Day.Date && (DateTime)dr["tEnd"] >= e.Day.Date
                               select (String)dr["cName"]);
                    strr = (from DataRow dr in dt.Rows
                              where (DateTime)dr["tbegin"] <= e.Day.Date && (DateTime)dr["tEnd"] >= e.Day.Date
                              select (int)dr["id"]);
                    lstId = strr.ToList();
                    lst = courses.ToList();
                }
                catch (Exception ex)
                { }


                //if there are courses
                if (lst.Count != 0)
                {    
                    e.Cell.HorizontalAlign = HorizontalAlign.Left;
                    e.Cell.BackColor = Color.FromArgb(92, 184, 92);

                    for (int i = 0; i < lst.Count; i++)
                    {
                        //adds a line break
                        e.Cell.Controls.Add(lineBreak);
                        //sets the name
                        String cName = lst.ElementAt(i);
                        //gets the course id
                        String cId = Convert.ToString(lstId.ElementAt(i));
                        //creates a hyperlink
                        HyperLink link = new HyperLink();
                        //sets the name
                        link.Text = cName;
                        //sets the link
                        link.NavigateUrl =
                            Page.ClientScript.GetPostBackClientHyperlink(CalendarLinkButton,
                                cId, true);
                        e.Cell.Controls.Add(link);
                    }
                }
            }
            catch (Exception ex)
            {
                String ex1 = ex.Message;
            }
        }
        /// <summary>
        /// Hyperlink of course
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void CalendarLinkButton_Click(object sender, EventArgs e)
        {
            //gets the id and goes to the couse details
            int id = Convert.ToInt16(Request.Form["__EVENTARGUMENT"]);
            Response.Redirect("~/Course/CourseDetails.aspx?idCourse="+id+"");
        }

    }
}