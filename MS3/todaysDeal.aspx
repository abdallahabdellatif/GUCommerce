<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="todaysDeal.aspx.cs" Inherits="WebApplicationMsAdmin.todaysDeal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Today's Deals</title>
    <style type="text/css">
        .auto-style1 {
            height: 312px;
        }
        .auto-style2 {
            width: 718px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="auto-style1">
        <div>
            <asp:Button ID="Button6" runat="server" Text="Back to Home Page" OnClick="Button6_Click" /><br /><br />
            <asp:Label ID="Label1" runat="server" Text="Create a Today's Deal"></asp:Label>
        </div>
        <asp:Label ID="Label2" runat="server" Text="Deals Amount:  "></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Label ID="Label3" runat="server" Text="Expire Date:   "></asp:Label>
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        <asp:Label ID="Label4" runat="server" Text="Date must be in this format yyyy-mm-dd   "></asp:Label>
        <asp:Button ID="Button1" runat="server" Text="Create" OnClick="Button1_Click" />
        <br /><br /><br />
        <asp:Label ID="Label5" runat="server" Text="Add Today's Deal on a Product"></asp:Label>
         <br />
        <asp:Label ID="Label6" runat="server" Text="Product Serial Number:  "></asp:Label>
        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
        <asp:Label ID="Label7" runat="server" Text="Deal Number:  "></asp:Label>
        <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
        <asp:Button ID="Button2" runat="server" Text="Add Deal" OnClick="Button2_Click" />
        <br /><br /><br />
        <asp:Label ID="Label8" runat="server" Text="Remove Expired Deals"></asp:Label>
        <br />
        <asp:Label ID="Label9" runat="server" Text="Deal Number:  "></asp:Label>
        <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
        <asp:Button ID="Button3" runat="server" Text="Remove Deal" OnClick="Button3_Click" />
        <br /><br /><br />
        <asp:Button ID="Button4" runat="server" Text="Show All Products" OnClick="Button4_Click" />
        <asp:Button ID="Button5" runat="server" Text="Show All Deals" OnClick="Button5_Click" />
        <br /><br />
    </form>
</body>
</html>
