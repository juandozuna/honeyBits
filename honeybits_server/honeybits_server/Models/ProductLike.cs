using System;
using System.Collections.Generic;

namespace honeybits_server.Models
{
    public partial class ProductLike
    {
        public int ProductLikeId { get; set; }
        public int UserId { get; set; }
        public int ProductId { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool? IsDeleted { get; set; }
        public int? DeletedBy { get; set; }
        public DateTime? DeletedDate { get; set; }

        public virtual Users CreatedByNavigation { get; set; }
        public virtual Users DeletedByNavigation { get; set; }
        public virtual Product Product { get; set; }
        public virtual Users User { get; set; }
    }
}
