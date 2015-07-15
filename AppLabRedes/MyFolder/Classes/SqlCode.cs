using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace AppLabRedes.Scripts.MyScripts
{
    public class SqlCode
    {
        //Method to copy data from a DataTable to Database
        public static void UpdateDB(DataTable dt, int active)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(strConn);


            if (!dt.Columns.Contains("active"))
                dt.Columns.Add("active", typeof(Int32));
            foreach (DataRow row in dt.Rows)
            {
                row["active"] = active;
            }

            string saveStaff = "update tblLOginTimes set active = @active where id=@id";

            using (SqlCommand command = new SqlCommand(saveStaff, con))
            {

                foreach (DataRow row in dt.Rows)
                {
                    con.Open();

                    command.Parameters.AddWithValue("@id", row["id"]);
                    command.Parameters.AddWithValue("@active", active);

                    command.ExecuteNonQuery();

                    command.Parameters.Clear();
                    con.Close();
                }

            }

        }

        //Method to copy data from a DataTable to Database
        public static void tempVPNtoVpn(DataTable dt)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(strConn);
            try
            {
                con.Open();
                SqlBulkCopy bulk = new SqlBulkCopy(strConn);
                bulk.DestinationTableName = "dbo.VPNUsers";
                bulk.WriteToServer(dt);
                con.Close();
                SqlCode.copyDataEventLogger("Successfully Scheduled VPN Users", "success", "");
            }
            catch (Exception ex)
            {
                SqlCode.copyDataEventLogger("Error Scheduling VPN Users", "danger", ex.Message);
            }
        }

        //Method to copy data from a DataTable to Database
        public static void copyDataEventLogger(String text, String Cclass, String note)
        {
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(strConn);
            try
            {   //especificar o comando SQL
                string strSqlConn;
                if (note.Equals(""))

                    strSqlConn = "insert into EventLogger (text, class, NotSeen,datetime,hasNote) values (@text,@class,'true',GETDATE(),'false')";
                else
                {
                    strSqlConn = "insert into EventLogger (text, class, NotSeen,datetime,note,hasNote) values (@text,@class,'true',GETDATE(),@note,'true')";
                }
                //especificar o 'Command'
                SqlCommand MyComand = new SqlCommand(strSqlConn, con);

                MyComand.Parameters.AddWithValue("@note", note);
                MyComand.Parameters.AddWithValue("@class", "alert alert-" + Cclass);
                MyComand.Parameters.AddWithValue("@text", text);

                //opens the connection
                con.Open();

                MyComand.ExecuteNonQuery();

                con.Close();
            }
            catch (Exception ex)
            {
                //failure.Text += ex.Message;
            }
        }


        // http://stackoverflow.com/questions/6073382/read-sql-table-into-c-sharp-datatable
        // your method to pull data from database to datatable   
        public static DataTable PullDataToDataTable(String SelectCommand)
        {
            //especifica o acesso a BD
            //ddefinir acesso a Connection String
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            //especificar Connection (a 'estrada')
            SqlConnection MyConn = new SqlConnection(strConn);

            //especificar o comando SQL
            string strSqlConn = SelectCommand;

            //especificar o 'Command'
            SqlCommand MyComand = new SqlCommand(strSqlConn, MyConn);

            //Data table para apoio á criaçao
            DataTable dt = new DataTable("Temp");
            //opens the connection
            MyConn.Open();

            // create data adapter
            SqlDataAdapter da = new SqlDataAdapter(MyComand);
            // this will query your database and return the result to your datatable
            da.Fill(dt);
            MyConn.Close();
            da.Dispose();
            //dt = trimDataTable(dt);
            return dt;
        }

        public static DataTable trimDataTable(DataTable dt)
        {

                foreach (DataRow dr in dt.Rows)
                {
                    foreach (DataColumn col in dt.Columns)
                    {
                        if  (col.DataType == typeof(System.String))    
                        {
                            dr[col] = dr[col].ToString().Replace(" ", "");
                        }
                        else
                        {
                            dr[col] = dr[col].ToString().Trim();
                        }
                    }
                }
            return dt;
        }


        //Method to copy data from a DataTable to Database
        public static void tempVPNtotempVpn(DataTable dt)
        {
            dt = trimDataTable(dt);
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(strConn);
            try
            {
                con.Open();
                SqlBulkCopy bulk = new SqlBulkCopy(strConn);
                bulk.DestinationTableName = "dbo.VPNUsersTemp";
                bulk.WriteToServer(dt);
                con.Close();
                //SqlCode.copyDataEventLogger("Successfully Scheduled VPN Users", "success", "");
            }
            catch (Exception ex)
            {
                SqlCode.copyDataEventLogger("Error Scheduling VPN Users", "danger", ex.Message);
            }
        }

        public static int SelectForINT(String SelectCommand)
        {
            int number=0;
            Object retCmd;
            //especifica o acesso a BD
            //ddefinir acesso a Connection String
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            //especificar Connection (a 'estrada')
            SqlConnection MyConn = new SqlConnection(strConn);

            //especificar o comando SQL
            string strSqlConn = SelectCommand;

            //especificar o 'Command'
            SqlCommand MyComand = new SqlCommand(strSqlConn, MyConn);

            //opens the connection
            MyConn.Open();

            //execute command
            retCmd = MyComand.ExecuteScalar();

            if (retCmd != System.DBNull.Value) 
               number = Convert.ToInt16(retCmd);

            //closes the connection
            MyConn.Close();

            return number;
        }

        public static string SelectForString(String SelectCommand)
        {
            String str = "";
            Object retCmd;
            //especifica o acesso a BD
            //ddefinir acesso a Connection String
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            //especificar Connection (a 'estrada')
            SqlConnection MyConn = new SqlConnection(strConn);

            //especificar o comando SQL
            string strSqlConn = SelectCommand;

            //especificar o 'Command'
            SqlCommand MyComand = new SqlCommand(strSqlConn, MyConn);

            //opens the connection
            MyConn.Open();

            //execute command
            retCmd = MyComand.ExecuteScalar();

            if (retCmd != System.DBNull.Value)
                str = Convert.ToString(retCmd);

            //closes the connection
            MyConn.Close();

            return str;
        }
        /// <summary>
        /// Updates the table Ping Status
        /// </summary>
        /// <param name="itPings">Router status</param>
        public static void UpdPingStatus(bool itPings)
        {

            //especifica o acesso a BD
            //ddefinir acesso a Connection String
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            //especificar Connection (a 'estrada')
            SqlConnection MyConn = new SqlConnection(strConn);

            //especificar o comando SQL
            string strSqlConn = "update Ping set routerOn = @itpings where id=1";

            //especificar o 'Command'
            SqlCommand MyComand = new SqlCommand(strSqlConn, MyConn);

            MyComand.Parameters.AddWithValue("@itpings", itPings);

            //opens the connection
            MyConn.Open();

            //execute command
            MyComand.ExecuteNonQuery();

            //closes the connection
            MyConn.Close();

        }

        //DropTable VPNUsersTemp
        public static void deleteAllFromTempTable(Literal txtError)
        {
            //especifica o acesso a BD
            //ddefinir acesso a Connection String
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            //especificar Connection (a 'estrada')
            SqlConnection MyConn = new SqlConnection(strConn);

            //especificar o comando SQL
            string strSqlConn = "DELETE  FROM dbo.VPNUsersTemp";

            //especificar o 'Command'
            SqlCommand MyComand = new SqlCommand(strSqlConn, MyConn);
            try
            {

                //abrir a 'ligação'
                MyConn.Open();

                //recolher os dados
                MyComand.ExecuteScalar();

                //fechar a ligação
                MyConn.Close();
            }
            catch (SqlException ex)
            {
                txtError.Text = ex.Message;
            }

        }

        //DropTable VPNUsersTemp
        public static void dropTempTable(Literal txtError)
        {
            //especifica o acesso a BD
            //ddefinir acesso a Connection String
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            //especificar Connection (a 'estrada')
            SqlConnection MyConn = new SqlConnection(strConn);

            //especificar o comando SQL
            string strSqlConn = "IF OBJECT_ID('dbo.VPNUsersTemp', 'U') IS NOT NULL DROP TABLE dbo.VPNUsersTemp";

            //especificar o 'Command'
            SqlCommand MyComand = new SqlCommand(strSqlConn, MyConn);
            try
            {

                //abrir a 'ligação'
                MyConn.Open();

                //recolher os dados
                MyComand.ExecuteScalar();

                //fechar a ligação
                MyConn.Close();
            }
            catch (SqlException ex)
            {
                txtError.Text = ex.Message;
            }

        }


        public static void createTempTable(Literal txtError)
        {
            //especifica o acesso a BD
            //ddefinir acesso a Connection String
            String strConn = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            //especificar Connection (a 'estrada')
            SqlConnection MyConn = new SqlConnection(strConn);

            //especificar o comando SQL
            string strSqlConn = "CREATE TABLE [dbo].[VPNUsersTemp] ([Id] INT IDENTITY (1, 1) NOT NULL,[usr]     NCHAR (50) NULL,[pwd] NCHAR (50) NULL,[email]    NCHAR (50) NULL,[initDate] DATETIME   NULL,[endDate]  DATETIME   NULL, [groupp] NCHAR (50) NULL, PRIMARY KEY CLUSTERED ([Id] ASC));";

            //especificar o 'Command'
            SqlCommand MyComand = new SqlCommand(strSqlConn, MyConn);
            try
            {

                //abrir a 'ligação'
                MyConn.Open();

                //recolher os dados
                MyComand.ExecuteScalar();

                //fechar a ligação
                MyConn.Close();
            }
            catch (SqlException ex)
            {
                txtError.Text = ex.Message;
            }

        }



    }
}