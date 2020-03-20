<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerMain.aspx.cs" Inherits="Milestone3.CustomerMain" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Customer Home</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" runat="server" Text="Logout" OnClick="Button1_Click" />
        </div>
        
        <h2>WELCOME TO GUCommerce </h2>
        <br />
        <asp:Button ID="viewCart" runat="server" Text="View My Cart" OnClick="viewCart_Click" />
        <asp:Button ID="viewWishlists" runat="server" OnClick="viewWishlists_Click" Text="View My Wishlists" />
        <p>
            <asp:Button ID="creditCards" runat="server" Text="Add new credit card" OnClick="creditCards_Click" />
        </p>
        <p>
            <asp:Button ID="createWishlist" runat="server" Text="Create a new wishlist" OnClick="createWishlist_Click" />
        </p>
        <p>
            <asp:Button ID="viewOrders" runat="server" Text="View My Orders" OnClick="viewOrders_Click" />
        </p>
        <h4>
            Add/remove to/from cart</h4>
    <asp:Label ID="Label1" runat="server" Text="Serial no of desired product:"></asp:Label>
        <asp:TextBox ID="productserialC" runat="server"></asp:TextBox>
        <asp:Button ID="adsToCart" runat="server" Text="Add to cart" OnClick="adsToCart_Click" />
        <asp:Button ID="removefromcart" runat="server" Text="Remove from cart" OnClick="removefromcart_Click" />
        <br />
        <br />
        <h4>Adding/removing to/from wishlist</h4>
    <asp:Label ID="Label2" runat="server" Text="Serial no of desired product:"></asp:Label>
        <asp:TextBox ID="productserialW" runat="server"></asp:TextBox>
        <br />
        <br />
        <h4>Specify the wishlist name to add the product to: </h4>
        <asp:TextBox ID="wishname" runat="server"></asp:TextBox><asp:Button ID="addToWishlist" runat="server" Text="Add to wishlist" OnClick="addToWishlist_Click" />
         <asp:Button ID="removefromwish" runat="server" Text="Remove from wishlist" OnClick="removefromwish_Click" />
        <br /> <br />
        <asp:Button ID="Button5" runat="server" Text="Add your mobile phone numbers" OnClick="Button5_Click" Width="241px" />
        <br />
        <br />
        <h3>Available products: </h3>
        
        </form>
    </body>
</html>
