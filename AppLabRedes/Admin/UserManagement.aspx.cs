using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using TOP.CodeLibrary.Extensions;
using System.Web.UI.WebControls;
using System.Web.ModelBinding;
using System.Web.UI.HtmlControls;
using AppLabRedes.Models;
using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;


// From https://aspnetidentitymanager.codeplex.com/

namespace AspNet.Identity.Manager.Account.Admin
{
    public partial class UserManagement : System.Web.UI.Page
    {
        protected string SuccessMessageUser { get; private set; }

        protected string SuccessMessageRole { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            SuccessMessageUser = string.Empty;
            successMessageUser.Visible = false;

            SuccessMessageRole = string.Empty;
            successMessageRole.Visible = false;
        }

        public IEnumerable<IUser> GetUsers()
        {
            ApplicationDbContext context = new ApplicationDbContext();
            return context.Users.AsEnumerable<IUser>();
        }

        protected void usersListview_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                CheckBoxList userRolesCheckboxList = e.Item.FindFirstControl<CheckBoxList>("userRolesCheckboxList");
                if (userRolesCheckboxList.IsNotNull() && e.Item.DataItem.IsNotNull())
                {
                    UserManager manager = new UserManager();
                    ApplicationUser user = e.Item.DataItem as ApplicationUser;

                    IList<string> userRoles = manager.GetRoles(user.Id);

                    foreach (ListItem item in userRolesCheckboxList.Items)
                    {
                        item.Selected = userRoles.Contains(item.Text);
                    }
                }
            }
        }

        protected void addUserButton_Click(object sender, EventArgs e)
        {
            ApplicationDbContext context = new ApplicationDbContext();
            ApplicationUser user = new ApplicationUser(newUserTextbox.Text);
            context.Users.Add(user);
            context.SaveChanges();

            usersListview.DataBind();
            newUserTextbox.Text = string.Empty;

            SuccessMessageUser = "User added";
            successMessageUser.Visible = true;

        }

        public void UpdateUser(string Id)
        {
            ApplicationDbContext context = new ApplicationDbContext();
            ApplicationUser user = context.Users.Find(Id);
            if (user.IsNotNull())
            {
                TryUpdateModel(user);
                if (ModelState.IsValid)
                {
                    context.SaveChanges();
                    SuccessMessageUser = "User updated";
                    successMessageUser.Visible = true;
                    Unnamed_LoggingOut();
                    Response.Redirect("~/Account/Login.aspx");
                }
            }
            else
            {
                AddErrors(new IdentityResult(new string[] { string.Format("element with id {0} not found.", Id) }));
                return;
            }
        }

        public void removeUser(string Id)
        {
            ApplicationDbContext context = new ApplicationDbContext();
            ApplicationUser user = context.Users.Find(Id);
            var roles = new List<string> { "Administrator" };

            if (user.IsNotNull())
            {
                if (!user.Roles.Any(u => roles.Contains("Administrator")))
                {
                    context.Users.Remove(user);
                    context.SaveChanges();
                    SuccessMessageUser = "User removed";
                    successMessageUser.Visible = true;
                }
                else
                {
                    SuccessMessageUser = "User is Administrator cant be removed";
                    successMessageUser.Visible = true;
                }
            }
        }

        public IEnumerable<UserRole> GetUserRoles()
        {
            UserManager manager = new UserManager();
            ApplicationDbContext context = new ApplicationDbContext();
            List<UserRole> roles = context.Roles.ToList().Select(r => new UserRole() { Id = r.Id, Name = r.Name, Selected = false }).OrderBy(r => r.Name).ToList();

            return roles;
        }

        public IEnumerable<IdentityRole> GetRoles()
        {
            ApplicationDbContext context = new ApplicationDbContext();
            return context.Roles.OrderBy(r => r.Name).AsEnumerable();
        }

        public void removeRole(string Id)
        {
            ApplicationDbContext context = new ApplicationDbContext();
            IdentityRole role = context.Roles.Find(Id);
            if (role.IsNotNull())
            {
                context.Roles.Remove(role);
                context.SaveChanges();
                SuccessMessageRole = "Role removed";
                successMessageRole.Visible = true;

                usersListview.DataBind();
                usersUpdatePanel.Update();
            }
        }

        protected void usersListview_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "SaveUserRoles")
            {
                string userId = e.CommandArgument.ConvertTo<string>();
                UserManager manager = new UserManager();
                CheckBoxList userRolesCheckboxList = e.Item.FindFirstControl<CheckBoxList>("userRolesCheckboxList");
                foreach (ListItem item in userRolesCheckboxList.Items)
                {
                    if (item.Selected)
                    {
                        manager.AddToRole(userId, item.Text);
                    }
                    else
                    {
                        manager.RemoveFromRole(userId, item.Text);
                    }
                }
                SuccessMessageUser = "Roles of user saved";
                successMessageUser.Visible = true;
            }
            else if (e.CommandName == "ChangePassword")
            {
                TextBox passwordTextBox = e.Item.FindFirstControl<TextBox>("NewPassword");
                TextBox confirmPasswordTextBox = e.Item.FindFirstControl<TextBox>("ConfirmNewPassword");

                if (!passwordTextBox.Equals("") && !confirmPasswordTextBox.Equals("") &&
                    passwordTextBox.Text == confirmPasswordTextBox.Text)
                {
                    string userId = e.CommandArgument.ConvertTo<string>();
                    UserManager manager = new UserManager();
                    IdentityResult result = manager.RemovePassword(userId);
                    result = manager.AddPassword(userId, passwordTextBox.Text);
                    if (result.Succeeded)
                    {
                        successMessageUser.Visible = true;
                        SuccessMessageUser = "Password of user changed";
                    }
                    else
                    {
                        successMessageUser.Visible = true;
                        AddErrors(result);
                        return;
                    }
                }
            }
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        protected void Unnamed_LoggingOut()
        {
            Context.GetOwinContext().Authentication.SignOut();
        }

    }

    public class UserRole : IdentityRole
    {
        public UserRole() : base() { }

        public bool Selected { get; set; }
    }
}