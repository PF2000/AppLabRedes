<%@ Page Title="Register" Language="C#" MasterPageFile="~/AccountMP.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="AppLabRedes.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <asp:PlaceHolder runat="server" ID="PlaceHolder1" Visible="false">
        <p class="text-danger">
            <asp:Literal runat="server" ID="FailureText" />
        </p>
    </asp:PlaceHolder>

    <asp:ValidationSummary runat="server" CssClass="text-danger" />
    <div class="form-group">
        <asp:Label runat="server" AssociatedControlID="User" CssClass="col-md-2 control-label">User</asp:Label>

        <asp:TextBox runat="server" ID="User" CssClass="form-control" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="User"
            CssClass="text-danger" ErrorMessage="The User field is required." />

    </div>
    <asp:ValidationSummary runat="server" CssClass="text-danger" />
    <div class="form-group">
        <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Email</asp:Label>

        <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
            CssClass="text-danger" ErrorMessage="The Email field is required." />

    </div>
    <div class="form-group">
        <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>

        <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
            CssClass="text-danger" ErrorMessage="The password field is required." />

    </div>
    <div class="form-group">
        <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Confirm password</asp:Label>

        <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
            CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
        <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
            CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />

    </div>
    <br />
    <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" CssClass="btn btn-lg btn-success btn-block" />

</asp:Content>
