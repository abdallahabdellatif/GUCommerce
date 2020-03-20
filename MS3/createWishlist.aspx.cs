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
    public partial class createWishlist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx", true);
            }
        }

        protected void Addwishlist_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("createWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string username = (string)(Session["username"]);
            //string serial = productserial.Text;
            string wishname = wishlistname.Text;
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            cmd.Parameters.Add(new SqlParameter("@name", wishname));
            SqlParameter suc = cmd.Parameters.Add("@out", SqlDbType.Int);
            suc.Direction = ParameterDirection.Output;
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            if (wishname == "")
            {
                Response.Write("Name cannot be empty");
            }
            else if (suc.Value.ToString().Equals("1"))
            {
                Response.Write(wishname + " is added succesfully");
            }
            else
            {
                Response.Write(wishname + " already exists in your wishlists");
            }
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerMain.aspx", true);
        }
    }
}