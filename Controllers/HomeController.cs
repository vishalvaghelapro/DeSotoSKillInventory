using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json;
using SkillInventory.Models;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Linq;

namespace SkillInventory.Controllers
{
    public class HomeController : Controller
    {

        private readonly ILogger<HomeController> _logger;
        public IConfiguration Configuration { get; }

        public HomeController(ILogger<HomeController> logger, IConfiguration configuration)
        {
            _logger = logger;
            Configuration = configuration;
        }
        public IActionResult Login()
        {
            return View();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="charts"></param>
        /// <param name="employee"></param>
        /// <param name="employesSkills"></param>
        /// <returns></returns>
        
        [Authorize]
        public IActionResult Dashboard(Charts charts, Employee employee, EmployesSkills employesSkills)
        {
            List<object> viewModel = new List<object>();
            var emp = EmployeeInfo(employee);
            var pieChartData = PieChart(charts);

            //viewModel.Add(emp);
            //viewModel.Add(pieChartData);
            return View(pieChartData);
            //return View();
        }

        public ChartsViewModel PieChart(Charts charts)
        {
            SqlConnection conn = new SqlConnection(Configuration.GetConnectionString("DefaultConnection"));
            List<Charts> lst = new List<Charts>();
            SqlCommand cmd = conn.CreateCommand();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "DepartmentEmp";

            conn.Open();
            da.Fill(dt);
            conn.Close();

            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(
                    new Charts
                    {
                        SkillName = Convert.ToString(dr["SkillName"]),
                        Employees = Convert.ToString(dr["Employees"]),

                    });
            }

            Charts[] ChartsArray = lst.ToArray();
            string[] DepartmentNames = ChartsArray.Select(x => x.SkillName.Replace(" ", "")).ToArray();
            string[] Employees = ChartsArray.Select(x => x.Employees).ToArray();

            int[] Employee = ChartsArray.Select(x => Convert.ToInt32(x.Employees)).ToArray();
            string CategorycommaSeparatedValues = string.Join(", ", DepartmentNames);
            string StockcommaSeparatedValues = string.Join(", ", Employees);
            string[] stringInts = CategorycommaSeparatedValues.Split(',');


            ViewBag.Employees = StockcommaSeparatedValues;
            ViewBag.SkillName = DepartmentNames;

            //   return RedirectToAction("Dashboard", new ChartsViewModel { Employee = StockcommaSeparatedValues, SkillNames = DepartmentNames });
            return new ChartsViewModel { Employee = StockcommaSeparatedValues, SkillNames = DepartmentNames };
        }

        public Employee EmployeeInfo(Employee employee)
        {
            var employeeId = HttpContext.Session.GetInt32("EmpID");
            employee.EmployeeId = Convert.ToInt32(employeeId);
            Console.WriteLine(employeeId);
            return employee;
        }

        [Authorize]
        public IActionResult ViewSkill()
        {
            return View();
        }

        public IActionResult Registration()
        {
            return View();
        }
        [Authorize]
        public IActionResult AddSkill()
        {
            return View();
        }
     
      
        [Authorize]
        public IActionResult Test()
        {
            return View();
        }
        [Authorize]
        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Login", "Home");
        }

    }
}