using AppLabRedes.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using TOP.CodeLibrary.Extensions;
using System.Web.UI.WebControls;
using System.Web.ModelBinding;
using System.Web.UI.HtmlControls;
using AppLabRedes.Models;
using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using AppLabRedes.Scripts.MyScripts;
using AppLabRedes.MyFolder.Classes;
using AppLabRedes.MyScripts;
using System.Threading;



namespace AppLabRedes.Account
{
    public partial class Forgot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void Recover_Click(object sender, EventArgs e)
        {
            String user = User.Text;
            String email = Email.Text;
            if (user != "" && email != "")
            {

                ApplicationDbContext context = new ApplicationDbContext();
                String idUser = SqlCode.SelectForString("select id from AspNetUsers where UserName = '" + user + "'");
                ApplicationUser userr = context.Users.Find(idUser);


                if (userr.IsNotNull())
                {
                    if (userr.Email == email)
                    {
                        //gets user manager
                        UserManager manager = new UserManager();
                        //removes user pass
                        IdentityResult result = manager.RemovePassword(idUser);
                        //generates new pass
                        String newPass = (Guid.NewGuid().ToString("N").Substring(1, 8) + ".").Trim();
                        //updates the pass
                        result = manager.AddPassword(idUser, newPass);

                        if (result.Succeeded)
                        {
                            EmailClass.SendEmailRecover(email, newPass);
                            PlaceHolder1.Visible = true;
                            FailureText.Text = "Password of user changed email has been send";
                            Thread.Sleep(1000);
                            Response.Redirect("~/Account/Login.aspx");

                        }
                        else
                        {
                            PlaceHolder1.Visible = true;
                            FailureText.Text = "Error reseting the password";
                        }

                    }
                    else
                    {
                        PlaceHolder1.Visible = true;
                        FailureText.Text = "User does not match email!!";
                    }
                }
                else
                {
                    PlaceHolder1.Visible = true;
                    FailureText.Text = "User is invalid";
                }

            }
            else
            {
                PlaceHolder1.Visible = true;
                FailureText.Text = "User or password fields are empty!!";
            }
        }
    }
}