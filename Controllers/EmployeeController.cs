using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using SkillInventory.Models;
using System.Configuration;
using System.Data;

namespace SkillInventory.Controllers
{
    public class EmployeeController : Controller
    {
        public IConfiguration Configuration { get; }
        public EmployeeController(IConfiguration configuration)
        {
            Configuration = configuration;
        }
        [HttpGet]
        public JsonResult GetSkillName()
        {
            try
            {
                SqlConnection conn = new SqlConnection(Configuration.GetConnectionString("DefaultConnection"));
                List<Skill> lst = new List<Skill>();
                SqlCommand cmd = conn.CreateCommand();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "GetSkill";

                conn.Open();
                da.Fill(dt);
                conn.Close();

                foreach (DataRow dr in dt.Rows)
                {
                    lst.Add(
                        new Skill
                        {
                            SkillId = Convert.ToInt32(dr["Skillid"]),
                            SkillName = Convert.ToString(dr["SkillName"])
                        });

                }

                var data = lst;
                return new JsonResult(data);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);

            }
            return new JsonResult(null);
        }

        [HttpGet]
        public JsonResult GetDepartmentName()
        {
            try
            {
                SqlConnection conn = new SqlConnection(Configuration.GetConnectionString("DefaultConnection"));
                List<Department> lst = new List<Department>();
                SqlCommand cmd = conn.CreateCommand();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "GetDepartment";

                conn.Open();
                da.Fill(dt);
                conn.Close();

                foreach (DataRow dr in dt.Rows)
                {
                    lst.Add(
                        new Department
                        {
                            //DepartmentId = Convert.ToInt32(dr["DepartmentId"]),
                            DepartmentName = Convert.ToString(dr["DepartmentName"])
                        });

                }

                var data = lst;
                return new JsonResult(data);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            return new JsonResult(null);

        }

        [HttpPost]
        public JsonResult AddEmployee(Employee employee)
        {
            string status = "";

            // Validate employee data (consider adding more validations as needed)
            if (employee == null ||
                string.IsNullOrEmpty(employee.FirstName) ||
                string.IsNullOrEmpty(employee.LastName) ||
                string.IsNullOrEmpty(employee.Email) ||
                string.IsNullOrEmpty(employee.Department) ||
                string.IsNullOrEmpty(employee.Roll) ||
                string.IsNullOrEmpty(employee.Password))
            {
                status = "null";
                return Json(status);
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(Configuration.GetConnectionString("DefaultConnection")))
                {
                    SqlCommand cmd = new SqlCommand("Registration", conn);
                    cmd.CommandType = CommandType.StoredProcedure; // Ensure it's a stored procedure

                    cmd.Parameters.AddWithValue("@FirstName", employee.FirstName);
                    cmd.Parameters.AddWithValue("@LastName", employee.LastName);
                    cmd.Parameters.AddWithValue("@Email", employee.Email);
                    cmd.Parameters.AddWithValue("@Department", employee.Department);
                    cmd.Parameters.AddWithValue("@Roll", employee.Roll);
                    cmd.Parameters.AddWithValue("@Password", EncryptPasswordBase64(employee.Password));

                    conn.Open();
                    cmd.ExecuteNonQuery();  // This line might throw an exception if the stored procedure raises RAISERROR
                }

                status = "Success";
                return Json(status);
            }
            catch (SqlException ex)  // Catch specific SqlException for database-related errors
            {
                // Check for specific error codes or messages from the stored procedure's RAISERROR
                if (ex.Message.Contains("already exists"))  // Example check for duplicate email error
                {
                    status = "Error: Email already exists";
                }
                else
                {
                    status = "Error: An error occurred while adding the employee.";
                }

                // Log the exception for debugging
                Console.WriteLine(ex.Message);

                return Json(status);
            }
            catch (Exception ex)  // Catch any other unexpected exceptions
            {
                status = "Error: An unexpected error occurred.";
                Console.WriteLine(ex.Message);
                return Json(status);
            }
        }

        public static string EncryptPasswordBase64(string text)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(text);
            return System.Convert.ToBase64String(plainTextBytes);
        }
        [HttpPost]
        public JsonResult AddSkill(Employee employee)
        {
           
            try
            {
                using (SqlConnection conn = new SqlConnection(Configuration.GetConnectionString("DefaultConnection")))
                {
                    SqlCommand cmd = new SqlCommand("InsertData", conn);
                    cmd.CommandType = CommandType.StoredProcedure; // Ensure it's a stored procedure

                    cmd.Parameters.AddWithValue("@FirstName", employee.FirstName);
                    cmd.Parameters.AddWithValue("@LastName", employee.LastName);
                    cmd.Parameters.AddWithValue("@Email", employee.Email);
                    cmd.Parameters.AddWithValue("@Department", employee.Department);
                    cmd.Parameters.AddWithValue("@Roll", employee.Roll);
                    cmd.Parameters.AddWithValue("@Password", EncryptPasswordBase64(employee.Password));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                return Json("");
                // return Json(new { status = "Saved" }); // Indicate success without revealing sensitive data
            }
            catch (Exception ex)
            {
                // Log the exception for debugging
                Console.WriteLine(ex.Message);
                

                // Return a generic error message to avoid exposing details

            }
            return Json("");
        }
    }
    
}
