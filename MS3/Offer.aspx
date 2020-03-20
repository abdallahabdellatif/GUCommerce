<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Offer.aspx.cs" Inherits="MS3A.Offer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Offer</title>
    <style type="text/css">
        .auto-style1 {
            position: absolute;
            top: 122px;
            left: 6px;
            z-index: 1;
            width: 81px;
            height: 34px;
        }
        .auto-style2 {
            position: absolute;
            top: 125px;
            left: 113px;
            z-index: 1;
            height: 25px;
        }
        .auto-style3 {
            position: absolute;
            left: 272px;
            z-index: 1;
            height: 23px;
            margin-top: 2px;
            top: 123px;
        }
        .auto-style4 {
            position: absolute;
            top: 92px;
            left: 132px;
            z-index: 1;
            right: 1535px;
        }
        .auto-style5 {
            position: absolute;
            top: 91px;
            left: 293px;
            z-index: 1;
        }
        .auto-style6 {
            position: absolute;
            top: 122px;
            left: 435px;
            z-index: 1;
            width: 301px;
        }
        .auto-style7 {
            position: absolute;
            top: 199px;
            left: 7px;
            z-index: 1;
            width: 74px;
            height: 30px;
            right: 1529px;
        }
        .auto-style8 {
            position: absolute;
            top: 198px;
            left: 105px;
            z-index: 1;
            height: 29px;
            }
        .auto-style9 {
            position: absolute;
            top: 198px;
            left: 265px;
            z-index: 1;
            height: 29px;
            width: 133px;
        }
        .auto-style10 {
            position: absolute;
            top: 162px;
            left: 138px;
            z-index: 1;
            width: 84px;
        }
        .auto-style11 {
            position: absolute;
            top: 167px;
            left: 273px;
            z-index: 1;
            width: 135px;
        }
        .auto-style12 {
            position: absolute;
            top: 278px;
            left: 6px;
            z-index: 1;
            width: 173px;
        }
        .auto-style13 {
            position: absolute;
            top: 284px;
            left: 207px;
            z-index: 1;
        }
        .auto-style14 {
            position: absolute;
            top: 249px;
            left: 246px;
            z-index: 1;
        }
        .auto-style15 {
            position: absolute;
            top: 350px;
            left: 8px;
            z-index: 1;
            width: 105px;
        }
        .auto-style16 {
            position: absolute;
            top: 384px;
            left: 12px;
            z-index: 1;
            width: 1580px;
            height: 322px;
        }
        .auto-style17 {
            position: absolute;
            top: 351px;
            left: 158px;
            z-index: 1;
            width: 134px;
        }
        .auto-style18 {
            position: absolute;
            top: 352px;
            left: 331px;
            z-index: 1;
            width: 140px;
        }
        .auto-style19 {
            position: absolute;
            top: 61px;
            left: 828px;
            z-index: 1;
            height: 34px;
            width: 118px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-family: 'Arial Black'; font-size: x-large; background-color: #00FFFF;">
            Offer page
        </div>
        <asp:Label ID="Label1" runat="server" CssClass="auto-style4" Text="Offer amount" Font-Bold="True"></asp:Label>
        <asp:Label ID="Label2" runat="server" CssClass="auto-style5" Text="ExpiryDate" Font-Bold="True"></asp:Label>
        <asp:Button ID="Button1" runat="server" CssClass="auto-style1" Text="Add offer" OnClick="Addoffer" />
        <asp:TextBox ID="lbl_offerID" runat="server" CssClass="auto-style2"></asp:TextBox>
        <asp:TextBox ID="lbl_expiry" runat="server" CssClass="auto-style3"></asp:TextBox>
        <asp:Label ID="Label3" runat="server" CssClass="auto-style6" Text="Date must be in this format yyyy-mm-dd" Font-Bold="True"></asp:Label>
        <asp:Button ID="Button2" runat="server" CssClass="auto-style7" Text="Apply offer" OnClick="ApplyOffer" />
        <asp:TextBox ID="lbl_Offerid2" runat="server" CssClass="auto-style8"></asp:TextBox>
        <asp:TextBox ID="lbl_productSNO" runat="server" CssClass="auto-style9"></asp:TextBox>
        <asp:Label ID="Label4" runat="server" CssClass="auto-style10" Text="Offer id" Font-Bold="True"></asp:Label>
        <asp:Label ID="Label5" runat="server" CssClass="auto-style11" Text="Product serialNO" Font-Bold="True"></asp:Label>
        <asp:Button ID="Button3" runat="server" CssClass="auto-style12" Text="Remove Expired Offer" OnClick="RemoveExpired" />
        <asp:TextBox ID="lbl_expiredOffer" runat="server" CssClass="auto-style13"></asp:TextBox>
        <asp:Label ID="Label6" runat="server" CssClass="auto-style14" Text="Offer ID" Font-Bold="True"></asp:Label>
        <asp:Button ID="Button4" runat="server" CssClass="auto-style15" Text="Show offers" OnClick="ShowOffers" />
        <asp:Label ID="Label7" runat="server" CssClass="auto-style16" Text=""></asp:Label>
        <asp:Button ID="Button5" runat="server" CssClass="auto-style17" Text="ShowActiveOffers" OnClick="ShowActiveOffers" />
        <asp:Button ID="Button6" runat="server" CssClass="auto-style18" Text="MyProducts" OnClick="ShowMyProducts" />
        <asp:Button ID="Button7" runat="server" CssClass="auto-style19" Text="Return Home" BackColor="#FF3300" BorderColor="#33CC33" OnClick="ReturnHome" />
    </form>
</body>
</html>
