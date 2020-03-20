using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace WebApplicationMsAdmin
{
    public partial class addTelephoneNumber : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx", true);
            }

        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            string user =(string)(Session["username"]);
            string numS = TextBox1.Text;
            if (numS.Length > 20)
            {
                Response.Write("Number is too long");

            }
            else
            {
                int num;
                if (!Int32.TryParse(numS, out num))
                {
                    Response.Write("Mobile Phone must be a number");
                }
                else
                {
                    string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);
                    SqlCommand cmd = new SqlCommand("addMobile", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@username", user));
                    cmd.Parameters.Add(new SqlParameter("@mobile_number", numS));
                    SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
                    outp.Direction = ParameterDirection.Output;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    if (outp.Value.ToString() == "1")
                    {
                        Response.Write("Mobile phone is added successfully");
                    }
                    else
                    {
                        Response.Write("Mobile phone already exists");
                    }
                }
            }
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string user = (string)(Session["username"]);
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("whichUser", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@user", user));
            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            if (outp.Value.ToString() == "0")
            {
                Response.Redirect("CustomerMain.aspx", true);//asm el customer home 3andoko
            }
            else
            {
                if (outp.Value.ToString() == "1")
                {
                    Response.Redirect("VendorMain.aspx", true);//asm el vendor home 3andoko
                }
                else
                {
                    Response.Redirect("adminHomePage.aspx", true);
                }
            }
        }
    }
}