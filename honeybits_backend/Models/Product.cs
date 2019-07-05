using System;
using System.Collections.Generic;

namespace honeybits_backend.Models
{
    public partial class Product
    {
        public uint ProductId { get; set; }
        public string ProductName { get; set; }
        public string ProductDescription { get; set; }
        public decimal? ProductPrice { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
    }
}
