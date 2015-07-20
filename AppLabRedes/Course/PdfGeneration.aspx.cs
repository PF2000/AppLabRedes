using AppLabRedes.Scripts.MyScripts;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppLabRedes.VPNUsers.ManageVPNUsers
{
    public partial class ManageCreationVpn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnGetSearch_Click(object sender, EventArgs e)
        {

            var initDate = txtbeginDate.Text;
            var endDate = txtEndDate.Text;
            DateTime dBegin = Convert.ToDateTime(initDate);
            DateTime dEnd = Convert.ToDateTime(endDate);

            DataTable dt = SqlCode.PullDataToDataTable("select distinct c.id,c.description,c.numUsers,c.cName from tblcourse c ,tblLOginTimes lt where lt.course=c.id and c.Lab = 0 and (lt.tBegin >= '" + dBegin.ToString("yyyyMMdd") + "' and lt.tBegin <= '" + dEnd.ToString("yyyyMMdd") + "' ) or (lt.tEnd <=  '" + dBegin.ToString("yyyyMMdd") + "' and  lt.tEnd >= '" + dEnd.ToString("yyyyMMdd") + "' );");

            tbl.Visible = true;
            rptUsersTopdf.DataSource = dt;
            rptUsersTopdf.DataBind();

        }
        //http://www.codeproject.com/Articles/570682/PDF-File-Writer-Csharp-Class-Library-Version
        protected void btnGenPdf_Click(object sender, EventArgs e)
        {
            //string appRootDir = new DirectoryInfo(Environment.CurrentDirectory).Parent.Parent.FullName;
            string appRootDir = Server.MapPath("~/PDFs/");
            String pdfNameFile = "VpnUsers.pdf";
            try
            {
                // Step 1: Creating System.IO.FileStream object
                using (FileStream fs = new FileStream(appRootDir + pdfNameFile+"", FileMode.Create, FileAccess.Write, FileShare.None))
                // Step 2: Creating iTextSharp.text.Document object
                using (Document doc = new Document())
                // Step 3: Creating iTextSharp.text.pdf.PdfWriter object
                // It helps to write the Document to the Specified FileStream
                using (PdfWriter writer = PdfWriter.GetInstance(doc, fs))
                {
                    // Step 4: Openning the Document
                    doc.Open();

                    doc.Add(new Paragraph("Seached VpnUsers"));
                    var i=0;
                    foreach (RepeaterItem curItem in rptUsersTopdf.Items)
                    {
                        i++;
                        var txtUsername = curItem.FindControl("txtUsername") as Label;
                        var txtpwd = curItem.FindControl("txtpwd") as Label;
                        var txtInit = curItem.FindControl("txtInit") as Label;
                        var txtEnd = curItem.FindControl("txtEnd") as Label;
                        var txtGroup = curItem.FindControl("txtGroup") as Label;

                        doc.Add(new Paragraph(" "));
                        doc.Add(new Paragraph(" "));
                        doc.Add(new Paragraph("User " + i));
                        doc.Add(new Paragraph("Username: "+txtUsername.Text));
                        doc.Add(new Paragraph("Password: "+txtpwd.Text));
                        doc.Add(new Paragraph("Begin Date: "+txtInit.Text));
                        doc.Add(new Paragraph("End Date: "+txtEnd.Text));
                        doc.Add(new Paragraph("Group: "+txtGroup.Text));


                    }


                    // Step 6: Closing the Document
                    doc.Close();
                }
            }
            // Catching iTextSharp.text.DocumentException if any
            catch (DocumentException de)
            {
                throw de;
            }
            // Catching System.IO.IOException if any
            catch (IOException ioe)
            {
                throw ioe;
            }


            //http://stackoverflow.com/questions/8897458/asp-net-download-file-to-client-browser#comment46624340_8897675
            string filePath = appRootDir + pdfNameFile+"";
            FileInfo file = new FileInfo(filePath);
            if (file.Exists)
            {
                Response.Clear();

                Response.ClearHeaders();

                Response.ClearContent();

                Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);

                Response.AddHeader("Content-Length", file.Length.ToString());

                Response.ContentType = "text/plain";

                Response.Flush();

                Response.TransmitFile(file.FullName);

                Response.End();
            }


        }
    }
}