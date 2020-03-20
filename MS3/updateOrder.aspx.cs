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
    public partial class updateOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx", true);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string orderNoS = TextBox1.Text;
            int orderNo;
            if(!Int32.TryParse(orderNoS, out orderNo))
            {
                Response.Write("Order number must be an integer");
            }
            else
            {
                string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
                SqlConnection conn = new SqlConnection(connStr);
                SqlCommand cmd = new SqlCommand("updateOrderStatusInProcess", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@order_no",orderNo));
                SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
                outp.Direction = ParameterDirection.Output;

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (outp.Value.ToString() == "0")
                {
                    Response.Write("Order number does not exists, please check from 'Review Orders' button");
                }
                else
                {
                    if(outp.Value.ToString() == "1")
                        Response.Write("Update is successful");
                    else
                        Response.Write("Order is already updated");
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("reviewOrders.aspx", true);
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminHomePage.aspx", true);
        }
    }
}