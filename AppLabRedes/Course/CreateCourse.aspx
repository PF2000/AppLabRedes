<%@ Page Title="Create Course" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateCourse.aspx.cs" Inherits="AppLabRedes.CourseDetails.CreateCourse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <div class="row">
        <asp:UpdatePanel ID="upUsers" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:PlaceHolder runat="server" ID="cphErrorMessage" Visible="false">
                    <div class="form-group">
                        <asp:Label runat="server" CssClass="text-danger col-lg-12 control-label" ID="txtOutput"></asp:Label>
                    </div>
                    <br />
                    <hr />
                </asp:PlaceHolder>
            </ContentTemplate>
        </asp:UpdatePanel>

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
                <!-- TuimeZone -->
                <asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:PlaceHolder runat="server" ID="cphTimeZones" Visible="false">
                            <div class="form-group">
                                <label class="col-md-2 control-label">Choose TimeZone</label>
                                <div class="col-md-10 ">
                                    <asp:DropDownList ID="ddlTimeZone" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlTimeZone_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
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
                                    <!-- to insert -->
                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <div class="form-inline">
                                                <div class="col-xs-6">
                                                    <div class="form-group">
                                                        <label>Begin Date</label>
                                                        <asp:TextBox ID="txtBDate" runat="server" CssClass="form-control date"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-xs-6">
                                                    <div class="form-group">
                                                        <label>End Date</label>
                                                        <asp:TextBox ID="txtEDate" runat="server" CssClass="form-control date"></asp:TextBox>
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
                                                        <asp:TextBox ID="txtBTime" runat="server" CssClass="form-control time" data-date="" data-date-format="hh:ii" data-link-field="dtp_input3" data-link-format="hh:ii"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-xs-6">
                                                    <div class="form-group">
                                                        <label>End Time</label>
                                                        <asp:TextBox ID="txtETime" runat="server" CssClass="form-control time" data-date="" data-date-format="hh:ii" data-link-field="dtp_input3" data-link-format="hh:ii"></asp:TextBox>
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
                <!-- check users in that time -->
                <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:PlaceHolder runat="server" ID="cphUsers" Visible="false">
                            <div class="form-group">
                                <label class="col-md-1 control-label"></label>
                                <div class="col-md-11 ">
                                    <asp:ListView ID="lstUsers" runat="server" DataKeyNames="Name">
                                        <ItemTemplate>
                                            <div class="form-group">
                                                <div class="col-lg-12">
                                                    <div class="form-inline">
                                                        <div class="col-xs-6">
                                                            <div class="form-group">
                                                                <div class="col-xs-3">
                                                                    <div class="form-group">
                                                                        <label>Name</label>
                                                                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Text='<%# Eval("Name") %>'></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xs-6">
                                                            <div class="form-group">
                                                                <div class="col-xs-3">
                                                                    <div class="form-group">
                                                                        <label>Pass</label>
                                                                        <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" Text='<%# Eval("Pass") %>'></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="form-inline">
                                                        <div class="col-md-12 ">
                                                            <div class="form-group">
                                                                <label class="control-label">E-Mail</label>
                                                                <asp:TextBox ID="txtMail" runat="server" CssClass="form-control"></asp:TextBox>
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
                                    <asp:Button ID="btnAddCourse" runat="server" Text="Add Course" OnClick="btnAddCourse_Click" CssClass="btn btn-default" OnClientClick="return confirm('Are you sure you want to add this course ?')" />
                                </div>
                            </div>

                        </asp:PlaceHolder>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
    <%--http://mugifly.github.io/jquery-simple-datetimepicker/--%>
    <script type="text/javascript" src="../MyFolder/Scripts/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="../MyFolder/Scripts/bootstrap-datetimepicker.min.js"></script>
    <script>

        $(function () {
            $("body").on("mousemove", function () {
                $("body").find(".date").datepicker({
                    // daysOfWeekDisabled: "0",
                    format: "dd/mm/yyyy",
                    //daysOfWeekDisabled: "0",
                    autoclose: true,
                    todayHighlight: true,
                    //datesDisabled: ['07/06/2015', '07/21/2015'],
                    toggleActive: true
                });

                $("body").find('.time').datetimepicker({
                    language: 'en',
                    weekStart: 1,
                    todayBtn: 0,
                    autoclose: 1,
                    todayHighlight: 1,
                    startView: 1,
                    minView: 0,
                    maxView: 1,
                    forceParse: 0
                });
                $("body").find(".switch").parent().find('*').each(function () {
                    $(this).css("visibility", " hidden")

                });

            });
        });
    </script>
</asp:Content>
