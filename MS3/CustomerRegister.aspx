<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerRegister.aspx.cs" Inherits="Milestone3.CustomerRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register as a customer</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <p>
            Registration</p>
        <p>
            &nbsp;</p>
        <p>
            First name&nbsp;&nbsp;
            <asp:TextBox ID="fname" runat="server"></asp:TextBox>
        </p>
        <p>
            Last name&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="lname" runat="server"></asp:TextBox>
        </p>
        <p>
            Username&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
        </p>
        <p>
            Password&nbsp; &nbsp;
            <asp:TextBox ID="password" runat="server" TextMode="Password"></asp:TextBox>
        </p>
        <p>
            Email&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
            <asp:TextBox ID="email" runat="server"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="Register" runat="server" Text="Register" OnClick="Register_Click" />
            <asp:Button ID="BackLogin" runat="server" Text="Back to Login Page" OnClick="BackLogin_Click" />
        </p>
    </form>
</body>
</html>
