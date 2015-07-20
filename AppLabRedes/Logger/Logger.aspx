<%@ Page Title="Events Log" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Logger.aspx.cs" Inherits="AppLabRedes.Admin.Logger" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">




    <h2><%: Title %></h2>
    <!-- /.row -->


    <div class="row">
        <div class="col-md-10">
            <section>
                <div class="form-horizontal">
                    <h4>Log</h4>
                    <hr />
                    <p class="text-danger">
                        <asp:Literal runat="server" ID="txtOutput" />
                    </p>


                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Logger
                       
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">

                            <asp:ListView ID="lstLogger" runat="server" DataSourceID="SqlDSUser" DataKeyNames="Id">
                                <EmptyDataTemplate>
                                    <div class="alert alert-success">
                                        <span>No data was returned.</span>
                                    </div>
                                </EmptyDataTemplate>
                                <ItemTemplate>
                                    <asp:UpdatePanel ID="updPanel" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:HiddenField Value='<%# Eval("id") %>' runat="server" />
                                            <div class='<%# Eval("class") %> + inline'>
                                                <%# Eval("text") %>
                                                <asp:LinkButton ID="btnNote" runat="server" Visible='<%# Eval("hasNote") %>' PostBackUrl='<%# "EventDetails.aspx?idEvent="+Eval ("id") %>'>Note</asp:LinkButton>
                                                <asp:Button ID="btnSeen" runat="server" Text="Read" Visible='<%# Eval("NotSeen") %>' CommandArgument='<%# Eval("id") %>' CommandName="chkid" OnClick="btnSeen_Click" CssClass="pull-right  btn btn-info"  />
                                                <span class="pull-right text-muted small"><em><%# Eval("datetime") %>   &nbsp&nbsp&nbsp </em>
                                                </span>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <div runat="server" id="itemPlaceholderContainer" style="font-family: Verdana, Arial, Helvetica, sans-serif;"><span runat="server" id="itemPlaceholder" /></div>

                                    <asp:DataPager runat="server" ID="ContactsDataPager" PageSize="10" PagedControlID="lstLogger">
                                        <Fields>
                                            <asp:TemplatePagerField>
                                                <PagerTemplate>
                                                    <b>Page
            <asp:Label runat="server" ID="CurrentPageLabel" Text="<%# Container.TotalRowCount>0 ? (Container.StartRowIndex / Container.PageSize) + 1 : 0 %>  " />

                                                        <asp:Label runat="server" ID="TotalPagesLabel" Text="<%# Math.Ceiling ((double)Container.TotalRowCount / Container.PageSize) %>" />
                                                        (
            <asp:Label runat="server" ID="TotalItemsLabel" Text="<%# Container.TotalRowCount%>" />
                                                        records)
            <br />
                                                    </b>
                                                </PagerTemplate>
                                            </asp:TemplatePagerField>
                                            <asp:NextPreviousPagerField ButtonType="Button" FirstPageText="First" ShowFirstPageButton="true" ShowNextPageButton="false" ShowPreviousPageButton="false" />
                                            <asp:NumericPagerField PreviousPageText="&lt; Prev 10" NextPageText="Next 10 &gt;" ButtonCount="10" />
                                            <asp:NextPreviousPagerField ButtonType="Button" LastPageText="Last" ShowLastPageButton="true" ShowNextPageButton="false" ShowPreviousPageButton="false" />
                                        </Fields>
                                    </asp:DataPager>

                                </LayoutTemplate>

                            </asp:ListView>
                        </div>
                    </div>
                    <br />
                    <br />


                    <asp:SqlDataSource runat="server" ID="SqlDSUser" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [EventLogger] order by id desc"></asp:SqlDataSource>
                    <br />

                    <br />
                    <br />
                </div>
            </section>
        </div>
        <div class="col-md-4">
        </div>
    </div>
    <!-- /.row -->


</asp:Content>
