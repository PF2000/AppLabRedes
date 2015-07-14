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

        int IDToEdit;


        protected void Page_Load(object sender, EventArgs e)
        {
            IDToEdit = Convert.ToInt16(Request.QueryString["idLab"]);
            if (!IsPostBack)
                BindText(IDToEdit);

        }

        protected void BindText(int idLab)
        {

            DataTable dt = SqlCode.PullDataToDataTable(
                " select t.id as id, t.type" +
                " from tblLabs as l , tblLabType as t , tblTypes_Labss as tl " +
                " where l.Id=tl.IdLab and t.Id = tl.IdType and l.id=" + idLab + "");

            DataTable dt1 = SqlCode.PullDataToDataTable("select * from tblLabs where id='" + idLab + "'");

            DataTable dt2 = SqlCode.PullDataToDataTable("select * from tblLabType");

            txtLabName.Text = Convert.ToString(dt1.Rows[0]["name"]);
            txtNumPods.Text = Convert.ToString(dt1.Rows[0]["numPods"]);
            txtDescription.Text = Convert.ToString(dt1.Rows[0]["description"]);


            foreach (DataRow row in dt2.Rows) // Loop over the items.
            {
                String tp = Convert.ToString(row["type"]);
                String tId = Convert.ToString(row["id"]);

                ListItem lst = new ListItem(tp, tId);

                ckbTypes.Items.Add(lst);
            }



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




        protected void btnUpdateLab_Click(object sender, EventArgs e)
        {
            string labName = txtLabName.Text;
            int numPods = Convert.ToInt16(txtNumPods.Text);
            string description = txtDescription.Text;

            RemoveType_Lab(IDToEdit);
            addType_Lab(IDToEdit);

            UpdateLab(IDToEdit, labName, numPods, description);

            System.Threading.Thread.Sleep(3000);
            Response.Redirect("~/Lab/Labs.aspx");
        }

        private void UpdateLab(int id, string name, int numPods, string description)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string saveLab = " update tblLabs set name =@name,numPods = @numPods, description = @description where id=@id"; ;

                using (SqlCommand command = new SqlCommand(saveLab, openCon))
                {
                    int maxId = SqlCode.SelectForINT("Select Max(id)+1 From tblLabType");

                    command.Parameters.AddWithValue("@id", id);
                    command.Parameters.AddWithValue("@name", name);
                    command.Parameters.AddWithValue("@numPods", numPods);
                    command.Parameters.AddWithValue("@description", description);
                    try
                    {
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();

                    }
                    catch (SqlException ex)
                    {
                        txtOutput.Text = ex.Message + "@UpdateData";

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

        private void addType_Lab(int idLab)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string saveTypes_Lab = " insert into tblTypes_Labss (IdType,IdLab) VALUES (@idType,@idLab)"; ;


                foreach (ListItem listItem in ckbTypes.Items)
                {
                    if (listItem.Selected == true)
                    {
                        int idType = Convert.ToInt16(listItem.Value);
                        using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                        {

                            command.Parameters.AddWithValue("@idType", idType);
                            command.Parameters.AddWithValue("@idLab", idLab);

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