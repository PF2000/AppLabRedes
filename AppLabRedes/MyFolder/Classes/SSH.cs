using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using Tamir.SharpSsh;

namespace AppLabRedes.Scripts.MyScripts
{
    public class SSH
    {

        //Save the file Script.txt 
        public static String SaveGenScriptSSH(string fileName)
        {
            StringBuilder sb = new StringBuilder();
            SshStream ssh = null;

            String RouterIP = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("RouterIP");
            String RouterUser = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("RouterUser");
            String RouterPass = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("RouterPass");


            ssh = new SshStream(RouterIP, RouterUser, RouterPass);
            if (File.Exists(fileName))
            {

                // Open the file to read from. 
                string[] readText = File.ReadAllLines(fileName);
                foreach (string str in readText)
                {
                    ssh.Write(str);
                    System.Threading.Thread.Sleep(200);
                    sb.AppendLine(ssh.ReadResponse());
                }
            }
            else
            {
                throw new System.ArgumentException("File with script to send via SSH found");
            }

            System.Threading.Thread.Sleep(500);
            ssh.Close();
            return sb.ToString();
        }


    }
}