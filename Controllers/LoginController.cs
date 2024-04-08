using Microsoft.AspNetCore.Mvc;

namespace SkillInventory.Controllers
{
    public class LoginController : Controller
    {
        public IConfiguration Configuration { get; }
        public LoginController(IConfiguration configuration)
        {
            Configuration = configuration;
        }
        public IActionResult Login()
        {
            return View();
        }
    }
}
