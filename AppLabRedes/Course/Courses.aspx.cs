using ActiveDirectoryHelper;
using AppLabRedes.Scripts.MyScripts;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppLabRedes.Course
{
    public partial class Courses : System.Web.UI.Page
    {

        //fazer select por mês
        //coloca calendário para escolher o mês
        //pesquisar por todos os logintimes  (unique) por mes

        protected void Page_Load(object sender, EventArgs e)
        {
            if (ddlLabs.Items.Count == 0)
            {
                DataTable dtLabs = SqlCode.PullDataToDataTable("select * from tblLabs");
                //default Item

                ListItem lst1 = new ListItem("Labs", "-1");

                ddlLabs.Items.Add(lst1);
                foreach (DataRow row in dtLabs.Rows) // Loop over the items.
                {
                    String tp = Convert.ToString(row["name"]);
                    String tId = Convert.ToString(row["id"]);

                    ListItem lst = new ListItem(tp, tId);

                    ddlLabs.Items.Add(lst);
                }
            }
            DataTable dt = SqlCode.PullDataToDataTable("select DISTINCT c.id,c.description,c.numUsers,c.cName from tblcourse c ,tblLOginTimes lt where lt.course=c.id and (select MONTH(lt.tBegin)) = (SELECT MONTH(GETDATE())) ;");

            lstCourses.DataSource = dt;
            lstCourses.DataBind();

        }

        protected void btnRemoveCourse_Command(object sender, CommandEventArgs e)
        {
            StringBuilder sb = new StringBuilder();

            int idCourse = Convert.ToInt16(e.CommandArgument.ToString());

            ActiveDirectory ad = new ActiveDirectory();
            DataTable dt = SqlCode.PullDataToDataTable("select usr from tblUsers where course = '" + idCourse + "'");

            foreach (DataRow row in dt.Rows) // Loop over the items.
            {
                ad.DeleteUser(sb, row["usr"].ToString());
            }

            //adds the labTypes to database
            RemoveUsers(idCourse);
            //adds the labTypes to database
            RemoveLogTimes(idCourse);
            //remove lab
            RemoveCourse(idCourse);
            //PostBack
            Response.Redirect(Request.RawUrl);

        }

        private void RemoveCourse(int idCourse)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string saveLab = " delete tblCourse where id = @idCourse "; ;

                using (SqlCommand command = new SqlCommand(saveLab, openCon))
                {

                    command.Parameters.AddWithValue("@idCourse", idCourse);

                    try
                    {
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();

                    }
                    catch (SqlException ex)
                    {
                        txtOutput.Text = ex.Message + "@DeleteData";

                    }
                    finally
                    {
                        openCon.Close();
                    }
                    command.Parameters.Clear();

                }
            }
            txtOutput.Text = "";

        }

        private void RemoveLogTimes(int idCourse)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string strr = " delete from tblLOginTimes where course = @idCourse"; ;



                using (SqlCommand command = new SqlCommand(strr, openCon))
                {

                    command.Parameters.AddWithValue("@idCourse", idCourse);

                    try
                    {
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException ex)
                    {
                        txtOutput.Text = ex.Message + "@DeleteData";

                    }
                    finally
                    {
                        openCon.Close();
                    }
                    command.Parameters.Clear();

                }
            }
            txtOutput.Text = "";

        }

        private void RemoveUsers(int idCourse)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string strr = " delete from tblUsers where course = @idCourse"; ;

                using (SqlCommand command = new SqlCommand(strr, openCon))
                {

                    command.Parameters.AddWithValue("@idCourse", idCourse);

                    try
                    {
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException ex)
                    {
                        txtOutput.Text = ex.Message + "@DeleteData";

                    }
                    finally
                    {
                        openCon.Close();
                    }
                    command.Parameters.Clear();

                }
            }
            txtOutput.Text = "";

        }


        public static HashTable<String, Set<TimeZone>> getAvailableTimeZones()

{

Map<String, Set<TimeZone>> availableTimezones = new HashMap<String, Set<TimeZone>>();

 

// Loop through all available locales

 

for (Locale locale : Locale.getAvailableLocales())

{

 String countryCode = locale.getCountry();

 

// Locate the timezones added for this country so far
// (This can be moved to inside the loop if depending
// on whether country with no available timezones should
// be in the result map with an empty set,
// or not included at all)

 

List<TimeZone> timezones = availableTimezones.get(countryCode);

if (timezones==null)

{

timezones = new HashSet<TimeZone>();

availableTimezones.put(countryCode, timezones);

}

 

// Find all timezones for that country (code) using ICU4J

 

for (String id :

com.ibm.icu.util.TimeZone.getAvailableIDs(countryCode))

{

// Add timezone to result map

 

timezones.add(TimeZone.getTimeZone(id));

}

}

return availableTimezones;

}


        private void teste()
        {

            IEnumerable col = TimeZoneInfo.GetSystemTimeZones();


            CultureInfo[] cinfo = CultureInfo.GetCultures(CultureTypes.AllCultures);
            foreach (CultureInfo cul in cinfo)
            {
                try
                {
                    RegionInfo ri = new RegionInfo(cul.Name);
                    ddlTeste.Items.Add(ri.DisplayName);
                    
                    TimeZoneInfo tzi = TimeZoneInfo.FindSystemTimeZoneById("<the time zone id>");
// May 7, 08:04:00
DateTime userDateTime = new DateTime(2009, 5, 7, 8, 4, 0);
DateTime utcDateTime = userDateTime.Subtract(tzi.BaseUtcOffset);

                    ri.GeoId

                }
                catch (Exception ex)
                {

                }

            }

        }



        protected void btnSearch_Click(object sender, EventArgs e)
        {

            teste();
            cphErrorMessage.Visible = false;
            int idLab = Convert.ToInt16(ddlLabs.SelectedValue);
            if (idLab >= 0 && txtBegin.Text != "" && txtEnd.Text != "")
            {

                DateTime dBegin = Convert.ToDateTime(txtBegin.Text);
                DateTime dEnd = Convert.ToDateTime(txtEnd.Text);

                DataTable dt = SqlCode.PullDataToDataTable("select distinct c.id,c.description,c.numUsers,c.cName from tblcourse c ,tblLOginTimes lt where lt.course=c.id and c.Lab = 0 and (lt.tBegin >= '" + dBegin.ToString("yyyyMMdd") + "' and lt.tBegin <= '" + dEnd.ToString("yyyyMMdd") + "' ) or (lt.tEnd <=  '" + dBegin.ToString("yyyyMMdd") + "' and  lt.tEnd >= '" + dEnd.ToString("yyyyMMdd") + "' );");

                if (dt.Rows.Count != 0)
                {
                    lstCourses.DataSource = dt;
                    lstCourses.DataBind();
                }
                else
                {
                    DataTable dtFinall = new DataTable();
                    lstCourses.DataSource = dtFinall;
                    lstCourses.DataBind();
                }

            }
            else
            {
                cphErrorMessage.Visible = true;
                txtOutput.Text = "Error!! Select a valid lab or check the dates!!";

            }

        }

        protected void ddlTeste_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddl
        }

    }
}