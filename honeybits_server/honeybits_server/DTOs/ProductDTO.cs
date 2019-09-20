using honeybits_server.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.DTOs
{
    public class ProductDTO
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string ProductDescription { get; set; }
        public decimal ProductPrice { get; set; }
        public int ProductCategoryId { get; set; }

        public IEnumerable<ProductImageDTO> ProductImages { get; set; }
        public IEnumerable<ProductLikeDTO> ProductLikes { get; set; }
    }
}