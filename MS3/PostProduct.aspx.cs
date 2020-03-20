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
    public partial class PostProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx", true);
            }
        }
        protected void postProduct(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("postProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string user = (string)(Session["username"]).ToString();
            string product_name = TextBox1.Text;
            string category = TextBox2.Text;
            string product_description = TextBox3.Text;
            string price = TextBox4.Text;
            string color = TextBox5.Text;
            Decimal price1;



            if (product_name.Length == 0 || category.Length == 0 || product_description.Length == 0 || color.Length == 0)
            {
                Response.Write("<span id='Label1' style='height:16px;width:120px;Z-INDEX: 102; LEFT: 288px; POSITION: absolute; TOP: 144px'>Please fill all the Data</span>");

            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@vendorUsername", user));
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
    }
}