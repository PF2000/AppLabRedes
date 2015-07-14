using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tamir.SharpSsh;
using TelnetApp;
using AppLabRedes.Scripts;
using AppLabRedes.Scripts.MyScripts;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

/**
 * 
 * From: http://www.dotnetcurry.com/showarticle.aspx?ID=144
 * http://stackoverflow.com/questions/54991/generating-random-passwords
 * https://msdn.microsoft.com/en-us/library/s2tte0y1(v=vs.110).aspx
 * http://stackoverflow.com/questions/889485/changing-webcontrol-id-inside-of-a-repeater
 * 
 */

namespace AppLabRedes.Management
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        static string UserType = "ExGroup";

        protected void Page_Load(object sender, EventArgs e)
        {
        }


        public Boolean isForbiddenUserNames(String User)
        {

            //especifica o acesso a BD
            //ddefinir acesso a Connection String
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            //especificar Connection (a 'estrada')
            SqlConnection MyConn = new SqlConnection(strConn);

            //especificar o comando SQL
            string strSqlConn = "select count(*) from VPNUsers where GETDATE() < endDate and usr = @UserName";
            //especificar o 'Command'
            SqlCommand MyComand = new SqlCommand(strSqlConn, MyConn);

            MyComand.Parameters.AddWithValue("@UserName", User);
            int cmdRet = 0;
            //opens the connection
            MyConn.Open();
            //recolher os dados
            cmdRet = Convert.ToInt32(MyComand.ExecuteScalar());
            MyConn.Close();

            if (cmdRet != 0)
            {
                return true;
            }

            //especifica o acesso a BD
            //ddefinir acesso a Connection String
             strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            //especificar Connection (a 'estrada')
             MyConn = new SqlConnection(strConn);

            //especificar o comando SQL
             strSqlConn = "select count(*) from VPNUsersTemp where usr = @UserName";
            //especificar o 'Command'
            SqlCommand MyComandd = new SqlCommand(strSqlConn, MyConn);

            MyComandd.Parameters.AddWithValue("@UserName", User);
            int cmdRett = 0;
            //opens the connection
            MyConn.Open();
            //recolher os dados
            cmdRett = Convert.ToInt32(MyComandd.ExecuteScalar());
            MyConn.Close();

            if (cmdRett != 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }



        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            SqlCode.deleteAllFromTempTable(txtOutput);
            int number = Int16.Parse(txtNumUsers.Text);
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string saveStaff = "INSERT into VPNUsersTemp (usr,pwd) VALUES (@usr,@Password)";

                using (SqlCommand command = new SqlCommand(saveStaff, openCon))
                {

                    for (int i = 0; i < number; i++)
                    {
                        int k = 0;
                        String usr = UserType + (i + 1);

                        do
                        {
                            usr = UserType + ((i + 1) + k);
                            k++;
                        } while (isForbiddenUserNames(usr));

                        command.Parameters.AddWithValue("@usr", usr.Trim());
                        command.Parameters.AddWithValue("@Password", (Guid.NewGuid().ToString("N").Substring(1, 8)+".").Trim());

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
            rptNewUser.Visible = true;
            btnConfirm.Visible = true;
            pnlCreateUsers.Visible = false;
            txtOutput.Text = "";
        }


        public Boolean isForbiddenUserNamesSave(String User)
        {

            //especifica o acesso a BD
            //ddefinir acesso a Connection String
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            //especificar Connection (a 'estrada')
            SqlConnection MyConn = new SqlConnection(strConn);

            //especificar o comando SQL
            string strSqlConn = "select count(*) from VPNUsers where GETDATE() < endDate and usr = @UserName";
            //especificar o 'Command'
            SqlCommand MyComand = new SqlCommand(strSqlConn, MyConn);

            MyComand.Parameters.AddWithValue("@UserName", User);
            int cmdRet = 0;
            //opens the connection
            MyConn.Open();
            //recolher os dados
            cmdRet = Convert.ToInt32(MyComand.ExecuteScalar());
            MyConn.Close();

            if (cmdRet != 0)
            {
                return true;
            }

            //especifica o acesso a BD
            //ddefinir acesso a Connection String
            strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            //especificar Connection (a 'estrada')
            MyConn = new SqlConnection(strConn);

            //especificar o comando SQL
            strSqlConn = "select count(*) from VPNUsersTemp where usr = @UserName";
            //especificar o 'Command'
            SqlCommand MyComandd = new SqlCommand(strSqlConn, MyConn);

            MyComandd.Parameters.AddWithValue("@UserName", User);
            int cmdRett = 0;
            //opens the connection
            MyConn.Open();
            //recolher os dados
            cmdRett = Convert.ToInt32(MyComandd.ExecuteScalar());
            MyConn.Close();

            if (cmdRett == 0 || cmdRett == 1)
            {
                return false;
            }
            else
            {
                return true;
            }

        }


        public Boolean groupInUse(String group, DateTime initd, DateTime endd)
        {

            //especifica o acesso a BD
            //ddefinir acesso a Connection String
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            //especificar Connection (a 'estrada')
            SqlConnection MyConn = new SqlConnection(strConn);

            //especificar o comando SQL
            //string strSqlConn = "select count(*) from VPNUsers where @initd >= initDate and @endd >= endDate and groupp = @group";
            string strSqlConn = " select count(*) from VPNUsers where @initd >= initDate and @endd <= endDate and groupp = @group ";
            //especificar o 'Command'
            SqlCommand MyComand = new SqlCommand(strSqlConn, MyConn);

            MyComand.Parameters.AddWithValue("@group", group);
            MyComand.Parameters.AddWithValue("@initd", initd);
            MyComand.Parameters.AddWithValue("@endd", endd);
            int cmdRet = 0;
            //opens the connection
            MyConn.Open();
            //recolher os dados
            cmdRet = Convert.ToInt32(MyComand.ExecuteScalar());
            MyConn.Close();

            if (cmdRet != 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            txtOutput.Text = "";
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection openCon = new SqlConnection(strConn))
            {
                string saveStaff = "update VPNUsersTemp  set  usr=@usr,pwd=@Password,email=@email,initDate=@initDate,endDate=@endDate,groupp=@groupp,description=@description where id=@id";
                using (SqlCommand command = new SqlCommand(saveStaff, openCon))
                {
                    foreach (RepeaterItem curItem in rptNewUser.Items)
                    {
                        // Due to the way a Repeater works, these two controls are linked together.  The questionID
                        // label that is found is in the same RepeaterItem as the DropDownList (and any other controls
                        // you might find using curRow.FindControl)

                        var hddID = curItem.FindControl("hddID") as HiddenField;
                        var txtUsername = curItem.FindControl("txtUsername") as TextBox;
                        var txtPassword = curItem.FindControl("txtPassword") as TextBox;
                        var txtemail = curItem.FindControl("txtemail") as TextBox;
                        var txtbeginDate = curItem.FindControl("txtbeginDate") as TextBox;
                        var txtEndDate = curItem.FindControl("txtEndDate") as TextBox;
                        var txtDescription = curItem.FindControl("txtDescription") as TextBox;
                        var ddlGroupList = curItem.FindControl("ddlGroupList") as DropDownList;

                        //check is all fileds are valid
                        if (txtUsername.Text.Equals("") 
                            || txtPassword.Text.Equals("") 
                            || txtemail.Text.Equals("")
                            || txtbeginDate.Text.Equals("")
                            || txtEndDate.Text.Equals(""))
                        {
                            txtOutput.Text = "One or more fields are empty";
                            return;
                        }
                        DateTime initDate = Convert.ToDateTime(txtbeginDate.Text);
                        DateTime endDate = Convert.ToDateTime(txtEndDate.Text);
                        if (groupInUse(ddlGroupList.SelectedItem.ToString(), initDate, endDate))
                        {
                            txtOutput.Text = "Group is already in use for that date";
                            return;
                        }

                        //retira o T 
                        txtbeginDate.Text = txtbeginDate.Text.Replace('T', ' ');
                        txtEndDate.Text = txtEndDate.Text.Replace('T', ' ');

                        command.Parameters.AddWithValue("@id", hddID.Value);
                        if (isForbiddenUserNamesSave(txtUsername.Text))
                        {
                            txtOutput.Text = "Username " + txtUsername.Text + " already exists";
                            break;
                        }
                        command.Parameters.AddWithValue("@usr", txtUsername.Text);
                        command.Parameters.AddWithValue("@Password", txtPassword.Text);
                        command.Parameters.AddWithValue("@email", txtemail.Text);
                        command.Parameters.AddWithValue("@initDate", txtbeginDate.Text);
                        command.Parameters.AddWithValue("@endDate", txtEndDate.Text);
                        command.Parameters.AddWithValue("@description", txtDescription.Text);
                        command.Parameters.AddWithValue("@groupp", ddlGroupList.SelectedItem.ToString());

                        try
                        {
                            openCon.Open();

                            int recordsAffected = command.ExecuteNonQuery();
                        }
                        catch (SqlException ex)
                        {
                            txtOutput.Text = ex.Message + "@Confirm";
                            //break;
                        }
                        finally
                        {
                            openCon.Close();
                        }
                        command.Parameters.Clear();

                    }
                }
            }
            //if Textbox has errors has texts
            if (txtOutput.Text.Equals(""))
            {
                SqlCode.tempVPNtoVpn(SqlCode.PullDataToDataTable("select * from VPNUsersTemp"));
                //Redirect to page
                Server.Transfer("~/Admin/Logger.aspx", true);
            }
        }

    }
}