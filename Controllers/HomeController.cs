using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SkillInventory.Models;
using System.Diagnostics;

namespace SkillInventory.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }
   
        public IActionResult Dashboard()
        {
            return View();
        }

        public IActionResult ViewSkill()
        {
            return View();
        }
   
        public IActionResult Registration()
        {
            return View();
        }
     
        public IActionResult AddSkill()
        {
            return View();
        }

        public IActionResult Login()
        {
            return View();
        }

        public IActionResult Test()
        {
            return View();
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Login", "Home");
        }

    }
}