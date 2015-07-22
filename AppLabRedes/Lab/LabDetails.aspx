<%@ Page Title="Lab Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LabDetails.aspx.cs" Inherits="AppLabRedes.Lab.LabDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



    <h3><%: Title %></h3>
    <!-- /.row -->


    <div class="row">

        <p class="text-danger">
            <asp:Literal runat="server" ID="txtOutput" />
        </p>
        <div class="col-md-6">
            <h4>Create Lab</h4>
            <hr />
            <div class="form-horizontal">

                <div class="form-group">
                    <label class="col-md-2 control-label">Lab Name</label>
                    <div class="col-md-10 ">
                        <asp:TextBox ID="txtLabName" runat="server" CssClass="form-control"></asp:TextBox>

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label">Number Pods</label>
                    <div class="col-md-10 ">
                        <asp:TextBox ID="txtNumPods" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label">Types</label>
                    <div class="col-md-10 ">
                        <asp:ListView ID="lstTypes" runat="server" DataKeyNames="type">
                            <ItemTemplate>

                                <asp:TextBox ID="txtTypes" runat="server" CssClass="form-control" Text='<%# Eval("type") %>'></asp:TextBox>
                                <br />
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
                    <label class="col-md-2 control-label">Description</label>
                    <div class="col-md-10 ">
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Width="80%" Height="130px"></asp:TextBox>

                    </div>
                </div>
                <br />
                <div class="form-group">
                    <div class="col-md-offset-8 col-md-10">
                        <!-- http://forums.asp.net/t/1508094.aspx?How+to+pop+up+a+confirmation+dialog+box+OnClientClick="return confirm('Are you sure you want to submit ?')" -->
                        <%--<asp:Button ID="btnUpdateLab" runat="server" OnClick="btnUpdateLab_Click" Text="Update Lab" CssClass="btn btn-default" OnClientClick="confirm('Are you sure you want to submit ?')" />--%>
                        <br />
                    </div>
                </div>

                <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                    <p class="text-danger">
                        <asp:Literal runat="server" ID="FailureText" />
                    </p>
                </asp:PlaceHolder>
            </div>

        </div>

        <div class="col-md-6">
        </div>
    </div>
</asp:Content>
