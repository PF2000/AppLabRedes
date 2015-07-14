using ActiveDirectoryHelper;
using AppLabRedes.Scripts.MyScripts;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppLabRedes.VPNUsers.ManageVPNUsers
{
    public partial class ScheduleUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnApply_Click(object sender, EventArgs e)
        {
            String st = "";
            try
            {
                string filepath = System.AppDomain.CurrentDomain.BaseDirectory + "Files\\script.txt";
                foreach (RepeaterItem item in rptScheduleUsers.Items)
                {
                    var hddID = item.FindControl("hddID") as HiddenField;
                    var txtUsername = item.FindControl("txtUsername") as TextBox;
                    var txtEndsIn = item.FindControl("txtEndsIn") as TextBox;
                    var chkAddUser = item.FindControl("chkAddUser") as CheckBox;
                    var ChkRemoveuser = item.FindControl("ChkRemoveuser") as CheckBox;

                    if (chkAddUser.Checked)
                    {
                        DataTable dt = SqlCode.PullDataToDataTable("select * from VPNUsers where id = " + hddID.Value + " ; ");
                        TextBox txt = new TextBox();
                        ActiveDirectory ad = new ActiveDirectory();

                        foreach (DataRow row in dt.Rows) // Loop over the items.
                        {
                            String userName = row["usr"].ToString().Trim();
                            String pwd = row["pwd"].ToString().Trim();
                            DateTime dateTime = (DateTime)row["endDate"];
                            ad.CreateUser(txt, userName, pwd, dateTime);
                            ad.AddUserToGroup(userName, "RadiusUsers");
                            st = txt.Text;
                        }
                        SqlCode.UpdateDB(dt, true);
                        SqlCode.copyDataEventLogger("Successfully added users", "success", st);
                    }

                    if (ChkRemoveuser.Checked)
                    {
                        DataTable dt = SqlCode.PullDataToDataTable("select * from VPNUsers where id = " + hddID.Value + " ; ");
                        TextBox txt = new TextBox();
                        ActiveDirectory ad = new ActiveDirectory();

                        SqlCode.UpdateDB(dt, false);
                        SqlCode.copyDataEventLogger("Successfully deleted users", "success", st);

                    }


                }
            }
            catch (Exception ex)
            {
                FailureText.Text = ex.Source + ex.Message;
                SqlCode.copyDataEventLogger("Error creating users", "failure", st);

            }
            Response.Redirect(Request.RawUrl);
        }
    }
}