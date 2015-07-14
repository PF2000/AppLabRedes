<%@ Page Title="Schedule Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ScheduleUsers.aspx.cs" Inherits="AppLabRedes.VPNUsers.ManageVPNUsers.ScheduleUsers" %>

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
                                <th>Begin Date</th>
                                <th>Start Now</th>
                                <th>End Now</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptScheduleUsers" runat="server" DataSourceID="SqlDScheduleUsers">
                                <ItemTemplate>
                                    <tr>
                                        <th>
                                            <a href='<%# "Userdetails.aspx?idUser="+Eval ("id") %>'>
                                                <div class="col-md-9">
                                                    <asp:HiddenField ID="hddID" runat="server" Value='<%#Eval("id")%>' />
                                                    <asp:Label ID="txtUsername" runat="server" CssClass="form-control" Text='<%#Eval("usr")%>'> </asp:Label>
                                                </div>
                                            </a>
                                        </th>
                                        <th>
                                            <a href='<%# "Userdetails.aspx?idUser="+Eval ("id") %>'>
                                                <div class="col-md-9">
                                                    <asp:Label ID="txtemail" runat="server" CssClass="form-control" Text='<%#Eval("email")%>'> </asp:Label>
                                                </div>
                                            </a>
                                        </th>
                                        <th>
                                            <a href='<%# "Userdetails.aspx?idUser="+Eval ("id") %>'>
                                                <div class="col-md-9">
                                                    <asp:Label ID="txtEndsIn" runat="server" CssClass="form-control" Text='<%#Eval("initDate")%>'></asp:Label>
                                                </div>
                                            </a>
                                        </th>
                                        <th>
                                            <a href='<%# "Userdetails.aspx?idUser="+Eval ("id") %>'>
                                                <div class="col-md-1">
                                                    <asp:CheckBox ID="chkAddUser" runat="server" />
                                                </div>
                                            </a>
                                        </th>
                                        <th>
                                            <a href='<%# "Userdetails.aspx?idUser="+Eval ("id") %>'>
                                                <div class="col-md-1">
                                                    <asp:CheckBox ID="ChkRemoveuser" runat="server" />
                                                </div>
                                            </a>
                                        </th>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <br />
                <br />
                <div class="form-group">
                    <div class="col-md-offset-11 col-md-1">
                        <asp:Button ID="btnApply" runat="server" OnClick="btnApply_Click" Text="Confirm" CssClass="btn btn-default" OnClientClick="return confirm('Are you sure you want to submit ?')" />
                    </div>
                </div>


                <asp:SqlDataSource runat="server" ID="SqlDScheduleUsers" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [VPNUsers] WHERE ([active] is null)"></asp:SqlDataSource>
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
