using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace honeybits_server.Models
{
    public partial class Shop
    {
        [Key]
        public int ShopId { get; set; }
        [Required]
        public int OwnerId { get; set; }
        [Required]
        [MinLength(3, ErrorMessage = "Minimun lenght is 3")]
        [MaxLength(250, ErrorMessage = "Maximum lengt is 250")]
        public string ShopName { get; set; }
        [MinLength(3, ErrorMessage = "Minimun lenght is 3")]
        [MaxLength(250, ErrorMessage = "Maximum lengt is 250")]
        public string ShopDescription { get; set; }
        [Required]
        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
    }
}
