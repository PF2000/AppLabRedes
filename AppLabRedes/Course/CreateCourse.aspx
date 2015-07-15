<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateCourse.aspx.cs" Inherits="AppLabRedes.CourseDetails.CreateCourse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



    <h2><%: Title %></h2>
    <!-- /.row -->


    <div class="row">

        <p class="text-danger">
            <asp:Literal runat="server" ID="txtOutput" />
        </p>
        <div class="col-md-6">

            <h4>Create Course</h4>
            <hr />
            <div class="form-horizontal">

                <div class="form-group">
                    <label class="col-md-2 control-label">Course Name</label>
                    <div class="col-md-10 ">
                        <asp:TextBox ID="txtCourseName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div class="form-group">
                            <label class="col-md-2 control-label">Choose Lab</label>
                            <div class="col-md-10 ">
                                <asp:DropDownList ID="ddlLabs" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLabs_SelectedIndexChanged" OnDataBound="ddlLabs_DataBound" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="Id"></asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="Data Source=.\SQLEXPRESS;Initial Catalog=AspNet.AppLabRedes.mdf;User ID=WebApp;Password=Labredes." ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [tblLabs]"></asp:SqlDataSource>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <!-- Types -->
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:PlaceHolder runat="server" ID="cphTypes" Visible="false">
                            <div class="form-group">
                                <label class="col-md-2 control-label">Choose Type</label>
                                <div class="col-md-10 ">
                                    <asp:DropDownList ID="ddlTypes" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" OnDataBound="ddlType_DataBound" CssClass="form-control" DataTextField="type" DataValueField="Id"></asp:DropDownList>
                                </div>
                            </div>
                        </asp:PlaceHolder>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <!-- Times -->
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:PlaceHolder runat="server" ID="cphTime" Visible="false">
                            <div class="form-group">
                                <label class="col-md-2 control-label">Login Time</label>
                                <div class="col-md-10 ">
                                    <hr />
                                    <!-- to insert -->
                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <div class="form-inline">
                                                <div class="col-xs-6">
                                                    <div class="form-group">
                                                        <label>Begin Date</label>
                                                        <asp:TextBox ID="txtnBDate" runat="server" CssClass="form-control datetime"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-xs-6">
                                                    <div class="form-group">
                                                        <label>End Date</label>
                                                        <asp:TextBox ID="txtnEDate" runat="server" CssClass="form-control datetime"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <div class="form-inline">
                                                <div class="col-xs-6">
                                                    <div class="form-group">
                                                        <label>Begin Time</label>
                                                        <asp:TextBox ID="txtBTime" runat="server" CssClass="form-control datetime"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-xs-6">
                                                    <div class="form-group">
                                                        <label>End Time</label>
                                                        <asp:TextBox ID="txtETime" runat="server" CssClass="form-control datetime"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <asp:PlaceHolder runat="server" ID="cphPodsLeft" Visible="false">
                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            Number of pods available : 
                                            <label runat="server" id="lblnumAvlPods"></label>
                                            /
                                            <label runat="server" id="lblnumTotalPods"></label>
                                        </div>
                                    </div>
                                        </asp:PlaceHolder>
                                    <asp:Button ID="btnTime" runat="server" Text="Verify" OnClick="btnTime_Click" CssClass="btn btn-default" />
                                </div>
                            </div>
                        </asp:PlaceHolder>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:PlaceHolder runat="server" ID="cphPods" Visible="false">
                            <div class="form-group">
                                <label class="col-md-2 control-label">Pods</label>
                                <div class="col-md-10 ">
                                    <asp:DropDownList ID="ddlNumPods" AutoPostBack="true" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlNumPods_SelectedIndexChanged"></asp:DropDownList>
                                </div>
                            </div>
                        </asp:PlaceHolder>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

        </div>

        <div class="col-md-6">
            <h4>Users </h4>
            <hr />

            <div class="form-horizontal">
                <!-- Para Utilizadores ver quantos estão disponiveis para aqueles horários -->
                <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:PlaceHolder runat="server" ID="cphUsers" Visible="false">
                            <div class="form-group">
                                <label class="col-md-1 control-label"></label>
                                <div class="col-md-11 ">
                                    <asp:ListView ID="lstUsers" runat="server" DataKeyNames="Name">
                                        <ItemTemplate>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="form-inline">
                                                        <div class="col-xs-6">
                                                            <div class="form-group">
                                                                <label>Name</label>
                                                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Text='<%# Eval("Name") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-xs-6">
                                                            <div class="form-group">
                                                                <label>Pass</label>
                                                                <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" Text='<%# Eval("Pass") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <hr />
                                        </ItemTemplate>
                                        <LayoutTemplate>
                                            <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                                            <div style="">
                                            </div>
                                        </LayoutTemplate>
                                    </asp:ListView>
                                </div>
                            </div>

                            <div class="form-group">
                                <br />
                                <label class="col-md-2 control-label">Description</label>
                                <div class="col-md-10 ">
                                    <br />
                                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Width="80%" Height="130px"></asp:TextBox>
                                </div>
                            </div>
                            <!-- Button to add Course -->
                            <div class="form-group">
                                <br />
                                <div class="col-md-offset-2 col-md-10">
                                    <br />
                                    <asp:Button ID="btnAddCourse" runat="server" Text="Add Course" OnClick="btnAddCourse_Click" CssClass="btn btn-default" />
                                </div>
                            </div>

                        </asp:PlaceHolder>
                    </ContentTemplate>
                </asp:UpdatePanel>
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
