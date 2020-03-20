<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="MS3.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome to GUCommerce</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1> GUCommerce</h1>
            <h3> Welcome to our site</h3>
            <h3> Developed by : Team 005</h3>
            <h4> Customer Part 1 Component : Abdallah Ragab<br />
             Customer Part 2 Component : Eslam Sabry<br />
             Admin Component : Khaled Elshabrawy<br />
             Vendor Component : Ahmed Alarousi</h4>
        </div>
        <hr />
        <div>

            <asp:Button ID="Button1" runat="server" Text="Enter the website" OnClick="Button1_Click" />

        </div>
        
    </form>
</body>
</html>
