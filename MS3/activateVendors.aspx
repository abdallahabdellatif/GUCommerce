<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activateVendors.aspx.cs" Inherits="WebApplicationMsAdmin.activateVendors" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Activating Vendors</title>
    </head>
<body>
    <p>
        &nbsp;<form id="form1" runat="server">
       
        <asp:Button ID="Button3" runat="server" Text="Back to Home Page" OnClick="Button3_Click" /><br /><br />
       
        <asp:Label ID="Label3" runat="server" Text="Activate Vendor:  "></asp:Label>
       
    </p>
    

    <p>
        <asp:label id="label2" runat="server" text="Vendor Username:  "></asp:label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        </p>
    <p>
        <asp:Button ID="Button1" runat="server" Text="Activate Vendor" OnClick="Button1_Click" /><br /><br />
            </p>
        <asp:Button ID="Button2" runat="server" Text="Unactivated Vendors" OnClick="Button2_Click" />
    </form>
       
    </body>
</html>
