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


        protected void btnSeen_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            int id = Convert.ToInt16(btn.CommandArgument.ToString());

            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(strConn);
            try
            {

                //especificar o comando SQL
                string strSqlConn = "update EventLogger set NotSeen='false' where id=@id ";

                //especificar o 'Command'
                SqlCommand MyComand = new SqlCommand(strSqlConn, con);

                MyComand.Parameters.AddWithValue("@id", id);

                //opens the connection
                con.Open();

                MyComand.ExecuteNonQuery();

                con.Close();
            }
            catch (Exception ex)
            {
                SqlCode.copyDataEventLogger("Error updating Events", "danger", ex.Message);
            }



            //Actualiza os botoes
            lstLogger.DataBind();

            int i=0;
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
    }
}