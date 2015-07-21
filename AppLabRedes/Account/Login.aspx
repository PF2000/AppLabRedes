<%@ Page Title="Login" Language="C#" MasterPageFile="~/Account/Account.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AspNet.Identity.Manager.Account.Login" Async="true" %>




<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2><%: Title %>.</h2>


    <form role="form">
        <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
            <p class="text-danger">
                <asp:Literal runat="server" ID="FailureText" />
            </p>
        </asp:PlaceHolder>
        <fieldset>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="UserName" CssClass="col-md-2 control-label">Username</asp:Label>
                <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                    CssClass="text-danger" ErrorMessage="Username is required." />
            </div>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="Password is required." />
            </div>
            <div class="checkbox">
                <label>
                    <asp:CheckBox runat="server" ID="RememberMe" />
                    <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
                </label>
            </div>

            <!-- Change this to a button or input when using this as a form -->
            <asp:Button runat="server" OnClick="LogIn" Text="Login" CssClass="btn btn-lg btn-success btn-block" />
            <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/Account/Register.aspx" >Register</asp:LinkButton>

        </fieldset>
    </form>


<%--            <div class="col-md-4">
            <section id="socialLoginForm">
                <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" />
            </section>
        </div>--%>
</asp:Content>
