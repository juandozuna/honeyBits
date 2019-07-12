using System;
using System.Collections.Generic;

namespace honeybits_server.Models
{
    public partial class Role
    {
        public uint RoleId { get; set; }
        public string Description { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool? IsDeleted { get; set; }
        public int? DeletedBy { get; set; }
        public DateTime? DeletedDate { get; set; }
    }
}
