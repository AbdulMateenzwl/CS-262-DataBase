using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Lab2_GettingStartedWithDatabase
{
    public partial class Registration : Form
    {
        public Registration()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            var con = Configuration.getInstance().getConnection();
            SqlCommand cmd = new SqlCommand("Insert into Enrollments values (@RegNo, @CourseName)", con);
            cmd.Parameters.AddWithValue("@RegNo", regNotxtbox.Text);
            cmd.Parameters.AddWithValue("@CourseName", coursenametxtbox.Text);
            cmd.ExecuteNonQuery();
            MessageBox.Show("Successfully saved");
            clearData();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            var con = Configuration.getInstance().getConnection();
            SqlCommand cmd = new SqlCommand("DELETE from Enrollments WHERE StudentRegNo=@RegNo AND CourseName=@CourseName", con);
            cmd.Parameters.AddWithValue("@RegNo", regNotxtbox.Text);
            cmd.Parameters.AddWithValue("@CourseName", coursenametxtbox.Text);
            cmd.ExecuteNonQuery();
            MessageBox.Show("Successfully Deleted");
            clearData();
        }

        private void clearData()
        {
            regNotxtbox.Text = "";
            coursenametxtbox.Text = "";
        }

        private void button4_Click(object sender, EventArgs e)
        {
            var con = Configuration.getInstance().getConnection();
            SqlCommand cmd = new SqlCommand("Select * from Enrollments", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
        }

        private void dataGridView1_RowHeaderMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            regNotxtbox.Text = dataGridView1.Rows[e.RowIndex].Cells[0].Value.ToString();
            coursenametxtbox.Text = dataGridView1.Rows[e.RowIndex].Cells[1].Value.ToString();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
