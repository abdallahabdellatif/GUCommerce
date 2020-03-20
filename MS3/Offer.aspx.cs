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
    public partial class Offer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx", true);
            }
        }

        protected void Addoffer(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("addOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string offerAmount = lbl_offerID.Text;
            string date = lbl_expiry.Text;
            int offerAmount1;
            if (!Int32.TryParse(offerAmount, out offerAmount1))
            {
                Response.Write("Offer amount must be an integer");
            }
            else
            {
                try
                {
                    cmd.Parameters.Add(new SqlParameter("@offeramount", offerAmount1));
                    cmd.Parameters.Add(new SqlParameter("@expiry_date", date));
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    Response.Write("Offer created successfully");
                }
                catch(SqlException)
                {
                    Response.Write("Date format is not correct");
                }

            }
        }
        
        protected void ApplyOffer(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("applyOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string user = (string)(Session["username"]).ToString();
            string offerid = lbl_Offerid2.Text;
            string serialnumber = lbl_productSNO.Text;
            int offerID;
            int SerialNumber;
            if (!Int32.TryParse(offerid, out offerID) || !Int32.TryParse(serialnumber, out SerialNumber))
            {
                Response.Write("Offer amount must be an integer");
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@vendorname", user));
                cmd.Parameters.Add(new SqlParameter("@offerid", offerID));
                cmd.Parameters.Add(new SqlParameter("@serial", SerialNumber));
                SqlParameter successID = cmd.Parameters.Add("@successID", SqlDbType.Bit);
                successID.Direction = ParameterDirection.Output;
                SqlParameter successSerial = cmd.Parameters.Add("@successSerial", SqlDbType.Bit);
                successSerial.Direction = ParameterDirection.Output;
                SqlParameter activeOffer = cmd.Parameters.Add("@Active", SqlDbType.Bit);
                activeOffer.Direction = ParameterDirection.Output;
                SqlParameter Myproduct = cmd.Parameters.Add("@MyProduct", SqlDbType.Bit);
                Myproduct.Direction = ParameterDirection.Output;
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                if(Myproduct.Value.Equals(false))
                {
                    Response.Write("Thats not your product!");
                }
                else
                {
                    if (activeOffer.Value.Equals(true))
                    {
                        Response.Write("Product has an active offer");
                    }
                    else
                    {
                        if (successID.Value.Equals(false))
                        {
                            Response.Write("No offer with such ID");
                        }
                        else
                        {
                            if (successSerial.Value.Equals(false))
                            {
                                Response.Write("No Product with such SerialNumber");
                            }
                            else
                            {
                                Response.Write("Offer has been activated");
                            }
                        }
                    }
                }
            }
        }

        protected void RemoveExpired(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("checkandremoveExpiredoffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string offerid = lbl_expiredOffer.Text;
            int offerID;
            if (!Int32.TryParse(offerid, out offerID))
            {
                Response.Write("Offer amount must be an integer");
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@offerid", offerID));
                SqlParameter successID = cmd.Parameters.Add("@successID", SqlDbType.Bit);
                successID.Direction = ParameterDirection.Output;
                SqlParameter successRemoved = cmd.Parameters.Add("@successRemoved", SqlDbType.Bit);
                successRemoved.Direction = ParameterDirection.Output;
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                if (successID.Value.Equals(false))
                {
                    Response.Write("No offer with such ID");
                }
                else
                {
                    if(successRemoved.Value.Equals(true))
                    {
                        Response.Write("Offer has been removed");
                    }
                    else
                    {
                        Response.Write("Offer hasn't expired yet");
                    }
                }
            }
        }

        protected void ShowOffers(object sender, EventArgs e)
        {
            Label7.Text = "";
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("ShowOffers", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                int offerID = rdr.GetInt32(rdr.GetOrdinal("offer_id"));
                int offerAmount = rdr.GetInt32(rdr.GetOrdinal("offer_amount"));
                DateTime expiry_date = rdr.GetDateTime(rdr.GetOrdinal("expiry_date"));
                Label7.Text += "OfferID:" + offerID + ", " + "OfferAmount:" + offerAmount + ", " + "Expiry_date:" + 
                    expiry_date + ", " + "<br />" + "<br />";
            }

        }

        protected void ShowActiveOffers(object sender, EventArgs e)
        {
            Label7.Text = "";
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("ShowActiveOffers", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                int offerID = rdr.GetInt32(rdr.GetOrdinal("offer_id"));
                int SerialNumber = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                Label7.Text += "OfferID:" + offerID + ", " + "ProductSerialNo:" + SerialNumber +"" + "<br />" + "<br />";
            }
        }

        protected void ShowMyProducts(object sender, EventArgs e)
        {
            Label7.Text = "";
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
                Label7.Text += "SerialNo: " + serial_no + ", " + "PName: " + product_name + ", " + "Category: " + category + ", " +
                    "Description: " + product_description + ", " + "Price: " + price + ", " + "FinalPrice: " + final_price + ", " 
                    + "Color: " + color + ", " + "Availability: " + available + ", " + "Rate: " + rate + ", " + 
                    "VendorUserName: " + vendor_username + ", "  + "CustomerUserName: " + customer_username 
                    + "CustomerOrderID: " + customer_order_id + "<br />" + "<br />";
            }
        }

        protected void ReturnHome(object sender, EventArgs e)
        {
            Response.Redirect("VendorMain.aspx");
        }
    }
}