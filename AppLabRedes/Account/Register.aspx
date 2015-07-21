<%@ Page Title="Registrieren" Language="C#" MasterPageFile="~/Account/Account.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="AspNet.Identity.Manager.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
        <asp:PlaceHolder runat="server" ID="PlaceHolder1" Visible="false">
        <p class="text-danger">
            <asp:Literal runat="server" ID="FailureText" />
        </p>
    </asp:PlaceHolder>
    <fieldset>
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="UserName" CssClass="col-md-2 control-label">Username</asp:Label>
            <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                CssClass="text-danger" ErrorMessage="User name is required." />

        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>

            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                CssClass="text-danger" ErrorMessage="New Password is required." />

        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Confirm password</asp:Label>

            <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                CssClass="text-danger" Display="Dynamic" ErrorMessage="Confirm password is required." />
            <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                CssClass="text-danger" Display="Dynamic" ErrorMessage="Password does not match the confirm password." />

        </div>

                <!-- Change this to a button or input when using this as a form -->
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" CssClass="btn btn-default" />

    </fieldset>
</asp:Content>
