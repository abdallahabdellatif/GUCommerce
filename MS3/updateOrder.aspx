<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="updateOrder.aspx.cs" Inherits="WebApplicationMsAdmin.updateOrder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="Button3" runat="server" Text="Back to Home Page" OnClick="Button3_Click" /><br /><br />
        <asp:Label ID="Label1" runat="server" Text="Update Order Status to 'IN PROCESS'"></asp:Label><br /><br />
        <div>
            <asp:Label ID="Label2" runat="server" Text="Order Number:  "></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Update Status" />
        </div>
        <p>
            &nbsp;</p>
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Review Orders" />
    </form>
</body>
</html>
