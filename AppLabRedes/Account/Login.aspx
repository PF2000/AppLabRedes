﻿<%@ Page Title="Log in" Language="C#" MasterPageFile="~/AccountMP.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AppLabRedes.Account.Login" Async="true" EnableEventValidation="false" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
        <p class="text-danger">
            <asp:Literal runat="server" ID="FailureText" />
        </p>
    </asp:PlaceHolder>
    <div class="form-group">
        <asp:TextBox runat="server" ID="User" CssClass="form-control" placeholder="Username" />
    </div>
    <div class="form-group">
        <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" placeholder="Password" /> </div>
    <div class="checkbox">
        <label>
            <asp:CheckBox runat="server" ID="RememberMe" />
            <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
        </label>
    </div>
    <asp:Button runat="server" OnClick="LogIn" Text="Login" CssClass="btn btn-lg btn-success btn-block" />
    <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/Account/Forgot.aspx" CssClass="btn btn-lg btn-success btn-block" >Recover Password</asp:LinkButton>

</asp:Content>
