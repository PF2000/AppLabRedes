using AppLabRedes.Scripts.MyScripts;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
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
            try
            {
                int numPods = Convert.ToInt16(txtNumPods.Text);

                //if all fields are filled
                if (txtLabName.Text != "" && txtNumPods.Text != "" && txtDescription.Text != "")
                {
                    //gets the parameters
                    string labName = txtLabName.Text;
                    string description = txtDescription.Text;
                    string labIP = txtIP.Text;

                    //adds the lab to database
                    addLab(labName, numPods, description, labIP);
                    //adds the labTypes to database
                    addType_Lab();
                    //redirects
                    System.Threading.Thread.Sleep(3000);
                    Response.Redirect("~/Lab/Labs.aspx");
                }
                else
                {
                    cphErrorMessage.Visible = true;
                    txtOutput.Text = "Please complete all required text fields ";
                }
            }
            catch (Exception ex)
            {
                cphErrorMessage.Visible = true;
                txtOutput.Text = ex.Message + "Only numbers are permitted";
            }
        }
        /// <summary>
        /// Ads the Lab to the database
        /// </summary>
        /// <param name="name"></param>
        /// <param name="numPods"></param>
        /// <param name="description"></param>
        private void addLab(string name, int numPods, string description, string labIP)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //command
                string saveLab = " insert into tblLabs (id,name,numPods, description,labIP) VALUES (@id,@name,@numPods,@description,@labIP)"; ;

                using (SqlCommand command = new SqlCommand(saveLab, openCon))
                {
                    //id For Lab
                    int maxId = SqlCode.SelectForINT("Select Max(id)+1 From tblLabs");
                    //parameters
                    command.Parameters.AddWithValue("@id", maxId);
                    command.Parameters.AddWithValue("@name", name);
                    command.Parameters.AddWithValue("@numPods", numPods);
                    command.Parameters.AddWithValue("@description", description);
                    command.Parameters.AddWithValue("@labIP", labIP);
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

        protected void btnRemoveType_Command(object sender, CommandEventArgs e)
        {
            //gets the lab id
            int idType = Convert.ToInt16(e.CommandArgument.ToString());
            //removes from association with lab
            RemoveType_Lab(idType);
            //gets all courses with this type
            DataTable dt = SqlCode.PullDataToDataTable("select id from tblCourse where cType = '" + idType + "'");
            //REmoves all courses and dependencies

            foreach (DataRow row in dt.Rows)
            {

                int idCourse = Convert.ToInt16(row["id"]);
                RemoveLogTimes(idCourse);
                RemoveCourse(idCourse);
                RemoveUsers(idCourse);

            }
            //removes the type
            RemoveType(idType);
            //refresh
            Response.Redirect(Request.RawUrl);

        }
        /// <summary>
        /// Removes the dependencies from database
        /// </summary>
        /// <param name="idLabb"></param>
        private void RemoveType_Lab(int idType)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //command
                string saveTypes_Lab = " delete from tblTypes_Labss where idType= @idType"; ;
                using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                {
                    //parametrs
                    command.Parameters.AddWithValue("@idType", idType);
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
        /// Remove the Type
        /// </summary>
        /// <param name="idCourse">Id for course removal</param>
        private void RemoveType(int idType)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {   //command
                string saveLab = " delete tblLabType where id = @idType "; ;

                using (SqlCommand command = new SqlCommand(saveLab, openCon))
                {
                    //comand parameters
                    command.Parameters.AddWithValue("@idType", idType);
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
    }
}