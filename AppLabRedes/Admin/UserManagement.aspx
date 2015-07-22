<%@ Page Title="User management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="AspNet.Identity.Manager.Account.Admin.UserManagement" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>

    <%--https://aspnetidentitymanager.codeplex.com/--%>

    <div class="row">
        <div class="col-md-5">
            <section id="usersForm">
                <asp:UpdatePanel ID="usersUpdatePanel" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                <div class="form-horizontal">
                    <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                    <asp:PlaceHolder runat="server" ID="successMessageUser" Visible="false" ViewStateMode="Disabled">
                        <p class="text-success"><%: SuccessMessageUser %></p>
                    </asp:PlaceHolder>
                    <hr />
                    <div class="form-horizontal">
                        <asp:ListView ID="usersListview" runat="server"
                            ItemType="Microsoft.AspNet.Identity.IUser"
                            SelectMethod="GetUsers" DeleteMethod="RemoveUser" UpdateMethod="UpdateUser" DataKeyNames="Id"
                            OnItemCommand="usersListview_ItemCommand"
                            OnItemDataBound="usersListview_ItemDataBound">
                            <LayoutTemplate>
                                <h4>Users</h4>
                                <table class="table">
                                    <tbody>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </tbody>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr class="form-group">
                                    <td>
                                        <asp:LinkButton ID="EditUserButton" OnClientClick="return confirm('Are you sure you want to submit ?')" runat="server" CommandName="Edit" CommandArgument='<%#: Item.Id %>'
                                            Text='<span class="glyphicon glyphicon-edit" />' style="margin-right:10px;"/><%#: Item.UserName %>
                                    </td>
                                    <td>
                                        <asp:CheckBoxList runat="server" ID="userRolesCheckboxList"
                                            ItemType="Microsoft.AspNet.Identity.EntityFramework.IdentityRole" DataTextField="Name"
                                            RepeatDirection="Vertical" SelectMethod="GetUserRoles" />
                                        <asp:LinkButton runat="server" OnClientClick="return confirm('Are you sure you want to submit ?')" CommandName="SaveUserRoles" CommandArgument='<%#: Item.Id %>' 
                                            ToolTip='<%# "Save roles of user " + Item.UserName%>'><span class="glyphicon glyphicon-save" /></asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton runat="server" OnClientClick="return confirm('Are you sure you want to submit ?')" CommandName="Delete" CausesValidation="false"
                                            ToolTip='<%# "remove the user " + Item.UserName%>'><span class="glyphicon glyphicon-remove"></asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <tr style="background-color: #ADD8E6">
                                    <td>
                                        <asp:LinkButton ID="UpdateButton" OnClientClick="return confirm('Are you sure you want to submit ?')" runat="server" CommandName="Update" ToolTip="Update" ValidationGroup="Userdata"><span class="glyphicon glyphicon-save" /></asp:LinkButton>&nbsp;
                                        <asp:LinkButton ID="CancelButton" OnClientClick="return confirm('Are you sure you want to submit ?')" runat="server" CommandName="Cancel" ToolTip="Cancel"><span class="glyphicon glyphicon-refresh" /></asp:LinkButton>
                                    </td>
                                    <td colspan="2">
                                        <div class="form-group">
                                            <asp:Label runat="server" ID="UserNameLabel" AssociatedControlID="UserNameTextBox" CssClass="col-md-4 control-label" Text="User name" />
                                            <div class="col-md-8">
                                                <asp:TextBox ID="UserNameTextBox" runat="server" Text='<%#Bind("UserName") %>' MaxLength="50" CssClass="form-control" />
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserNameTextBox"
                                                    CssClass="text-danger" ErrorMessage="User name is required." Display="Dynamic"
                                                    ValidationGroup="Userdata" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <div class="form-group">
                                            <asp:Label runat="server" ID="EMailLabel" Text="EMail" AssociatedControlID="EMail" CssClass="col-md-4 control-label"/>
                                            <div class="col-md-8">
                                                <asp:TextBox runat="server" ID="EMail" Text='<%#Bind("EMail") %>' CssClass="form-control"/>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="EMail" Display="Dynamic"
                                                    CssClass="text-danger" ErrorMessage="EMail is required."
                                                    ValidationGroup="Userdata"/>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <div class="form-group">
                                            <asp:Label runat="server" ID="PhoneNumberLabel" Text="Phone number" AssociatedControlID="PhoneNumber" CssClass="col-md-4 control-label"/>
                                            <div class="col-md-8">
                                                <asp:TextBox runat="server" ID="PhoneNumber" Text='<%#Bind("PhoneNumber") %>' CssClass="form-control"/>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <div class="form-group">
                                            <asp:Label runat="server" ID="LockoutEnabledLabel" Text="Lockout enabled" AssociatedControlID="LockoutEnabled" CssClass="col-md-4 control-label"/>
                                            <div class="col-md-8">
                                                <asp:CheckBox runat="server" ID="LockoutEnabled" Checked='<%#Bind("LockoutEnabled") %>' CssClass="checkbox" style="margin-left:20px;"/>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <h4>Use the form below to change your password.</h4>
                                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                                        <div class="form-group">
                                            <asp:Label runat="server" ID="NewPasswordLabel" AssociatedControlID="NewPassword" CssClass="col-md-4 control-label" Text="New password" />
                                            <div class="col-md-8">
                                                <asp:TextBox runat="server" ID="NewPassword" TextMode="Password" CssClass="form-control" />
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword" Display="Dynamic"
                                                    CssClass="text-danger" ErrorMessage="New password is required."
                                                    ValidationGroup="ChangePassword" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <asp:Label runat="server" ID="ConfirmNewPasswordLabel" AssociatedControlID="ConfirmNewPassword" CssClass="col-md-4 control-label">Confirm new password</asp:Label>
                                            <div class="col-md-8">
                                                <asp:TextBox runat="server" ID="ConfirmNewPassword" TextMode="Password" CssClass="form-control" />
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
                                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="Confirm new password is required."
                                                    ValidationGroup="ChangePassword" />
                                                <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="New password does not match the confirm new password."
                                                    ValidationGroup="ChangePassword" />
                                            </div>
                                        </div>
                                        <div class="form-group" style="background-color: #ADD8E6;padding:12px 0;">
                                            <div class="col-md-offset-4 col-md-8">
                                                <asp:Button runat="server" Text="Change password" ValidationGroup="ChangePassword" OnClientClick="return confirm('Are you sure you want to submit ?')" 
                                                    CommandName="ChangePassword" CommandArgument='<%#: Item.Id %>' CssClass="btn btn-default" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </EditItemTemplate>
                        </asp:ListView>
                    </div>

                    <div class="form-inline">
                        <asp:Label runat="server" AssociatedControlID="newUserTextbox" CssClass="control-label" Text="Add user: " />
                        <asp:TextBox runat="server" ID="newUserTextbox" CssClass="form-control" />
                        <asp:LinkButton runat="server" OnClick="addUserButton_Click" OnClientClick="return confirm('Are you sure you want to submit ?')" ToolTip="Add user">&nbsp;<span class="glyphicon glyphicon-plus" /></asp:LinkButton>
                    </div>
                </div>
                </ContentTemplate>
                </asp:UpdatePanel>
            </section>
        </div>
        <div class="col-md-offset-2 col-md-5">
            <section id="rolesForm">
                <asp:UpdatePanel ID="rolesUpdatePanel" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                <div class="form-horizontal">
 
                    <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                    <asp:PlaceHolder runat="server" ID="successMessageRole" Visible="false" ViewStateMode="Disabled">
                        <p class="text-success"><%: SuccessMessageRole %></p>
                    </asp:PlaceHolder>
                    <hr />
                    <div class="form-group">
                        <asp:ListView ID="rolesListview" runat="server"
                            ItemType="Microsoft.AspNet.Identity.EntityFramework.IdentityRole"
                            SelectMethod="GetRoles" DeleteMethod="RemoveRole" UpdateMethod="UpdateRole" DataKeyNames="Id">
                            <LayoutTemplate>
                                <h4>Roles</h4>
                                <table class="table">
                                    <tbody>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </tbody>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><!--<asp:LinkButton ID="EditRoleButton" runat="server" OnClientClick="return confirm('Are you sure you want to submit ?')" CommandName="Edit" CommandArgument='<%#: Item.Id %>'
                                            ToolTip="Edit" Text='<span class="glyphicon glyphicon-edit" />' style="margin-right:10px;"/><%#: Item.Name %>
                                 --> <%#: Item.Name %>
                                          </td>
                                  <!--  <td>
                                        <asp:LinkButton runat="server" CommandName="Delete" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to submit ?')"
                                            ToolTip='<%# "Remove the role " + Item.Name %>' Text='<span class="glyphicon glyphicon-remove" />'/>
                                    </td>-->
                                </tr>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <tr style="background-color: #ADD8E6">
                                    <td>
                                        <asp:LinkButton ID="UpdateButton" OnClientClick="return confirm('Are you sure you want to submit ?')" runat="server" CommandName="Update" ToolTip="Update" Text='<span class="glyphicon glyphicon-save"/>'/>&nbsp;
                                        <asp:LinkButton ID="CancelButton" OnClientClick="return confirm('Are you sure you want to submit ?')" runat="server" CommandName="Cancel" ToolTip="Cancel" Text='<span class="glyphicon glyphicon-refresh" />' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="NameTextBox" runat="server" Text='<%#Bind("Name") %>' MaxLength="50" CssClass="form-control" />
                                    </td>
                                </tr>
                            </EditItemTemplate>
                        </asp:ListView>
                    </div>

<%--                    <div class="form-inline">
                        <asp:Label runat="server" AssociatedControlID="newRoleTextbox" CssClass="control-label" Text="Add role: " />
                        <asp:TextBox runat="server" ID="newRoleTextbox" CssClass="form-control" />
                        <asp:LinkButton runat="server" OnClientClick="return confirm('Are you sure you want to submit ?')" OnClick="addRoleButton_Click" ToolTip="Add role" Text=' <span class="glyphicon glyphicon-plus" />' />
                    </div>--%>
                </div>
                </ContentTemplate>
                </asp:UpdatePanel>
            </section>
        </div>
    </div>
    <script>
        $(function () {
            $('span.checkbox>input').addClass('checkbox');
        });
    </script>
</asp:Content>
