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
    public partial class addcc : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx", true);
            }
        }

        protected void addC_Click(object sender, EventArgs e)
        {
            string username = (string)Session["username"];
            string ccnum = ccnumber.Text;
          
            string Cvv = cvv.Text;
            string expiry = expirydate.Text;
            long ccnumnew;
            if (!Int64.TryParse(ccnum, out ccnumnew))
            {
                Response.Write("Credit card number must be a number");
            }
            else if (Cvv.Length != 3 && Cvv.Length!=4)
            {
                Response.Write("CVV must contain 3 or 4 characters only");
            }
            else if (ccnumnew<(long)1e15 || ccnumnew >= (long)1e16)
            {
                Response.Write("Credit card number must be a 16-digit number, not starting with a '0'");
            }
            else
            {
                try
                {
                    string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);

                    SqlCommand cmd = new SqlCommand("AddCreditCard", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@creditcardnumber", ccnumnew));
                    cmd.Parameters.Add(new SqlParameter("@expirydate", expiry));
                    cmd.Parameters.Add(new SqlParameter("@cvv", Cvv));
                    cmd.Parameters.Add(new SqlParameter("@customername", username));
                    SqlParameter suc = cmd.Parameters.Add("@out", SqlDbType.Int);
                    suc.Direction = ParameterDirection.Output;
                    conn.Open();
                    Session["username"] = username;
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    if (suc.Value.ToString().Equals("1"))
                    {
                        Response.Write("Credit card has been added sucessfully");
                    }
                    else
                    {
                        Response.Write("Credit card already exists");
                    }
                }
                catch (SqlException)
                {
                    Response.Write("Date Format is not correct");
                }
            }
        }
 

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerMain.aspx", true);
        }
    }
}