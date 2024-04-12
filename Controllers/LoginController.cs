using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.IdentityModel.Tokens;
using NuGet.Common;
using SkillInventory.Models;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text;

namespace SkillInventory.Controllers
{
    public class LoginController : Controller
    {
        String token = "";
        public IConfiguration Configuration { get; }
        public LoginController(IConfiguration configuration)
        {
            Configuration = configuration;
        }
        public IActionResult Login()
        {
            return View();
        }
        [AllowAnonymous]
        [HttpPost]
        public IActionResult Login(Employee employee)
        {
            SqlConnection conn = new SqlConnection(Configuration.GetConnectionString("DefaultConnection"));
            Employee lstroll = new Employee();
            SqlCommand cmd = conn.CreateCommand();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            cmd.CommandText = "LoginSP";
            cmd.CommandType = CommandType.StoredProcedure;
            
    
            cmd.Parameters.AddWithValue("@FirstName", employee.Email);
           
            cmd.Parameters.AddWithValue("@Password", EncryptPasswordBase64(employee.Password) == null ? "" : EncryptPasswordBase64(employee.Password));
            Employee res = new Employee();
            SqlParameter Status = new SqlParameter();
            Status.ParameterName = "@Isvalid";
            Status.SqlDbType = SqlDbType.Bit;

            Status.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(Status);
            conn.Open();
            cmd.ExecuteNonQuery();

            conn.Close();
            if (Convert.ToString(Status.Value) == Convert.ToString(true))
            {
                token = GenerateJSONWebToken(employee);
                HttpClient client = new HttpClient();
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
                HttpContext.Session.SetString("JWToken", token);
                //  return RedirectToAction("HomeController/Home");
                return RedirectToAction("Home", "Home");
            }
            else
            {
                return Content("User is Not Exiest");
            }
            

        }
        private string GenerateJSONWebToken(Employee employee)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration["Jwt:Key"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[] {
            new Claim(JwtRegisteredClaimNames.Name, employee.Roll),
            new Claim(JwtRegisteredClaimNames.Prn, employee.Password)
            };

            var token = new JwtSecurityToken(Configuration["Jwt:Issuer"],
                Configuration["Jwt:Issuer"],
                claims,
                expires: DateTime.Now.AddMinutes(120),
                signingCredentials: credentials);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
        public static string EncryptPasswordBase64(string text)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(text);
            return System.Convert.ToBase64String(plainTextBytes);
        }
    }
}
