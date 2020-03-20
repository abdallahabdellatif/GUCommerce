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
    public partial class cashPayment : System.Web.UI.Page
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

                SqlCommand cmd = new SqlCommand("getPoints", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@username", (string)(Session["username"])));
                SqlParameter points = cmd.Parameters.Add("@points", SqlDbType.Int);
                points.Direction = ParameterDirection.Output;
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                TextBox3.Text = "" + points.Value;
                //TextBox3
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            string oid = TextBox1.Text;
            string amnt = TextBox2.Text;
            int orderID; decimal amount;
            if (!Int32.TryParse(oid, out orderID ))
            {
                Response.Write("Order ID must be a number");
            }
            else
            {
                if (!Decimal.TryParse(amnt, out amount))
                {
                    Response.Write("Cash amount must be a decimal");
                }
                else
                {
                    SqlCommand cmd = new SqlCommand("specifyAmount", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@customername", (string)(Session["username"])));
                    cmd.Parameters.Add(new SqlParameter("@orderID", orderID));
                    cmd.Parameters.Add(new SqlParameter("@cash", amount));
                    decimal balabizo = 0;
                    cmd.Parameters.Add(new SqlParameter("@credit", balabizo));
                    decimal pnts;
                    Decimal.TryParse(TextBox1.Text, out pnts);
                    SqlParameter success = cmd.Parameters.Add("@done", SqlDbType.Int);
                    success.Direction = ParameterDirection.Output;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    if (success.Value.ToString () == "1")
                    {
                        Response.Write("Payment was specified successfully");
                    }
                    else
                    {
                        Response.Write("Couldn't pay! Either this amount is not enough or this order can not be paid!");
                    }
                }
            }


            
            
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerMain.aspx", true);
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("myOrders.aspx", true);
        }
    }
}