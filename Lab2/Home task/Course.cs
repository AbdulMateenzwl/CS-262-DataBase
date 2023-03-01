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
    public partial class Course : Form
    {
        public Course()
        {
            InitializeComponent();
        }
        private void button2_Click(object sender, EventArgs e)
        {
            var con = Configuration.getInstance().getConnection();
            SqlCommand cmd = new SqlCommand("Insert into Course values (@CourseId, @CourseName, @StudentName,@TeacherName,@Semester)", con);
            cmd.Parameters.AddWithValue("@CourseId", courseIdtxtbox.Text);
            cmd.Parameters.AddWithValue("@CourseName", coursenametxtbox.Text);
            cmd.Parameters.AddWithValue("@StudentName", studentnametxtbox.Text);
            cmd.Parameters.AddWithValue("@Semester", semestertxtbox.Text);
            cmd.Parameters.AddWithValue("@TeacherName", teachernametxtbox.Text);
            cmd.ExecuteNonQuery();
            MessageBox.Show("Successfully saved");
            clearData();
        }
        private void button1_Click(object sender, EventArgs e)
        {
            var con = Configuration.getInstance().getConnection();
            SqlCommand cmd = new SqlCommand("DELETE from Course WHERE CourseId=@CourseId", con);
            cmd.Parameters.AddWithValue("@CourseId", courseIdtxtbox.Text);
            cmd.ExecuteNonQuery();
            MessageBox.Show("Successfully Deleted");
            clearData();
        }
        private void button4_Click(object sender, EventArgs e)
        {
            var con = Configuration.getInstance().getConnection();
            SqlCommand cmd = new SqlCommand("Select * from Course", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
        }
        private void button3_Click(object sender, EventArgs e)
        {
            var con = Configuration.getInstance().getConnection();
            SqlCommand cmd = new SqlCommand("UPDATE  Course " +
                "SET CourseId=@CourseId, CourseName=@CourseName, StudentName=@StudentName,Semester=@Semester,TeacherName=@TeacherName " +
                "WHERE CourseId=@CourseId", con);
            cmd.Parameters.AddWithValue("@CourseId", courseIdtxtbox.Text);
            cmd.Parameters.AddWithValue("@CourseName", coursenametxtbox.Text);
            cmd.Parameters.AddWithValue("@StudentName", studentnametxtbox.Text);
            cmd.Parameters.AddWithValue("@Semester", semestertxtbox.Text);
            cmd.Parameters.AddWithValue("@TeacherName", teachernametxtbox.Text);
            cmd.ExecuteNonQuery();
            MessageBox.Show("Successfully UPDATED");
            clearData();
        }
        private void button5_Click(object sender, EventArgs e)
        {
            var con = Configuration.getInstance().getConnection();
            SqlCommand cmd = new SqlCommand("SELECT * FROM  Course " +
                "WHERE CourseId=@CourseId", con);
            cmd.Parameters.AddWithValue("@CourseId", courseIdtxtbox.Text);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            MessageBox.Show("Operation Completed");
            clearData();
        }
        private void clearData()
        {
            courseIdtxtbox.Text = "";
            coursenametxtbox.Text = "";
            studentnametxtbox.Text = "";
            semestertxtbox.Text = "";
            teachernametxtbox.Text = "";
        }
        private void dataGridView1_RowHeaderMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            courseIdtxtbox.Text = dataGridView1.Rows[e.RowIndex].Cells[0].Value.ToString();
            coursenametxtbox.Text = dataGridView1.Rows[e.RowIndex].Cells[1].Value.ToString();
            studentnametxtbox.Text = dataGridView1.Rows[e.RowIndex].Cells[2].Value.ToString();
            semestertxtbox.Text = dataGridView1.Rows[e.RowIndex].Cells[3].Value.ToString();
            teachernametxtbox.Text = dataGridView1.Rows[e.RowIndex].Cells[4].Value.ToString();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label9_Click(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void courseIdtxtbox_TextChanged(object sender, EventArgs e)
        {

        }

        private void label7_Click(object sender, EventArgs e)
        {

        }

        private void coursenametxtbox_TextChanged(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label8_Click(object sender, EventArgs e)
        {

        }
    }
}
