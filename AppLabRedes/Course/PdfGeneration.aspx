<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PdfGeneration.aspx.cs" Inherits="AppLabRedes.VPNUsers.ManageVPNUsers.ManageCreationVpn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



    <h2><%: Title %></h2>
    <!-- /.row -->


    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal">
                <h4>Manage</h4>
                <hr />
                <p class="text-danger">
                    <asp:Literal runat="server" ID="txtOutput" />
                </p>


                <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                    <p class="text-danger">
                        <asp:Literal runat="server" ID="FailureText" />
                    </p>
                </asp:PlaceHolder>

                <div class="col-md-12">
                    <h4>PDF Generation</h4>
                    <hr />
                    <div class="form-group">
                        <label class="col-md-2 control-label">Begin Date</label>
                        <div class="col-md-10">
                            <asp:TextBox ID="txtbeginDate" runat="server" CssClass="form-control datetime" ></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtbeginDate"
                                CssClass="text-danger" ErrorMessage="The Begin Date field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">End Date</label>
                        <div class="col-md-10">
                            <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control datetime" ></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEndDate"
                                CssClass="text-danger" ErrorMessage="The Begin Date field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-11 col-md-1">
                            <asp:Button ID="btnGetSearch" runat="server" OnClick="btnGetSearch_Click" Text="Confirm" CssClass="btn btn-default" OnClientClick="return confirm('Are you sure you want to submit ?')" />
                        </div>
                    </div>
                    <asp:PlaceHolder runat="server" ID="tbl" Visible="false">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>User Name</th>
                                    <th>Password</th>
                                    <th>Begin Date</th>
                                    <th>End Date</th>
                                    <th>Group</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptUsersTopdf" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <th>
                                                <div class="col-md-9">
                                                    <a href='<%# "Userdetails.aspx?idUser="+Eval ("id") %>'>
                                                        <asp:HiddenField ID="hddID" runat="server" Value='<%#Eval("id")%>' />
                                                        <asp:Label ID="txtUsername" runat="server" CssClass="form-control" Text='<%#Eval("usr")%>'> </asp:Label>
                                                    </a>
                                                </div>
                                            </th>
                                            <th>
                                                <a href='<%# "Userdetails.aspx?idUser="+Eval ("id") %>'>
                                                    <div class="col-md-9">
                                                        <asp:Label ID="txtpwd" runat="server" CssClass="form-control" Text='<%#Eval("pwd")%>'> </asp:Label>
                                                    </div>
                                                </a>
                                            </th>
                                            <th>
                                                <a href='<%# "Userdetails.aspx?idUser="+Eval ("id") %>'>
                                                    <div class="col-md-9">
                                                        <asp:Label ID="txtInit" runat="server" CssClass="form-control" Text='<%#Eval("initDate")%>'></asp:Label>
                                                    </div>
                                                </a>
                                            </th>
                                            <th>
                                                <a href='<%# "Userdetails.aspx?idUser="+Eval ("id") %>'>
                                                    <div class="col-md-9">
                                                        <asp:Label ID="txtEnd" runat="server" CssClass="form-control" Text='<%#Eval("endDate")%>'></asp:Label>
                                                    </div>
                                                </a>
                                            </th>
                                            <th>
                                                <a href='<%# "Userdetails.aspx?idUser="+Eval ("id") %>'>
                                                    <div class="col-md-9">
                                                        <asp:Label ID="txtGroup" runat="server" CssClass="form-control" Text='<%#Eval("groupp")%>'></asp:Label>
                                                    </div>
                                                </a>
                                            </th>
                                        </tr>

                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                        <div class="form-group">
                            <div class="col-md-offset-11 col-md-1">
                                <asp:Button ID="btnGenPdf" runat="server" OnClick="btnGenPdf_Click" Text="Confirm" CssClass="btn btn-default" OnClientClick="return confirm('Are you sure you want to submit ?')" />
                            </div>
                        </div>
                    </asp:PlaceHolder>
                </div>
            </div>
        </div>
    </div>
        <%--http://mugifly.github.io/jquery-simple-datetimepicker/--%>
    <script type="text/javascript" src="/MyFolder/Scripts/jquery.simple-dtpicker.js"></script>
    <script>

        $(function () {
            $("body").find(".datetime").appendDtpicker();
            $('body').delegate('.datetime').appendDtpicker();

            $("body").on("mousemove", function () {

                $("body").find(".datetime").appendDtpicker();
                $('body').delegate('.datetime').appendDtpicker();

            });
        });


    </script>
</asp:Content>
