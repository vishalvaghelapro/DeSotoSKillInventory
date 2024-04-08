using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc.Razor;
using Microsoft.IdentityModel.Tokens;
using System.Configuration;
using System.Security.Policy;
using System.Text;

namespace SkillInventory
{
    public class Startup
    {
        public IConfiguration configRoot
        {
            get;
        }
        public Startup(IConfiguration configuration)
        {
            configRoot = configuration;

        }
        public void ConfigureServices(IServiceCollection services, WebApplicationBuilder builder)
        {
            services.AddRazorPages();
        }
        public void Configure(WebApplication app, IWebHostEnvironment env)
        {
            if (!app.Environment.IsDevelopment())
            {
                app.UseExceptionHandler("/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }
            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseRouting();
            app.UseAuthorization();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                name: "default",
                pattern: "{controller=Home}/{action=AddSkill}/{id?}");
                endpoints.MapControllerRoute(
                name: "Registration",
                pattern: "{controller=Home}/{action=Registration}/{id?}");
                endpoints.MapControllerRoute(
                name: "Login",
                pattern: "{controller=Login}/{action=Login}/{id?}");


            });

            app.Run();
        }

     
    }
}