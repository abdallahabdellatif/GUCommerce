<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Milestone3.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login to GUCommerce</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        username<br />
        <asp:TextBox ID="tusername" runat="server"></asp:TextBox>
        <br />
        password<p>
            <asp:TextBox ID="tpassword" runat="server" TextMode="Password"></asp:TextBox>
        </p>
        <asp:Button ID="login" runat="server" Text="Login" OnClick="login_Click" />
        <br />
        <p>
            Don&#39;t have an account? register as,</p>
        <asp:Button ID="Customer" runat="server" Text="Customer" OnClick="Customer_Click" />
        <asp:Button ID="Vendor" runat="server" Text="Vendor" OnClick="Vendor_Click" />
    </form>
</body>
</html>
