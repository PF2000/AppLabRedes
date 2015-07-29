using AppLabRedes.Scripts.MyScripts;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;

namespace AppLabRedes.MyScripts
{
    /// <summary>
    /// 
    /// </summary>
    public class EmailClass
    {

        //http://stackoverflow.com/questions/1774498/how-to-iterate-through-a-datatable
        public static void SendEmails(DataTable dt)
        {
            StringBuilder sb = new StringBuilder();
            String email = null;
            String user = null;
            String pass = null;
            String labIP = null;

            try
            {
                //Sends the emails to all users
                foreach (DataRow row in dt.Rows) // Loop over the items.
                {
                    StringBuilder sb1 = new StringBuilder();
                    //gets the values
                    email = row["email"].ToString();
                    user = row["usr"].ToString();
                    pass = row["pass"].ToString();
                    labIP = row["labIP"].ToString();
                    //build the message
                    sb1.AppendLine("");
                    sb1.AppendLine("Username: " + user);
                    sb1.AppendLine("Password: " + pass);
                    sb1.AppendLine("");
                    //sends the email
                    SendEmail(email, sb1.ToString(),labIP);

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


        public static void SendEmail(String recipient, String Message,String labIP)
        {

            String EmailHost = "";
            String Emailport = "";
            String EmailMail = "";
            String EmailPass = "";
            String EmailMessage = "";

            try
            {

                DataTable dt = SqlCode.PullDataToDataTable("Select * from tblEmail");

                DataRow dr = dt.Rows[0];

                EmailHost = Convert.ToString(dr["host"]);
                Emailport = Convert.ToString(dr["port"]);
                EmailMail = Convert.ToString(dr["email"]);
                EmailPass = Convert.ToString(dr["pass"]);
                EmailMessage = Convert.ToString(dr["message"]);
            }
            catch (Exception ex)
            {

            }



            var client = new SmtpClient(EmailHost, Int16.Parse(Emailport))
            {
                Credentials = new NetworkCredential(EmailMail, EmailPass),
                EnableSsl = true
            };

            StringBuilder sb = new StringBuilder();
            sb.AppendLine("Credentials");
            sb.AppendLine("");
            sb.AppendLine("Ip Lab: " + labIP);
            sb.AppendLine("");
            sb.AppendLine("Users: ");
            sb.AppendLine(Message);
            sb.AppendLine("");
            sb.AppendLine("");
            sb.AppendLine(EmailMessage);


            client.Send(EmailMail, recipient, "Credentials", sb.ToString());



        }


        public static void SendEmailRecover(String recipient, String Message)
        {

            String EmailHost = "";
            String Emailport = "";
            String EmailMail = "";
            String EmailPass = "";
            //String EmailMessage = "";

            try
            {
                //gets the email credentials
                DataTable dt = SqlCode.PullDataToDataTable("Select * from tblEmail");

                DataRow dr = dt.Rows[0];

                EmailHost = Convert.ToString(dr["host"]);
                Emailport = Convert.ToString(dr["port"]);
                EmailMail = Convert.ToString(dr["email"]);
                EmailPass = Convert.ToString(dr["pass"]);
                //EmailMessage = Convert.ToString(dr["message"]);
            }
            catch (Exception ex)
            {

            }



            var client = new SmtpClient(EmailHost, Int16.Parse(Emailport))
            {
                Credentials = new NetworkCredential(EmailMail, EmailPass),
                EnableSsl = true
            };
            client.Send(EmailMail, recipient,"Message recovery" ," Your Password now is: " + Message + " /n Please change it !!" );
        }



    }
}