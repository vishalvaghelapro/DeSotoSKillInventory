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
        
        public IActionResult Dashboard(Charts charts)
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

            //var echartData = lst.Select(item => new
            //{
            //    value = item.Employees,
            //    name = item.SkillName
            //});
            // Convert string integers to actual integers using LINQ
            //int[] intArray = stringInts.Select(int.Parse).ToArray();
            //ViewBag.PieChartDataJson = CategorycommaSeparatedValues.ToArray(); // Convert to JSON
            //ViewBag.Department = CategorycommaSeparatedValues.ToArray();
            ViewBag.Employees = StockcommaSeparatedValues;
            ViewBag.SkillName = DepartmentNames;
            //ViewBag.ChartsData = echartData; 
           
            //ChartsViewModel viewModel = new ChartsViewModel();
            //foreach (var item in lst)
            //{
            //    viewModel.ChartsList.Add(new Charts { SkillName = item.SkillName, Employees = item.Employees });
            //} // Get your charts data

            ///return View(new Charts { Employees = StockcommaSeparatedValues, SkillName = CategorycommaSeparatedValues });

            return View(new ChartsViewModel { Employee = StockcommaSeparatedValues, SkillNames = DepartmentNames });
            //return View(viewModel);
            //return View(new Charts(lst));

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
        
        public IActionResult Login()
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