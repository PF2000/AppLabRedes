<%@ Page Title="Overview Labs" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Labs.aspx.cs" Inherits="AppLabRedes.Lab.Labs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h3><%: Title %></h3>
    <!-- /.row -->


    <div class="row">
        
        <hr />
        <p class="text-danger">
            <asp:Literal runat="server" ID="txtOutput" />
        </p>

        <asp:Repeater ID="rptNewUser" runat="server" DataSourceID="SqlDSLabs" Visible="true">
            <ItemTemplate>
                <div class="col-md-6 ">
                    <div class="panel panel-default text-center">

                        <div class="panel-heading">
                            <a href='<%# "LabDetails.aspx?idLab="+Eval ("id") %>'>
                                <h4><%#Eval("name")%></h4>
                            </a>
                        </div>

                        <div class="panel-body">
                            <p>Lab IP - <%#Eval("labIP")%></p>
                            <hr />
                            <h5>Number of Pods - <strong><%#Eval("numPods")%></strong></h5>
                            <a href='<%# "EditLab.aspx?idLab="+Eval ("id") %>' class="btn btn-primary">Edit</a>
                            <%--<asp:Button ID="btnRemoveLab" runat="server" Text="Remove" class="btn btn-primary" OnClick= />--%>
                            <asp:LinkButton ID="btnRemoveLab" runat="server" CssClass="btn btn-primary" OnCommand="btnRemoveLab_Command" CommandArgument='<%# Eval ("id") %>' OnClientClick="return confirm('Are you sure you want to add this course ?')">Remove</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

    </div>
    <asp:LinkButton runat="server" PostBackUrl="~/Lab/CreateLab.aspx" ToolTip="Create Lab">&nbsp;<span class="glyphicon glyphicon-plus fa-4x" /></asp:LinkButton>
    <asp:SqlDataSource runat="server"  ID="SqlDSLabs" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [tblLabs]"></asp:SqlDataSource>

</asp:Content>

