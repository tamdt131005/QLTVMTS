using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QLHSSV
{
    internal class Public
    {
        public static SqlConnection conn;
        public static SqlCommand cmd;
        static string sql;


        public static SqlConnection KetNoi()
        {
            string strConn = @"Data Source=.;Initial Catalog=QLSV23;Integrated Security=True;Encrypt=False";
            conn = new SqlConnection(strConn);
            return conn;
        }

        public static DataTable LayDuLieu(string sql)
        {
            SqlDataAdapter da = new SqlDataAdapter(sql, KetNoi());
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
  
        public static void GanNguonDataGridView(DataGridView dgDanhSach, string sql)
        {
            dgDanhSach.DataSource = LayDuLieu(sql);
        }
        public static void GanNguonComboBox(ComboBox cboName, string TableName, string DisplayField, string KeyField)
        {
            sql = $"Select {KeyField},{DisplayField} From {TableName}";
            cboName.DataSource = LayDuLieu(sql);
            cboName.DisplayMember = DisplayField;
            cboName.ValueMember = KeyField;
        }
        public static bool XoaHang(DataGridView dtdanhsach, string bang, string cot, string dieukien)
        {
            string lenhxoa = "DELETE FROM " + bang + " WHERE " + cot + " = '" + dieukien + "'";
            try
            {
                cmd = new SqlCommand(lenhxoa, KetNoi());
                if (conn.State != ConnectionState.Open)
                {
                    conn.Open();
                }
                cmd.ExecuteNonQuery();
                return true;
            }
            catch (Exception ex) { return false; }
        }
            
        public static bool ktTrungMa(string FieldName, string Table, bool ktThem,string ValueNew, string ValueOld)
        {
            if (ktThem == true)
                sql = "Select " + FieldName + " From " + Table + " Where " +FieldName + " = '" + ValueNew + "'";
            else
                sql = "Select " + FieldName + " From " + Table + " Where " +FieldName + " = '" + ValueNew + "' and " + FieldName + " <> '" + ValueOld + "'";
            DataTable dt = LayDuLieu(sql);
            if (dt.Rows.Count > 0)
                return true;
            else
                return false;
        }
    }
}
    

