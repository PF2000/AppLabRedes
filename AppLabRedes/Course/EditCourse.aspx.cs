using AppLabRedes.Scripts.MyScripts;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
        static int idCourse = 0;
        int LabId = 0;


        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                initTable();
                initfields();
            }
        }
        #region init all fields
        /// <summary>
        /// To init all fields
        /// </summary>
        private void initfields()
        {
            //gets course id from query string
            idCourse = Convert.ToInt16(Request.QueryString["idCourse"]);
            //gets labId
            LabId = SqlCode.SelectForINT("select lab from tblCourse where id='" + idCourse + "' ");
            //all information about the course
            DataTable dt = SqlCode.PullDataToDataTable("select * from tblCourse c,tblLabs l, tblLabType t where c.lab=l.id and c.cType=t.id and c.id='" + idCourse + "'");
            DataRow row = dt.Rows[0];

            String name = Convert.ToString(row["cName"]);
            String numUsers = Convert.ToString(row["numUsers"]);
            String description = Convert.ToString(row["description"]);
            String lab = Convert.ToString(row["name"]);
            String type = Convert.ToString(row["type"]);
            String idTimeZone = Convert.ToString(row["timeZone"]);

            //sets the course name
            txtCourseName.Text = name;
            //populate ddl Labs
            initDdlLabs();
            //populate ddl Types
            initDdlTypes();
            //data from LoginTimes
            initLoginTimes(idTimeZone);
            //popoulate timezone
            initDdlTimeZone(idTimeZone);
            //populate ddl Users
            initDdlUsers();
            //Populate UserList
            initUsersList();
            //sets the description
            txtDescription.Text = description;
        }
        /// <summary>
        /// Init the Labs drop down list 
        /// </summary>
        private void initDdlLabs()
        {
            //sets the ddlLabs parameters
            ddlLabs.ID = "ddlLabs";
            ddlLabs.AutoPostBack = true;
            ddlLabs.CssClass = "form-control";
            //gets all Labs
            DataTable dt = SqlCode.PullDataToDataTable("select * from tblLabs");

            //default Item
            ListItem lst1 = new ListItem(" ", "-1");
            ddlLabs.Items.Add(lst1);
            //Other labs
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
        /// <summary>
        /// Init the LabTypes drop down list 
        /// </summary>
        private void initDdlTypes()
        {
            //sets the ddlTypes parameters
            ddlTypes.ID = "ddlTypes";
            ddlTypes.AutoPostBack = true;
            ddlTypes.CssClass = "form-control";
            //gets all the Types that matching the given Lab
            DataTable dt = SqlCode.PullDataToDataTable(
             " select t.id as id, t.type" +
             " from tblLabs as l , tblLabType as t , tblTypes_Labss as tl " +
             " where l.Id=tl.IdLab and t.Id = tl.IdType and l.id=" + ddlLabs.SelectedValue + "");

            //default Item
            ListItem lst1 = new ListItem(" ", "-1");
            ddlTypes.Items.Add(lst1);
            //sets all types
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
        /// <summary>
        /// Init the LabTypes drop down list 
        /// </summary>
        private void initDdlTimeZone(String idTimeZone)
        {
            //sets the ddlTypes parameters
            ddlTimeZone.ID = "ddlTimeZone";
            ddlTimeZone.AutoPostBack = true;
            ddlTimeZone.CssClass = "form-control";
            //gets all the Types that matching the given Lab
            ReadOnlyCollection<TimeZoneInfo> tzi;
            tzi = TimeZoneInfo.GetSystemTimeZones();
            //adds default item
            ListItem lst1 = new ListItem(" ", "-1");
            ddlTimeZone.Items.Add(lst1);
            foreach (TimeZoneInfo timeZone in tzi)
            {
                ddlTimeZone.Items.Add(new ListItem(timeZone.DisplayName, timeZone.Id));
            }
            //set selection
            ddlTimeZone.Items.FindByValue(idTimeZone + "").Selected = true;
        }
        /// <summary>
        /// Init the LoginTimes list 
        /// </summary>
        private void initLoginTimes(String idTimeZone)
        {
            //to put in Form
            String begin = SqlCode.SelectForString("select min(tBegin) from tblCourse c,tblLOginTimes as lt where lt.course=c.id and c.id='" + idCourse + "'");
            String end = SqlCode.SelectForString("select max(tBegin) from tblCourse c,tblLOginTimes as lt where lt.course=c.id and c.id='" + idCourse + "'");
            //to get time
            String endTime = SqlCode.SelectForString("select max(tEnd) from tblCourse c,tblLOginTimes as lt where lt.course=c.id and c.id='" + idCourse + "'");

            //gets the name of timezone
            String timeZone = Convert.ToString(TimeZoneInfo.FindSystemTimeZoneById(idTimeZone));

            //gets the localTimeZone
            String IdLocalTz = TimeZoneInfo.Local.Id;

            //Converts to dateTime
            DateTime tBegin = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(Convert.ToDateTime(begin), IdLocalTz, idTimeZone);
            DateTime tEnd = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(Convert.ToDateTime(end), IdLocalTz, idTimeZone);
            DateTime tEndTime = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(Convert.ToDateTime(endTime), IdLocalTz, idTimeZone);
            //begin
            txtBDate.Text = tBegin.Date.ToString("d");
            txtBTime.Text = tBegin.TimeOfDay + "";
            //end
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
            int numMin = timeHours.Minutes;

            DateTime dtt = new DateTime(dateeBegin.Year, dateeBegin.Month, dateeBegin.Day, timeBegin.Hour, timeBegin.Minute, timeBegin.Second);
            DateTime dtEnd = new DateTime(dateeEnd.Year, dateeEnd.Month, dateeEnd.Day, timeEnd.Hour, timeEnd.Minute, timeEnd.Second);

            //gets lab id
            int idLab = Convert.ToInt16(ddlLabs.SelectedValue);

            //initializes the number of pods left by date with the max number of users
            numPodsLeftByDate = numPodsFromLab;

            //given 2 diferent days and 2 diferent times, its necessary to create one by day
            while (dtt.AddHours(numHours).AddMinutes(numMin) <= dtEnd)
            {
                DateTime tB = dtt;
                DateTime tE = dtt.AddHours(numHours).AddMinutes(numMin); ;
                //gets the number os pods available
                podsLeftOnInit(tB, tE, idLab, idCourse);
                //number of next line
                int rCount = dtTimes.Rows.Count + 1;
                dtTimes.Rows.Add(tB, tE, numPodsLeftByDate, numPodsFromLab, rCount);
                //update datasource
                dtt = dtt.AddDays(1);
            }
            //clears fields
            lblnumAvlPods.InnerText = (numPodsLeftTotal) + "";
            lblnumTotalPods.InnerText = numPodsFromLab + "";
        }
        /// <summary>
        /// Calculates the number of available pods on page load
        /// </summary>
        /// <param name="tB"></param>
        /// <param name="tE"></param>
        /// <param name="idLab"></param>
        /// <param name="idCourse"></param>
        private void podsLeftOnInit(DateTime tB, DateTime tE, int idLab, int idCourse)
        {

            DataTable dt = SqlCode.PullDataToDataTable(
               " select distinct c.Id, lt.tBegin , lt.tEnd, c.numUsers" +
               " from tblLabs as l , tblCourse as c , tblLOginTimes as lt, tblUsers as u " +
               " where l.Id=" + idLab + " and c.id != '" + idCourse + "' and l.id=c.Lab and lt.course=c.id and u.course=c.id");
            int podsAvl = 50;

            //resets the pods per day
            numPodsLeftByDate = numPodsFromLab;

            //verificações
            foreach (DataRow row in dt.Rows)
            {
                DateTime dBegin = Convert.ToDateTime(row["tBegin"]);
                DateTime dEnd = Convert.ToDateTime(row["tEnd"]);
                podsAvl = Convert.ToInt16(row["numUsers"]);

                //checks if date is in the time span 
                if ((tB >= dBegin && tB <= dEnd) || (tE >= dBegin && tE <= dEnd) || (tB <= dBegin && dEnd <= tE))
                {
                    //updates the number minimum number of pod by date
                    // if (podsAvl <= numPodsLeftByDate)
                    // {
                    //subtracts the pod available to the total of pods of the date
                    numPodsLeftByDate -= podsAvl;
                    //}
                }
            }
            //updates the total 
            if (numPodsLeftByDate < numPodsLeftTotal)
            {
                numPodsLeftTotal = numPodsLeftByDate;
            }
        }
        /// <summary>
        /// Init the Users drop down list 
        /// </summary>
        private void initDdlUsers()
        {
            //clears the list
            ddlNumPods.Items.Clear();
            //default item
            ListItem lst1 = new ListItem(" ", "-1");
            ddlNumPods.Items.Insert(0, lst1);
            //creates all the users left
            for (int i = 0; i < numPodsLeftTotal; i++)
            {
                int k = numPodsLeftTotal - i;
                // int k = numPodsLeftByDate - i;
                ListItem lst = new ListItem(k + "", k + "");
                ddlNumPods.Items.Add(lst);
            }
            int numUsersPods = SqlCode.SelectForINT("select numUsers from tblCourse where id='" + idCourse + "'");
            //set selection
            ddlNumPods.Items.FindByValue(numUsersPods + "").Selected = true;
        }
        /// <summary>
        /// The users List
        /// </summary>
        private void initUsersList()
        {
            //data from Users by course
            DataTable dt2 = SqlCode.PullDataToDataTable("select u.usr as Name, u.pass as Pass, u.email as email  from tblCourse c,tblUsers as u where u.course=c.id and c.id='" + idCourse + "'");

            lstUsers.DataSource = dt2;
            lstUsers.DataBind();
        }
        /// <summary>
        /// Creates the data table
        /// </summary>
        private void initTable()
        {
            dtTimes = new DataTable();
            dtTimes.Columns.Add("begin", typeof(DateTime));
            dtTimes.Columns.Add("end", typeof(DateTime));
            dtTimes.Columns.Add("numPods", typeof(int));
            dtTimes.Columns.Add("TotalPods", typeof(int));
            dtTimes.Columns.Add("rId", typeof(int));
        }
        #endregion

        /// <summary>
        /// to check selected lab and updates the variables associated
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlLabs_SelectedIndexChanged(object sender, EventArgs e)
        {
            //clears the list
            ddlTypes.Items.Clear();
            //gets the labId
            int LabId = Convert.ToInt16(ddlLabs.SelectedValue);
            //if not default
            if (LabId != -1)
            {
                //inits the table
                initTable();
                //sets the number os available with the total number of pods in the lab
                numPodsLeftTotal = numPodsFromLab;
                //sets the ddlTypes parameters
                ddlTypes.ID = "ddlTypes";
                ddlTypes.AutoPostBack = true;
                ddlTypes.CssClass = "form-control";
                //pulls the types associated to the lab
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
                //populates the ddlTypes
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
            UpdatePanel6.Update();
        }
        /// <summary>
        /// to validate the type selection
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {

            //gets the type id
            int typeId = Convert.ToInt16(ddlTypes.SelectedValue);
            //if not default type
            if (typeId != -1)
            {
                //shows the time panel
                cphTimeZones.Visible = true;
                UpdatePanel6.Update();
            }
            else
            {
                //if not clears all fields after ddlTypes
                //toclear
                cphPods.Visible = false;
                cphTime.Visible = false;
                cphUsers.Visible = false;
                //creates the table
                initTable();
                //updates the number of podsleft
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
        /// <summary>
        /// Inits the dropDownList with TimeZones
        /// </summary>
        protected void initTimeZone()
        {
            ReadOnlyCollection<TimeZoneInfo> tzi;
            tzi = TimeZoneInfo.GetSystemTimeZones();
            foreach (TimeZoneInfo timeZone in tzi)
            {
                ddlTimeZone.Items.Add(new ListItem(timeZone.DisplayName, timeZone.Id));

            }
            //set selection
            //ddlTimeZone.Items.FindByValue(TimeZoneInfo.Local.Id + "").Selected = true;
        }
        /// <summary>
        /// DropDownList TimeZone
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddlTimeZone_SelectedIndexChanged(object sender, EventArgs e)
        {

            cphTime.Visible = true;
            UpdatePanel1.Update();

            cphPods.Visible = false;
            cphUsers.Visible = false;
            initTable();

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
        /// Button to verify the time selected
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnTime_Click(object sender, EventArgs e)
        {
            try
            {
                //hiddes the fields
                cphUsers.Visible = false;
                UpdatePanel4.Update();
                //resets the table
                initTable();
                int LabId = Convert.ToInt16(ddlLabs.SelectedValue);

                //gets pods from lab
                numPodsFromLab = SqlCode.SelectForINT("select numPods from tblLabs where id='" + LabId + "';");
                //initializes the number of pods left with the max number of users
                numPodsLeftTotal = numPodsFromLab;

                String bDate = txtBDate.Text;
                String eDate = txtEDate.Text;

                String bTime = txtBTime.Text;
                String eTime = txtETime.Text;

                //id fields are not empty
                if (bDate != "" && eDate != "" && bTime != "" && eTime != "")
                {
                    //Converts to dateTime
                    DateTime tBegin = ConvertTime(Convert.ToDateTime(bDate), ddlTimeZone.SelectedValue);
                    DateTime tEnd = ConvertTime(Convert.ToDateTime(eDate), ddlTimeZone.SelectedValue);
                    //Converts to dateTime
                    DateTime timeBegin = ConvertTime(Convert.ToDateTime(bTime), ddlTimeZone.SelectedValue);
                    DateTime timeEnd = ConvertTime(Convert.ToDateTime(eTime), ddlTimeZone.SelectedValue);

                    //se end time is bigger than begin time
                    if (tBegin <= tEnd && timeBegin < timeEnd)
                    {
                        //counts the number of days
                        TimeSpan ts = tEnd - tBegin;
                        int numDays = ts.Days;

                        //counts the number of days
                        TimeSpan timeHours = timeEnd - timeBegin;
                        int numHours = timeHours.Hours;
                        int numMin = timeHours.Minutes;

                        DateTime dtt = new DateTime(tBegin.Year, tBegin.Month, tBegin.Day, timeBegin.Hour, timeBegin.Minute, timeBegin.Second);
                        DateTime dtEnd = new DateTime(tEnd.Year, tEnd.Month, tEnd.Day, timeEnd.Hour, timeEnd.Minute, timeEnd.Second);

                        //gets lab id
                        int idLab = Convert.ToInt16(ddlLabs.SelectedValue);

                        //initializes the number of pods left by date with the max number of users
                        numPodsLeftByDate = numPodsFromLab;

                        while (dtt.AddHours(numHours) <= dtEnd)
                        {
                            DateTime tB = dtt;
                            DateTime tE = dtt.AddHours(numHours).AddMinutes(numMin); ;
                            //gets the number os pods available
                            podsLeft(tB, tE, idLab, idCourse);
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
                    else
                    {
                        cphPods.Visible = false;
                        UpdatePanel5.Update();
                        cphVerify.Visible = true;
                        lblErrorVerify.Text = "Begin time or date is bigger than End time or date!!";
                    }
                }
                else
                {
                    cphPods.Visible = false;
                    UpdatePanel5.Update();
                    cphVerify.Visible = true;
                    lblErrorVerify.Text = "One ou more fields are empty!!";
                }
            }            
            catch (Exception ex)
            {
                cphVerify.Visible = true;
                lblErrorVerify.Text = "Error !!" +ex.Message;
            }
        }
        /// <summary>
        /// gets the pods left in the date in the lab
        /// </summary>
        /// <param name="tB"></param>
        /// <param name="tE"></param>
        /// <param name="idLab"></param>
        public void podsLeft(DateTime tB, DateTime tE, int idLab, int idCourse)
        {
            //gets the table of with the dates and users of the lab
            DataTable dt = SqlCode.PullDataToDataTable(
               " select distinct lt.tBegin , lt.tEnd, c.numUsers" +
               " from tblLabs as l , tblCourse as c , tblLOginTimes as lt, tblUsers as u " +
               " where l.Id=" + idLab + " and c.id != '" + idCourse + "' and l.id=c.Lab and lt.course=c.id and u.course=c.id");
            int podsAvl = 50;

            //resets the pods per day
            numPodsLeftByDate = numPodsFromLab;

            //verificações
            foreach (DataRow row in dt.Rows)
            {
                DateTime dBegin = Convert.ToDateTime(row["tBegin"]);
                DateTime dEnd = Convert.ToDateTime(row["tEnd"]);
                podsAvl = Convert.ToInt16(row["numUsers"]);

                //checks if date is in the time span 
                if ((tB >= dBegin && tB <= dEnd) || (tE >= dBegin && tE <= dEnd) || (tB <= dBegin && dEnd <= tE))
                {
                    //updates the number minimum number of pod by date
                    if (podsAvl <= numPodsLeftByDate)
                    {
                        //subtracts the pod available to the total of pods of the date
                        numPodsLeftByDate -= podsAvl;
                    }
                }
            }
            //updates the total 
            if (numPodsLeftByDate < numPodsLeftTotal)
            {
                numPodsLeftTotal = numPodsLeftByDate;
            }
        }
        /// <summary>
        /// to build the list with the number of pods
        /// </summary>
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
            dt.Columns.Add("email", typeof(string));
            //to generate the userNames
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
        /// Button to updates all courses
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnUpdateCourse_Click(object sender, EventArgs e)
        {
            //variable to check if is valid to update
            bool valid = true;
            //check all the names(if they are valid or are used)
            foreach (ListViewItem lstItem in lstUsers.Items)
            {
                String usr = ((TextBox)lstItem.FindControl("txtName")).Text;
                if (isForbiddenUserBeforeInsert(usr, idCourse))
                {
                    valid = false;
                }
            }
            //if true updates all
            if (valid == true)
            {
                try
                {
                    updateCourse(idCourse);
                    //removes 
                    RemoveLogTimes(idCourse);
                    RemoveUsers(idCourse);
                    //inserts agains
                    insertLoginTimes(idCourse);
                    insertUsers(idCourse);
                    //redirect
                    Response.Redirect("~/Course/Courses?op=deleteSuccess");
                }
                catch (Exception ex)
                {
                    //error message
                    txtOutput.Text =  "Error updating the Course !! " + ex.Message ;
                    cphErrorMessage.Visible = true;
                }
            }
        }

        protected bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
        /// <summary>
        /// Updates the course.
        /// </summary>
        /// <param name="idCourse"></param>
        private void updateCourse(int idCourse)
        {

            bool validMail = true;
            //check if emails are valid
            foreach (ListViewItem lstItem in lstUsers.Items)
            {
                String mail = ((TextBox)lstItem.FindControl("txtMail")).Text;
                if (!IsValidEmail(mail))
                {
                    validMail = false;
                    break;
                }
            }
            //check if the fields are all valid
            if (txtCourseName.Text != "" && validMail == true)
            {
                String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection openCon = new SqlConnection(strConn))
                {
                    string strr = " update tblCourse set Lab=@idLab,description=@description,numUsers=@numUsers,cName=@cName,cType=@cType where id=@id";

                    using (SqlCommand command = new SqlCommand(strr, openCon))
                    {
                        //command
                        command.Parameters.AddWithValue("@id", idCourse);
                        command.Parameters.AddWithValue("@idLab", ddlLabs.SelectedValue);
                        command.Parameters.AddWithValue("@description", txtDescription.Text);
                        command.Parameters.AddWithValue("@numUsers", ddlNumPods.SelectedValue);
                        command.Parameters.AddWithValue("@cName", txtCourseName.Text);
                        command.Parameters.AddWithValue("@cType", ddlTypes.SelectedValue);

                        //opens the connections
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();
                        //closes the connection
                        openCon.Close();
                        command.Parameters.Clear();
                    }
                }
            }
        }
        /// <summary>
        /// Remove the time
        /// </summary>
        /// <param name="idCourse"></param>
        private void RemoveLogTimes(int idCourse)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //command
                string strr = " delete from tblLOginTimes where course = @idCourse"; ;
                using (SqlCommand command = new SqlCommand(strr, openCon))
                {
                    //command parameters
                    command.Parameters.AddWithValue("@idCourse", idCourse);
                    //opens the connection
                    openCon.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    //closes the connection
                    openCon.Close();
                    command.Parameters.Clear();
                }
            }
        }
        /// <summary>
        /// Removes the users
        /// </summary>
        /// <param name="idCourse"></param>
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
                    //opends connection
                    openCon.Open();
                    int recordsAffected = command.ExecuteNonQuery();
                    //closes the connection
                    openCon.Close();
                    command.Parameters.Clear();
                }
            }
        }
        /// <summary>
        /// Insert the login times
        /// </summary>
        /// <param name="idCourse"></param>
        private void insertLoginTimes(int idCourse)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //command
                string saveTypes_Lab = " insert into tblLOginTimes (tBegin,tEnd,course) VALUES (@tBegin,@tEnd,@course)"; ;
                //all rows
                foreach (DataRow row in dtTimes.Rows)
                {
                    using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                    {
                        //command parameters
                        command.Parameters.AddWithValue("@tBegin", row["begin"]);
                        command.Parameters.AddWithValue("@tEnd", row["end"]);
                        command.Parameters.AddWithValue("@course", idCourse);

                        //opens the connection
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();
                        //closes the conection
                        openCon.Close();
                        command.Parameters.Clear();
                    }
                }
            }
        }
        /// <summary>
        /// Inserts users
        /// </summary>
        /// <param name="idCourse"></param>
        private void insertUsers(int idCourse)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //command
                string saveTypes_Lab = " insert into tblUsers (usr,pass,course,email) VALUES (@user,@pass,@course,@mail)"; ;
                //all users in list
                foreach (ListViewItem lstItem in lstUsers.Items)
                {
                    using (SqlCommand command = new SqlCommand(saveTypes_Lab, openCon))
                    {
                        //command parameters
                        String usr = ((TextBox)lstItem.FindControl("txtName")).Text;
                        String pass = ((TextBox)lstItem.FindControl("txtPass")).Text;
                        String mail = ((TextBox)lstItem.FindControl("txtMail")).Text;

                        command.Parameters.AddWithValue("@user", usr);
                        command.Parameters.AddWithValue("@pass", pass);
                        command.Parameters.AddWithValue("@mail", mail);
                        command.Parameters.AddWithValue("@course", idCourse);

                        //opens the connection
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();
                        //closes the connection
                        openCon.Close();
                        command.Parameters.Clear();
                    }
                }
            }
        }
        /// <summary>
        /// Check if the user is valids
        /// </summary>
        /// <param name="name"></param>
        /// <param name="dt"></param>
        /// <returns></returns>
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
            //check the database for the name
            int count = SqlCode.SelectForINT("select count(*) from tblUsers where usr='" + name + "' and course != '" + idCourse + "'");
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