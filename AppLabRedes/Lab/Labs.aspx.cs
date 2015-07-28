using AppLabRedes.Scripts.MyScripts;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppLabRedes.Lab
{
    public partial class Labs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        /// <summary>
        /// Button to remove the selected Lab
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnRemoveLab_Command(object sender, CommandEventArgs e)
        {
            try
            {
                //gets the lab id
                int idLab = Convert.ToInt16(e.CommandArgument.ToString());

                DataTable dt = SqlCode.PullDataToDataTable("select c.id from tblCourse c, tblLabs l where c.Lab=l.Id and c.Lab='" + idLab + "'");

                foreach (DataRow row in dt.Rows)
                {
                    int idCourse = Convert.ToInt16(row["id"]);
                    //adds the labTypes to database
                    RemoveUsers(idCourse);
                    //adds the labTypes to database
                    RemoveLogTimes(idCourse);
                    //remove lab
                    RemoveCourse(idCourse);
                }

                //adds the labTypes to database
                RemoveType_Lab(idLab);
                //remove lab
                RemoveLab(idLab);
                //PostBack
                Response.Redirect("~/Lab/Labs?op=deleteSuccess");
            }
            catch (Exception ex)
            {
                //error message
                cphErrorMessage.Visible = true;
                txtOutput.Text = "Error deleting user!! " + ex.Message;
            }
        }
        /// <summary>
        /// Removes the lab from the table Labs from the database
        /// </summary>
        /// <param name="idLabb"></param>
        private void RemoveLab(int idLabb)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //command
                string saveLab = " delete tblLabs where id = @idLab "; ;
                using (SqlCommand command = new SqlCommand(saveLab, openCon))
                {
                    //parameters
                    command.Parameters.AddWithValue("@idLab", idLabb);
                    //opens the connection
                    openCon.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    //closes the connections
                    openCon.Close();
                    command.Parameters.Clear();
                }
            }
        }
        /// <summary>
        /// Removes the dependencies from database
        /// </summary>
        /// <param name="idLabb"></param>
        private void RemoveType_Lab(int idLabb)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //command
                string saveTypes_Lab = " delete from tblTypes_Labss where idLab= @idLab"; ;
                using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                {
                    //parametrs
                    command.Parameters.AddWithValue("@idLab", idLabb);
                    //opens the connection
                    openCon.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    //closes the connection
                    openCon.Close();
                    command.Parameters.Clear();
                }
            }
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
                    //open connection
                    openCon.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    //closes que connection
                    openCon.Close();
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
                    //open connection
                    openCon.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    //closes conection
                    openCon.Close();
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
                    //open connection
                    openCon.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    //closes connection
                    openCon.Close();
                    command.Parameters.Clear();
                }
            }

        }

    }
}