<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyProducts.aspx.cs" Inherits="MS3A.MyProducts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            position: absolute;
            top: 18px;
            left: 19px;
            z-index: 1;
            width: 136px;
        }
        .auto-style2 {
            position: absolute;
            top: 27px;
            left: 256px;
            z-index: 1;
            width: 87px;
        }
    </style>
</head>
<body style="margin-top: 78px">
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" CssClass="auto-style1" Text="My Products" Font-Bold="True" Font-Size="X-Large"></asp:Label>
        <asp:Button ID="Button1" runat="server" CssClass="auto-style2" Text="Go Back" BackColor="#0099CC" BorderColor="#00CCFF" OnClick="ReturnHome" />
        <div>
        </div>
    </form>
</body>
</html>
