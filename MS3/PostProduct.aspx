<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PostProduct.aspx.cs" Inherits="MS3A.PostProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            position: absolute;
            top: 81px;
            left: 4px;
            z-index: 1;
            width: 96px;
            height: 28px;
        }
        .auto-style2 {
            position: absolute;
            top: 80px;
            left: 117px;
            z-index: 1;
        }
        .auto-style3 {
            position: absolute;
            top: 80px;
            left: 274px;
            z-index: 1;
        }
        .auto-style4 {
            position: absolute;
            top: 80px;
            left: 431px;
            z-index: 1;
            margin-top: 0px;
        }
        .auto-style5 {
            position: absolute;
            top: 79px;
            left: 591px;
            z-index: 1;
        }
        .auto-style6 {
            position: absolute;
            top: 80px;
            left: 751px;
            z-index: 1;
        }
        .auto-style9 {
            position: absolute;
            top: 50px;
            left: 132px;
            z-index: 1;
            width: 101px;
        }
        .auto-style11 {
            position: absolute;
            top: 49px;
            left: 303px;
            z-index: 1;
            width: 67px;
        }
        .auto-style12 {
            position: absolute;
            top: 50px;
            left: 429px;
            z-index: 1;
            width: 145px;
        }
        .auto-style13 {
            position: absolute;
            top: 47px;
            left: 631px;
            z-index: 1;
            width: 52px;
            right: 1156px;
        }
        .auto-style14 {
            position: absolute;
            top: 48px;
            left: 793px;
            z-index: 1;
            width: 51px;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Button ID="Button1" runat="server" CssClass="auto-style1" Text="Post Product" OnClick="postProduct" />
        <asp:TextBox ID="TextBox1" runat="server" CssClass="auto-style2"></asp:TextBox>
        <asp:TextBox ID="TextBox2" runat="server" CssClass="auto-style3"></asp:TextBox>
        <asp:TextBox ID="TextBox3" runat="server" CssClass="auto-style4"></asp:TextBox>
        <asp:TextBox ID="TextBox4" runat="server" CssClass="auto-style5"></asp:TextBox>
        <asp:TextBox ID="TextBox5" runat="server" CssClass="auto-style6"></asp:TextBox>
            <asp:Label ID="Label3" runat="server" CssClass="auto-style11" Text="Category" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label4" runat="server" CssClass="auto-style12" Text="Product description" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label5" runat="server" CssClass="auto-style13" Text="Price" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label6" runat="server" CssClass="auto-style14" Text="Color" Font-Bold="True"></asp:Label>
        <p>
            <asp:Label ID="Label1" runat="server" CssClass="auto-style9" Text="Product name" Font-Bold="True"></asp:Label>
            </p>
    </form>
</body>
</html>
