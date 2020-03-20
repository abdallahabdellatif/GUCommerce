using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


namespace WebApplicationMsAdmin
{
    public partial class activateVendors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            

        }
        
        protected bool existV(string vu)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("vendorExists", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@vendor", vu));
            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            if (outp.Value.ToString()=="0")
                return false;
            else
                return true;
        }
        protected bool isActive(string vu)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("showUnactiveVendors", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr.Read())
            {
                string uname = rdr.GetString(rdr.GetOrdinal("Vendor Username"));
                if (uname.Equals( vu))
                {
                        return false;
                }


            }
            return true;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string vu = TextBox1.Text;
            string au = (string)(Session["username"]);
           
            if (!existV(vu))
            {
                Response.Write("vendor doesn't exist. choose from the list");
            }
            else
            {
                if (isActive(vu))
                {
                    Response.Write("vendor already activated. choose from the list");
                }
                else
                {

                    Response.Write( vu + " is activated");

                    string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);
                    SqlCommand cmd = new SqlCommand("activateVendors", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@admin_username", au));
                    cmd.Parameters.Add(new SqlParameter("@vendor_username", vu));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("showUnactiveVendors", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            int i = 1;
            Label h = new Label();
            h.Text = "<br />" + "UnActivated Vendors: " + "<br />";
            form1.Controls.Add(h);
            while (rdr.Read())
            {
                string uname = rdr.GetString(rdr.GetOrdinal("Vendor Username"));

                Label lbl_serial = new Label();
                lbl_serial.Text = i + ": " + uname + "<br />";
                form1.Controls.Add(lbl_serial);

                i++;
            }

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminHomePage.aspx", true);
        }
    }
}