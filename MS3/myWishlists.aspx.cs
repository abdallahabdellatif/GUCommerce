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
    public partial class myWishlists : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx", true);
            }
            else { 
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            // string username = (string)(Session["username"]);
            conn.Open();
            SqlCommand cmd = new SqlCommand("showMyWishlists", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"].ToString()));


            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr.Read())
                {
                    string wname = rdr.GetString(rdr.GetOrdinal("wish_name"));
                    string pname = rdr.GetString(rdr.GetOrdinal("product_name"));
                    string pdesc = rdr.GetString(rdr.GetOrdinal("product_description"));
                    decimal price = rdr.GetDecimal(rdr.GetOrdinal("price"));
                    decimal finalprice = rdr.GetDecimal(rdr.GetOrdinal("final_price"));
                    string color = rdr.GetString(rdr.GetOrdinal("color"));


                    Label lbl_wname = new Label();
                    lbl_wname.Text = "Wishlist name:" + wname;
                    form1.Controls.Add(lbl_wname);

                    Label lbl_pname = new Label();
                    lbl_pname.Text = ",product name:" + pname;
                    form1.Controls.Add(lbl_pname);

                    Label lbl_pdesc = new Label();
                    lbl_pdesc.Text = ",description:" + pdesc;
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
            Response.Redirect("CustomerMain.aspx", true);
        }
    }
}