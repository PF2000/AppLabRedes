<%@ Page Title="VPN User" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserDetails.aspx.cs" Inherits="AppLabRedes.VPNUsers.ManageVPNUsers.UserDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <h2><%: Title %></h2>
    <!-- /.row -->


    <div class="row">
        <div class="col-md-12">
            <section>
                <div class="form-horizontal">
                    <h4>Details</h4>
                    <hr />
                    <p class="text-danger">
                        <asp:Literal runat="server" ID="txtOutput" />
                    </p>


                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>

                    <asp:FormView ID="FormView1" DataKeyNames="Id" runat="server" DataSourceID="SqlDSUser">
                        <ItemTemplate>

                            <div class="col-md-9">
                                <asp:HiddenField ID="hddID" runat="server" Value='<%#Eval("id")%>' />
                                <label>UserName</label>
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Text='<%#Eval("usr")%>' ReadOnly="true"> </asp:TextBox>
                            </div>

                            <div class="col-md-9">
                                <label>Email</label>
                                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Text='<%#Eval("email")%>' ReadOnly="true"> </asp:TextBox>
                            </div>

                            <div class="col-md-9">
                                <label>BeginDate</label>
                                <asp:TextBox ID="txtEndsIn" runat="server" CssClass="form-control" Text='<%#Eval("initDate")%>' ReadOnly="true"></asp:TextBox>
                            </div>

                            <div class="col-md-9">
                                <label>EndDate</label>
                                <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control" Text='<%#Eval("endDate")%>' ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="col-md-9">
                                <label>Description</label>
                                <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control" Text='<%#Eval("description")%>' ReadOnly="true"></asp:TextBox>
                            </div>
                            <div class="col-md-9">
                                <label>Status</label>
                                <asp:TextBox ID="txtStatus" runat="server" CssClass="form-control" Text='<%#Eval("active")%>' ReadOnly="true"></asp:TextBox>
                            </div>

                        </ItemTemplate>
                    </asp:FormView>

                </div>
                <br />
                <br />


                <asp:SqlDataSource runat="server" ID="SqlDSUser" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [VPNUsers] WHERE ([id] = @id)">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="0" Name="Id" QueryStringField="idUser" Type="Int32" />
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
