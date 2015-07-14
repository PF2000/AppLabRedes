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

        protected void btnRemoveLab_Command(object sender, CommandEventArgs e)
        {
            int idLab = Convert.ToInt16(e.CommandArgument.ToString());

            //adds the labTypes to database
            RemoveType_Lab(idLab);
            //remove lab
            RemoveLab(idLab);
            //PostBack
            Response.Redirect(Request.RawUrl);
        }



        private void RemoveLab(int idLabb)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string saveLab = " delete tblLabs where id = @idLab "; ;

                using (SqlCommand command = new SqlCommand(saveLab, openCon))
                {

                    command.Parameters.AddWithValue("@idLab", idLabb);

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

        private void RemoveType_Lab(int idLabb)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string saveTypes_Lab = " delete from tblTypes_Labss where idLab= @idLab"; ;



                using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                {

                    command.Parameters.AddWithValue("@idLab", idLabb);

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

    }
}