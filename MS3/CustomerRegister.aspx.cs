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
    public partial class CustomerRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null)
            {
                string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand cmd = new SqlCommand("userType", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                string username = (Session["username"]).ToString();
                cmd.Parameters.Add(new SqlParameter("@username", username));

                SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.Int);
                type.Direction = ParameterDirection.Output;

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (type.Value.ToString().Equals("0"))
                {
                    Response.Redirect("CustomerMain.aspx", true);
                }
                else if (type.Value.ToString().Equals("1"))
                {
                    Response.Redirect("VendorMain.aspx", true);
                }
                else if (type.Value.ToString().Equals("2"))
                {
                    Response.Redirect("adminHomePage.aspx", true);
                }
            }
        }

        protected void Register_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("customerRegister", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string firstname = fname.Text;
            string lastname = lname.Text;
            string uname = username.Text;
            string pass = password.Text;
            string mail = email.Text;
            if (firstname == "")
            {
                Response.Write("First name cannot be empty");
            }
            else if (lastname == "")
            {
                Response.Write("Last name cannot be empty");
            }
            else if (uname == "")
            {
                Response.Write("Username cannot be empty");
            }
            else if (pass == "")
            {
                Response.Write("Password cannot be empty");
            }
            else if (mail == "")
            {
                Response.Write("Email cannot be empty");
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@username", uname));
                cmd.Parameters.Add(new SqlParameter("@first_name", firstname));
                cmd.Parameters.Add(new SqlParameter("@last_name", lastname));
                cmd.Parameters.Add(new SqlParameter("@password", pass));
                cmd.Parameters.Add(new SqlParameter("@email", mail));

                SqlParameter suc = cmd.Parameters.Add("@out", SqlDbType.Int);
                suc.Direction = ParameterDirection.Output;

                SqlParameter sucmail = cmd.Parameters.Add("@outmail", SqlDbType.Int);
                sucmail.Direction = ParameterDirection.Output;
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                if (sucmail.Value.ToString().Equals("1"))
                {
                    if (suc.Value.ToString().Equals("1"))
                    {
                        Response.Write("Registered successfully , go back to login page to log in");
                    }
                    else
                    {
                        Response.Write("Username already exists");
                    }
                }
                else
                {
                    Response.Write("Email already exists");
                }
            }
        }

        protected void BackLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx", true);
        }
    }
}