using System;
using System.Collections.Generic;

namespace honeybits_server.Model
{
    public partial class Role
    {
        public Role()
        {
            Users = new HashSet<Users>();
        }

        public int RoleId { get; set; }
        public string Description { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool? IsDeleted { get; set; }
        public int? DeletedBy { get; set; }
        public DateTime? DeletedDate { get; set; }

        public virtual Users CreatedByNavigation { get; set; }
        public virtual Users DeletedByNavigation { get; set; }
        public virtual ICollection<Users> Users { get; set; }
    }
}
