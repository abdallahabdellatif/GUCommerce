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
    public partial class VendorMain : System.Web.UI.Page
    {   
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx", true);
            }
        }

        protected void MyProducts(object sender, EventArgs e)
        {
            Response.Redirect("MyProducts.aspx");
        }

        protected void PostProduct(object sender, EventArgs e)
        {
            Response.Redirect("PostProduct.aspx");
        }

        protected void EditProduct(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("GetProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string user = (string)(Session["username"]).ToString();
            string serialnumber = Snumber.Text;
            cmd.Parameters.Add(new SqlParameter("@vendorUsername", user));
            cmd.Parameters.Add(new SqlParameter("@serialNumber", serialnumber));
            SqlParameter successSerial = cmd.Parameters.Add("@successSerial", SqlDbType.Bit);
            successSerial.Direction = ParameterDirection.Output;
            int serialnumber1;
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            if(serialnumber.Length == 0)
            {
                Response.Write("Please Enter A serial Number");
            }
            else
            {
                if (successSerial.Value.Equals(true))
                {
                    if (!Int32.TryParse(serialnumber, out serialnumber1))
                    {
                        Response.Write("Serial number must be an integer");
                    }
                    else
                    {
                        Session["serialnumber"] = serialnumber1;
                        Response.Redirect("EditProduct.aspx");
                    }
                }
                else
                {
                    Response.Write("<span id='Label1' style='height:16px;width:120px;Z-INDEX: 102; LEFT: 288px; POSITION: absolute; TOP: 144px'>That's not your product</span>");
                }
            }
            
        }

        protected void Offer(object sender, EventArgs e)
        {
            Response.Redirect("Offer.aspx");
        }

        protected void AddPhone(object sender, EventArgs e)
        {
            Response.Redirect("addTelephoneNumber.aspx");
        }

        protected void Button0_Click(object sender, EventArgs e)
        {
            Session["username"] = null;
            Response.Redirect("Login.aspx", true);
        }
    }
}