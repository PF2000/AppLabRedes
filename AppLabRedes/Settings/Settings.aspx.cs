using System;
using System.Collections.Generic;
using System.Configuration;
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

                txtEmailHost.Text = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("EmailHost");
                txtEmailport.Text = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("EmailPort");
                txtEmailMail.Text = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("Emailmail");

                txtEmailPass.Attributes.Add("value", System.Web.Configuration.WebConfigurationManager.AppSettings.Get("EmailPass"));
                txtEmailMessage.Text = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("EmailMessage");
            }
        }

        protected void btnApplySettings_Click(object sender, EventArgs e)
        {
            System.Configuration.Configuration conf = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~");

            conf.AppSettings.Settings["RouterIP"].Value = txtRouterIP.Text;
            conf.AppSettings.Settings["RouterUser"].Value = txtRouterUser.Text;
            conf.AppSettings.Settings["RouterPass"].Value = txtRouterPass.Text;

            conf.AppSettings.Settings["EmailHost"].Value = txtEmailHost.Text;
            conf.AppSettings.Settings["EmailPort"].Value = txtEmailport.Text;
            conf.AppSettings.Settings["Emailmail"].Value = txtEmailMail.Text;
            conf.AppSettings.Settings["EmailPass"].Value = txtEmailPass.Text;
            conf.AppSettings.Settings["EmailMessage"].Value = txtEmailMessage.Text;

            conf.Save();
            Response.Redirect(Request.RawUrl);
        }

    }
}