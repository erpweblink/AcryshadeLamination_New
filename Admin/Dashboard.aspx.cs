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
                if (Session["Role"].ToString()== "Admin")
                {
                    divAdmin.Visible = true;
                }
            }
        }

    }

    [WebMethod]
    public static Dictionary<string, object> GetDashboard(string fromDate, string toDate)
    {
        Dictionary<string, object> result = new Dictionary<string, object>();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
        {
            result["Stage1"] = ToList(GetDataTable(con, "Todaysproductionsstage1", fromDate, toDate));
            result["Stage2"] = ToList(GetDataTable(con, "Todaysproductionsstage2", fromDate, toDate));
            result["Packaging"] = ToList(GetDataTable(con, "TodaysPackaging", fromDate, toDate));
            result["Orders"] = ToList(GetDataTable(con, "OrderCount", fromDate, toDate));
            result["Rejected"] = ToList(GetDataTable(con, "Returncount", fromDate, toDate));
            result["Dispatch"] = ToList(GetDataTable(con, "Dispatchedcount", fromDate, toDate));
            result["DownTime"] = ToList(GetDataTable(con, "GetBreakdown", fromDate, toDate));
            result["Productivity"] = ToList(GetDataTable(con, "TodaysProductivity", fromDate, toDate));
            result["MonthlyProduction"] = ToList(GetDataTable(con, "Currentmonthproductions", fromDate, toDate));
            result["DealerCount"] = ToList(GetDataTable(con, "CardsDetails", fromDate, toDate));
        }

        return result;
    }

    private static List<Dictionary<string, object>> ToList(DataTable dt)
    {
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();

        foreach (DataRow dr in dt.Rows)
        {
            Dictionary<string, object> row = new Dictionary<string, object>();

            foreach (DataColumn col in dt.Columns)
            {
                row[col.ColumnName] = dr[col];
            }

            rows.Add(row);
        }

        return rows;
    }

    private static DataTable GetDataTable(SqlConnection con, string action, string fromDate, string toDate)
    {
        DataTable dt = new DataTable();

        using (SqlDataAdapter da = new SqlDataAdapter("SP_DashboardDetails", con))
        {
            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            da.SelectCommand.Parameters.AddWithValue("@SP_Action", action);
            da.SelectCommand.Parameters.AddWithValue("@FromDate", fromDate);
            da.SelectCommand.Parameters.AddWithValue("@ToDate", toDate);

            da.Fill(dt);
        }

        return dt;
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
        string encryptionKey = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        byte[] clearBytes = Encoding.Unicode.GetBytes(encryptString);

        using (Aes encryptor = Aes.Create())
        {
            using (Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(
                encryptionKey,
                new byte[]
                {
                0x49, 0x76, 0x61, 0x6E,
                0x20, 0x4D, 0x65, 0x64,
                0x76, 0x65, 0x64, 0x65,
                0x76
                }))
            {
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);

                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.FlushFinalBlock();
                    }

                    // Convert to Base64
                    string encrypted = Convert.ToBase64String(ms.ToArray());

                    // Make URL-safe
                    encrypted = encrypted.Replace("+", "-")
                                         .Replace("/", "_")
                                         .Replace("=", "");

                    return encrypted;
                }
            }
        }
    }
}


