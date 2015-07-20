<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventDetails.aspx.cs" Inherits="AppLabRedes.Admin.EventDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    

    <h2><%: Title %></h2>
    <!-- /.row -->


    <div class="row">
        <div class="col-md-12">
            <section>
                <div class="form-horizontal">
                    <h4>Details</h4>
                    <hr />
                    <p class="text-danger">
                        <asp:Literal runat="server" ID="txtOutput" />
                    </p>


                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>

                    <asp:FormView ID="FormView1" DataKeyNames="Id" runat="server" DataSourceID="SqlDSUser">
                        <ItemTemplate>
                            <div class="col-md-9">
                                <label>Date</label>
                                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" Text='<%#Eval("datetime")%>' ReadOnly="true"> </asp:TextBox>
                            </div>
                            <div class="col-md-9">
                                <asp:HiddenField ID="hddID" runat="server" Value='<%#Eval("id")%>' />
                                <label>Text</label>
                                <asp:TextBox ID="txtUsername" runat="server"  Width="400" CssClass="form-control" Text='<%#Eval("text")%>' ReadOnly="true"> </asp:TextBox>
                            </div>
                            <div class="col-md-9">
                                <label>Note</label>
                                <asp:TextBox ID="txtEndsIn" runat="server" TextMode="MultiLine" Width="800" Height="400" CssClass="form-control" Text='<%#Eval("note")%>' ReadOnly="true"></asp:TextBox>
                            </div>


                        </ItemTemplate>
                    </asp:FormView>

                </div>
                <br />
                <br />


                <asp:SqlDataSource runat="server" ID="SqlDSUser" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT * FROM [EventLogger] WHERE ([id] = @id)">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="0" Name="Id" QueryStringField="idEvent" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />

                <br />
                <br />
            </section>
        </div>
        <div class="col-md-4">
        </div>
    </div>
    <!-- /.row -->
</asp:Content>
