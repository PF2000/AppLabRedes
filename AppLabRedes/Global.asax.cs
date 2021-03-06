﻿using ActiveDirectoryHelper;
using AppLabRedes.MyFolder.Classes;
using AppLabRedes.MyScripts;
using AppLabRedes.Scripts.MyScripts;
using System;
using System.Data;
using System.Text;
using System.Timers;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.UI.WebControls;

namespace AppLabRedes
{
    public class Global : HttpApplication
    {

        /// <summary>
        /// Thread To verify dates to run Scripts
        /// </summary>
        public static System.Timers.Timer MainThread;
        /// <summary>
        /// Thread To check Router Status
        /// </summary>
        public static System.Timers.Timer Ping;
        /// <summary>
        /// to control the messages
        /// </summary>
        bool errorAdd = false;
        bool errorRemove = false;
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            //starts the Thread
            StartMainThread(5000);
            //StartPingThread(4000);

        }

        /// <summary>
        /// Method to start the Thread, to check users for runnings scripts
        /// </summary>
        /// <param name="interval">Interval to run the thread in miliseconds</param>
        /// 
        public void StartMainThread(int interval)
        {

            MainThread = new System.Timers.Timer();
            // Create a timer with a ten second interval.
            MainThread.Interval = interval;
            // Hook up the Elapsed event for the timer.
            MainThread.Elapsed += new ElapsedEventHandler(OnTimedEvent);
            //starts the thread
            MainThread.Enabled = true;       

            //If the timer is declared in a long-running method, use
            // KeepAlive to prevent garbage collection from occurring
            // before the method ends.
            GC.KeepAlive(MainThread);
            //Check router status
            //Network.checkRouterStatus();
            //make a log
            SqlCode.copyDataEventLogger("The Thread has been started", "success", "");
        }

        private void OnTimedEvent(object source, ElapsedEventArgs e)
        {

            //SqlCode.copyData("Check the Users - begin or end","info");

            //Gets the users to Add
            DataTable dt = SqlCode.PullDataToDataTable("select distinct usr,pass, tl.id as id, u.email as email  , l.labIP from tblLOginTimes tl, tblUsers u, tblCourse c, tblLabs l where tl.course = u.course and c.Lab = l.Id and GETDATE() > tl.tBegin and tl.active = '0'");
            if (dt.Rows.Count != 0)
            {
                SaveUsers(dt);
            }
            System.Threading.Thread.Sleep(500);
            //Gets the users to Remove
            dt = SqlCode.PullDataToDataTable("select distinct usr,pass, tl.id as id, u.email as email  , l.labIP from tblLOginTimes tl, tblUsers u, tblCourse c, tblLabs l where tl.course = u.course and c.Lab = l.Id and GETDATE() > tl.tEnd and tl.active = '1'");
            if (dt.Rows.Count != 0)
            {
                RemoveUsers(dt);
            }
        }

        public void RemoveUsers(DataTable dt)
        {
            StringBuilder sb = new StringBuilder();
            try
            {
                //TextBox txt = new TextBox();
                ActiveDirectory ad = new ActiveDirectory();
                
                foreach (DataRow row in dt.Rows) // Loop over the items.
                {
                    String userName = row["usr"].ToString();
                    String pwd = row["pass"].ToString();
                    //DateTime dateTime = (DateTime)row["endDate"];
                    ad.DeleteUser(sb, userName);
                }
                SqlCode.UpdateDB(dt, 2);
                SqlCode.copyDataEventLogger("Successfully deleted users", "success",sb.ToString());

                errorRemove = false;
            }
            catch (Exception ex)
            {
                if (errorRemove == false)
                SqlCode.copyDataEventLogger("Error removing users", "danger", ex.Message);
                errorRemove = true;
            }
        }

        public void SaveUsers(DataTable dt)
        {
            StringBuilder sb = new StringBuilder();
            try
            {
                TextBox txt = new TextBox();
                ActiveDirectory ad = new ActiveDirectory();

                foreach (DataRow row in dt.Rows) // Loop over the items.
                {                   
                    String userName = row["usr"].ToString();
                    String pwd = row["pass"].ToString();
                    //DateTime dateTime = (DateTime)row["tEnd"];
                    ad.CreateUser(sb, userName, pwd);
                    ad.AddUserToGroup(userName, "RadiusUsers");
                }
                SqlCode.UpdateDB(dt, 1);
                EmailClass.SendEmails(dt);
                SqlCode.copyDataEventLogger("Successfully created users", "success", sb.ToString());
                errorAdd = false;
            }
            catch (Exception ex)
            {
                if(errorAdd == false)
                    SqlCode.copyDataEventLogger("Error creating users", "danger", ex.Message);
                errorAdd = true;
            }
        }



        /// <summary>
        /// Method to start the Thread, to check users for runnings scripts
        /// </summary>
        /// <param name="interval">Interval to run the thread in miliseconds</param>
        /// 
        public void StartPingThread(int interval)
        {
            Ping = new System.Timers.Timer();
            // Create a timer with a ten second interval.
            Ping.Interval = interval;
            // Hook up the Elapsed event for the timer.
            Ping.Elapsed += new ElapsedEventHandler(OnTimedEventPing);
            //starts the thread
            Ping.Enabled = true;

            //If the timer is declared in a long-running method, use
            // KeepAlive to prevent garbage collection from occurring
            // before the method ends.
            GC.KeepAlive(Ping);
            //Check router status
            //Network.checkRouterStatus();
            //make a log
            //SqlCode.copyDataEventLogger("The Ping thread has been started", "success", "");
        }


        /// <summary>
        /// // Specify what you want to happen when the Elapsed event is raised.
        /// </summary>
        /// <param name="source"></param>
        /// <param name="e"></param>
        private void OnTimedEventPing(object source, ElapsedEventArgs e)
        {
            try
            {
                //get the Router ip settings
                String RouterIP = System.Web.Configuration.WebConfigurationManager.AppSettings.Get("RouterIP");
                //check if it pings
                Boolean itPings = Network.itPings(RouterIP);
                //get the previous status 
                Boolean StatusRouter = Convert.ToBoolean(Application["RouterStatus"]);

                if (itPings != StatusRouter)
                {
                    Application.Lock();
                    if (itPings)
                    {
                        //updates the ping status 

                        Application["RouterStatus"] = itPings;
                        Application["PingTime"] = Network.PingTimeAverage(RouterIP, 8);
                        SqlCode.copyDataEventLogger("Router is UP", "success", "");
                    }
                    else
                    {
                        //updates the ping status 
                        Application["RouterStatus"] = itPings;
                        Application["PingTime"] = 0;
                        SqlCode.copyDataEventLogger("Ping not received", "danger", "");
                    }
                    Application.UnLock();

                }
            }
            catch (Exception ex)
            {
                SqlCode.copyDataEventLogger("Error Pingging router", "danger", ex.Message);
            }

        }

    }
}