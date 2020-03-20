<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cashPayment.aspx.cs" Inherits="MS3.cashPayment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cash Payment</title>
    <h1> Pay for an order in cash</h1>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button2" runat="server" Text="Back to Home Page" OnClick="Button2_Click" />
            <asp:Button ID="Button3" runat="server" Text="Back to My Orders" OnClick="Button3_Click" />
            <br />
            <b>Your Current Points :</b>
            <asp:TextBox ID="TextBox3" runat="server" Enabled="False" ReadOnly="True"></asp:TextBox>

        </div>

        <asp:Label ID="Label1" runat="server" Text="Order Number:"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label2" runat="server" Text="Amount to pay in cash:"></asp:Label>
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Pay Now" />
        </p>
    </form>
</body>
</html>
