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
    public partial class CustomerMain : System.Web.UI.Page
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

                SqlCommand cmd = new SqlCommand("ShowProductsbyPrice", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                conn.Open();
                SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                while (rdr.Read())
                {
                    Int32 serial = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                    string pname = rdr.GetString(rdr.GetOrdinal("product_name"));
                    string pdesc = rdr.GetString(rdr.GetOrdinal("product_description"));
                    decimal price = rdr.GetDecimal(rdr.GetOrdinal("price"));
                    string color = rdr.GetString(rdr.GetOrdinal("color"));

                    Label lbl_serial = new Label();
                    lbl_serial.Text = "Serial:" + serial;
                    form1.Controls.Add(lbl_serial);

                    Label lbl_pname = new Label();
                    lbl_pname.Text = ",name:" + pname;
                    form1.Controls.Add(lbl_pname);

                    Label lbl_pdesc = new Label();
                    lbl_pdesc.Text = ",describtion:" + pdesc;
                    form1.Controls.Add(lbl_pdesc);

                    Label lbl_price = new Label();
                    lbl_price.Text = ",price:" + price;
                    form1.Controls.Add(lbl_price);

                    Label lbl_color = new Label();
                    lbl_color.Text = ",color:" + color + "  <br /> <br />";
                    form1.Controls.Add(lbl_color);
                }
            }
        }
        


        protected void viewCart_Click(object sender, EventArgs e)
        {
            string username = (string)(Session["username"]);
            Session["username"] = username;
            Response.Redirect("myCart.aspx", true);
          //  string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            //SqlConnection conn = new SqlConnection(connStr);

            //string username = Session["username"].ToString(); //not sure tho

         //   SqlCommand cmd = new SqlCommand("viewMyCart", conn);
           // cmd.CommandType = CommandType.StoredProcedure;
            
            //cmd.Parameters.Add(new SqlParameter("@username", username));

        }

        protected void viewWishlists_Click(object sender, EventArgs e)
        {
            string username = (string)(Session["username"]);
            Session["username"] = username;
            Response.Redirect("myWishlists.aspx", true);
            //   string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            // SqlConnection conn = new SqlConnection(connStr);

            //string username = Session["username"].ToString();
        }

        protected void creditCards_Click(object sender, EventArgs e)
        {
            Response.Redirect("addcc.aspx", true);
        }

        protected void createWishlist_Click(object sender, EventArgs e)
        {
            Response.Redirect("createWishlist.aspx", true);
        }

       

        protected void addToWishlist_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("AddtoWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string username = (string)(Session["username"]);
            string serial = productserialW.Text;
            string wishlistname = wishname.Text;
            int serialnew;
            if(!Int32.TryParse(serial, out serialnew)){
                Response.Write("Product serial must be a number");
            }
            else if (wishlistname == "")
            {
                Response.Write("Name cannot be empty");
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@customername", username));
                cmd.Parameters.Add(new SqlParameter("@wishlistname", wishlistname));
                cmd.Parameters.Add(new SqlParameter("@serial", serial));
                SqlParameter w_notexists = cmd.Parameters.Add("@w_notexists", SqlDbType.Int);
                w_notexists.Direction = ParameterDirection.Output;
                SqlParameter s_notexists = cmd.Parameters.Add("@s_notexists", SqlDbType.Int);
                s_notexists.Direction = ParameterDirection.Output;
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                if (w_notexists.Value.ToString().Equals("1"))
                {
                    if (s_notexists.Value.ToString().Equals("1"))
                    {
                        Response.Write("Product is added successfully");
                    }
                    else
                    {
                        Response.Write("Product is already in the wishlist or doesn't exist in products");
                    }
                }
                else
                {
                    Response.Write("You do not have such wishlist , create a new one?");
                }

            }
            
        }

        protected void adsToCart_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("addToCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string username = (string)(Session["username"]);
            string serial = productserialC.Text;
            int serialnew;
            if(!Int32.TryParse(serial, out serialnew))
            {
                Response.Write("Product serial must be a number");
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@serial", serialnew));
                cmd.Parameters.Add(new SqlParameter("@customername", username));
                SqlParameter suc = cmd.Parameters.Add("@out", SqlDbType.Int);
                suc.Direction = ParameterDirection.Output;
                conn.Open();
                Session["username"] = username;
                cmd.ExecuteNonQuery();
                conn.Close();
                if (suc.Value.ToString().Equals("1"))
                {
                    Response.Write("Product added sucessfully");
                }
                else
                {
                    Response.Write("Product already exists");
                }
            }

        }

        protected void removefromcart_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("removefromCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string username = (string)(Session["username"]);
            string serial = productserialC.Text;
            int serialnew;
            if (!Int32.TryParse(serial, out serialnew))
            {
                Response.Write("Product serial must be a number");
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@serial", serialnew));
                cmd.Parameters.Add(new SqlParameter("@customername", username));
                SqlParameter suc = cmd.Parameters.Add("@out", SqlDbType.Int);
                suc.Direction = ParameterDirection.Output;
                conn.Open();
                Session["username"] = username;
                cmd.ExecuteNonQuery();
                conn.Close();
                if (suc.Value.ToString().Equals("1"))
                {
                    Response.Write("Product removed sucessfully");
                }
                else
                {
                    Response.Write("Product is not in your cart");
                }
            }
        }

        protected void removefromwish_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("removefromWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string username = (string)(Session["username"]);
            string serial = productserialW.Text;
            string wishlistname = wishname.Text;
            int serialnew;
            if (!Int32.TryParse(serial, out serialnew))
            {
                Response.Write("Product serial must be a number");
            }
            else if (wishlistname == "")
            {
                Response.Write("Name cannot be empty");
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@customername", username));
                cmd.Parameters.Add(new SqlParameter("@wishlistname", wishlistname));
                cmd.Parameters.Add(new SqlParameter("@serial", serial));
                SqlParameter w_notexists = cmd.Parameters.Add("@w_notexists", SqlDbType.Int);
                w_notexists.Direction = ParameterDirection.Output;
                SqlParameter s_notexists = cmd.Parameters.Add("@s_notexists", SqlDbType.Int);
                s_notexists.Direction = ParameterDirection.Output;
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                if (w_notexists.Value.ToString().Equals("1"))
                {
                    if (s_notexists.Value.ToString().Equals("1"))
                    {
                        Response.Write("Product is deleted successfully");
                    }
                    else
                    {
                        Response.Write("Product is not in the wishlist");
                    }
                }
                else
                {
                    Response.Write("You do not have such wishlist , create a new one?");
                }
            }
        }

        protected void viewOrders_Click(object sender, EventArgs e)
        {

            Response.Redirect("myOrders.aspx", true);

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Session["username"] = null;
            Response.Redirect("Login.aspx", true);
        }
        protected void Button5_Click(object sender, EventArgs e)
        {
            Response.Redirect("addTelephoneNumber.aspx", true);
        }
    }
}