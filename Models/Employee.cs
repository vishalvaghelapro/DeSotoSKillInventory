using System.ComponentModel.DataAnnotations;
using System.Diagnostics.Eventing.Reader;

namespace SkillInventory.Models
{
    public class Employee
    {
        [Key]
        //public int EmployeeId { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? Email { get; set; }
        public string? Department { get; set; }
        public string? JobTitle { get; set; }
        public string? Roll { get; set; }
        public string? Password { get; set; }
        public List<EmployessSkills> EmployessSkillList { get; set; }
    }
    public class EmployessSkills
    {
        public int EmployeeSkillId { get; set; }
        public int EmployeeId { get; set; }
        public String SkillName { get; set; }
        public String ProficiencyLevel { get; set; }
        public char IsDelete { get; set; }

    }
}
