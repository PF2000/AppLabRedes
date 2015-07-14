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

namespace AppLabRedes.CourseDetails
{
    public partial class CreateCourse : System.Web.UI.Page
    {

        string UserType = "ExGroup";

        static DataTable dtTimes;

        static int numPodsLeftByDate = 0;
        static int numPodsLeftTotal = 0;
        static int numPodsFromLab = 0;


        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                initTable();
            }
        }

        private void initTable()
        {
            dtTimes = new DataTable();
            dtTimes.Columns.Add("begin", typeof(DateTime));
            dtTimes.Columns.Add("end", typeof(DateTime));
            dtTimes.Columns.Add("numPods", typeof(int));
            dtTimes.Columns.Add("TotalPods", typeof(int));
            dtTimes.Columns.Add("rId", typeof(int));
        }

        protected void ddlLabs_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlTypes.Items.Clear();

            int LabId = Convert.ToInt16(ddlLabs.SelectedValue);
            if (LabId != -1)
            {

                ddlTypes.ID = "ddlTypes";
                ddlTypes.AutoPostBack = true;
                ddlTypes.CssClass = "form-control";

                DataTable dt = SqlCode.PullDataToDataTable(
                 " select t.id as id, t.type" +
                 " from tblLabs as l , tblLabType as t , tblTypes_Labss as tl " +
                 " where l.Id=tl.IdLab and t.Id = tl.IdType and l.id=" + LabId + "");


                //default Item
                ListItem lst1 = new ListItem("Types", "-1");
                ddlTypes.Items.Add(lst1);

                //gets pods from lab
                numPodsFromLab = SqlCode.SelectForINT("select numPods from tblLabs where id='" + LabId + "';");
                //initializes the number of pods left with the max number of users
                numPodsLeftTotal = numPodsFromLab;

                foreach (DataRow row in dt.Rows) // Loop over the items.
                {
                    String tp = Convert.ToString(row["type"]);
                    String tId = Convert.ToString(row["id"]);

                    ListItem lst = new ListItem(tp, tId);

                    ddlTypes.Items.Add(lst);
                }

                //adicionar
                cphTypes.Visible = true;

            }
            else
            {
                cphTypes.Visible = false;
                cphPods.Visible = false;
                cphTime.Visible = false;
                cphUsers.Visible = false;
                initTable();
            }
            UpdatePanel1.Update();
            UpdatePanel2.Update();
            UpdatePanel4.Update();
            UpdatePanel5.Update();
        }

        protected void ddlLabs_DataBound(object sender, EventArgs e)
        {

            ListItem lst1 = new ListItem("Labs", "-1");
            ddlLabs.Items.Insert(0, lst1);
        }

        protected void ddlType_DataBound(object sender, EventArgs e)
        {
            ListItem lst1 = new ListItem("Types", "-1");
            ddlTypes.Items.Insert(0, lst1);
        }

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            int typeId = Convert.ToInt16(ddlTypes.SelectedValue);
            if (typeId != -1)
            {

                cphTime.Visible = true;
                UpdatePanel1.Update();

            }
            else
            {
                cphPods.Visible = false;
                cphTime.Visible = false;
                cphUsers.Visible = false;
                initTable();
                numPodsLeftTotal = numPodsFromLab; ;
            }
            UpdatePanel1.Update();
            UpdatePanel2.Update();
            UpdatePanel4.Update();
            UpdatePanel5.Update();
        }

        protected void btnTime_Click(object sender, EventArgs e)
        {
            String tB = txtnBDate.Text;
            String tE = txtnEDate.Text;

            if (tB != "" && tE != "")
            {
                DateTime tBegin = Convert.ToDateTime(txtnBDate.Text);
                DateTime tEnd = Convert.ToDateTime(txtnEDate.Text);
                if (tBegin < tEnd)
                {
                    //gets lab id
                    int idLab = Convert.ToInt16(ddlLabs.SelectedValue);

                    //initializes the number of pods left by date with the max number of users
                    numPodsLeftByDate = numPodsFromLab;

                    //gets the number os pods available
                    podsLeft(tBegin, tEnd, idLab);
                    //numero da proxima linha
                    int rCount = dtTimes.Rows.Count + 1;

                    dtTimes.Rows.Add(tB, tE, numPodsLeftByDate, numPodsFromLab, rCount);
                    //update datasource
                    lstTimes.DataSource = dtTimes;
                    lstTimes.DataBind();

                    cphTime.Visible = true;

                    txtnBDate.Text = "";
                    txtnEDate.Text = "";
                    bindDdl();
                    UpdatePanel1.Update();

                }
            }
        }

        public void podsLeft(DateTime tB, DateTime tE, int idLab)
        {

            DataTable dt = SqlCode.PullDataToDataTable(
               " select lt.tBegin , lt.tEnd, c.numUsers" +
               " from tblLabs as l , tblCourse as c , tblLOginTimes as lt, tblUsers as u " +
               " where l.Id=" + idLab + " and l.id=c.Lab and lt.course=c.id and u.course=c.id");
            int podsAvl = 50;

            //verificações
            foreach (DataRow row in dt.Rows)
            {
                DateTime dBegin = Convert.ToDateTime(row["tBegin"]);
                DateTime dEnd = Convert.ToDateTime(row["tEnd"]);
                podsAvl = Convert.ToInt16(row["numUsers"]);

                //ifThereUsers
                if( (dBegin > tB && dBegin < tE) || (dEnd <tB && dEnd > tE) )
                {
                    //updates the number minimum number of pod by date
                    if (podsAvl < numPodsLeftByDate)
                    {
                        numPodsLeftByDate = podsAvl;
                        //updates the number minimum number of pod total
                        if (numPodsLeftByDate < numPodsLeftTotal)
                        {
                            numPodsLeftTotal = numPodsLeftByDate;
                        }
                    }


                }

            }
        }

        protected void bindDdl()
        {
            ddlNumPods.Items.Clear();
            ListItem lst1 = new ListItem("Num Pods", "-1");
            ddlNumPods.Items.Insert(0, lst1);
            for (int i = 0; i < numPodsLeftTotal; i++)
            {
                int k = numPodsLeftTotal - i;
                ListItem lst = new ListItem(k + "", k + "");
                ddlNumPods.Items.Add(lst);
            }
            cphPods.Visible = true;
            UpdatePanel5.Update();
        }

        protected void ddlNumPods_SelectedIndexChanged(object sender, EventArgs e)
        {
            int numCreatePods = Convert.ToInt16(ddlNumPods.SelectedValue);

            //create data table
            DataTable dt = new DataTable();
            dt.Columns.Add("Name", typeof(string));
            dt.Columns.Add("Pass", typeof(string));

            for (int i = 0; i < numCreatePods; i++)
            {

                int k = SqlCode.SelectForINT("select count(*) from tblUsers");
                String usr = UserType + (i + 1);
                do
                {
                    usr = UserType + ((i + 1) + k);
                    k++;
                } while (isForbiddenUser(usr));
                //Pass para user
                String pass = (Guid.NewGuid().ToString("N").Substring(1, 8) + ".").Trim();
                dt.Rows.Add(usr, pass);
            }

            lstUsers.DataSource = dt;
            lstUsers.DataBind();

            cphUsers.Visible = true;

            if (Convert.ToInt16(ddlNumPods.SelectedValue) < 0)
            {
                cphUsers.Visible = false;

            }
            UpdatePanel4.Update();

        }

        protected void btnTimeRemove_Command(object sender, CommandEventArgs e)
        {
            int rid = Convert.ToInt16(e.CommandArgument.ToString());

            dtTimes.Rows[rid - 1].Delete();

            if (dtTimes.Rows.Count != 0)
            {
                //updates the number of pods left
                foreach (DataRow row in dtTimes.Rows)
                {
                    int ll = Convert.ToInt16(row["numPods"]);
                    if (ll < numPodsLeftByDate)
                    {
                        numPodsLeftByDate = ll;
                    }
                }
            }
            else
            {
                cphPods.Visible = false;
                cphUsers.Visible = false;
                UpdatePanel4.Update();
                UpdatePanel5.Update();
            }
            lstTimes.DataSource = dtTimes;
            lstTimes.DataBind();
            UpdatePanel1.Update();

        }

        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            //gets the maxId
            int maxId = SqlCode.SelectForINT("Select Max(id)+1 From tblCourse");

            bool valid = true;
            foreach (ListViewItem lstItem in lstUsers.Items)
            {
                String usr = ((TextBox)lstItem.FindControl("txtName")).Text;
                if (isForbiddenUserBeforeInsert(usr))
                {
                    valid = false;
                }
            }

            if (valid == true)
            {
                insertCourse(maxId);
                insertLoginTimes(maxId);
                insertUsers(maxId);
                System.Threading.Thread.Sleep(3000);
                Response.Redirect("~/Course/Courses.aspx");
            }
        }

        protected void insertCourse(int maxId)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string saveTypes_Lab = " insert into tblCourse (id,Lab,active,description,numUsers,cName,cType) VALUES (@id,@idLab,@active,@description,@numUsers,@cName,@cType)"; ;


                using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                {

                    command.Parameters.AddWithValue("@id", maxId);
                    command.Parameters.AddWithValue("@idLab", ddlLabs.SelectedValue);
                    command.Parameters.AddWithValue("@active", false);
                    command.Parameters.AddWithValue("@description", txtDescription.Text);
                    command.Parameters.AddWithValue("@numUsers", ddlNumPods.SelectedValue);
                    command.Parameters.AddWithValue("@cName", txtCourseName.Text);
                    command.Parameters.AddWithValue("@cType", ddlTypes.SelectedValue);
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
            txtOutput.Text = "";
        }

        protected void insertLoginTimes(int idCourse)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string saveTypes_Lab = " insert into tblLOginTimes (tBegin,tEnd,course) VALUES (@tBegin,@tEnd,@course)"; ;

                foreach (DataRow row in dtTimes.Rows)
                {

                    using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                    {

                        command.Parameters.AddWithValue("@tBegin", row["begin"]);
                        command.Parameters.AddWithValue("@tEnd", row["end"]);
                        command.Parameters.AddWithValue("@course", idCourse);

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
            txtOutput.Text = "";
        }

        protected void insertUsers(int idCourse)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string saveTypes_Lab = " insert into tblUsers (usr,pass,course) VALUES (@user,@pass,@course)"; ;

                foreach (ListViewItem lstItem in lstUsers.Items)
                {

                    using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                    {

                        String usr = ((TextBox)lstItem.FindControl("txtName")).Text;
                        String pass = ((TextBox)lstItem.FindControl("txtPass")).Text;

                        command.Parameters.AddWithValue("@user", usr);
                        command.Parameters.AddWithValue("@pass", pass);
                        command.Parameters.AddWithValue("@course", idCourse);

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
            txtOutput.Text = "";
        }

        private bool isForbiddenUser(String name)
        {

            int count = SqlCode.SelectForINT("select count(*) from tblUsers where usr='" + name + "'");
            if (count != 0)
            {
                return true;
            }

            foreach (ListViewItem lstItem in lstUsers.Items)
            {
                String usr = ((TextBox)lstItem.FindControl("txtName")).Text;
                if (usr.Equals(name))
                {
                    return true;
                }
            }

            return false;
        }

        private bool isForbiddenUserBeforeInsert(String name)
        {

            int count = SqlCode.SelectForINT("select count(*) from tblUsers where usr='" + name + "'");
            if (count != 0)
            {
                return true;
            }
            int kk = 0;
            foreach (ListViewItem lstItem in lstUsers.Items)
            {
                String usr = ((TextBox)lstItem.FindControl("txtName")).Text;
                if (usr.Equals(name))
                {
                    kk++;
                }
            }

            if (kk <= 1)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

    }
}