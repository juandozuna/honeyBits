using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace honeybits_server.Models
{
    public partial class Product
    {
        [Key]
        public uint ProductId { get; set; }
        [Required]
        [MinLength(2, ErrorMessage = "Minimum lenght is 2")]
        [MaxLength(250, ErrorMessage = "Max lenght is 250")]
        public string ProductName { get; set; }
        [Required]
        public int ProductCategoryId { get; set; }
        [Required]
        [MinLength(2, ErrorMessage = "Minimum lenght is 2")]
        [MaxLength(250, ErrorMessage = "Max lenght is 250")]
        public string ProductDescription { get; set; }
        [Required]
        public decimal? ProductPrice { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; } = DateTime.Now;
    }
}
