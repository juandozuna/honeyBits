
using System.Collections.Generic;

namespace honeybits_server.DTOs {
    public class ProductCategoryDTO {
        public int ProductCategoryId { get; set; }
        public string ProductCategoryName { get; set; }
        public string ProductCategoryDescription { get; set; }

        public IEnumerable<ProductDTO> Products { get; set; }
    }
}