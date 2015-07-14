using AppLabRedes.Scripts.MyScripts;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;

namespace AppLabRedes.MyScripts{
    /// <summary>
    /// 
    /// </summary>
    public class Email
    {

        //http://stackoverflow.com/questions/1774498/how-to-iterate-through-a-datatable
        public static void SendEmails(DataTable dt )
        {
            StringBuilder sb = new StringBuilder();
            String email = null;
            String user = null;
            String pass = null;

            try
            {
                //Sends the emails to all users
                foreach (DataRow row in dt.Rows) // Loop over the items.
                {
                    StringBuilder sb1 = new StringBuilder();
                    //gets the values
                    email = row["email"].ToString();
                    user = row["usr"].ToString();
                    pass = row["pwd"].ToString();
                    //build the message
                    sb1.AppendLine("");
                    sb1.AppendLine("Username: " + user);
                    sb1.AppendLine("Password: " + pass);
                    sb1.AppendLine("");
                    //sends the email
                    SendEmail(email, sb1.ToString());

                    //builds the logMessage
                    sb.AppendLine("To:" + (row["email"].ToString()));
                    sb.AppendLine("Message:" + sb1.ToString());
                }
                SqlCode.copyDataEventLogger("The emails were sucessfully send", "success", sb.ToString());
            }
            catch (Exception ex)
            {
                SqlCode.copyDataEventLogger("Error sending the emails", "danger", ex.Message);
            }
        }


        public static void SendEmail(String recipient, String Message)
        {


            String EmailHost = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("EmailHost");
            String Emailport = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("EmailPort");
            String EmailMail = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("Emailmail");
            String EmailPass = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("EmailPass");
            String EmailMessage = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("EmailMessage");

            var client = new SmtpClient(EmailHost, Int16.Parse(Emailport))
            {
                Credentials = new NetworkCredential(EmailMail, EmailPass),
                EnableSsl = true
            };
            client.Send(EmailMail, recipient, "Credentials", EmailMessage + " " + Message);



        }



    }
}