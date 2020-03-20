using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace WebApplicationMsAdmin
{
    public partial class reviewOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx", true);
            }
            else
            {
                string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand cmd = new SqlCommand("reviewOrders", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                conn.Open();
                SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                int i = 1;
                while (rdr.Read())
                {
                    int orderNo = rdr.GetInt32(rdr.GetOrdinal("order_no"));
                    DateTime orderDate = rdr.GetDateTime(rdr.GetOrdinal("order_date"));
                    decimal totalAmo = rdr.IsDBNull(2) ? -1 : rdr.GetDecimal(rdr.GetOrdinal("total_amount"));
                    decimal cashAmo = rdr.IsDBNull(3) ? 0 : rdr.GetDecimal(rdr.GetOrdinal("cash_amount"));
                    decimal creditAmo = rdr.IsDBNull(4) ? 0 : rdr.GetDecimal(rdr.GetOrdinal("credit_amount"));
                    string paymentType = rdr.IsDBNull(5) ? "N/A" : rdr.GetString(rdr.GetOrdinal("payment_type"));
                    string orderStatus = rdr.IsDBNull(6) ? "N/A" : rdr.GetString(rdr.GetOrdinal("order_status"));
                    int remDays = rdr.IsDBNull(7) ? -1 : rdr.GetInt32(rdr.GetOrdinal("remaining_days"));
                    string timeLimit = rdr.IsDBNull(8) ? "N/A" : rdr.GetString(rdr.GetOrdinal("time_limit"));
                    string GiftCCU = rdr.IsDBNull(9) ? "N/A" : rdr.GetString(rdr.GetOrdinal("Gift_Card_code_used"));
                    string customerName = rdr.IsDBNull(10) ? "N/A" : rdr.GetString(rdr.GetOrdinal("customer_name"));
                    int deliveryId = rdr.IsDBNull(11) ? -1 : rdr.GetInt32(rdr.GetOrdinal("delivery_id"));
                    string ccn = rdr.IsDBNull(12) ? "N/A" : rdr.GetString(rdr.GetOrdinal("creditCard_number"));


                    Label o1 = new Label();
                    o1.Text = i + ":- Order Number: " + orderNo;
                    form1.Controls.Add(o1);
                    Label o2 = new Label();
                    o2.Text = "<br> Order Date: " + orderDate;
                    form1.Controls.Add(o2);
                    Label o3 = new Label();
                    o3.Text = "<br> Total Amount: " + totalAmo;
                    form1.Controls.Add(o3);
                    Label o4 = new Label();
                    o4.Text = "<br> Cash Amount: " + cashAmo;
                    form1.Controls.Add(o4);
                    Label o5 = new Label();
                    o5.Text = "<br> Credit Amount: " + creditAmo;
                    form1.Controls.Add(o5);
                    Label o6 = new Label();
                    o6.Text = "<br> Payment Type: " + paymentType;
                    form1.Controls.Add(o6);
                    Label o7 = new Label();
                    o7.Text = "<br> Order Status: " + orderStatus;
                    form1.Controls.Add(o7);
                    Label o8 = new Label();
                    o8.Text = "<br> Remaining Days: " + remDays;
                    form1.Controls.Add(o8);
                    Label o9 = new Label();
                    o9.Text = "<br> Time Limit: " + timeLimit;
                    form1.Controls.Add(o9);
                    Label o10 = new Label();
                    o10.Text = "<br>Used Giftcard Code: " + GiftCCU;
                    form1.Controls.Add(o10);
                    Label o11 = new Label();
                    o11.Text = "<br> Customer Name: " + customerName;
                    form1.Controls.Add(o11);
                    Label o12 = new Label();
                    o12.Text = "<br> Delivery ID: " + deliveryId;
                    form1.Controls.Add(o12);
                    Label o13 = new Label();
                    o13.Text = "<br> Credit Card Number: " + ccn + "<br /><br />";
                    form1.Controls.Add(o13);

                    i++;
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminHomePage.aspx", true);
        }
    }
}