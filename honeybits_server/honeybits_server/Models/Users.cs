using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace honeybits_server.Models
{
    public partial class Users
    {
        [Key]
        public uint UserId { get; set; }
        [Required]
        [MinLength(2, ErrorMessage = "Minimum lenght is 2")]
        [MaxLength(250, ErrorMessage = "Max lenght is 250")]
        public string FirstName { get; set; }

        [Required]
        [MinLength(2, ErrorMessage = "Minimum lenght is 2")]
        [MaxLength(250, ErrorMessage = "Max lenght is 250")]
        public string LastName { get; set; }

        [Required]
        [EmailAddress(ErrorMessage = "Invalid email address")]
        public string Email { get; set; }

        [Required]
        public DateTime Birtdate { get; set; }
        [Required]
        public int RoleId { get; set; }
        [Required]
        public string Username { get; set; }
        [Required]
        public string Passwd { get; set; }

        public DateTime? CreatedDate { get; set; } = DateTime.Now;
    }
}
