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


//http://www.aspsnippets.com/Articles/Create-dynamic-textbox-using-JavaScript-in-ASP.Net.aspx
//http://stackoverflow.com/questions/3464498/pass-c-sharp-asp-net-array-to-javascript-array
namespace AppLabRedes.Lab
{
    public partial class EditLab : System.Web.UI.Page
    {
        /// <summary>
        /// Id Lab to edit
        /// </summary>
        int IDToEdit;


        protected void Page_Load(object sender, EventArgs e)
        {
            IDToEdit = Convert.ToInt16(Request.QueryString["idLab"]);
            //just in post back binds all the text
            if (!IsPostBack)
                BindText(IDToEdit);

        }
        /// <summary>
        /// Binds all text of the lab
        /// </summary>
        /// <param name="idLab"></param>
        protected void BindText(int idLab)
        {
            //gets lab types
            DataTable dt = SqlCode.PullDataToDataTable(
                " select t.id as id, t.type" +
                " from tblLabs as l , tblLabType as t , tblTypes_Labss as tl " +
                " where l.Id=tl.IdLab and t.Id = tl.IdType and l.id=" + idLab + "");
            //gets all from the lab
            DataTable dt1 = SqlCode.PullDataToDataTable("select * from tblLabs where id='" + idLab + "'");
            //gets all the types
            DataTable dt2 = SqlCode.PullDataToDataTable("select * from tblLabType");
            //sets the information
            txtLabName.Text = Convert.ToString(dt1.Rows[0]["name"]);
            txtNumPods.Text = Convert.ToString(dt1.Rows[0]["numPods"]);
            txtDescription.Text = Convert.ToString(dt1.Rows[0]["description"]);
            txtIP.Text = Convert.ToString(dt1.Rows[0]["labIP"]);

            //creates the types field
            foreach (DataRow row in dt2.Rows) // Loop over the items.
            {
                String tp = Convert.ToString(row["type"]);
                String tId = Convert.ToString(row["id"]);
                ListItem lst = new ListItem(tp, tId);
                ckbTypes.Items.Add(lst);
            }
            //selects the types of the lab
            foreach (ListItem listItem in ckbTypes.Items)
            {
                foreach (DataRow row in dt.Rows) // Loop over the items.
                {
                    string iddd = Convert.ToString(row["id"]);
                    if (listItem.Value == iddd)
                    {
                        listItem.Selected = true;
                    }
                }
            }
        }
        /// <summary>
        /// Button to update all information.Updates the Lab
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnUpdateLab_Click(object sender, EventArgs e)
        {
            try
            {

                //gets the new information
                string labName = txtLabName.Text;
                int numPods = Convert.ToInt16(txtNumPods.Text);
                string description = txtDescription.Text;
                string labIp = txtIP.Text;
                //if all fields are filled
                if (txtLabName.Text != "" && txtNumPods.Text != "" && txtDescription.Text != "" && txtIP.Text != "")
                {
                    //removes the dependencies
                    RemoveType_Lab(IDToEdit);
                    //add new dependencie
                    addType_Lab(IDToEdit);
                    //updates the table
                    UpdateLab(IDToEdit, labName, numPods, description, labIp);
                    //redirects
                    System.Threading.Thread.Sleep(3000);
                    Response.Redirect("~/Lab/Labs.aspx");
                }
            }            
            catch (Exception ex)
            {
                cphErrorMessage.Visible = true;
                txtOutput.Text = ex.Message + "Only numbers are permitted in Number pods field";
            }
        }
        /// <summary>
        /// updates the table Lab
        /// </summary>
        /// <param name="id"></param>
        /// <param name="name"></param>
        /// <param name="numPods"></param>
        /// <param name="description"></param>
        private void UpdateLab(int id, string name, int numPods, string description, string labIP)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //command
                string saveLab = " update tblLabs set name =@name,numPods = @numPods, description = @description, labIP = @labIP where id=@id"; ;
                using (SqlCommand command = new SqlCommand(saveLab, openCon))
                {
                    //new id
                    int maxId = SqlCode.SelectForINT("Select Max(id)+1 From tblLabs");
                    //parameters
                    command.Parameters.AddWithValue("@id", id);
                    command.Parameters.AddWithValue("@name", name);
                    command.Parameters.AddWithValue("@numPods", numPods);
                    command.Parameters.AddWithValue("@description", description);
                    command.Parameters.AddWithValue("@labIP", labIP);
                    try
                    {
                        //opens the connection
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();

                    }
                    catch (SqlException ex)
                    {
                        //error message
                        txtOutput.Text = ex.Message + "@UpdateData";
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
        /// adds the Type - Lab dependencies
        /// </summary>
        /// <param name="idLab"></param>
        private void addType_Lab(int idLab)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //command
                string saveTypes_Lab = " insert into tblTypes_Labss (IdType,IdLab) VALUES (@idType,@idLab)"; ;
                //runs the types
                foreach (ListItem listItem in ckbTypes.Items)
                {
                    //gets the selected ones
                    if (listItem.Selected == true)
                    {
                        //gets the id of the type
                        int idType = Convert.ToInt16(listItem.Value);
                        using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                        {
                            //command parameters
                            command.Parameters.AddWithValue("@idType", idType);
                            command.Parameters.AddWithValue("@idLab", idLab);
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

        /// <summary>
        /// Removes t
        /// </summary>
        /// <param name="idLabb"></param>
        private void RemoveType_Lab(int idLabb)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //commands
                string saveTypes_Lab = " delete from tblTypes_Labss where idLab= @idLab"; ;
                using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                {
                    //command parameters
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
                        //opens the connection
                        openCon.Close();
                    }
                    command.Parameters.Clear();
                }
            }
        }

        protected void SqlDSTypes_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }


        protected void btnRemoveType_Command(object sender, CommandEventArgs e)
        {
            //gets the lab id
            int idType = Convert.ToInt16(e.CommandArgument.ToString());
            //removes from association with lab
            RemoveType_LabT(idType);
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
        /// <param name="idType"></param>
        private void RemoveType_LabT(int idType)
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