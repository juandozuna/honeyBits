using System;
using System.Collections.Generic;

namespace honeybits_server.Models
{
    public partial class Shop
    {
        public Shop()
        {
            ShopFollower = new HashSet<ShopFollower>();
        }

        public int ShopId { get; set; }
        public int OwnerId { get; set; }
        public string ShopName { get; set; }
        public string ShopDescription { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool? IsDeleted { get; set; }
        public int? DeletedBy { get; set; }
        public DateTime? DeletedDate { get; set; }

        public virtual Users CreatedByNavigation { get; set; }
        public virtual Users DeletedByNavigation { get; set; }
        public virtual Users Owner { get; set; }
        public virtual ICollection<ShopFollower> ShopFollower { get; set; }
    }
}
