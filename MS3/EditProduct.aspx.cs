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
    public partial class EditProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx", true);
            }
        }

        protected void Edit(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("EditProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string user = (string)(Session["username"]).ToString();
            int serialNumber = (int)Session["serialnumber"];
            string product_name = lbl_product_name.Text;
            string category = lbl_category.Text;
            string product_description = lbl_product_description.Text;
            string price = lbl_price.Text;
            string color = lbl_color.Text;
            Decimal price1;



            if (product_name.Length == 0 || category.Length == 0 || product_description.Length == 0 || color.Length == 0)
            {
                Response.Write("<span id='Label1' style='height:16px;width:120px;Z-INDEX: 102; LEFT: 288px; POSITION: absolute; TOP: 144px'>Please fill all the Data</span>");

            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@vendorname", user));
                cmd.Parameters.Add(new SqlParameter("@serialnumber", serialNumber));
                cmd.Parameters.Add(new SqlParameter("@product_name", product_name));
                cmd.Parameters.Add(new SqlParameter("@category", category));
                cmd.Parameters.Add(new SqlParameter("@product_description", product_description));
                cmd.Parameters.Add(new SqlParameter("@color", color));
                if (!Decimal.TryParse(price, out price1))
                {
                    Response.Write("<span id='Label1' style='height:16px;width:120px;Z-INDEX: 102; LEFT: 288px; POSITION: absolute; TOP: 144px'>Enter the correct price</span>");

                }
                else
                {

                    cmd.Parameters.Add(new SqlParameter("@price", price1));
                    Response.Write("<span id='Label1' style='height:16px;width:120px;Z-INDEX: 102; LEFT: 288px; POSITION: absolute; TOP: 144px'>Product is added sucssesfully</span>");

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }

            }
        }

        protected void ReturnHome(object sender, EventArgs e)
        {
            Response.Redirect("VendorMain.aspx");        }

        protected void ViewProduct(object sender, EventArgs e)
        {
            
            MyProducts.Text = "";
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("ViewProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            int serialNumber = (int)Session["serialnumber"];
            conn.Open();
            cmd.Parameters.Add(new SqlParameter("@serial", serialNumber));
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {

                    
                string product_name = rdr.IsDBNull(0) ? "N/A" : rdr.GetString(rdr.GetOrdinal("product_name"));
                string category = rdr.IsDBNull(1) ? "N/A" : rdr.GetString(rdr.GetOrdinal("category"));
                string product_description = rdr.IsDBNull(2) ? "N/A" : rdr.GetString(rdr.GetOrdinal("product_description"));
                decimal price = rdr.IsDBNull(3) ? -1 : rdr.GetDecimal(rdr.GetOrdinal("price"));
                string color = rdr.IsDBNull(4) ? "N/A" : rdr.GetString(rdr.GetOrdinal("color"));
                MyProducts.Text += "Product Name: " + product_name + ", " + "Category: " + category + ", " +
                    "Description: " + product_description + ", " + "Price: " + price + ", "
                    + "Color: " + color;
            }
           
        }
    }
}
