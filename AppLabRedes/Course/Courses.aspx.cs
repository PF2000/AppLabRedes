﻿using AppLabRedes.Scripts.MyScripts;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
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
            int idCourse = Convert.ToInt16(e.CommandArgument.ToString());

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

        protected void btnSearch_Click(object sender, EventArgs e)
        {

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

    }
}