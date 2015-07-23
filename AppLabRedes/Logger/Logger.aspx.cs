using AppLabRedes.Scripts.MyScripts;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppLabRedes.Admin
{
    public partial class Logger : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// button to check message as read
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSeen_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            //gets the message id
            int id = Convert.ToInt16(btn.CommandArgument.ToString());

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(strConn);
            try
            {
                //ecommand
                string strSqlConn = "update EventLogger set NotSeen='false' where id=@id ";
                SqlCommand MyComand = new SqlCommand(strSqlConn, con);
                //paramenters
                MyComand.Parameters.AddWithValue("@id", id);
                //opens the connection
                con.Open();
                //excutes the command
                MyComand.ExecuteNonQuery();
                //closes connection
                con.Close();
            }
            catch (Exception ex)
            {
                SqlCode.copyDataEventLogger("Error updating Events", "danger", ex.Message);
            }



            //updates the buttons
            lstLogger.DataBind();

            int i=0;
            //updates the panels
            foreach(ListViewItem item in lstLogger.Items)
            {
                var pnl = item.FindControl("updPanel") as UpdatePanel;
                pnl.Update();
                i++;
                if (i >= 10)
                {
                    break;
                }
            }


        }

        protected void btnReadAll_Click(object sender, EventArgs e)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(strConn);
            try
            {
                //ecommand
                string strSqlConn = "update EventLogger set NotSeen='false' ";
                SqlCommand MyComand = new SqlCommand(strSqlConn, con);
                //opens the connection
                con.Open();
                //excutes the command
                MyComand.ExecuteNonQuery();
                //closes connection
                con.Close();
            }
            catch (Exception ex)
            {
                SqlCode.copyDataEventLogger("Error updating Events", "danger", ex.Message);
            }
            //refresh
            Response.Redirect(Request.RawUrl);

        }
    }
}