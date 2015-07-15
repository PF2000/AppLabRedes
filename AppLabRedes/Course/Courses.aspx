<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="AppLabRedes.Course.Courses" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2><%: Title %></h2>
    <!-- /.row -->

    <div class="row">
        <h4>Search</h4>

        <hr />
        <p class="text-danger">
            <asp:Literal runat="server" ID="txtOutput" />
        </p>


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
                            <asp:TextBox ID="txtBegin" runat="server" CssClass="form-control datetime"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="form-group">
                            <label>End Date</label>
                            <asp:TextBox ID="txtEnd" runat="server" CssClass="form-control datetime"></asp:TextBox>
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
            <LayoutTemplate>
                <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                <div style="">
                </div>
            </LayoutTemplate>
        </asp:ListView>

        <asp:LinkButton runat="server" PostBackUrl="~/Course/CreateCourse.aspx" ToolTip="Create Course">&nbsp;<span class="glyphicon glyphicon-plus fa-4x" /></asp:LinkButton>
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

