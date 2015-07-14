using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.DirectoryServices.AccountManagement;
using System.Web.UI.WebControls;

namespace ActiveDirectoryHelper
{
    public class ADManager
    {

        PrincipalContext context;

        public ADManager()
        {
            context = new PrincipalContext(ContextType.Domain);

        }


        public ADManager(string domain, string container)
        {
            context = new PrincipalContext(ContextType.Domain, domain, container);
        }

        public ADManager(string domain, string username, string password)
        {
            context = new PrincipalContext(ContextType.Domain, username, password);
        }

        public bool AddUserToGroup(string userName, string groupName)
        {
            bool done = false;
            GroupPrincipal group = GroupPrincipal.FindByIdentity(context, groupName);
            if (group == null)
            {
                group = new GroupPrincipal(context, groupName);
            }
            UserPrincipal user = UserPrincipal.FindByIdentity(context, userName);
            if (user != null & group != null)
            {
                group.Members.Add(user);
                group.Save();
                done = (user.IsMemberOf(group));
            }
            return done;
        }


        public bool RemoveUserFromGroup(string userName, string groupName)
        {
            bool done = false;
            UserPrincipal user = UserPrincipal.FindByIdentity(context, userName);
            GroupPrincipal group = GroupPrincipal.FindByIdentity(context, groupName);
            if (user != null & group != null)
            {
                group.Members.Remove(user);
                group.Save();
                done = !(user.IsMemberOf(group));
            }
            return done;
        }

        /// <summary>
        /// To Create users
        /// </summary>
        /// <param name="txt">textbox to warnings</param>
        /// <param name="userLogonName">username</param>
        /// <param name="userPassword"></param>
        /// <param name="datetime">account expiration date</param>
        /// <returns>true if users if deleted sucessfully </returns>
        public void CreateUser(TextBox txt, string userLogonName, string userPassword, DateTime datetime)
        {
            // Creating the PrincipalContext
            PrincipalContext principalContext = null;
            //try
            //{
            //principalContext = new PrincipalContext(ContextType.Domain);
            principalContext = context;
            //}
            //catch (Exception ex)
            //{
            //    txt.Text = "Failed to create PrincipalContext. Exception: " + ex.Message;
            //    return false;
            //}

            // Check if user object already exists in the store
            UserPrincipal usr = UserPrincipal.FindByIdentity(principalContext, userLogonName);
            if (usr != null)
            {
                txt.Text = userLogonName + " already exists. Please use a different User Logon Name.";
            }

            // Create the new UserPrincipal object
            UserPrincipal userPrincipal = new UserPrincipal(context);
            // username
            userPrincipal.SamAccountName = userLogonName;
            // Expiring date
            userPrincipal.AccountExpirationDate = datetime;
            //Password
            userPrincipal.SetPassword(userPassword);
            //Activate the account
            userPrincipal.Enabled = true;
            //cant change the password
            userPrincipal.UserCannotChangePassword = true;

            userPrincipal.Save();

        }


        /// <summary>
        /// To delete Users
        /// </summary>
        /// <param name="txt">textbox to warnings</param>
        /// <param name="userLogonName">username</param>
        /// <returns>true if users if deleted sucessfully </returns>
        public void DeleteUser(TextBox txt, string userLogonName)
        {
            // Creating the PrincipalContext
            PrincipalContext principalContext = null;

            //principalContext = new PrincipalContext(ContextType.Domain);
            principalContext = context;

            //txt.Text = "Failed to create PrincipalContext. Exception: " + ex.Message;


            // Check if user object already exists in the store
            UserPrincipal usr = UserPrincipal.FindByIdentity(principalContext, userLogonName);
            if (usr != null)
            {
                usr.Delete();
                txt.Text = userLogonName + " Deleted.";
            }
            else
            {
                txt.Text = userLogonName + " doesn't exists. Please use a different User Logon Name.";
                throw new System.InvalidOperationException("The user does not exist");
            }

        }


    }
}