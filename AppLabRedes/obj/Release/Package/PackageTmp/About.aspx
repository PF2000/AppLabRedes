<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" 
    ViewStateMode ="Disabled"
    AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="AppLabRedes.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <h3>Your application description page.</h3>
    <p>Use this area to provide additional information.</p>
    <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
    <br />
    <br />
    <asp:TextBox ID="txtConsole" runat="server" Height="225px" Width="588px" TextMode="MultiLine" EnableViewState="False"></asp:TextBox>

    <br />
    <br />
    <br />
    <br />
</asp:Content>
