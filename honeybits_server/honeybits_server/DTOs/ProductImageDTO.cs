using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.DTOs
{
    public class ProductImageDTO
    {
        public int ProductImageId { get; set; }
        
        [Required]
        public int ProductId { get; set; }
        
        [Required]
        [StringLength(250, MinimumLength=3, ErrorMessage="Image name is less than 2 or more than 250 characters.")]
        public string ProductImageName { get; set; }
        
        [StringLength(500, MinimumLength=5, ErrorMessage="Image description is less than 5 or more than 500 characters.")]
        public string ProductImageDesc { get; set; }
        
        [Required]
        public string ProductImageType { get; set; }
        
        [Required]
        public string ImageContent { get; set; }

        public int CreatedBy { get; set; }
        
    }
}
