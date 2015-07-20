using AppLabRedes.Scripts.MyScripts;
using System;
using System.Collections.Generic;
using System.Configuration;
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
            //gets the lab id
            int idLab = Convert.ToInt16(e.CommandArgument.ToString());
            //adds the labTypes to database
            RemoveType_Lab(idLab);
            //remove lab
            RemoveLab(idLab);
            //PostBack
            Response.Redirect(Request.RawUrl);
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
                    try
                    {
                        //opens the connection
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
                        //closes the connections
                        openCon.Close();
                    }
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
                    try
                    {
                        //opens the connection
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
                        //closes the connection
                        openCon.Close();
                    }
                    command.Parameters.Clear();
                }
            }
        }

    }
}