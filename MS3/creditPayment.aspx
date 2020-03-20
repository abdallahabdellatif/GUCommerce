<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="creditPayment.aspx.cs" Inherits="MS3.creditPayment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Credit Payment</title>
    <h1> Pay for an order by a credit card</h1>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button3" runat="server" Text="Back to My Orders" OnClick="Button3_Click" />
            <br /><br />
            <b>Your Current Points :</b>
            <asp:TextBox ID="TextBox3" runat="server" Enabled="False" ReadOnly="True"></asp:TextBox>

        </div>

        <asp:Label ID="Label1" runat="server" Text="Order Number:"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label2" runat="server" Text="Amount to pay:"></asp:Label>
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Text="Choose a credit card:"></asp:Label>
        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="cc_number" DataValueField="cc_number" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
            </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=i\sqlexpress;Initial Catalog=ms3;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [cc_number] FROM [Customer_CreditCard] WHERE ([customer_name] = @customer_name)">
            <SelectParameters>
                <asp:SessionParameter Name="customer_name" SessionField="username" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br /><br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Pay Now" />
        
        
    </form>
</body>
</html>
