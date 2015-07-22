<%@ Page Title="Course Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseDetails.aspx.cs" Inherits="AppLabRedes.Course.CDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



    <h3><%: Title %></h3>
    <!-- /.row -->


    <div class="row">

        <p class="text-danger">
            <asp:Literal runat="server" ID="txtOutput" />
        </p>
        <div class="col-md-6">

            <hr />
            <div class="form-horizontal">

                <div class="form-group">
                    <label class="col-md-2 control-label">Course Name</label>
                    <div class="col-md-10 ">
                        <asp:TextBox ID="txtCourseName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-md-2 control-label">Choose Lab</label>
                    <div class="col-md-10 ">
                        <asp:TextBox ID="txtLab" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-md-2 control-label">Choose Type</label>
                    <div class="col-md-10 ">
                        <asp:TextBox ID="txtType" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label"> TimeZone</label>
                    <div class="col-md-10 ">
                        <asp:TextBox ID="txtTimeZone" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label">Login Time</label>
                    <div class="col-md-10 ">

                        <div class="form-group">
                            <div class="col-xs-12">
                                <div class="form-inline">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label>Begin Date</label>
                                            <asp:TextBox ID="txtnBDate" runat="server" CssClass="form-control"></asp:TextBox>
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
                                            <asp:TextBox ID="txtnBTime" runat="server" CssClass="form-control datetime"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label>End Time</label>
                                            <asp:TextBox ID="txtnETime" runat="server" CssClass="form-control datetime"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr />
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-md-2 control-label">Pods</label>
                    <div class="col-md-10 ">
                        <asp:TextBox ID="txtNumPods" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

            </div>

        </div>

        <div class="col-md-6">
            <h4>Users </h4>
            <hr />

            <div class="form-horizontal">
                <!-- Para Utilizadores ver quantos estão disponiveis para aqueles horários -->

                <div class="form-group">
                    <label class="col-md-1 control-label"></label>
                    <div class="col-md-11 ">
                        <asp:ListView ID="lstUsers" runat="server" DataKeyNames="usr">
                            <ItemTemplate>
                                <div class="form-group">
                                    <div class="col-xs-12">
                                        <div class="form-inline">
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label>Name</label>
                                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Text='<%# Eval("usr") %>'></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label>Pass</label>
                                                    <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" Text='<%# Eval("pass") %>'></asp:TextBox>
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
                                                    <asp:TextBox ID="txtMail" runat="server" CssClass="form-control" Text='<%# Eval("email") %>'></asp:TextBox>
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
            </div>
        </div>
    </div>
</asp:Content>

