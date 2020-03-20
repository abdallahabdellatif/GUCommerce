<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="myOrders.aspx.cs" Inherits="MS3.myOrders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Orders</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="Button1" runat="server" Text="Back to Home Page" OnClick="Button1_Click" />
        <br /><br />
        <div>
            <asp:Label ID="Label1" runat="server" Text="Enter Number of order:"></asp:Label>
        <asp:TextBox ID="orderNumberText" runat="server" ></asp:TextBox>
        <asp:Button ID="cancelOrder" runat="server" Text="Cancel Order" OnClick="cancelOrder_Click" />
        </div>
        <br />
        <div>
        <h4>Pay for An Order</h4>
        <asp:RadioButtonList ID="RadioButtonList2" runat="server" OnSelectedIndexChanged="RadioButtonList2_SelectedIndexChanged">
            <asp:ListItem>Cash</asp:ListItem>
            <asp:ListItem>Credit</asp:ListItem>
        </asp:RadioButtonList>
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Pay" />

    </div>
</body>
    </form>
</html>
