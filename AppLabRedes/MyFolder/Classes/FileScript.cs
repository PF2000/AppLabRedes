using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace AppLabRedes.Scripts.MyScripts
{
    public class FileScript
    {


        // Write to a Text File
        public static void WriteFile(String text, String filePath)
        {
            //string fileName = Server.MapPath("~/Files/") + "script.txt";

            if (File.Exists(filePath))
            {
                using (StreamWriter sw = File.AppendText(filePath))
                {
                    sw.Write(text + " \n");
                }
            }
            else
            {
                throw new System.ArgumentException("File not found");
            }

        }

        // Read From a Text File
        public static void ReadFile(TextBox textbox, String filePath)
        {
            //string fileName = Server.MapPath("~/Files/") + "script.txt";

            if (File.Exists(filePath))
            {
                using (TextReader tr = new StreamReader(filePath))
                {
                    string str = "";

                    while (str != null)
                    {
                        textbox.Text += (str + " \n ");

                        str = tr.ReadLine();
                    }
                }
            }
            else
            {
                throw new System.ArgumentException("File not found");
            }
        }

        //Create a File
        public static void CreateFile(string filepath)
        {
            FileStream fs = null;
            if (!File.Exists(filepath))
            {
                using (fs = File.Create(filepath))
                {

                }
            }
        }

        // Delete a text file
        public static void DeleteFile(string fileName)
        {
            if (File.Exists(fileName))
            {
                File.Delete(fileName);
            }
        }

        //http://stackoverflow.com/questions/1774498/how-to-iterate-through-a-datatable
        public static void GenTextAdd(DataTable dt, String filepath)
        {
            //ApagaFicheiro Se existe
            FileScript.DeleteFile(filepath);
            //Cria novo Ficheiro
            FileScript.CreateFile(filepath);
            //Começa a escrita
            FileScript.WriteFile("en", filepath);
            FileScript.WriteFile("conf", filepath);
            //CreateSeveralUsers(3, filepath);
            foreach (DataRow row in dt.Rows) // Loop over the items.
            {
                FileScript.WriteFile("aaa user " + row["usr"].ToString(), filepath);
                FileScript.WriteFile("password " + row["pwd"].ToString(), filepath);
                FileScript.WriteFile("group default", filepath);
                FileScript.WriteFile("policy vpn", filepath);
                FileScript.WriteFile("exit" + " \n", filepath);
            }
        }

        //http://stackoverflow.com/questions/1774498/how-to-iterate-through-a-datatable
        public static void GenTextRemove(DataTable dt, String filepath)
        {
            //ApagaFicheiro Se existe
            FileScript.DeleteFile(filepath);
            //Cria novo Ficheiro
            FileScript.CreateFile(filepath);
            //Começa a escrita
            FileScript.WriteFile("en", filepath);
            FileScript.WriteFile("conf", filepath);
            //CreateSeveralUsers(3, filepath);
            foreach (DataRow row in dt.Rows) // Loop over the items.
            {
                FileScript.WriteFile("no aaa user " + row["usr"].ToString(), filepath);
            }
        }

    }
}