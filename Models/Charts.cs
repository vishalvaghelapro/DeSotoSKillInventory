namespace SkillInventory.Models
{
    public class Charts
    {
        public string SkillName { get; set; }
        public string Employees { get; set; }

       
    }
    public class ChartsViewModel
    {
        public List<Charts> ChartsList { get; set; }
        public ChartsViewModel()
        {
            ChartsList = new List<Charts>(); // Initialize an empty list
        }

        public string[] SkillNames { get; set; }
        public string Employee { get; set; }
    }

}
