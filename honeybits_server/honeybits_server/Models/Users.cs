using System;
using System.Collections.Generic;

namespace honeybits_server.Models
{
    public partial class Users
    {
        public uint UserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public DateTime Birtdate { get; set; }
        public int RoleId { get; set; }
        public string Username { get; set; }
        public string Passwd { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool? IsDeleted { get; set; }
        public int? DeletedBy { get; set; }
        public DateTime? DeletedDate { get; set; }
    }
}
