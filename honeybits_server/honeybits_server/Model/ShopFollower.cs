using System;
using System.Collections.Generic;

namespace honeybits_server.Model
{
    public partial class ShopFollower
    {
        public int ShopFollowerId { get; set; }
        public int ShopId { get; set; }
        public int UserId { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool? IsDeleted { get; set; }
        public int? DeletedBy { get; set; }
        public DateTime? DeletedDate { get; set; }

        public virtual Users CreatedByNavigation { get; set; }
        public virtual Users DeletedByNavigation { get; set; }
        public virtual Shop Shop { get; set; }
        public virtual Users User { get; set; }
    }
}
