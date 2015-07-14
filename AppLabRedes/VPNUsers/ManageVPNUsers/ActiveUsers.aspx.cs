using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AppLabRedes;
using AppLabRedes.Scripts.MyScripts;
using System.Data;
using ActiveDirectoryHelper;

namespace AppLabRedes.VPNUsers.ActiveUsers
{
    public partial class ActiveUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            String st = "";
            try
            {
                foreach (RepeaterItem item in rptActiveUsers.Items)
                {
                    var hddID = item.FindControl("hddID") as HiddenField;
                    var txtUsername = item.FindControl("txtUsername") as TextBox;
                    var txtEndsIn = item.FindControl("txtEndsIn") as TextBox;
                    var chkRemoveUser = item.FindControl("chkRemoveUser") as CheckBox;


                    if (chkRemoveUser.Checked)
                    {
                        DataTable dt = SqlCode.PullDataToDataTable("select * from VPNUsers where id = " + hddID.Value + " ; ");
                        TextBox txt = new TextBox();
                        ActiveDirectory ad = new ActiveDirectory();

                        foreach (DataRow row in dt.Rows) // Loop over the items.
                        {
                            String userName = row["usr"].ToString().Trim();
                            ad.DeleteUser(txt, userName);
                            st = txt.Text;

                        }
                        SqlCode.UpdateDB(dt, false);
                        SqlCode.copyDataEventLogger("Successfully deleted users", "success", st);
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorMessage.Visible = true;
                FailureText.Text = ex.Message;
                SqlCode.copyDataEventLogger("Error removing users", "danger", ex.Message);

            }
            Response.Redirect(Request.RawUrl);
        }
    }
}