using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MS3
{
    public partial class myOrders : System.Web.UI.Page
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

                SqlCommand cmd = new SqlCommand("viewOrders", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@username", Session["username"].ToString()));
                conn.Open();
                SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr.Read())
                {
                    int num = rdr.GetInt32(rdr.GetOrdinal("order_no"));
                    DateTime date = rdr.GetDateTime(rdr.GetOrdinal("order_date"));
                    decimal tot = rdr.GetDecimal(rdr.GetOrdinal("total_amount"));
                    string type = rdr.IsDBNull(5) ? "Not yet" : rdr.GetString(rdr.GetOrdinal("payment_type"));
                    string status = rdr.GetString(rdr.GetOrdinal("order_status"));


                    Label lbl_status = new Label();
                    lbl_status.Text = "Order Num:" + num + "<br>Date: " + date + "<br>Total Amount: " + tot + "<br>Payment Type: " + type + "<br>Status: " + status ;
                    if (type == "credit")
                    {
                        string creditcardused = rdr.IsDBNull(12)? "N/A" : ( rdr.GetString(rdr.GetOrdinal("creditCard_number")));
                        lbl_status.Text = lbl_status.Text +"<br> Credit Card Used:" +creditcardused+ "<br /> <br />";
                    }
                    else
                    {
                        lbl_status.Text = lbl_status.Text + "<br /> <br />";
                    }
                    form1.Controls.Add(lbl_status);

                }
                conn.Close();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerMain.aspx", true);
        }

        protected void cancelOrder_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string sorderid = orderNumberText.Text;
            int orderid;
            if (!Int32.TryParse(sorderid, out orderid))
            {
                Response.Write("Order Number must be a number");
            }
            else
            {
                SqlCommand tmp = new SqlCommand("orderBelong", conn);
                tmp.CommandType = CommandType.StoredProcedure;
                tmp.Parameters.Add(new SqlParameter("@username", Session["username"].ToString()));
                tmp.Parameters.Add(new SqlParameter("@orderid", orderid));
                SqlParameter belong = tmp.Parameters.Add("@belong", SqlDbType.Int);
                belong.Direction = ParameterDirection.Output;
                conn.Open();
                tmp.ExecuteNonQuery();
                conn.Close();
                if (belong.Value.ToString() == "0")
                {
                    Response.Write("You do not have a running order with this number!");
                }
                else
                {
                    SqlCommand cmd = new SqlCommand("cancelOrder", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@orderid", sorderid));
                    SqlParameter canceled = cmd.Parameters.Add("@canceled", SqlDbType.Int);
                    canceled.Direction = ParameterDirection.Output;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    if (canceled.Value.ToString() == "1")
                    {
                        Response.Write("Order has been canceled successfully");
                    }
                    else
                    {
                        Response.Write("This order couldn't be canceled !");
                    }
                }
            }
        }

        protected void RadioButtonList2_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            if (RadioButtonList2.SelectedValue == "Cash")
            {
                Response.Redirect("cashPayment.aspx", true);
            }
            else if (RadioButtonList2.SelectedValue == "Credit")
            {
                Response.Redirect("creditPayment.aspx", true);

            }
            else
            {
                Response.Write("You should select one payment method to be able to pay");
            }
        }
    }
}