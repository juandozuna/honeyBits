using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.DTOs
{
    public class ProductImageDTO
    {
        public int ProductImageId { get; set; }
        public int ProductId { get; set; }
        public string ProductImageName { get; set; }
        public string ProductImageDesc { get; set; }
        public string ProductImageType { get; set; }
        public string ImageContent { get; set; }
    }
}
