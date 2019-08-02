using System;
using System.Collections.Generic;

namespace honeybits_server.Model
{
    public partial class ProductImage
    {
        public int ProductImageId { get; set; }
        public int ProductId { get; set; }
        public string ProductImageName { get; set; }
        public string ProductImageDescription { get; set; }
        public string ProductImageType { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool? IsDeleted { get; set; }
        public int? DeletedBy { get; set; }
        public DateTime? DeletedDate { get; set; }

        public virtual Users CreatedByNavigation { get; set; }
        public virtual Users DeletedByNavigation { get; set; }
        public virtual Product Product { get; set; }
    }
}
