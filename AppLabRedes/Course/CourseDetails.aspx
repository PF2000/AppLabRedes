<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CourseDetails.aspx.cs" Inherits="AppLabRedes.Course.CDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



    <h2><%: Title %></h2>
    <!-- /.row -->


    <div class="row">

        <p class="text-danger">
            <asp:Literal runat="server" ID="txtOutput" />
        </p>
        <div class="col-md-6">

            <h4>course Details</h4>
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
                    <label class="col-md-2 control-label">Login Time</label>
                    <div class="col-md-10 ">

                        <asp:ListView ID="lstTimes" runat="server" DataKeyNames="tBegin">
                            <ItemTemplate>
                                <div class="form-group">
                                    <div class="col-xs-12">
                                        <div class="form-inline">
                                            <div class="col-xs-6">
                                                <div class="form-group">
                                                    <label>Begin Date</label>
                                                    <asp:TextBox ID="txtBeginDate" runat="server" CssClass="form-control" Text='<%# Eval("tBegin") %>'></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-xs-5">
                                                <div class="form-group">
                                                    <label>End Date</label>
                                                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" Text='<%# Eval("tEnd") %>'></asp:TextBox>
                                                </div>
                                            </div>
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

