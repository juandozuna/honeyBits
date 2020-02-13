using honeybits_server.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.DTOs
{
    public class ProductDTO
    {
        public int ProductId { get; set; }
        
        [Required]
        [StringLength(150, ErrorMessage = "Max lenght for product name is 150 characters.")]
        [MinLength(2, ErrorMessage = "Minimum lenght for product name is 2 characters.")]
        public string ProductName { get; set; }

        [Required]
        [StringLength(150, ErrorMessage = "Max lenght for product name is 150 characters.")]
        [MinLength(2, ErrorMessage = "Minimum lenght for product name is 2 characters.")]
        public string ProductDescription { get; set; }
        public decimal? ProductPrice { get; set; }
        
        [Required]
        public int ProductCategoryId { get; set; }

        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool? IsDeleted { get; set; }
        public int? DeletedBy { get; set; }

        public IEnumerable<ProductImageDTO> ProductImages { get; set; }
        public int ProductLikes { get; set; }
    }
}