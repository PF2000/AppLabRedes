﻿<%@ Page Title="Create Lab" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateLab.aspx.cs" Inherits="AppLabRedes.Lab.CreateLab" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <asp:PlaceHolder runat="server" ID="cphErrorMessage" Visible="false">
        <div class="form-group">
            <asp:Label runat="server" CssClass="text-danger col-lg-12 control-label" ID="Label1"></asp:Label>
        </div>
        <br />
        <hr />
    </asp:PlaceHolder>


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
                        <asp:CheckBoxList ID="ckbTypes" runat="server" DataSourceID="SqlDSTypes" DataTextField="type" DataValueField="Id"></asp:CheckBoxList>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label">Lab IP</label>
                    <div class="col-md-10 ">
                        <asp:TextBox ID="txtIP" runat="server" CssClass="form-control"></asp:TextBox>

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
                        <asp:Button ID="btnaddLab" runat="server" OnClick="btnaddLab_Click" Text="Add Lab" CssClass="btn btn-default" OnClientClick=" return confirm('Are you sure you want to submit ?')" />
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
            <h4>Manage Lab Types</h4>
            <hr />
            <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDSTypes" DataKeyNames="Id" InsertItemPosition="LastItem">
                <EditItemTemplate>
                    <tr style="">
                        <td>
                            <asp:TextBox Text='<%# Bind("type") %>' runat="server" ID="typeTextBox" CssClass="form-control" /></td>
                        <td>
                            <asp:Button runat="server" CssClass="btn btn-default" CommandName="Update" Text="Update" ID="UpdateButton" />
                            <asp:Button runat="server" CssClass="btn btn-default" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                        </td>
                    </tr>

                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <tr style="">

                        <td>
                            <asp:TextBox Text='<%# Bind("type") %>' runat="server" ID="typeTextBox" CssClass="form-control" /></td>
                        <td>
                            <asp:Button runat="server" CssClass="btn btn-primary" CommandName="Insert" Text="Insert" ID="InsertButton" />
                            <asp:Button runat="server" CssClass="btn btn-primary" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                        </td>
                    </tr>
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Label Text='<%# Eval("type") %>' runat="server" ID="typeLabel" /></td>
                        <td>
                            <asp:LinkButton runat="server" CssClass="btn btn-default" OnCommand="btnRemoveType_Command" CommandArgument='<%# Eval ("id") %>' ID="DeleteButton" OnClientClick=" return confirm('Are you sure you want to delete this type ? This action will delete all courses associated with this Type.')">Delete</asp:LinkButton>
                            <asp:Button runat="server" CssClass="btn btn-default" CommandName="Edit" Text="Edit" ID="EditButton" />
                        </td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server" id="itemPlaceholderContainer" class="table table-hover">
                        <thead>
                            <tr>
                                <th runat="server">Type</th>
                                <th runat="server"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr runat="server" id="itemPlaceholder"></tr>

                        </tbody>
                    </table>
                </LayoutTemplate>
            </asp:ListView>
            <asp:SqlDataSource runat="server" ID="SqlDSTypes" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                DeleteCommand="DELETE FROM [tblTypes_Labss] WHERE [IdType] = @Id; DELETE FROM [tblLabType] WHERE [Id] = @Id"
                InsertCommand="INSERT INTO [tblLabType] ([type]) VALUES (@type)" ProviderName="System.Data.SqlClient"
                SelectCommand="SELECT * FROM [tblLabType]" UpdateCommand="UPDATE [tblLabType] SET [type] = @type WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="type" Type="String"></asp:Parameter>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="type" Type="String"></asp:Parameter>
                    <asp:Parameter Name="Id" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>

    </div>
</asp:Content>
