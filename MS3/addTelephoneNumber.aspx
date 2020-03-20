<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addTelephoneNumber.aspx.cs" Inherits="WebApplicationMsAdmin.addTelephoneNumber" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add a phone</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" runat="server" Text="Back to Home Page" OnClick="Button1_Click" /><br /><br />
        </div>
        <asp:Label ID="Label1" runat="server" Text="Add Telephone Number"></asp:Label><br />
        <asp:Label ID="Label2" runat="server" Text="Number:  "></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server" Width="173px"></asp:TextBox>
        <asp:Button ID="Button2" runat="server" Text="Add Number" OnClick="Button2_Click" />
    </form>
</body>
</html>
