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

        /// <summary>
        /// Button to create a Lab
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnaddLab_Click(object sender, EventArgs e)
        {
            //if all fields are filled
            if (txtLabName.Text != "" && txtNumPods.Text != "" && txtDescription.Text != "")
            {
                //gets the parameters
                string labName = txtLabName.Text;
                int numPods = Convert.ToInt16(txtNumPods.Text);
                string description = txtDescription.Text;

                //adds the lab to database
                addLab(labName, numPods, description);
                //adds the labTypes to database
                addType_Lab();
                //redirects
                System.Threading.Thread.Sleep(3000);
                Response.Redirect("~/Lab/Labs.aspx");
            }
            else
            {
                txtOutput.Text = "Please complete all required text fields ";
            }
        }

        /// <summary>
        /// Ads the Lab to the database
        /// </summary>
        /// <param name="name"></param>
        /// <param name="numPods"></param>
        /// <param name="description"></param>
        private void addLab(string name, int numPods, string description)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //command
                string saveLab = " insert into tblLabs (id,name,numPods, description) VALUES (@id,@name,@numPods,@description)"; ;

                using (SqlCommand command = new SqlCommand(saveLab, openCon))
                {
                    //id For Lab
                    int maxId = SqlCode.SelectForINT("Select Max(id)+1 From tblLabType");
                    //parameters
                    command.Parameters.AddWithValue("@id", maxId);
                    command.Parameters.AddWithValue("@name", name);
                    command.Parameters.AddWithValue("@numPods", numPods);
                    command.Parameters.AddWithValue("@description", description);
                    try
                    {
                        //open the connection
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();
                        if (recordsAffected != 0)
                            IdLab = maxId;
                    }
                    catch (SqlException ex)
                    {
                        //erros message
                        txtOutput.Text = ex.Message + "@InsertData";

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
        /// <summary>
        /// Adds to the table Lab and Type
        /// </summary>
        private void addType_Lab()
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //comand
                string saveTypes_Lab = " insert into tblTypes_Labss (IdType,IdLab) VALUES (@idType,@idLab)"; ;
                //runs all the lists
                foreach (ListItem listItem in ckbTypes.Items)
                {
                    //selects the 
                    if (listItem.Selected)
                    {
                        using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                        {
                            //parameters
                            command.Parameters.AddWithValue("@idType", listItem.Value);
                            command.Parameters.AddWithValue("@idLab", IdLab);
                            try
                            {
                                //opens the connection
                                openCon.Open();
                                int recordsAffected = command.ExecuteNonQuery();
                            }
                            catch (SqlException ex)
                            {
                                //error message
                                txtOutput.Text = ex.Message + "@InsertData";
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

    }
}