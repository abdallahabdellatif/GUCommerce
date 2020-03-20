<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addcc.aspx.cs" Inherits="Milestone3.addcc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add a credit card</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" runat="server" Text="Back to Home Page" OnClick="Button1_Click" /><br /><br />
        </div>
        <p>
            Credit card number
            <asp:TextBox ID="ccnumber" runat="server"></asp:TextBox>
        </p>
        <p>
            Expiry date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="expirydate" runat="server"></asp:TextBox>
        </p>
        <p>
            CVV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="cvv" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="addC" runat="server" Text="Add Credit" OnClick="addC_Click" />
        </p>
    </form>
</body>
</html>
