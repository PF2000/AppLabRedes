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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (ddlLabs.Items.Count == 0)
            {
                //get allLabs
                DataTable dtLabs = SqlCode.PullDataToDataTable("select * from tblLabs");
                //default Item
                ListItem lst1 = new ListItem("Labs", "-1");
                ddlLabs.Items.Add(lst1);
                //db Items
                foreach (DataRow row in dtLabs.Rows) // Loop over the items.
                {
                    String tp = Convert.ToString(row["name"]);
                    String tId = Convert.ToString(row["id"]);
                    ListItem lst = new ListItem(tp, tId);
                    ddlLabs.Items.Add(lst);
                }
            }
            //pulls courses for the mounth
            DataTable dt = SqlCode.PullDataToDataTable("select DISTINCT c.id,c.description,c.numUsers,c.cName from tblcourse c ,tblLOginTimes lt where lt.course=c.id and (select MONTH(lt.tBegin)) = (SELECT MONTH(GETDATE())) ;");

            lstCourses.DataSource = dt;
            lstCourses.DataBind();

        }
        /// <summary>
        /// Button for course removal
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnRemoveCourse_Command(object sender, CommandEventArgs e)
        {
            //gets the id from button parameters
            int idCourse = Convert.ToInt16(e.CommandArgument.ToString());

            StringBuilder sb = new StringBuilder();

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
        /// <summary>
        /// Remove the course
        /// </summary>
        /// <param name="idCourse">Id for course removal</param>
        private void RemoveCourse(int idCourse)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {   //command
                string saveLab = " delete tblCourse where id = @idCourse "; ;

                using (SqlCommand command = new SqlCommand(saveLab, openCon))
                {
                    //comand parameters
                    command.Parameters.AddWithValue("@idCourse", idCourse);
                    try
                    {
                        //open connection
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException ex)
                    {
                        //error message
                        txtOutput.Text = ex.Message + "@DeleteData";
                    }
                    finally
                    {
                        //closes que connection
                        openCon.Close();
                    }
                    command.Parameters.Clear();
                }
            }
        }
        /// <summary>
        /// Remove timeLogs from course
        /// </summary>
        /// <param name="idCourse">Id for course removal</param>
        private void RemoveLogTimes(int idCourse)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //comand
                string strr = " delete from tblLOginTimes where course = @idCourse"; ;
                using (SqlCommand command = new SqlCommand(strr, openCon))
                {
                    //comand parameters
                    command.Parameters.AddWithValue("@idCourse", idCourse);
                    try
                    {
                        //open connection
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException ex)
                    {
                        //error message
                        txtOutput.Text = ex.Message + "@DeleteData";
                    }
                    finally
                    {
                        //closes conection
                        openCon.Close();
                    }
                    command.Parameters.Clear();
                }
            }

        }
        /// <summary>
        /// Removes Users.
        /// </summary>
        /// <param name="idCourse">Id for Users removal</param>
        private void RemoveUsers(int idCourse)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //command
                string strr = " delete from tblUsers where course = @idCourse"; ;
                using (SqlCommand command = new SqlCommand(strr, openCon))
                {
                    //command parameters
                    command.Parameters.AddWithValue("@idCourse", idCourse);
                    try
                    {
                        //open connection
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException ex)
                    {
                        //error message
                        txtOutput.Text = ex.Message + "@DeleteData";
                    }
                    finally
                    {
                        //closes connection
                        openCon.Close();
                    }
                    command.Parameters.Clear();
                }
            }

        }
        /// <summary>
        /// Search button click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            cphErrorMessage.Visible = false;
            //gets the lab id
            int idLab = Convert.ToInt16(ddlLabs.SelectedValue);
            //if all fields are selected
            if (idLab >= 0 && txtBegin.Text != "" && txtEnd.Text != "")
            {
                //converts the dates selected
                DateTime dBegin = Convert.ToDateTime(txtBegin.Text);
                DateTime dEnd = Convert.ToDateTime(txtEnd.Text);
                //pulls data for courses in the selected dates
                DataTable dt = SqlCode.PullDataToDataTable("select distinct c.id,c.description,c.numUsers,c.cName from tblcourse c ,tblLOginTimes lt where lt.course=c.id and c.Lab = 0 and (lt.tBegin >= '" + dBegin.ToString("yyyyMMdd") + "' and lt.tBegin <= '" + dEnd.ToString("yyyyMMdd") + "' ) or (lt.tEnd <=  '" + dBegin.ToString("yyyyMMdd") + "' and  lt.tEnd >= '" + dEnd.ToString("yyyyMMdd") + "' );");
                //if exists
                if (dt.Rows.Count != 0)
                {
                    //binds the data table
                    lstCourses.DataSource = dt;
                    lstCourses.DataBind();
                }
                else
                {
                    //if no courses exists creates and binds an empty datatable
                    DataTable dtFinall = new DataTable();
                    lstCourses.DataSource = dtFinall;
                    lstCourses.DataBind();
                }
            }
            else
            {
                //error for search
                cphErrorMessage.Visible = true;
                txtOutput.Text = "Error!! Select a valid lab or check the dates!!";
            }
        }
    }
}