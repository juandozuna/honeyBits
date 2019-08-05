using System;
using System.Collections.Generic;

namespace honeybits_server.Models
{
    public partial class Product
    {
        public Product()
        {
            ProductImage = new HashSet<ProductImage>();
            ProductLike = new HashSet<ProductLike>();
        }

        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public int ProductCategoryId { get; set; }
        public string ProductDescription { get; set; }
        public decimal? ProductPrice { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool? IsDeleted { get; set; }
        public int? DeletedBy { get; set; }
        public DateTime? DeletedDate { get; set; }

        public virtual Users CreatedByNavigation { get; set; }
        public virtual Users DeletedByNavigation { get; set; }
        public virtual ProductCategory ProductCategory { get; set; }
        public virtual ICollection<ProductImage> ProductImage { get; set; }
        public virtual ICollection<ProductLike> ProductLike { get; set; }
    }
}
