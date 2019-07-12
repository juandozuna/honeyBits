using System;
using System.Collections.Generic;

namespace honeybits_server.Models
{
    public partial class Shop
    {
        public int ShopId { get; set; }
        public int OwnerId { get; set; }
        public string ShopName { get; set; }
        public string ShopDescription { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
    }
}
