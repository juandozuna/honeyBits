using System;
using System.Collections.Generic;

namespace honeybits_server.Models
{
    public partial class ShopProduct
    {
        public int ShopProductId { get; set; }
        public int ShopId { get; set; }
        public int ProductId { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
    }
}
