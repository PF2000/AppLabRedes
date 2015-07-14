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
    public partial class Courses : System.Web.UI.Page
    {

        //fazer select por mês
        //coloca calendário para escolher o mês
        //pesquisar por todos os logintimes  (unique) por mes

        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dtLabs = SqlCode.PullDataToDataTable("select * from tblLabs");

            //default Item
            ListItem lst1 = new ListItem("Labs", "-1");
            ddlLabs.Items.Add(lst1);
            foreach (DataRow row in dtLabs.Rows) // Loop over the items.
            {
                String tp = Convert.ToString(row["name"]);
                String tId = Convert.ToString(row["id"]);

                ListItem lst = new ListItem(tp, tId);

                ddlLabs.Items.Add(lst);
            }

            DataTable dt = SqlCode.PullDataToDataTable("select DISTINCT c.id,c.description,c.numUsers,c.cName from tblcourse c ,tblLOginTimes lt where lt.course=c.id and (select MONTH(lt.tBegin)) = (SELECT MONTH(GETDATE())) ;");

            lstCourses.DataSource = dt;
            lstCourses.DataBind();

        }

        protected void btnRemoveCourse_Command(object sender, CommandEventArgs e)
        {
            int idLab = Convert.ToInt16(e.CommandArgument.ToString());
            /*
            //adds the labTypes to database
            RemoveType_Lab(idLab);
            //remove lab
            RemoveLab(idLab);
            //PostBack
            Response.Redirect(Request.RawUrl);
             */
        }



        private void RemoveLab(int idLabb)
        {

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string saveLab = " delete tblLabs where id = @idLab "; ;

                using (SqlCommand command = new SqlCommand(saveLab, openCon))
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



        protected void btnSearch_Click(object sender, EventArgs e)
        {

            DateTime dBegin = Convert.ToDateTime(txtBegin.Text);
            DateTime dEnd = Convert.ToDateTime(txtEnd.Text);
            int idLab = Convert.ToInt16(ddlLabs.SelectedValue);

            //int count = SqlCode.SelectForINT("select count(*) from tblcourse c ,tblLOginTimes lt where lt.course=c.id and lt.tBegin > '" + dBegin + "' and lt.tEnd < '" + dEnd + "' ");
            //if (count != 0)
            //{

            DataTable dt = SqlCode.PullDataToDataTable("select * from tblcourse c ,tblLOginTimes lt where lt.course=c.id and c.Lab = '" + idLab + "' ");


            IEnumerable<DataRow> query = (from DataRow dr in dt.Rows
                                          where ((DateTime)dr["tBegin"] > dBegin && (DateTime)dr["tBegin"] < dEnd) || ((DateTime)dr["tEnd"] < dBegin && (DateTime)dr["tEnd"] > dEnd)
                                          select dr);

            if (query.Count() != 0)
            {
                DataTable dtFinal = query.CopyToDataTable<DataRow>();

                lstCourses.DataSource = dtFinal;
                lstCourses.DataBind();
            }
            else
            {
                DataTable dtFinall = new DataTable();
                lstCourses.DataSource = dtFinall;
                lstCourses.DataBind();
            }

        }

    }
}