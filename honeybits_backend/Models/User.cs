using System;
using honeybits_backend.Models.Enums;

namespace honeybits_backend.Models {
    public class User {
        public int Id { get; set; }
        public String FirstName { get; set; }
        public String LastName { get; set; }
        public DateTime Birthdate { get; set; }

        public String Username { get; set; }
        public String Password { get; set; }
        public Role Role { get; set; }
        
    }
}