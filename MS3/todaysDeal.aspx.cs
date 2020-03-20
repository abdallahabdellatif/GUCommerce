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
    public partial class todaysDeal : System.Web.UI.Page
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
            string dealAmoS = TextBox1.Text;
            string date = TextBox2.Text;
            string au = (string)(Session["username"]);
            int dealAmo;
            if (!Int32.TryParse(dealAmoS, out dealAmo))
            {
                Response.Write("Deal amount must be an integer");
            }
            else
            {
                try
                {
                    string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);
                    SqlCommand cmd = new SqlCommand("createTodaysDeal", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@deal_amount", dealAmo));
                    cmd.Parameters.Add(new SqlParameter("@expiry_date", date));
                    cmd.Parameters.Add(new SqlParameter("@admin_username", au));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    Response.Write("Deal created successfully");
                }
                catch (SqlException)
                {
                    Response.Write("Date format is not correct");
                }

            }
        }
        protected bool checkDF(string date)
        {

            if (date.Length==10&&
                date[0] >= '0' && date[0] <= '9' &&
                date[1] >= '0' && date[1] <= '9' &&
                date[2] >= '0' && date[2] <= '9' &&
                date[3] >= '0' && date[3] <= '9' &&
                date[4] == '-' &&
                date[5] >= '0' && date[5] <= '1' &&
                date[6] >= '0' && date[6] <= '9' &&
                date[7] == '-' &&
                date[8] >= '0' && date[8] <= '3' &&
                date[9] >= '0' && date[9] <= '9')
            {
                if (date[8] == '3')
                {
                    if (date[9] == '0' || date[9] == '1')
                    {
                        if (date[5] == '1')
                        {
                            if (date[6] == '0' || date[6] == '1' || date[6] == '2')
                            {
                                return true;
                            }
                            else
                                return false;
                        }
                        else
                            return true;
                    }
                    else
                        return false;
                }
                else
                    return true;
            }
            else
                return false;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string pSerS = TextBox3.Text;
            string dealNoS = TextBox4.Text;
            int pSer;
            int dealNo;
            if (!Int32.TryParse(pSerS, out pSer))
            {
                Response.Write("Product Serial Number must be an integer");
            }
            else
            {
                if (productExists(pSer))
                {
                    string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);
                    SqlCommand cmd = new SqlCommand("checkTodaysDealOnProduct", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@serial_no", pSer));
                    SqlParameter outp = cmd.Parameters.Add("@activeDeal", SqlDbType.Int);
                    outp.Direction = ParameterDirection.Output;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    if (outp.Value.ToString() == "1") 
                    {
                        Response.Write("There is an active deal on this product");
                    }
                    else
                    {
                        if (!Int32.TryParse(dealNoS, out dealNo))
                        {
                            Response.Write("Deal number must be an integer");
                        }
                        else
                        {
                            if (dealExists(dealNo))
                            {
                                string connStr1 = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
                                SqlConnection conn1 = new SqlConnection(connStr1);
                                SqlCommand cmd1 = new SqlCommand("addTodaysDealOnProduct", conn1);
                                cmd1.CommandType = CommandType.StoredProcedure;

                                cmd1.Parameters.Add(new SqlParameter("@serial_no", pSer));
                                cmd1.Parameters.Add(new SqlParameter("@deal_id", dealNo));
                                SqlParameter outp1 = cmd1.Parameters.Add("@out", SqlDbType.Int);
                                outp1.Direction = ParameterDirection.Output;

                                conn1.Open();
                                cmd1.ExecuteNonQuery();
                                conn1.Close();
                                if(outp1.Value.ToString()=="1")
                                    Response.Write("Deal is added successfully");
                                else
                                    Response.Write("Deal already exists");
                            }
                            else
                            {
                                Response.Write("Deal number does not exists");
                            }
                        }
                    }
                }
                else
                {
                    Response.Write("Product serial number does not exists");
                }
            }
        }
        protected bool productExists(int ser)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("ProductExists", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@serial_no", ser));
            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            if (outp.Value.ToString() == "0")
                return false;
            else
                return true;
        }
        protected bool dealExists(int deal)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("TDealExists", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@deal_id", deal));
            SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
            outp.Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            if (outp.Value.ToString() == "0")
                return false;
            else
                return true;
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            string dealIdS = TextBox5.Text;
            int dealId;
            if (!Int32.TryParse(dealIdS, out dealId))
            {
                Response.Write("Deal ID must be an integer");
            }
            else
            {
                if (dealExists(dealId))
                {
                    string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
                    SqlConnection conn = new SqlConnection(connStr);
                    SqlCommand cmd = new SqlCommand("removeExpiredDeal", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add(new SqlParameter("@deal_id", dealId));
                    SqlParameter outp = cmd.Parameters.Add("@out", SqlDbType.Int);
                    outp.Direction = ParameterDirection.Output;

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    if (outp.Value.ToString() == "0")
                    {
                        Response.Write("Deal is not expired");
                    }
                    else
                    {
                        Response.Write("Deal is removed successfully");
                    }
                }
                else
                {
                    Response.Write("Deal ID does not exists");
                }
            }
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("showAllProducts", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            int i = 1;
            Label h = new Label();
            h.Text = "<br />"+ "Products: " + "<br />";
            form1.Controls.Add(h);
            while (rdr.Read())
            {
                int serialNo = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                string pName = rdr.IsDBNull(1) ? "N/A" : rdr.GetString(rdr.GetOrdinal("product_name"));
                decimal price= rdr.IsDBNull(2) ? -1 : rdr.GetDecimal(rdr.GetOrdinal("price"));
                decimal fprice = rdr.IsDBNull(3) ? -1 : rdr.GetDecimal(rdr.GetOrdinal("final_price"));


                Label s = new Label();
                s.Text = i + ":-  Serial Number: " + serialNo;
                form1.Controls.Add(s);
                Label n = new Label();
                n.Text = ", Product Name: " + pName ;
                form1.Controls.Add(n);
                Label p = new Label();
                p.Text = ", Price: " + price;
                form1.Controls.Add(p);
                Label f = new Label();
                f.Text = ", Final Price: " + fprice+"<br /><br />";
                form1.Controls.Add(f);


                i++;
            }
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["ms3gui"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("showAllTDeals", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            int i = 1;
            Label h = new Label();
            h.Text = "<br />" + "Today's Deals: " + "<br />";
            form1.Controls.Add(h);
            while (rdr.Read())
            {
                int dealId = rdr.GetInt32(rdr.GetOrdinal("deal_id"));
                DateTime expD = rdr.GetDateTime(rdr.GetOrdinal("expiry_date"));

                Label s = new Label();
                s.Text = i + ":-  Deal ID: " + dealId;
                form1.Controls.Add(s);
                Label n = new Label();
                n.Text = ", Expire Date: " + expD + "<br /><br />";
                form1.Controls.Add(n);
                i++;
            }
        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            Response.Redirect("adminHomePage.aspx", true);
        }
    }
}