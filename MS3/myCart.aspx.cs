using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class myCart : System.Web.UI.Page
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
                // string username = (string)(Session["username"]);
                conn.Open();
                SqlCommand cmd = new SqlCommand("viewMyCart", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@customer", Session["username"].ToString()));


                SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr.Read())
                {
                    string pname = rdr.GetString(rdr.GetOrdinal("product_name"));
                    string pdesc = rdr.GetString(rdr.GetOrdinal("product_description"));
                    decimal price = rdr.GetDecimal(rdr.GetOrdinal("price"));
                    decimal finalprice = rdr.GetDecimal(rdr.GetOrdinal("final_price"));
                    string color = rdr.GetString(rdr.GetOrdinal("color"));



                    Label lbl_pname = new Label();
                    lbl_pname.Text = "Name:" + pname;
                    form1.Controls.Add(lbl_pname);

                    Label lbl_pdesc = new Label();
                    lbl_pdesc.Text = ",describtion:" + pdesc;
                    form1.Controls.Add(lbl_pdesc);

                    Label lbl_price = new Label();
                    lbl_price.Text = ",price:" + price;
                    form1.Controls.Add(lbl_price);

                    Label lbl_final_price = new Label();
                    lbl_final_price.Text = ",final price:" + finalprice;
                    form1.Controls.Add(lbl_final_price);

                    Label lbl_color = new Label();
                    lbl_color.Text = ",color:" + color + "  <br /> <br />";
                    form1.Controls.Add(lbl_color);
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            // string username = (string)(Session["username"]);
            conn.Open();
            SqlCommand cmd1 = new SqlCommand("isCartEmpty", conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.Add(new SqlParameter("@customername", Session["username"].ToString()));
            SqlParameter empty = cmd1.Parameters.Add("@EMPTY", SqlDbType.Int);
            empty.Direction = ParameterDirection.Output;
            cmd1.ExecuteNonQuery();
            conn.Close();

            if (empty.Value.ToString() == "1")
            {
                Response.Write("You cannot make an order with an empty cart ! Add some products to cart.");
            }
            else
            {
                if (empty.Value.ToString() == "0") {
                    SqlCommand cmd = new SqlCommand("makeOrder", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@customername", Session["username"].ToString()));
                    SqlParameter ordernum = cmd.Parameters.Add("@ordernum", SqlDbType.Int);
                    ordernum.Direction = ParameterDirection.Output;
                    SqlParameter amo = cmd.Parameters.Add("@amo", SqlDbType.Decimal);
                    amo.Direction = ParameterDirection.Output;

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    form1.Controls.Clear();
                    Response.Write("Congratulations! Order has been placed.");
                    Response.Write("Your order number is: ");
                    Response.Write(ordernum.Value);
                    Response.Write(", total amount= ");
                    Response.Write(amo.Value);
                }
            }
        }
       
    }
}