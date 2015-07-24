<%@ Page Title="Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="AppLabRedes.Settings.Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2><%: Title %></h2>
    <!-- /.row -->


    <div class="row">
        <div class="col-md-6">
            <div class="form-horizontal">
                <h4>Settings for Email</h4>
                <hr />
                <div class="panel panel-default">
                    <div class="panel-heading"><strong>E-mail</strong></div>
                    <div class="panel-body">

                        <div class="form-group">
                            <label class="col-md-2 control-label">Host</label>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtEmailHost" runat="server" CssClass="form-control"> </asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmailHost"
                                    CssClass="text-danger" ErrorMessage="The Username field is required." />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Port</label>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtEmailport" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmailport"
                                    CssClass="text-danger" ErrorMessage="The Password field is required." />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Email</label>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtEmailMail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmailMail"
                                    CssClass="text-danger" ErrorMessage="The E-Mail field is required." />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Password</label>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtEmailPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmailPass"
                                    CssClass="text-danger" ErrorMessage="The E-Mail field is required." />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Message</label>
                            <div class="col-md-8">
                                <asp:TextBox ID="txtEmailMessage" runat="server" CssClass="form-control" Height="200px" TextMode="MultiLine"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmailMessage"
                                    CssClass="text-danger" ErrorMessage="The E-Mail field is required." />
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button ID="btnApplySettings" runat="server" Text="Apply" CssClass="btn btn-default" OnClick="btnApplySettings_Click" OnClientClick="return confirm('Are you sure you want to submit ?')" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
