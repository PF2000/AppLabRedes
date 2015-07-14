using AppLabRedes.Scripts.MyScripts;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppLabRedes.Lab
{
    public partial class CreateLab : System.Web.UI.Page
    {
        int IdLab;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnaddLab_Click(object sender, EventArgs e)
        {
            if (txtLabName.Text != "" && txtNumPods.Text != "" && txtDescription.Text != "")
            {
                string labName = txtLabName.Text;
                int numPods = Convert.ToInt16(txtNumPods.Text);
                string description = txtDescription.Text;

                //adds the lab to database
                addLab(labName, numPods, description);
                //adds the labTypes to database
                addType_Lab();
                System.Threading.Thread.Sleep(3000);
                Response.Redirect("~/Lab/Labs.aspx");
            }
            else
            {
                txtOutput.Text = "Please complete all required text fields ";
            }
        }


        private void addLab(string name, int numPods, string description)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string saveLab = " insert into tblLabs (id,name,numPods, description) VALUES (@id,@name,@numPods,@description)"; ;

                using (SqlCommand command = new SqlCommand(saveLab, openCon))
                {
                    int maxId = SqlCode.SelectForINT("Select Max(id)+1 From tblLabType");

                    command.Parameters.AddWithValue("@id", maxId);
                    command.Parameters.AddWithValue("@name", name);
                    command.Parameters.AddWithValue("@numPods", numPods);
                    command.Parameters.AddWithValue("@description", description);
                    try
                    {
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();
                        if (recordsAffected != 0)
                            IdLab = maxId;
                    }
                    catch (SqlException ex)
                    {
                        txtOutput.Text = ex.Message + "@InsertData";

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

        private void addType_Lab()
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string saveTypes_Lab = " insert into tblTypes_Labss (IdType,IdLab) VALUES (@idType,@idLab)"; ;

                foreach (ListItem listItem in ckbTypes.Items)
                {
                    if (listItem.Selected)
                    {
                        using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                        {

                            command.Parameters.AddWithValue("@idType", listItem.Value);
                            command.Parameters.AddWithValue("@idLab", IdLab);

                            try
                            {
                                openCon.Open();
                                int recordsAffected = command.ExecuteNonQuery();
                            }
                            catch (SqlException ex)
                            {
                                txtOutput.Text = ex.Message + "@InsertData";

                            }
                            finally
                            {
                                openCon.Close();
                            }
                            command.Parameters.Clear();

                        }
                    }
                }
            }
            txtOutput.Text = "";

        }

    }
}