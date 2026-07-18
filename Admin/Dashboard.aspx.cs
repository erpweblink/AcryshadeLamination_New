using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Services;


public partial class Dashboard : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString);
    CommonCls objcls = new CommonCls();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserCode"] == null)
        {
            Response.Redirect("../Login.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                FillGrid();
                FillCardDetails();
                Fillstage1capcity();
                Fillstage2capcity();
                FillPackagingCapacity();
                Getdowntimehistory();
                GetDispatchCount();
                GetRejectedCount();
                GetProductivity();
                GetOrderCount();
            }
        }

    }
    private void FillGrid()
    {
        DataTable dt = new DataTable();

        using (SqlDataAdapter da = new SqlDataAdapter("[dbo].[SP_DashboardDetails]", con))
        {
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@SP_Action", "Currentmonthproductions");

            da.Fill(dt);
        }

        if (dt.Rows.Count > 0)
        {
            int production = Convert.ToInt32(dt.Rows[0]["CurrentMonthProduction"]);

            lblMonthlyProduction.Text = production.ToString() + " Sq.ft";
        }
        else
        {
            lblMonthlyProduction.Text = "0 Sq.ft";
        }
    }

    private void FillCardDetails()
    {
        DataTable dt = new DataTable();

        using (SqlDataAdapter da = new SqlDataAdapter("SP_DashboardDetails", con))
        {
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@SP_Action", "CardsDetails");

            da.Fill(dt);
        }

        if (dt.Rows.Count > 0)
        {
            lblDealerCount.Text = dt.Rows[0]["DealersCount"].ToString();
        }
        else
        {
            lblDealerCount.Text = "0";
        }
    }

    private void Fillstage1capcity()
    {
        DataTable dt = new DataTable();

        using (SqlDataAdapter da = new SqlDataAdapter("SP_DashboardDetails", con))
        {
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@SP_Action", "Todaysproductionsstage1");

            da.Fill(dt);
        }
        rptMachines.DataSource = dt;
        rptMachines.DataBind();
    }
    private void Fillstage2capcity()
    {
        DataTable dt = new DataTable();

        using (SqlDataAdapter da = new SqlDataAdapter("SP_DashboardDetails", con))
        {
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@SP_Action", "Todaysproductionsstage2");

            da.Fill(dt);
        }

        rptStage2Machines.DataSource = dt;
        rptStage2Machines.DataBind();
    }

    private void FillPackagingCapacity()
    {
        DataTable dt = new DataTable();

        using (SqlDataAdapter da = new SqlDataAdapter("SP_DashboardDetails", con))
        {
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@SP_Action", "TodaysPackaging");

            da.Fill(dt);
        }

        if (dt.Rows.Count > 0)
        {
            string percentage = Convert.IsDBNull(dt.Rows[0]["PackagingPercentage"])
                                ? "0%"
                                : dt.Rows[0]["PackagingPercentage"].ToString();

            int completed = Convert.IsDBNull(dt.Rows[0]["PackagingSqFeet"])
                            ? 0
                            : Convert.ToInt32(dt.Rows[0]["PackagingSqFeet"]);

            int allocated = Convert.IsDBNull(dt.Rows[0]["AllocatedSqFeet"])
                            ? 0
                            : Convert.ToInt32(dt.Rows[0]["AllocatedSqFeet"]);

            lblPackaging.Text = percentage + " (" + completed + " / " + allocated + ")";
        }
        else
        {
            lblPackaging.Text = "0% (0 / 0)";
        }
    }
    private void Getdowntimehistory()
    {
        DataTable dt = new DataTable();

        using (SqlDataAdapter da = new SqlDataAdapter("SP_DashboardDetails", con))
        {
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@SP_Action", "GetBreakdown");

            da.Fill(dt);
        }

        if (dt.Rows.Count > 0)
        {
            rptDownTime.DataSource = dt;
            rptDownTime.DataBind();
        }
        else
        {
            rptDownTime.DataSource = null;
            rptDownTime.DataBind();
        }
    }
    private void GetDispatchCount()
    {
        DataTable dt = new DataTable();

        using (SqlDataAdapter da = new SqlDataAdapter("SP_DashboardDetails", con))
        {
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@SP_Action", "Dispatchedcount");

            da.Fill(dt);
        }

        if (dt.Rows.Count > 0)
        {
            lblDispatchCount.Text =
                dt.Rows[0]["DispatchedCount"].ToString();
               
        }
        else
        {
            lblDispatchCount.Text = "0 / 0";
        }
    }

    private void GetRejectedCount()
    {
        DataTable dt = new DataTable();

        using (SqlDataAdapter da = new SqlDataAdapter("SP_DashboardDetails", con))
        {
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@SP_Action", "Returncount");

            da.Fill(dt);
        }

        if (dt.Rows.Count > 0)
        {
            lblRejectedCount.Text = dt.Rows[0]["ReturnCount"].ToString();
        }
        else
        {
            lblRejectedCount.Text = "0";
        }
    }

    private void GetProductivity()
    {
        DataTable dt = new DataTable();

        using (SqlDataAdapter da = new SqlDataAdapter("SP_DashboardDetails", con))
        {
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@SP_Action", "TodaysProductivity");

            da.Fill(dt);
        }

        if (dt.Rows.Count > 0)
        {
            rptProductivity.DataSource = dt;
            rptProductivity.DataBind();
        }
    }

    private void GetOrderCount()
    {
        DataTable dt = new DataTable();

        using (SqlDataAdapter da = new SqlDataAdapter("SP_DashboardDetails", con))
        {
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@SP_Action", "OrderCount");

            da.Fill(dt);
        }

        if (dt.Rows.Count > 0)
        {
            lblNewOrders.Text = dt.Rows[0]["NewOrders"].ToString();
            lblPendingOrders.Text = dt.Rows[0]["PendingOrders"].ToString();
            lblOverDueOrders.Text = dt.Rows[0]["OverDueOrders"].ToString();
        }
        else
        {
            lblNewOrders.Text = "0";
            lblPendingOrders.Text = "0";
            lblOverDueOrders.Text = "0";
        }
    }


    [WebMethod]
    public static List<Dictionary<string, object>> GetNotifications()
    {
        var notifications = new List<Dictionary<string, object>>();

        if (HttpContext.Current.Session["Role"].ToString() == "Admin")
        {
            string cs = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(@"
                SELECT DH.ID,
                       OrderID,
                       UM.FullName AS DealerName,
                       CONVERT(varchar(10), CreatedDate, 105) AS CDate,
                       COUNT(DD.HeaderID) AS TotProducts,
                       SUM(CAST(Qty AS decimal)) AS ProductQty,
                       CASE WHEN DH.HoldStatus = 1 AND DH.HoldStatus IS NOT NULL THEN 'ON HOLD' ELSE '' END as HoldStatus
                FROM tbl_DealersOrderHDR DH
                INNER JOIN tbl_DealersOrderDTLs DD
                    ON DD.HeaderID = DH.ID
                LEFT JOIN tbl_UserMaster UM
                    ON UM.ID = DH.DealerID
                WHERE DH.OrderStatus ='Order Placed'
                GROUP BY DH.ID, OrderID, UM.FullName, CreatedDate,DH.OrderStatus,DH.HoldStatus
                ORDER BY DH.ID DESC", con);

                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    notifications.Add(new Dictionary<string, object>
                {
                    { "Id", encrypt(dr["ID"].ToString()) },
                    { "orderId", dr["OrderID"].ToString() },
                    { "dealerName", dr["DealerName"].ToString() },
                    { "totalProducts", dr["TotProducts"].ToString() },
                    { "productQty", dr["ProductQty"].ToString() },
                    { "holdStatus", dr["HoldStatus"].ToString() },
                    { "orderDate", dr["CDate"].ToString() }
                });
                }
            }
        }

        return notifications;
    }


    public static string encrypt(string encryptString)
    {
        string EncryptionKey = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        byte[] clearBytes = Encoding.Unicode.GetBytes(encryptString);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] {
            0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76
        });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(clearBytes, 0, clearBytes.Length);
                    cs.Close();
                }
                encryptString = Convert.ToBase64String(ms.ToArray());
            }
        }
        return encryptString;
    }
}


