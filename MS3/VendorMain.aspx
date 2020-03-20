<%@ Page Language = "C#" AutoEventWireup="true" CodeBehind="VendorMain.aspx.cs" Inherits="MS3A.VendorMain" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Vendor Home</title>
    <style type="text/css">
        .auto-style1 {
            margin-top: 45px;
        }
        .auto-style2 {
            margin-bottom: 8px;
            margin-top: 0px;
        }
        .auto-style16 {
            margin-top: 63px;
        }
        .auto-style17 {
            position: absolute;
            top: 336px;
            left: 8px;
            z-index: 1;
            width: 99px;
            height: 34px;
        }
        .auto-style18 {
            height: 65px;
            margin-top: 45px;
        }
        .auto-style19 {
            position: absolute;
            top: 340px;
            left: 128px;
            z-index: 1;
            height: 23px;
            right: 1583px;
            margin-top: 0px;
        }
        .auto-style20 {
            position: absolute;
            top: 302px;
            left: 128px;
            z-index: 1;
            margin-top: 0px;
        }
        .auto-style21 {
            position: absolute;
            top: 394px;
            left: 10px;
            z-index: 1;
            width: 93px;
            height: 32px;
        }
        .auto-style22 {
            position: absolute;
            top: 450px;
            left: 10px;
            z-index: 1;
            width: 137px;
            height: 35px;
        }
        </style>
</head>
<body>
    
    <form id="form1" runat="server">
            
        <p style="font-size: x-large; background-color: #00FFFF; font-family: 'Arial Black';">
            Welcome</p>
    
            
        <p >
            <asp:Button ID="Button1" runat="server" CssClass="auto-style1" Height="45px" Text="My Products" Width="87px" OnClick="MyProducts" />
        </p>
        <p class="auto-style16">
            <asp:Button ID="Button2" runat="server" Text="Post a new Product" CssClass="auto-style2" Height="40px" Width="234px" OnClick="PostProduct" />

        </p>
    
            
        <p class="auto-style18">
                    <asp:Button ID="Button3" runat="server" CssClass="auto-style17" Text="Edit Product" OnClick="EditProduct" />

                    <asp:TextBox ID="Snumber" runat="server" CssClass="auto-style19"></asp:TextBox>

                    <asp:Label ID="Label7" runat="server" CssClass="auto-style20" Text="Enter the serial number"></asp:Label>

        </p>
        <asp:Button ID="Button4" runat="server" CssClass="auto-style21" Text="Offer" OnClick="Offer" />
        <asp:Button ID="Button5" runat="server" CssClass="auto-style22" Text="Add Phone number" OnClick="AddPhone" />
        <div> 
            <br /> <br />  <br /> <br /> <br /><br /><br />
            <asp:Button ID="Button0" runat="server" Text="Logout" OnClick="Button0_Click" style="height: 26px" />

        </div>
    </form>
    
    
    
    
</body>
</html>
