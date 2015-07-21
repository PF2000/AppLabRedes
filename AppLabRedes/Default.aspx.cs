using AppLabRedes;
using AppLabRedes.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace AppLabRedes
{
    public partial class _Default : Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("~/Account/Login.aspx");
        }
    }
}