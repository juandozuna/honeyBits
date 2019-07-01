using System;

namespace honeybits_backend.Models {
    public class User {
        public int Id { get; set; }
        public String FirstName { get; set; }
        public String LastName { get; set; }
        public DateTime Birthdate { get; set; }
        
    }
}