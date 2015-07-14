using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;

namespace AppLabRedes.MyFolder.Classes
{
    public class Network
    {


        public static Boolean itPings(string host)
        {
            int ping = 0;
            for (int i = 0; i < 6; i++)
            {
                int timeout = 120;
                Ping pingSender = new Ping();
                PingReply reply = pingSender.Send(host, timeout);

                if (reply.Status == IPStatus.Success)
                {
                    ping += 1;
                }
            }


            if (ping >= 3)
            {
                return true;
            }
            else
            {
                return false;
            }


        }


        public static double PingTimeAverage(string host, int echoNum)
        {
            long totalTime = 0;
            int timeout = 120;
            Ping pingSender = new Ping();

            for (int i = 0; i < echoNum; i++)
            {
                PingReply reply = pingSender.Send(host, timeout);
                if (reply.Status == IPStatus.Success)
                {
                    totalTime += reply.RoundtripTime;
                }
            }
           // return (totalTime / echoNum);
            double avg = ((double)totalTime / (double)echoNum);
            return avg;
        }

    }
}