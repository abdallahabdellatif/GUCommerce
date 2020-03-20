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
    public partial class Login : System.Web.UI.Page
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

        protected void login_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("userLogin", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string username = tusername.Text;
            string password = tpassword.Text;

            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@password", password));

            SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.Int);
            type.Direction = ParameterDirection.Output;

            //Executing the SQLCommand
            conn.Open();
            
            cmd.ExecuteNonQuery();
            conn.Close();


            if (success.Value.ToString().Equals("1"))
            {
                if (type.Value.ToString().Equals("0"))
                {
                    Session["username"] = username;
                    Response.Redirect("CustomerMain.aspx", true);
                }
                else if (type.Value.ToString().Equals("1"))
                {

                    SqlCommand cmd1 = new SqlCommand("isAct", conn);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.Add(new SqlParameter("@username", username));
                    SqlParameter act = cmd1.Parameters.Add("@act", SqlDbType.Int);
                    act.Direction = ParameterDirection.Output;
                    conn.Open();
                    cmd1.ExecuteNonQuery();
                    conn.Close();
                    if (act.Value.ToString().Equals("1"))
                    {
                        Session["username"] = username;
                        Response.Redirect("VendorMain.aspx", true);
                    }
                    else
                    {
                        Response.Write("This account has not been activated yet! Contact The Admins for help");
                    }
                }
                else if (type.Value.ToString().Equals("2"))
                {
                    Session["username"] = username;
                    Response.Redirect("adminHomePage.aspx", true);
                }
               // Session["username"] = username; //msh fahm elhwar da awi
                //deliveryyyyyyyy weeenoooo
            }
            else
            {
                Response.Write("Wrong username or password");//3yzen nhot error f nfs page b2a w kda
            }

        }

        protected void Customer_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerRegister.aspx", true);
        }

        protected void Vendor_Click(object sender, EventArgs e)
        {
            Response.Redirect("VendorRegister.aspx", true);
        }
    }
}