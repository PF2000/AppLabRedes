using ActiveDirectoryHelper;
using AppLabRedes.Scripts.MyScripts;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppLabRedes.Course
{
    public partial class Courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (ddlLabs.Items.Count == 0)
                {
                    //get allLabs
                    DataTable dtLabs = SqlCode.PullDataToDataTable("select * from tblLabs");
                    //default Item
                    System.Web.UI.WebControls.ListItem lst1 = new System.Web.UI.WebControls.ListItem(" ", "-1");
                    ddlLabs.Items.Add(lst1);
                    //db Items
                    foreach (DataRow row in dtLabs.Rows) // Loop over the items.
                    {
                        String tp = Convert.ToString(row["name"]);
                        String tId = Convert.ToString(row["id"]);
                        System.Web.UI.WebControls.ListItem lst = new System.Web.UI.WebControls.ListItem(tp, tId);
                        ddlLabs.Items.Add(lst);
                    }
                }
                //gets course string from query string
                String view = Convert.ToString(Request.QueryString["View"]);
                DataTable dt;
                if (view != null)
                {
                    //decides what view to show
                    if (view.Equals("active"))
                    {
                        dt = SqlCode.PullDataToDataTable("select DISTINCT c.id,c.description,c.numUsers,c.cName, ty.type  as typee  from tblcourse c ,tblLOginTimes lt, tblLabType ty where ty.id=c.cType and lt.course=c.id and (select MONTH(lt.tBegin)) = (SELECT MONTH(GETDATE())) and lt.active = 1;");
                    }
                    else
                    {
                        dt = SqlCode.PullDataToDataTable("select DISTINCT c.id,c.description,c.numUsers,c.cName, ty.type as typee from tblcourse c ,tblLOginTimes lt, tblLabType ty where ty.id=c.cType and lt.course=c.id and (select MONTH(lt.tBegin)) = (SELECT MONTH(GETDATE())) and lt.active = 0;");
                    }
                }
                else
                {
                    dt = SqlCode.PullDataToDataTable("select DISTINCT c.id,c.description,c.numUsers,c.cName, ty.type  as typee  from tblcourse c ,tblLOginTimes lt, tblLabType ty where ty.id=c.cType and lt.course=c.id and (select MONTH(lt.tBegin)) = (SELECT MONTH(GETDATE())) and lt.active != 2;");
                }

                lstCourses.DataSource = dt;
                lstCourses.DataBind();
            }
        }
        /// <summary>
        /// Button for course removal
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnRemoveCourse_Command(object sender, CommandEventArgs e)
        {
            //gets the id from button parameters
            int idCourse = Convert.ToInt16(e.CommandArgument.ToString());

            StringBuilder sb = new StringBuilder();

            ActiveDirectory ad = new ActiveDirectory();
            DataTable dt = SqlCode.PullDataToDataTable("select usr from tblUsers where course = '" + idCourse + "'");

            foreach (DataRow row in dt.Rows) // Loop over the items.
            {
                ad.DeleteUser(sb, row["usr"].ToString());
            }

            //adds the labTypes to database
            RemoveUsers(idCourse);
            //adds the labTypes to database
            RemoveLogTimes(idCourse);
            //remove lab
            RemoveCourse(idCourse);
            //PostBack
            Response.Redirect(Request.RawUrl);

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
        /// Search button click
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            cphErrorMessage.Visible = false;
            //gets the lab id
            int idLab = Convert.ToInt16(ddlLabs.SelectedValue);
            //if all fields are selected
            if (idLab >= 0 && txtBegin.Text != "" && txtEnd.Text != "")
            {
                //converts the dates selected
                DateTime dBegin = Convert.ToDateTime(txtBegin.Text);
                DateTime dEnd = Convert.ToDateTime(txtEnd.Text);
                if (dBegin < dEnd)
                {
                    //
                    dEnd = dEnd.AddHours(23);
                    dEnd = dEnd.AddMinutes(59);

                    //pulls data for courses in the selected dates
                    DataTable dt = SqlCode.PullDataToDataTable("select DISTINCT c.id as id,c.description,c.numUsers,c.cName, ty.type  as typee  from tblcourse c ,tblLOginTimes lt, tblLabType ty where ty.id=c.cType and lt.course=c.id and c.Lab = '" + ddlLabs.SelectedValue + "' and (lt.tBegin >= '" + dBegin.ToString("yyyy-MM-dd HH:mm") + "' and lt.tBegin <= '" + dEnd.ToString("yyyy-MM-dd HH:mm") + "' ) or (lt.tEnd <=  '" + dBegin.ToString("yyyy-MM-dd HH:mm") + "' and  lt.tEnd >= '" + dEnd.ToString("yyyy-MM-dd HH:mm") + "' );");
                    //if exists
                    if (dt.Rows.Count != 0)
                    {
                        //binds the data table
                        lstCourses.DataSource = dt;
                        lstCourses.DataBind();
                    }
                    else
                    {
                        //if no courses exists creates and binds an empty datatable
                        DataTable dtFinall = new DataTable();
                        lstCourses.DataSource = dtFinall;
                        lstCourses.DataBind();
                    }
                }
                else
                {
                    //error for search
                    cphErrorMessage.Visible = true;
                    txtOutput.Text = "Error!! Begin data is bigger than End date!!";
                }
            }
            else
            {
                //error for search
                cphErrorMessage.Visible = true;
                txtOutput.Text = "Error!! Select a valid lab or check the dates!!";
            }
            UpdatePanel1.Update();
        }

        protected void btnGenPdf_Command(object sender, CommandEventArgs e)
        {
            //gets the id from button parameters
            int idCourse = Convert.ToInt16(e.CommandArgument.ToString());

            //string appRootDir = new DirectoryInfo(Environment.CurrentDirectory).Parent.Parent.FullName;
            string appRootDir = Server.MapPath("~/PDFs/");
            String pdfNameFile = "Course.pdf";
            try
            {
                // Step 1: Creating System.IO.FileStream object
                using (FileStream fs = new FileStream(appRootDir + pdfNameFile + "", FileMode.Create, FileAccess.Write, FileShare.None))
                // Step 2: Creating iTextSharp.text.Document object
                using (Document doc = new Document())
                // Step 3: Creating iTextSharp.text.pdf.PdfWriter object
                // It helps to write the Document to the Specified FileStream
                using (PdfWriter writer = PdfWriter.GetInstance(doc, fs))
                {
                    // Step 4: Openning the Document
                    doc.Open();



                    ////---------------------------------------------------------
                    DataTable dt = SqlCode.PullDataToDataTable("select * from tblCourse c,tblLabs l, tblLabType t where c.lab=l.id and c.cType=t.id and c.id='" + idCourse + "'");
                    DataRow row = dt.Rows[0];

                    String name = Convert.ToString(row["cName"]);
                    String numUsers = Convert.ToString(row["numUsers"]);
                    String description = Convert.ToString(row["description"]);
                    String lab = Convert.ToString(row["name"]);
                    String type = Convert.ToString(row["type"]);


                    doc.Add(new Paragraph("Course: " + name));
                    doc.Add(new Paragraph(" "));
                    doc.Add(new Paragraph(" "));
                    doc.Add(new Paragraph(lab));
                    doc.Add(new Paragraph("Num Users: " + numUsers));
                    doc.Add(new Paragraph("Description: " + description));
                    doc.Add(new Paragraph("Type: " + type));

                    //data from LoginTimes
                    String begin = SqlCode.SelectForString("select min(tBegin) from tblCourse c,tblLOginTimes as lt where lt.course=c.id and c.id='" + idCourse + "'");
                    String end = SqlCode.SelectForString("select max(tBegin) from tblCourse c,tblLOginTimes as lt where lt.course=c.id and c.id='" + idCourse + "'");
                    //to get time
                    String endTime = SqlCode.SelectForString("select max(tEnd) from tblCourse c,tblLOginTimes as lt where lt.course=c.id and c.id='" + idCourse + "'");

                    //Converts to dateTime
                    DateTime tBegin = Convert.ToDateTime(begin);
                    DateTime tEnd = Convert.ToDateTime(end);
                    DateTime tEndTime = Convert.ToDateTime(endTime);
                    doc.Add(new Paragraph(" "));
                    doc.Add(new Paragraph("Permited Login Times "));
                    doc.Add(new Paragraph(" "));

                    //begin
                    doc.Add(new Paragraph("   Bagin Date: " + tBegin.Date.ToString("d")));
                    doc.Add(new Paragraph("   Begin Time: " + tBegin.TimeOfDay + ""));
                    //end
                    doc.Add(new Paragraph("   End Date: " + tEnd.Date.ToString("d")));
                    doc.Add(new Paragraph("   End Date: " + tEndTime.TimeOfDay + ""));

                    doc.Add(new Paragraph(" "));
                    //data from Users
                    DataTable dt2 = SqlCode.PullDataToDataTable("select * from tblCourse c,tblUsers as u where u.course=c.id and c.id='" + idCourse + "'");


                    foreach (DataRow roww in dt2.Rows) // Loop over the items.
                    {
                        doc.Add(new Paragraph(" "));
                        doc.Add(new Paragraph(" Users "));
                        doc.Add(new Paragraph(" "));
                        doc.Add(new Paragraph("UserName: " + roww["usr"]));
                        doc.Add(new Paragraph("Pass: " + roww["pass"]));
                    }


                    // Step 6: Closing the Document
                    doc.Close();
                }
            }
            // Catching iTextSharp.text.DocumentException if any
            catch (DocumentException de)
            {
                throw de;
            }
            // Catching System.IO.IOException if any
            catch (IOException ioe)
            {
                throw ioe;
            }


            //http://stackoverflow.com/questions/8897458/asp-net-download-file-to-client-browser#comment46624340_8897675
            string filePath = appRootDir + pdfNameFile + "";
            FileInfo file = new FileInfo(filePath);
            if (file.Exists)
            {
                Response.Clear();

                Response.ClearHeaders();

                Response.ClearContent();

                Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);

                Response.AddHeader("Content-Length", file.Length.ToString());

                Response.ContentType = "text/plain";

                Response.Flush();

                Response.TransmitFile(file.FullName);

                Response.End();
            }


        }
    }
}