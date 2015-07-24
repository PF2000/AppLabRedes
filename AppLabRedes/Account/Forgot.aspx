<%@ Page Title="" Language="C#" MasterPageFile="~/AccountMP.Master" AutoEventWireup="true" CodeBehind="Forgot.aspx.cs" Inherits="AppLabRedes.Account.Forgot" %>


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


    </div>
    <asp:ValidationSummary runat="server" CssClass="text-danger" />
    <div class="form-group">
        <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Email</asp:Label>

        <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />


    </div>
    <br />
    <asp:Button runat="server" OnClick="Recover_Click" Text="Recover" CssClass="btn btn-lg btn-success btn-block" />
    <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/Account/Login.aspx" CssClass="btn btn-lg btn-success btn-block">Cancel</asp:LinkButton>

</asp:Content>
