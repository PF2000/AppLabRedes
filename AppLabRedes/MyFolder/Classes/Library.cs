using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using TelnetApp;

namespace AppLabRedes.MyScripts
{
    public class Library
    {


        //Save in XSR script.txt
        public void SaveGenScriptTelnet()
        {
            //System.Diagnostics.Process.Start("rasdial.exe", "LabRedes teste teste");

            //create a new telnet connection to hostname "gobelijn" on port "23"
            TelnetConnection tc = new TelnetConnection("10.10.10.1", 23);

            //login with user "root",password "rootpassword", using a timeout of 100ms, and show server output
            string s = tc.Login("admin", "labredes", 100);

            // server output should end with "$" or ">", otherwise the connection failed
            string prompt = s.TrimEnd();
            prompt = s.Substring(prompt.Length - 1, 1);
            if (prompt != "$" && prompt != ">")
                throw new Exception("Connection failed");


           //// string fileName = Server.MapPath("~/Files/") + "script.txt";
           // string fileNamee= "ç" ;

           // if (File.Exists(fileNamee))
           // {

           //     // Open the file to read from. 
           //     string[] readText = File.ReadAllLines(fileNamee);
           //     foreach (string str in readText)
           //     {
           //         tc.WriteLine(str);
           //     }
           // }

           // tc.Disconnect();
        }

        protected DateTime ConvertTime(DateTime dt, String IdNewTz)
        {
            String IdLocalTz = TimeZoneInfo.Local.Id;

            DateTime nDateTime = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(dt, IdNewTz, IdLocalTz);
            return nDateTime;
        }

    }
}