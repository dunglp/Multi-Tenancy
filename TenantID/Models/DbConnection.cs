using System.Threading.Tasks;
using System.Data.Entity;
using TenantID.Models.Entity;

namespace TenantID.Models
{
    public class DbConnection : DbContext
    {
        public virtual DbSet<User> Users { get; set; }
    }
}