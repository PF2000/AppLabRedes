<%@ Page Title="Historical Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HistoricalUsers.aspx.cs" Inherits="AppLabRedes.VPNUsers.ManageVPNUsers.HistoricalUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <h2><%: Title %></h2>
    <!-- /.row -->


    <div class="row">
        <div class="col-md-12">
            <section>
                <div class="form-horizontal">
                    <h4>Now</h4>
                    <hr />
                    <p class="text-danger">
                        <asp:Literal runat="server" ID="txtOutput" />
                    </p>


                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>



                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>User Name</th>
                                <th>Email</th>
                                <th>End Date</th>

                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptHistoricalUsers" runat="server" DataSourceID="SqlDHistoricalUsers">
                                <ItemTemplate>
                                    <tr>
                                        <th>
                                            <a href='<%# "Userdetails.aspx?idUser="+Eval ("id") %>'>
                                                <div class="col-md-9">
                                                    <asp:HiddenField ID="hddID" runat="server" Value='<%#Eval("id")%>' />
                                                    <asp:label ID="txtUsername" runat="server" CssClass="form-control" Text='<%#Eval("usr")%>' > </asp:label>
                                                </div>
                                            </a>
                                        </th>
                                        <th>
                                            <a href='<%# "Userdetails.aspx?idUser="+Eval ("id") %>'>
                                                <div class="col-md-9">
                                                    <asp:label ID="txtemail" runat="server" CssClass="form-control" Text='<%#Eval("email")%>' > </asp:label>
                                                </div>
                                            </a>
                                        </th>
                                        <th>
                                            <a href='<%# "Userdetails.aspx?idUser="+Eval ("id") %>'>
                                                <div class="col-md-9">
                                                    <asp:label ID="txtEndsIn" runat="server" CssClass="form-control" Text='<%#Eval("endDate")%>' ></asp:label>
                                                </div>
                                            </a>
                                        </th>
                                        <th></th>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <br />
                <br />


                <asp:SqlDataSource runat="server" ID="SqlDHistoricalUsers" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [VPNUsers] WHERE ([active] = @active)">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="false" Name="active" Type="Boolean"></asp:Parameter>
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />

                <br />
                <br />
            </section>
        </div>
        <div class="col-md-4">
        </div>
    </div>
    <!-- /.row -->


</asp:Content>
