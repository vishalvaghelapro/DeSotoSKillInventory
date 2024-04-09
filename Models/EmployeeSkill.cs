using System.ComponentModel.DataAnnotations;

namespace SkillInventory.Models
{
    public class EmployeeSkill
    {
        [Key]
        public int EmployeeSkillId { get; set; }
        public int EmployeeId { get; set; }
        public int SkillId { get; set; }
        public String ProficiencyLevl { get; set; }
        public char IsDelete { get; set; }
    }
}
