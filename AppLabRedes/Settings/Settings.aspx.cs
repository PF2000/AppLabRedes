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

namespace AppLabRedes.Settings
{
    public partial class Settings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtRouterIP.Text = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("RouterIP");
                txtRouterUser.Text = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("RouterUser");
                txtRouterPass.Attributes.Add("value", System.Web.Configuration.WebConfigurationManager.AppSettings.Get("RouterPass"));

                initMail();
            }
        }

        protected void btnApplySettings_Click(object sender, EventArgs e)
        {
            System.Configuration.Configuration conf = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~");

            conf.AppSettings.Settings["RouterIP"].Value = txtRouterIP.Text;
            conf.AppSettings.Settings["RouterUser"].Value = txtRouterUser.Text;
            conf.AppSettings.Settings["RouterPass"].Value = txtRouterPass.Text;
            conf.Save();
            String host = txtEmailHost.Text;
            String port = txtEmailport.Text;

            String email = txtEmailMail.Text;
            String pass = txtEmailPass.Text;
            String message = txtEmailMessage.Text;



            insertMail(host, port, email, pass, message);

            Response.Redirect(Request.RawUrl);
        }

        private void insertMail(String host, String port, String email, String pass, String message)
        {
            SqlCode.SelectForINT("delete from tblEmail");
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                //comand
                string strr = " insert into tblEmail (host,port,email,pass,message) values (@host,@port,@email,@pass,@message)";
                using (SqlCommand command = new SqlCommand(strr, openCon))
                {
                    //comand parameters
                    command.Parameters.AddWithValue("@host", host);
                    command.Parameters.AddWithValue("@port", port);
                    command.Parameters.AddWithValue("@email", email);
                    command.Parameters.AddWithValue("@pass", pass);
                    command.Parameters.AddWithValue("@message", message);

                    try
                    {
                        //open connection
                        openCon.Open();
                        int recordsAffected = command.ExecuteNonQuery();
                    }
                    catch (SqlException ex)
                    {
     
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

        private void initMail()
        {
            try
            {
                
                DataTable dt = SqlCode.PullDataToDataTable("Select * from tblEmail");

                DataRow dr = dt.Rows[0];


                txtEmailHost.Text = Convert.ToString(dr["host"]);
                txtEmailport.Text = Convert.ToString(dr["port"]);
                txtEmailMail.Text = Convert.ToString(dr["email"]);

                txtEmailPass.Attributes.Add("value", Convert.ToString(dr["pass"]));
                txtEmailMessage.Text = Convert.ToString(dr["message"]);
            }
            catch (Exception ex)
            {

            }
        }


    }
}