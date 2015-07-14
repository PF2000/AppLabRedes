<%@ Page Title="VPN Users" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GenerateScript.aspx.cs" Inherits="AppLabRedes.Management.WebForm1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2><%: Title %></h2>
    <!-- /.row -->


    <div class="row">
        <div class="col-md-12">
            <section>
                <div class="form-horizontal">
                    <h4>Dashboard</h4>
                    <hr />
                    <p class="text-danger">
                        <asp:Literal runat="server" ID="txtOutput" />
                    </p>

                    <asp:Panel ID="pnlCreateUsers" runat="server">
                        <label>Num users to create</label>
                        <div class="form-inline">
                            <asp:TextBox ID="txtNumUsers" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:Button ID="btnGenerate" runat="server" CssClass="btn btn-primary" Text="Button" OnClick="btnGenerate_Click" Height="33px" Width="78px" OnClientClick="return confirm('Are you sure you want to submit ?')" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNumUsers"
                                CssClass="text-danger" ErrorMessage="This filed is necessary" EnableClientScript="false" />
                        </div>
                        <br />
                    </asp:Panel>

                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                </div>

                <div class="row">
                    <asp:Repeater ID="rptNewUser" runat="server" DataSourceID="SqlDSnewUsers" Visible="false">
                        <ItemTemplate>
                            <div class="col-md-6 text-center">
                                <div class="panel panel-default">
                                    <div class="panel-heading"><strong>User <%# Container.ItemIndex + 1 %> </strong></div>
                                    <div class="panel-body">
                                        <asp:HiddenField ID="hddID" runat="server" Value='<%#Eval("id").ToString().Trim() %>' />

                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Username</label>
                                            <div class="col-md-10 ">
                                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Text='<%#Eval("usr").ToString().Trim() %>'> </asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsername"
                                                    CssClass="text-danger" ErrorMessage="The Username field is required." />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Password</label>
                                            <div class="col-md-10">
                                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" Text='<%#Eval("pwd").ToString().Trim() %>'></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword"
                                                    CssClass="text-danger" ErrorMessage="The Password field is required." />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">E-Mail</label>
                                            <div class="col-md-10">
                                                <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtemail"
                                                    CssClass="text-danger" ErrorMessage="The E-Mail field is required." />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Group</label>
                                            <div class="col-md-10">
                                                <%--<asp:TextBox ID="txtGroup" runat="server" CssClass="form-control" Text='<%#Eval("group") %>'></asp:TextBox>--%>
                                                <asp:DropDownList ID="ddlGroupList" runat="server" CssClass="form-control" DataSourceID="SqlDSGroups" DataTextField="groupName" DataValueField="groupName">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource runat="server" ID="SqlDSGroups" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' ProviderName="System.Data.SqlClient" SelectCommand="SELECT [groupName] FROM [groupAdd]"></asp:SqlDataSource>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlGroupList"
                                                    CssClass="text-danger" ErrorMessage="The group field is required." />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Begin Date</label>
                                            <div class="col-md-10">
                                                <asp:TextBox ID="txtbeginDate" runat="server" CssClass="form-control" type="datetime-local"></asp:TextBox>
                                                <%--<asp:Label ID="Label1" CssClass="help-block" runat="server" Text="DD-MM-YY HH:MM"></asp:Label>--%>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtbeginDate"
                                                    CssClass="text-danger" ErrorMessage="The Begin Date field is required." />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">End Date</label>
                                            <div class="col-md-10">
                                                <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" type="datetime-local"></asp:TextBox>
                                                <%--<asp:Label ID="Label9" CssClass="help-block" runat="server" Text="DD-MM-YY HH:MM"></asp:Label>--%>
                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEndDate"
                                                    CssClass="text-danger" ErrorMessage="The Begin Date field is required." />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Description</label>
                                            <div class="col-md-10">
                                                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control"  TextMode="MultiLine"></asp:TextBox>
                                                <%--<asp:Label ID="Label9" CssClass="help-block" runat="server" Text="DD-MM-YY HH:MM"></asp:Label>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <!-- http://forums.asp.net/t/1508094.aspx?How+to+pop+up+a+confirmation+dialog+box+OnClientClick="return confirm('Are you sure you want to submit ?')" -->
                <asp:Button ID="btnConfirm" runat="server" OnClick="btnConfirm_Click" Text="Confirm" CssClass="btn btn-default" Visible="false" OnClientClick="confirm('Are you sure you want to submit ?')" />
            </div>
        </div>


        <asp:SqlDataSource runat="server" ID="SqlDSnewUsers" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [VPNUsersTemp]"></asp:SqlDataSource>
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
