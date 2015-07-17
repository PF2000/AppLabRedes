<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="AppLabRedes.Course.Courses" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2><%: Title %></h2>
    <!-- /.row -->

    <div class="row">
        <h4>Search</h4>

        <hr />
        <asp:PlaceHolder runat="server" ID="cphErrorMessage" Visible="false">
            <div class="form-group">
                <asp:Label runat="server" CssClass="text-danger col-lg-12 control-label" ID="txtOutput"></asp:Label>
            </div>
            <br />
            <hr />
        </asp:PlaceHolder>

        <div class="form-group">
            <div class="col-xs-12">
                <div class="form-inline">
                    <div class="col-xs-3">
                        <div class="form-group">
                            <label>End Date</label>
                            <asp:DropDownList ID="ddlLabs" runat="server" AutoPostBack="true" CssClass="form-control" DataTextField="name" DataValueField="Id"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label>Begin Date</label>
                            <asp:TextBox ID="txtBegin" runat="server" CssClass="form-control date "></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label>End Date</label>
                            <asp:TextBox ID="txtEnd" runat="server" CssClass="form-control date "></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-xs-">
                        <div class="form-group">
                            <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-default" Text="Search" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <hr />
    <div class="row">
        <h4>Overview Courses </h4>
        <hr />
        <asp:ListView ID="lstCourses" runat="server" DataKeyNames="id">
            <ItemTemplate>
                <div class="col-md-6 ">
                    <div class="panel panel-default text-center">
                        <div class="panel-heading">
                            <a href='<%# "CourseDetails.aspx?idCourse="+Eval ("id") %>'>
                                <h4><%#Eval("cName")%></h4>
                            </a>
                        </div>

                        <div class="panel-body">
                            <p><%#Eval("description")%></p>
                            <hr />
                            <h5>Number of Pods - <strong><%#Eval("numUsers")%></strong></h5>
                            <a href='<%# "EditCourse.aspx?idCourse="+Eval ("id") %>' class="btn btn-primary">Edit</a>
                            <asp:LinkButton ID="btnRemoveCourse" runat="server" CssClass="btn btn-primary" OnCommand="btnRemoveCourse_Command" CommandArgument='<%# Eval ("id") %>'>Remove</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
            <EmptyDataTemplate>
                <h4>No courses in the time span selected</h4>
            </EmptyDataTemplate>
            <LayoutTemplate>
                <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                <div style="">
                </div>
            </LayoutTemplate>
        </asp:ListView>
        <asp:LinkButton runat="server" PostBackUrl="~/Course/CreateCourse.aspx" ToolTip="Create Course">&nbsp;<span class="glyphicon glyphicon-plus fa-4x" /></asp:LinkButton>
    </div>

    <%--http://mugifly.github.io/jquery-simple-datetimepicker/--%>
    <script type="text/javascript" src="../MyFolder/Scripts/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="../MyFolder/Scripts/bootstrap-datetimepicker.min.js"></script>
    <script>

        $(function () {
            $("body").on("mousemove", function () {
                $("body").find(".date").datepicker({
                    daysOfWeekDisabled: "0",
                    format: "dd/mm/yyyy",
                    daysOfWeekDisabled: "0",
                    autoclose: true,
                    todayHighlight: true,
                    datesDisabled: ['07/06/2015', '07/21/2015'],
                    toggleActive: true
                });

            });
        });

    </script>
</asp:Content>

