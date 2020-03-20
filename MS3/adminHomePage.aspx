<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminHomePage.aspx.cs" Inherits="WebApplicationMsAdmin.adminHomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Home</title>
    
</head>
<body>
    <form id="form1" runat="server">
       <div>
            <asp:Button ID="Button0" runat="server" Text="Logout" OnClick="Button0_Click" style="height: 26px" />
            <br /><br />
        </div>
        <div>
            <asp:Label ID="Label1" runat="server" Text="Admin Home Page"></asp:Label><br /><br />
        </div>
       
        <asp:Button ID="Button1" runat="server" Text="Activate Non-Active Vendors" OnClick="Button1_Click" Width="245px" /><br /><br />
        <asp:Button ID="Button2" runat="server" Text="Review All Orders" OnClick="Button2_Click" Width="246px" /><br /><br />
        <asp:Button ID="Button3" runat="server" Text="Update Order Status" OnClick="Button3_Click" Width="244px" /><br /><br />
        <asp:Button ID="Button4" runat="server" Text="Today's Deals" OnClick="Button4_Click" Width="243px" /><br /><br />
        <asp:Button ID="Button5" runat="server" Text="Add your mobile phone numbers" OnClick="Button5_Click" Width="241px" />
    </form>
</body>
</html>
