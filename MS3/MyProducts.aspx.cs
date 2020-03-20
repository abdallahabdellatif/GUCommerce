using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace MS3A
{
    public partial class MyProducts : System.Web.UI.Page
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
                SqlCommand cmd = new SqlCommand("vendorviewProducts", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                conn.Open();
                string user = (string)(Session["username"]).ToString();
                cmd.Parameters.Add(new SqlParameter("@vendorname", user));
                SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr.Read())
                {

                    int serial_no = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                    string product_name = rdr.IsDBNull(2) ? "N/A" : rdr.GetString(rdr.GetOrdinal("product_name"));
                    string category = rdr.IsDBNull(3) ? "N/A" : rdr.GetString(rdr.GetOrdinal("category"));
                    string product_description = rdr.IsDBNull(4) ? "N/A" : rdr.GetString(rdr.GetOrdinal("product_description"));
                    decimal price = rdr.IsDBNull(5) ? -1 : rdr.GetDecimal(rdr.GetOrdinal("price"));
                    decimal final_price = rdr.IsDBNull(6) ? -1 : rdr.GetDecimal(rdr.GetOrdinal("final_price"));
                    string color = rdr.IsDBNull(7) ? "N/A" : rdr.GetString(rdr.GetOrdinal("color"));
                    bool available = rdr.GetBoolean(rdr.GetOrdinal("available"));
                    int rate = rdr.IsDBNull(8) ? -1 : rdr.GetInt32(rdr.GetOrdinal("rate"));
                    string vendor_username = rdr.IsDBNull(9) ? "N/A" : rdr.GetString(rdr.GetOrdinal("vendor_username"));
                    string customer_username = rdr.IsDBNull(10) ? "N/A" : rdr.GetString(rdr.GetOrdinal("customer_username"));
                    int customer_order_id = rdr.IsDBNull(11) ? -1 : rdr.GetInt32(rdr.GetOrdinal("customer_order_id"));

                    Label lbl_serial_no = new Label();
                    lbl_serial_no.Text = "SerialNo: " + serial_no + ", ";
                    form1.Controls.Add(lbl_serial_no);

                    Label lbl_product_name = new Label();
                    lbl_product_name.Text = "PName: " + product_name + ", ";
                    form1.Controls.Add(lbl_product_name);

                    Label lbl_category = new Label();
                    lbl_category.Text = "Category: " + category + ", ";
                    form1.Controls.Add(lbl_category);

                    Label lbl_product_description = new Label();
                    lbl_product_description.Text = "Description: " + product_description + ", ";
                    form1.Controls.Add(lbl_product_description);

                    Label lbl_price = new Label();
                    lbl_price.Text = "Price: " + price + ", ";
                    form1.Controls.Add(lbl_price);

                    Label lbl_final_price = new Label();
                    lbl_final_price.Text = "FinalPrice: " + final_price + ", ";
                    form1.Controls.Add(lbl_final_price);

                    Label lbl_color = new Label();
                    lbl_color.Text = "Color: " + color + ", ";
                    form1.Controls.Add(lbl_color);

                    Label lbl_available = new Label();
                    lbl_available.Text = "Availability: " + available + ", ";
                    form1.Controls.Add(lbl_available);

                    Label lbl_rate = new Label();
                    lbl_rate.Text = "Rate: " + rate + ", ";
                    form1.Controls.Add(lbl_rate);

                    Label lbl_vendor_username = new Label();
                    lbl_vendor_username.Text = "VendorUserName: " + vendor_username + ", ";
                    form1.Controls.Add(lbl_vendor_username);

                    Label lbl_customer_username = new Label();
                    lbl_customer_username.Text = "CustomerUserName: " + customer_username + ", ";
                    form1.Controls.Add(lbl_customer_username);

                    Label lbl_customer_order_id = new Label();
                    lbl_customer_order_id.Text = "CustomerOrderID: " + customer_order_id + "<br />" + "<br />";
                    form1.Controls.Add(lbl_customer_order_id);
                }
            }
        }

        protected void ReturnHome(object sender, EventArgs e)
        {
            Response.Redirect("VendorMain.aspx");
        }
    }
}