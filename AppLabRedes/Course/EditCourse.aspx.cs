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

namespace AppLabRedes.Course
{
    public partial class EditCourse : System.Web.UI.Page
    {
        string UserType = "ExGroup";

        static DataTable dtTimes;

        static int numPodsLeftByDate = 0;
        static int numPodsLeftTotal = 0;
        static int numPodsFromLab = 0;
        int idCourse = 0;
        int LabId = 0;


        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                initTable();
                initfields();
            }
        }

        private void initfields()
        {

            idCourse = Convert.ToInt16(Request.QueryString["idCourse"]);

            LabId = SqlCode.SelectForINT("select lab from tblCourse where id='" + idCourse + "' ");

            DataTable dt = SqlCode.PullDataToDataTable("select * from tblCourse c,tblLabs l, tblLabType t where c.lab=l.id and c.cType=t.id and c.id='" + idCourse + "'");
            DataRow row = dt.Rows[0];

            String name = Convert.ToString(row["cName"]);
            String numUsers = Convert.ToString(row["numUsers"]);
            String description = Convert.ToString(row["description"]);
            String lab = Convert.ToString(row["name"]);
            String type = Convert.ToString(row["type"]);

            txtCourseName.Text = name;
            //populate ddl Labs
            initDdlLabs();
            //populate ddl Types
            initDdlTypes();
            //data from LoginTimes
            initLoginTimes();
            //populate ddl Users
            initDdlUsers();
            //Populate UserList
            initUsersList();

            txtDescription.Text = description;

        }

        private void initDdlLabs()
        {
            ddlLabs.ID = "ddlLabs";
            ddlLabs.AutoPostBack = true;
            ddlLabs.CssClass = "form-control";

            DataTable dt = SqlCode.PullDataToDataTable("select * from tblLabs");

            //default Item
            ListItem lst1 = new ListItem("Labs", "-1");
            ddlLabs.Items.Add(lst1);
            foreach (DataRow row in dt.Rows) // Loop over the items.
            {
                String tp = Convert.ToString(row["name"]);
                String tId = Convert.ToString(row["id"]);

                ListItem lst = new ListItem(tp, tId);

                ddlLabs.Items.Add(lst);
            }

            //set selection
            ddlLabs.Items.FindByValue(LabId + "").Selected = true;
            //gets pods from lab
            numPodsFromLab = SqlCode.SelectForINT("select numPods from tblLabs where id='" + LabId + "';");
            //initializes the number of pods left with the max number of users
            numPodsLeftTotal = numPodsFromLab;

        }

        private void initDdlTypes()
        {
            ddlTypes.ID = "ddlTypes";
            ddlTypes.AutoPostBack = true;
            ddlTypes.CssClass = "form-control";

            DataTable dt = SqlCode.PullDataToDataTable(
             " select t.id as id, t.type" +
             " from tblLabs as l , tblLabType as t , tblTypes_Labss as tl " +
             " where l.Id=tl.IdLab and t.Id = tl.IdType and l.id=" + ddlLabs.SelectedValue + "");


            //default Item
            ListItem lst1 = new ListItem("Types", "-1");
            ddlTypes.Items.Add(lst1);
            foreach (DataRow row in dt.Rows) // Loop over the items.
            {
                String tp = Convert.ToString(row["type"]);
                String tId = Convert.ToString(row["id"]);

                ListItem lst = new ListItem(tp, tId);

                ddlTypes.Items.Add(lst);
            }
            int TypeId = SqlCode.SelectForINT("select cType from tblCourse where id='" + idCourse + "'");
            //set selection
            ddlTypes.Items.FindByValue(TypeId + "").Selected = true;
        }

        private void initLoginTimes()
        {

            //to put in HTML
            String begin = SqlCode.SelectForString("select min(tBegin) from tblCourse c,tblLOginTimes as lt where lt.course=c.id and c.id='" + idCourse + "'");
            String end = SqlCode.SelectForString("select max(tBegin) from tblCourse c,tblLOginTimes as lt where lt.course=c.id and c.id='" + idCourse + "'");
            //to get time
            String endTime = SqlCode.SelectForString("select max(tEnd) from tblCourse c,tblLOginTimes as lt where lt.course=c.id and c.id='" + idCourse + "'");

            //Converts to dateTime
            DateTime tBegin = Convert.ToDateTime(begin);
            DateTime tEnd = Convert.ToDateTime(end);
            DateTime tEndTime = Convert.ToDateTime(endTime);
            //begin
            txtBDate.Text = tBegin.Date.ToString("d");
            txtBTime.Text = tBegin.TimeOfDay + "";
            //ed
            txtEDate.Text = tEnd.Date.ToString("d");
            txtETime.Text = tEndTime.TimeOfDay + "";

            //-------------------------------------------------------------------
            //to generate the dataTable

            String bDate = txtBDate.Text;
            String eDate = txtEDate.Text;

            String bTime = txtBTime.Text;
            String eTime = txtETime.Text;

            //Converts to dateTime
            DateTime dateeBegin = Convert.ToDateTime(bDate);
            DateTime dateeEnd = Convert.ToDateTime(eDate);
            //Converts to dateTime
            DateTime timeBegin = Convert.ToDateTime(bTime);
            DateTime timeEnd = Convert.ToDateTime(eTime);


            //counts the number of days
            TimeSpan ts = dateeEnd - dateeBegin;
            int numDays = ts.Days;

            //counts the number of days
            TimeSpan timeHours = timeEnd - timeBegin;
            int numHours = timeHours.Hours;

            DateTime dtt = new DateTime(dateeBegin.Year, dateeBegin.Month, dateeBegin.Day, timeBegin.Hour, timeBegin.Minute, timeBegin.Second);
            DateTime dtEnd = new DateTime(dateeEnd.Year, dateeEnd.Month, dateeEnd.Day, timeEnd.Hour, timeEnd.Minute, timeEnd.Second);

            //gets lab id
            int idLab = Convert.ToInt16(ddlLabs.SelectedValue);

            //initializes the number of pods left by date with the max number of users
            numPodsLeftByDate = numPodsFromLab;


            while (dtt.AddHours(numHours) <= dtEnd)
            {
                DateTime tB = dtt;
                DateTime tE = dtt.AddHours(numHours);


                //gets the number os pods available
                podsLeftOnInit(dateeBegin, dateeEnd, idLab,idCourse);

                //numero da proxima linha
                int rCount = dtTimes.Rows.Count + 1;

                dtTimes.Rows.Add(tB, tE, numPodsLeftByDate, numPodsFromLab, rCount);
                //update datasource

                dtt = dtt.AddDays(1);
            }
            lblnumAvlPods.InnerText = numPodsLeftTotal + "";
            lblnumTotalPods.InnerText = numPodsFromLab + "";

        }

        private void initDdlUsers()
        {

            ddlNumPods.Items.Clear();
            ListItem lst1 = new ListItem("Num Pods", "-1");
            ddlNumPods.Items.Insert(0, lst1);
            for (int i = 0; i < numPodsLeftTotal; i++)
            {
                int k = numPodsLeftByDate - i;
                ListItem lst = new ListItem(k + "", k + "");
                ddlNumPods.Items.Add(lst);
            }
            int numUsersPods = SqlCode.SelectForINT("select numUsers from tblCourse where id='" + idCourse + "'");
            //set selection
            ddlNumPods.Items.FindByValue(numUsersPods + "").Selected = true;
        }

        private void initUsersList()
        {
            //data from Users
            DataTable dt2 = SqlCode.PullDataToDataTable("select usr as Name, pass as Pass from tblCourse c,tblUsers as u where u.course=c.id and c.id='" + idCourse + "'");

            lstUsers.DataSource = dt2;
            lstUsers.DataBind();
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

                initTable();
                numPodsLeftTotal = numPodsFromLab;


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

                #region on change clears all
                cphPods.Visible = false;
                cphTime.Visible = false;
                cphUsers.Visible = false;
                cphPodsLeft.Visible = false;
                initTable();
                numPodsLeftTotal = numPodsFromLab;

                //refresh txt
                txtBDate.Text = "";
                txtBTime.Text = "";
                txtEDate.Text = "";
                txtETime.Text = "";
                lblnumAvlPods.InnerText = "";
                lblnumTotalPods.InnerText = "";
                foreach (ListViewItem lstItem in lstUsers.Items)
                {
                    ((TextBox)lstItem.FindControl("txtName")).Text = "";
                }
                #endregion
            }
            else
            {
                #region if there are no labs selected
                cphTypes.Visible = false;
                cphPods.Visible = false;
                cphTime.Visible = false;
                cphUsers.Visible = false;
                initTable();
                numPodsLeftTotal = numPodsFromLab;

                //refresh txt
                txtBDate.Text = "";
                txtBTime.Text = "";
                txtEDate.Text = "";
                txtETime.Text = "";
                foreach (ListViewItem lstItem in lstUsers.Items)
                {
                    ((TextBox)lstItem.FindControl("txtName")).Text = "";
                }

                #endregion

            }
            UpdatePanel1.Update();
            UpdatePanel2.Update();
            UpdatePanel4.Update();
            UpdatePanel5.Update();
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
                //toclear
                cphPods.Visible = false;
                cphTime.Visible = false;
                cphUsers.Visible = false;
                initTable();
                numPodsLeftTotal = numPodsFromLab;

                //refresh txt
                txtBDate.Text = "";
                txtBTime.Text = "";
                txtEDate.Text = "";
                txtETime.Text = "";
                foreach (ListViewItem lstItem in lstUsers.Items)
                {
                    ((TextBox)lstItem.FindControl("txtName")).Text = "";
                }

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

        protected void btnTime_Click(object sender, EventArgs e)
        {
            String bDate = txtBDate.Text;
            String eDate = txtEDate.Text;

            String bTime = txtBTime.Text;
            String eTime = txtETime.Text;

            //id fields are not empty
            if (bDate != "" && eDate != "" && bTime != "" && eTime != "")
            {
                //Converts to dateTime
                DateTime tBegin = Convert.ToDateTime(bDate);
                DateTime tEnd = Convert.ToDateTime(eDate);
                //Converts to dateTime
                DateTime timeBegin = Convert.ToDateTime(bTime);
                DateTime timeEnd = Convert.ToDateTime(eTime);

                //se end time is bigger than begin time
                if (tBegin <= tEnd)
                {
                    //counts the number of days
                    TimeSpan ts = tEnd - tBegin;
                    int numDays = ts.Days;

                    //counts the number of days
                    TimeSpan timeHours = timeEnd - timeBegin;
                    int numHours = timeHours.Hours;

                    DateTime dtt = new DateTime(tBegin.Year, tBegin.Month, tBegin.Day, timeBegin.Hour, timeBegin.Minute, timeBegin.Second);
                    DateTime dtEnd = new DateTime(tEnd.Year, tEnd.Month, tEnd.Day, timeEnd.Hour, timeEnd.Minute, timeEnd.Second);

                    //gets lab id
                    int idLab = Convert.ToInt16(ddlLabs.SelectedValue);

                    //initializes the number of pods left by date with the max number of users
                    numPodsLeftByDate = numPodsFromLab;


                    while (dtt.AddHours(numHours) <= dtEnd)
                    {
                        DateTime tB = dtt;
                        DateTime tE = dtt.AddHours(numHours);


                        //gets the number os pods available
                        podsLeft(tBegin, tEnd, idLab);

                        //numero da proxima linha
                        int rCount = dtTimes.Rows.Count + 1;

                        dtTimes.Rows.Add(tB, tE, numPodsLeftByDate, numPodsFromLab, rCount);
                        //update datasource

                        dtt = dtt.AddDays(1);
                    }
                    cphPodsLeft.Visible = true;
                    cphTime.Visible = true;

                    lblnumAvlPods.InnerText = numPodsLeftTotal + "";
                    lblnumTotalPods.InnerText = numPodsFromLab + "";

                    bindDdl();
                    UpdatePanel1.Update();

                }
            }
        }

        private void podsLeft(DateTime tB, DateTime tE, int idLab)
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
                if ((dBegin > tB && dBegin < tE) || (dEnd < tB && dEnd > tE))
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

        private void podsLeftOnInit(DateTime tB, DateTime tE, int idLab, int idCourse)
        {

            DataTable dt = SqlCode.PullDataToDataTable(
               " select lt.tBegin , lt.tEnd, c.numUsers" +
               " from tblLabs as l , tblCourse as c , tblLOginTimes as lt, tblUsers as u " +
               " where l.Id=" + idLab + " and c.id != '"+idCourse+"' and l.id=c.Lab and lt.course=c.id and u.course=c.id");
            int podsAvl = 50;

            //verificações
            foreach (DataRow row in dt.Rows)
            {
                DateTime dBegin = Convert.ToDateTime(row["tBegin"]);
                DateTime dEnd = Convert.ToDateTime(row["tEnd"]);
                podsAvl = Convert.ToInt16(row["numUsers"]);

                //ifThereUsers
                if ((dBegin > tB && dBegin < tE) || (dEnd < tB && dEnd > tE))
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

        private void bindDdl()
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
                } while (isForbiddenUser(usr, dt));
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

        protected void btnUpdateCourse_Click(object sender, EventArgs e)
        {

            bool valid = true;
            foreach (ListViewItem lstItem in lstUsers.Items)
            {
                String usr = ((TextBox)lstItem.FindControl("txtName")).Text;
                if (isForbiddenUserBeforeInsert(usr, idCourse))
                {
                    valid = false;
                }
            }

            if (valid == true)
            {
                updateCourse(idCourse);
                //removes 
                RemoveLogTimes(idCourse);
                RemoveUsers(idCourse);
                //inserts agains
                insertLoginTimes(idCourse);
                insertUsers(idCourse);
                //redirect
                System.Threading.Thread.Sleep(3000);
                Response.Redirect("~/Course/Courses.aspx");
            }
        }

        private void updateCourse(int idCourse)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string strr = " update tblCourse set Lab=@idLab,description=@description,numUsers=@numUsers,cName=@cName,cType=@cType where id=@id"; ;


                using (SqlCommand command = new SqlCommand(strr, openCon))
                {

                    command.Parameters.AddWithValue("@id", idCourse);
                    command.Parameters.AddWithValue("@idLab", ddlLabs.SelectedValue);
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
                        txtOutput.Text = ex.Message + "@updateData";

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

        private void insertLoginTimes(int idCourse)
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

        private void insertUsers(int idCourse)
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

        private bool isForbiddenUser(String name, DataTable dt)
        {

            int count = SqlCode.SelectForINT("select count(*) from tblUsers where usr='" + name + "'");
            if (count != 0)
            {
                return true;
            }

            foreach (DataRow row in dt.Rows)
            {
                String usr = row["Name"].ToString();
                if (usr.Equals(name))
                {
                    return true;
                }
            }

            return false;
        }

        private bool isForbiddenUserBeforeInsert(String name, int idCourse)
        {

            int count = SqlCode.SelectForINT("select count(*) from tblUsers where usr='" + name + "' and course != '" + idCourse + "'");
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