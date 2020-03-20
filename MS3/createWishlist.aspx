<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="createWishlist.aspx.cs" Inherits="Milestone3.createWishlist" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create a wishlist</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" runat="server" Text="Back to Home Page" OnClick="Button1_Click" /><br /><br />
        </div>
        Wishlist name:<p>
            <asp:TextBox ID="wishlistname" runat="server"></asp:TextBox>
        </p>
        <asp:Button ID="Addwishlist" runat="server" Text="Add" OnClick="Addwishlist_Click" />
    </form>
</body>
</html>
