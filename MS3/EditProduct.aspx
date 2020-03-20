<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditProduct.aspx.cs" Inherits="MS3A.EditProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit a product</title>
    <style type="text/css">
        .auto-style1 {
            position: absolute;
            top: 26px;
            left: 13px;
            z-index: 1;
            width: 155px;
        }
        .auto-style2 {
            position: absolute;
            top: 101px;
            left: 10px;
            z-index: 1;
            height: 33px;
            width: 71px;
        }
        .auto-style3 {
            height: 47px;
            margin-top: 0px;
        }
        .auto-style6 {
            position: absolute;
            top: 101px;
            left: 163px;
            z-index: 1;
            height: 32px;
            width: 197px;
        }
        .auto-style10 {
            position: absolute;
            top: 100px;
            left: 418px;
            z-index: 1;
            height: 32px;
            width: 197px;
            right: 1216px;
        }
        .auto-style12 {
            position: absolute;
            top: 100px;
            left: 663px;
            z-index: 1;
            height: 32px;
            width: 197px;
            bottom: 254px;
        }
        .auto-style13 {
            position: absolute;
            top: 99px;
            left: 918px;
            z-index: 1;
            height: 32px;
            width: 197px;
        }
        .auto-style14 {
            position: absolute;
            top: 99px;
            left: 1176px;
            z-index: 1;
            height: 32px;
            width: 197px;
        }
        .auto-style16 {
            position: absolute;
            top: 66px;
            left: 208px;
            z-index: 1;
            width: 105px;
            right: 1526px;
        }
        .auto-style17 {
            position: absolute;
            top: 67px;
            left: 476px;
            z-index: 1;
            width: 83px;
        }
        .auto-style18 {
            position: absolute;
            top: 64px;
            left: 696px;
            z-index: 1;
        }
        .auto-style19 {
            position: absolute;
            top: 67px;
            left: 999px;
            z-index: 1;
            width: 86px;
        }
        .auto-style20 {
            position: absolute;
            top: 65px;
            left: 1255px;
            z-index: 1;
            width: 68px;
        }
        .auto-style21 {
            position: absolute;
            top: 170px;
            left: 198px;
            z-index: 1;
            width: 115px;
            height: 28px;
        }
        .auto-style22 {
            position: absolute;
            top: 165px;
            left: 16px;
            z-index: 1;
            width: 108px;
            height: 34px;
        }
        .auto-style23 {
            position: absolute;
            top: 227px;
            left: 14px;
            z-index: 1;
            width: 1787px;
            height: 103px;
            margin-top: 0px;
        }
    </style>
</head>
<body style="margin-top: 101px">
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" CssClass="auto-style1" Text="Edit Product"></asp:Label>
        <div class="auto-style3">
            <asp:Button ID="Button1" runat="server" CssClass="auto-style2" Text="Edit" OnClick="Edit" />
            <asp:Label ID="Label6" runat="server" CssClass="auto-style19" Text="Price" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label5" runat="server" CssClass="auto-style18" Text="Product description" Font-Bold="True"></asp:Label>
            <asp:TextBox ID="lbl_product_description" runat="server" CssClass="auto-style12"></asp:TextBox>
            <asp:TextBox ID="lbl_product_name" runat="server" CssClass="auto-style6"></asp:TextBox>
            <asp:TextBox ID="lbl_price" runat="server" CssClass="auto-style13"></asp:TextBox>
            <asp:TextBox ID="lbl_category" runat="server" CssClass="auto-style10"></asp:TextBox>
            <asp:TextBox ID="lbl_color" runat="server" CssClass="auto-style14"></asp:TextBox>

        </div>

        <asp:Label ID="Label4" runat="server" CssClass="auto-style17" Text="Category" Font-Bold="True"></asp:Label>
        <asp:Label ID="Label3" runat="server" CssClass="auto-style16" Text="Product name" Font-Bold="True"></asp:Label>
        <asp:Label ID="Label7" runat="server" CssClass="auto-style20" Text="Color" Font-Bold="True"></asp:Label>

        <asp:Button ID="Button2" runat="server" CssClass="auto-style21" Text="Return Home" OnClick="ReturnHome" />

        <asp:Button ID="Button3" runat="server" CssClass="auto-style22" Text="View Product" OnClick="ViewProduct" />

        <asp:Label ID="MyProducts" runat="server" CssClass="auto-style23" Text=""></asp:Label>

    </form>
</body>
</html>
