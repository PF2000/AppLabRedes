<%@ Page Title="Overview" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AppLabRedes._Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Dashboard</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">

        <div class="row">
            <div class="col-lg-4 col-md-6">
                <div class="panel panel-green">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-bell-o fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <asp:Label ID="lblNotifications" runat="server" CssClass="huge"></asp:Label>
                                <div>New Notifications!</div>
                            </div>
                        </div>
                    </div>
                    <a runat="server" href="~/Admin/Logger.aspx">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="panel panel-yellow">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-users fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <asp:Label ID="lblActiveUsers" runat="server" CssClass="huge"></asp:Label>
                                <div>Active VPN Users!</div>
                            </div>
                        </div>
                    </div>
                    <a runat="server" href="~/VPNUsers/ManageVPNUsers/ActiveUsers.aspx">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <div class="panel panel-red">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-3">
                                <i class="fa fa-calendar-o fa-5x"></i>
                            </div>
                            <div class="col-xs-9 text-right">
                                <asp:Label ID="lblScheduleUsers" runat="server" CssClass="huge"></asp:Label>
                                <div>Shedule VPN Users!</div>
                            </div>
                        </div>
                    </div>
                    <a runat="server" href="~/VPNUsers/ManageVPNUsers/ScheduleUsers.aspx">
                        <div class="panel-footer">
                            <span class="pull-left">View Details</span>
                            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                            <div class="clearfix"></div>
                        </div>
                    </a>
                </div>
            </div>
        </div>


        <!-- /.row -->
        <div class="row">
            <div class="col-lg-8">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-desktop fa-fw"></i>Router Status
                           
                    </div>
                    <!-- /.panel-heading -->
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="panel-body">
                                <div class="form-group">
                                    <div runat="server" id="divRouterPing">
                                        <label>Router Status: </label>
                                        <asp:Label runat="server" ID="lblRouterStatus"></asp:Label>
                                        <br />
                                        <label>Average Time: </label>
                                        <asp:Label runat="server" ID="lblPingAvegare"></asp:Label>
                                        <br />
                                        <asp:Button runat="server" OnClick="btnPing_Click" ID="btnPing" Text=" Ping " CssClass="btn btn-prymary" />
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <!-- /.panel-body -->
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-users fa-fw"></i>VPN Users
                           
                    </div>
                    <!-- /.panel-heading -->

                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12 ">
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <asp:Calendar ID="Calendar1" runat="server" Width="100%" SelectionMode="None" OnDayRender="Calendar1_DayRender" BackColor="White" BorderColor="#3366CC" CellPadding="2" DayNameFormat="Short" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" CssClass="col-lg-12">
                                                <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                                                <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                                <WeekendDayStyle BackColor="#CCCCFF" />
                                                <OtherMonthDayStyle ForeColor="#999999" />
                                                <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                                <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="5px" />
                                                <TitleStyle BackColor="#003399" BorderColor="#3366CC"
                                                    BorderWidth="1px" Font-Bold="True"
                                                    Font-Size="10pt" ForeColor="#CCCCFF" Height="5px" />
                                                <DayStyle Height="60" CssClass="dayStt" />
                                            </asp:Calendar>
		<asp:LinkButton ID="CalendarLinkButton" runat="server" CssClass="hide" 
			OnClick="CalendarLinkButton_Click"></asp:LinkButton>
		<asp:Label ID="ResultsLabel" runat="server" CssClass="results"></asp:Label>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-8 -->
            <div class="col-lg-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-bell fa-fw"></i>Notifications Panel                 
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="list-group">
                            <asp:ListView ID="lstLogger" runat="server" DataSourceID="SqlDSUser" DataKeyNames="Id">
                                <EmptyDataTemplate>
                                    <div class="alert alert-success">
                                        <span>No New Notifications.</span>
                                    </div>
                                </EmptyDataTemplate>
                                <ItemTemplate>
                                    <asp:HiddenField Value='<%# Eval("id") %>' runat="server" />
                                    <asp:LinkButton ID="btnNote" runat="server" PostBackUrl="~/Admin/Logger.aspx" CssClass="list-group-item">
                                <i class="fa fa-comment fa-fw"></i><%# Eval("text") %>                                                        
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <div runat="server" id="itemPlaceholderContainer" style="font-family: Verdana, Arial, Helvetica, sans-serif;"><span runat="server" id="itemPlaceholder" /></div>
                                </LayoutTemplate>
                            </asp:ListView>
                            <asp:SqlDataSource runat="server" ID="SqlDSUser" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT TOP  10 text,datetime,id FROM [EventLogger] where NotSeen='true' order by id desc"></asp:SqlDataSource>
                        </div>
                    </div>
                </div>
                <!-- /.list-group -->
                <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/Admin/Logger.aspx" CssClass="btn btn-default btn-block">View All Notifications</asp:LinkButton>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel .chat-panel -->
    </div>
    <!-- /.col-lg-4 -->
</asp:Content>
