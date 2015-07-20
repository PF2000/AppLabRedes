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

        static String eDate;
        static String bDate;
        static String eTime;
        static String bTime;


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
        /// <summary>
        /// to check selected lab and updates the variables associated
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlLabs_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlTypes.Items.Clear();

            int LabId = Convert.ToInt16(ddlLabs.SelectedValue);
            if (LabId != -1)
            {
                initTable();
                //sets parameters to ddlTypes
                ddlTypes.ID = "ddlTypes";
                ddlTypes.AutoPostBack = true;
                ddlTypes.CssClass = "form-control";
                //gets the table of types
                DataTable dt = SqlCode.PullDataToDataTable(
                 " select t.id as id, t.type" +
                 " from tblLabs as l , tblLabType as t , tblTypes_Labss as tl " +
                 " where l.Id=tl.IdLab and t.Id = tl.IdType and l.id=" + LabId + "");
                //default Item
                ListItem lst1 = new ListItem("Types", "-1");
                ddlTypes.Items.Add(lst1);

                //adds the types to list
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
        /// <summary>
        /// to insert the defaultItem 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlLabs_DataBound(object sender, EventArgs e)
        {

            ListItem lst1 = new ListItem("Labs", "-1");
            ddlLabs.Items.Insert(0, lst1);
        }
        /// <summary>
        /// to insert the defaultItem 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlType_DataBound(object sender, EventArgs e)
        {
            ListItem lst1 = new ListItem("Types", "-1");
            ddlTypes.Items.Insert(0, lst1);
        }
        /// <summary>
        /// to validate the type selection
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            int typeId = Convert.ToInt16(ddlTypes.SelectedValue);
            //if selected option is valid
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
            }
            UpdatePanel1.Update();
            UpdatePanel2.Update();
            UpdatePanel4.Update();
            UpdatePanel5.Update();
        }
        /// <summary>
        /// Button to verify the time selected
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnTime_Click(object sender, EventArgs e)
        {
            int LabId = Convert.ToInt16(ddlLabs.SelectedValue);
            //gets pods from lab
            numPodsFromLab = SqlCode.SelectForINT("select numPods from tblLabs where id='" + LabId + "';");
            //initializes the number of pods left with the max number of users
            numPodsLeftTotal = numPodsFromLab;
            //dates
            bDate = txtBDate.Text;
            eDate = txtEDate.Text;
            //times
            bTime = txtBTime.Text;
            eTime = txtETime.Text;

            //id fields are not empty
            if (bDate != "" && eDate != "" && bTime != "" && eTime != "")
            {
                //Converts to dateTime
                DateTime tBegin = Convert.ToDateTime(bDate);
                DateTime tEnd = Convert.ToDateTime(eDate);
                //Converts to dateTime
                DateTime timeBegin = Convert.ToDateTime(bTime);
                DateTime timeEnd = Convert.ToDateTime(eTime);

                //if end time is bigger than begin time
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
                        podsLeft(tB, tE, idLab);

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
        /// <summary>
        /// gets the pods left in the date in the lab
        /// </summary>
        /// <param name="tB"></param>
        /// <param name="tE"></param>
        /// <param name="idLab"></param>
        public void podsLeft(DateTime tB, DateTime tE, int idLab)
        {
            //gets the table of with the dates and users of the lab
            DataTable dt = SqlCode.PullDataToDataTable(
               " select distinct lt.tBegin , lt.tEnd, c.numUsers" +
               " from tblLabs as l , tblCourse as c , tblLOginTimes as lt, tblUsers as u " +
               " where l.Id=" + idLab + " and l.id=c.Lab and lt.course=c.id and u.course=c.id");
            int podsAvl = 50;
            //runs all the rows in the table
            foreach (DataRow row in dt.Rows)
            {
                //converts to date time
                DateTime dBegin = Convert.ToDateTime(row["tBegin"]);
                DateTime dEnd = Convert.ToDateTime(row["tEnd"]);
                //gets the number of users in the courses selected
                podsAvl = Convert.ToInt16(row["numUsers"]);
                //substract to the number os pods in the lab
                podsAvl = numPodsFromLab - podsAvl;
                //ifThereUsers in the time selected
                if ((dBegin >= tB && dBegin <= tE) || (dEnd <= tB && dEnd >= tE))
                {
                    //updates the number minimum number of pod by date
                    if (podsAvl <= numPodsLeftByDate)
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
        /// <summary>
        /// to build the list with the number of pods
        /// </summary>
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
        /// <summary>
        /// When the number of pods is selected creates the users.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlNumPods_SelectedIndexChanged(object sender, EventArgs e)
        {
            //check the number of pods
            int numCreatePods = Convert.ToInt16(ddlNumPods.SelectedValue);

            //create data table
            DataTable dt = new DataTable();
            dt.Columns.Add("Name", typeof(string));
            dt.Columns.Add("Pass", typeof(string));

            //to generate the userNames
            for (int i = 0; i < numCreatePods; i++)
            {
                int k = SqlCode.SelectForINT("select count(*) from tblUsers");
                String usr = UserType + (i + 1);
                do
                {
                    usr = UserType + ((i + 1) + k);
                    k++;
                } while (isForbiddenUser(usr,dt));
                //Pass to user
                String pass = (Guid.NewGuid().ToString("N").Substring(1, 8) + ".").Trim();
                //adds todataTable
                dt.Rows.Add(usr, pass);
            }
            //binds the data table to the list
            lstUsers.DataSource = dt;
            lstUsers.DataBind();

            cphUsers.Visible = true;
            //if number of users is valid
            if (Convert.ToInt16(ddlNumPods.SelectedValue) < 0)
            {
                cphUsers.Visible = false;
            }
            UpdatePanel4.Update();
        }
        /// <summary>
        /// To Convert a date time in a TimeZone to server TimeZone
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="IdNewTz"></param>
        /// <returns></returns>
        protected DateTime ConvertTime(DateTime dt, String IdNewTz)
        {
            //gets the localTimeZone
            String IdLocalTz = TimeZoneInfo.Local.Id;
            //data converted
            DateTime nDateTime = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(dt, IdNewTz, IdLocalTz);
            return nDateTime;
        }
        /// <summary>
        /// on button click inserts the course.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            //gets the maxId(next)
            int maxId = SqlCode.SelectForINT("Select Max(id)+1 From tblCourse");

            bool valid = true;
            //checks if users are all valid
            foreach (ListViewItem lstItem in lstUsers.Items)
            {
                String usr = ((TextBox)lstItem.FindControl("txtName")).Text;
                if (isForbiddenUserBeforeInsert(usr))
                {
                    valid = false;
                }
            }
            //checks if the users are really valid
            if (valid == true)
            {
                insertCourse(maxId);
                insertLoginTimes(maxId);
                insertUsers(maxId);
                System.Threading.Thread.Sleep(3000);
                Response.Redirect("~/Course/Courses.aspx");
            }
        }
        /// <summary>
        /// Inserts the course in Database.
        /// </summary>
        /// <param name="maxId">NextId</param>
        protected void insertCourse(int maxId)
        {
            //conectionString
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //command
                string saveTypes_Lab = " insert into tblCourse (id,Lab,description,numUsers,cName,cType) VALUES (@id,@idLab,@description,@numUsers,@cName,@cType)"; 
                using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                {
                    //all command parameters
                    command.Parameters.AddWithValue("@id", maxId);
                    command.Parameters.AddWithValue("@idLab", ddlLabs.SelectedValue);
                    command.Parameters.AddWithValue("@description", txtDescription.Text);
                    command.Parameters.AddWithValue("@numUsers", ddlNumPods.SelectedValue);
                    command.Parameters.AddWithValue("@cName", txtCourseName.Text);
                    command.Parameters.AddWithValue("@cType", ddlTypes.SelectedValue);
                    try
                    {
                        //open connection
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException ex)
                    {
                        //output error
                        txtOutput.Text = ex.Message + "@InsertData";

                    }
                    finally
                    {
                        //closes the connection
                        openCon.Close();
                    }
                    //clear the parameters
                    command.Parameters.Clear();
                }
            }
        }
        /// <summary>
        /// Inserts the loginTimes in course
        /// </summary>
        /// <param name="idCourse">Course Id</param>
        protected void insertLoginTimes(int idCourse)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //insertCommands
                string saveTypes_Lab = " insert into tblLOginTimes (tBegin,tEnd,course) VALUES (@tBegin,@tEnd,@course)"; ;
                //inserts all the times in the previously added when creating a course
                foreach (DataRow row in dtTimes.Rows)
                {
                    using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                    {
                        //command parameters
                        command.Parameters.AddWithValue("@tBegin", row["begin"]);
                        command.Parameters.AddWithValue("@tEnd", row["end"]);
                        command.Parameters.AddWithValue("@course", idCourse);

                        try
                        {
                            //opens the connections
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
                            //closes connections
                            openCon.Close();
                        }
                        command.Parameters.Clear();
                    }
                }
            }
        }
        /// <summary>
        /// inserts the users for a courswe
        /// </summary>
        /// <param name="idCourse">course Id</param>
        protected void insertUsers(int idCourse)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string saveTypes_Lab = " insert into tblUsers (usr,pass,course,email) VALUES (@user,@pass,@course,@mail)"; ;

                foreach (ListViewItem lstItem in lstUsers.Items)
                {

                    using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                    {

                        String usr = ((TextBox)lstItem.FindControl("txtName")).Text;
                        String pass = ((TextBox)lstItem.FindControl("txtPass")).Text;
                        String mail = ((TextBox)lstItem.FindControl("txtMail")).Text;

                        command.Parameters.AddWithValue("@user", usr);
                        command.Parameters.AddWithValue("@pass", pass);
                        command.Parameters.AddWithValue("@mail", mail);
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

        /// <summary>
        /// Check the user name is valid. If is in the database or in the webForm
        /// </summary>
        /// <param name="name"></param>
        /// <param name="dt"></param>
        /// <returns></returns>
        private bool isForbiddenUser(String name, DataTable dt)
        {
            //check the database for the name
            int count = SqlCode.SelectForINT("select count(*) from tblUsers where usr='" + name + "'");
            //if some name is returned returns true
            if (count != 0)
            {
                return true;
            }
            //checks all the names in the webform
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
        /// <summary>
        /// Check the user name is valid before insertion(the user can change them). If is in the database or in the webForm
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        private bool isForbiddenUserBeforeInsert(String name)
        {
            //check the database for the name
            int count = SqlCode.SelectForINT("select count(*) from tblUsers where usr='" + name + "'");
            if (count != 0)
            {
                return true;
            }
            int kk = 0;
            //if some name is returned returns true
            foreach (ListViewItem lstItem in lstUsers.Items)
            {
                String usr = ((TextBox)lstItem.FindControl("txtName")).Text;
                if (usr.Equals(name))
                {
                    kk++;
                }
            }
            //because only one can be equal 
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