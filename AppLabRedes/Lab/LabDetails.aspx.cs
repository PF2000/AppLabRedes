using AppLabRedes.Scripts.MyScripts;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppLabRedes.Lab
{
    public partial class LabDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //gets the lab Id
            int idLab = Convert.ToInt16(Request.QueryString["idLab"]);
            //gets all lab information
            DataTable dt = SqlCode.PullDataToDataTable("select * from tblLabs l where l.id='" + idLab + "'");
            DataRow row = dt.Rows[0];
            //gets the information
            String name = Convert.ToString(row["name"]);
            String numUsers = Convert.ToString(row["numPods"]);
            String description = Convert.ToString(row["description"]);

            //set the information
            txtLabName.Text = name;
            txtNumPods.Text = numUsers;
            txtDescription.Text = description;

            //data from LoginTimes
            DataTable dt1 = SqlCode.PullDataToDataTable("select t.type from tblLabs l, tblLabType t, tblTypes_Labss lt where l.id=lt.idLab and t.id=lt.idType and l.id='" + idLab + "'");
            //binds the information
            lstTypes.DataSource = dt1;
            lstTypes.DataBind();

        }
    }
}