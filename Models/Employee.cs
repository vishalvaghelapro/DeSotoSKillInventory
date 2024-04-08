using System.ComponentModel.DataAnnotations;

namespace SkillInventory.Models
{
    public class Employee
    {
        [Key]
        public int EmployeeId { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? Email { get; set; }
        public string? Department { get; set; }
        public string? JobTitle { get; set; }
        public string? Roll { get; set; }
        public string? Password { get; set; }
    }
}
