using System;
using System.Collections.Generic;

namespace honeybits_server.Models
{
    public partial class Users
    {
        public Users()
        {
            BeeTransactionCreatedByNavigation = new HashSet<BeeTransaction>();
            BeeTransactionDeletedByNavigation = new HashSet<BeeTransaction>();
            BeeTransactionUser = new HashSet<BeeTransaction>();
            InverseDeletedByNavigation = new HashSet<Users>();
            ProductCategoryCreatedByNavigation = new HashSet<ProductCategory>();
            ProductCategoryDeletedByNavigation = new HashSet<ProductCategory>();
            ProductCreatedByNavigation = new HashSet<Product>();
            ProductDeletedByNavigation = new HashSet<Product>();
            ProductImageCreatedByNavigation = new HashSet<ProductImage>();
            ProductImageDeletedByNavigation = new HashSet<ProductImage>();
            ProductLikeCreatedByNavigation = new HashSet<ProductLike>();
            ProductLikeDeletedByNavigation = new HashSet<ProductLike>();
            ProductLikeUser = new HashSet<ProductLike>();
            RoleCreatedByNavigation = new HashSet<Role>();
            RoleDeletedByNavigation = new HashSet<Role>();
            ShopCreatedByNavigation = new HashSet<Shop>();
            ShopDeletedByNavigation = new HashSet<Shop>();
            ShopFollowerCreatedByNavigation = new HashSet<ShopFollower>();
            ShopFollowerDeletedByNavigation = new HashSet<ShopFollower>();
            ShopFollowerUser = new HashSet<ShopFollower>();
            ShopOwner = new HashSet<Shop>();
            TransactionTypeCreatedByNavigation = new HashSet<TransactionType>();
            TransactionTypeDeletedByNavigation = new HashSet<TransactionType>();
        }

        public int UserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public DateTime Birtdate { get; set; }
        public int RoleId { get; set; }
        public string Username { get; set; }
        public string Passwd { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool? IsDeleted { get; set; }
        public int? DeletedBy { get; set; }
        public DateTime? DeletedDate { get; set; }

        public virtual Users DeletedByNavigation { get; set; }
        public virtual Role Role { get; set; }
        public virtual ICollection<BeeTransaction> BeeTransactionCreatedByNavigation { get; set; }
        public virtual ICollection<BeeTransaction> BeeTransactionDeletedByNavigation { get; set; }
        public virtual ICollection<BeeTransaction> BeeTransactionUser { get; set; }
        public virtual ICollection<Users> InverseDeletedByNavigation { get; set; }
        public virtual ICollection<ProductCategory> ProductCategoryCreatedByNavigation { get; set; }
        public virtual ICollection<ProductCategory> ProductCategoryDeletedByNavigation { get; set; }
        public virtual ICollection<Product> ProductCreatedByNavigation { get; set; }
        public virtual ICollection<Product> ProductDeletedByNavigation { get; set; }
        public virtual ICollection<ProductImage> ProductImageCreatedByNavigation { get; set; }
        public virtual ICollection<ProductImage> ProductImageDeletedByNavigation { get; set; }
        public virtual ICollection<ProductLike> ProductLikeCreatedByNavigation { get; set; }
        public virtual ICollection<ProductLike> ProductLikeDeletedByNavigation { get; set; }
        public virtual ICollection<ProductLike> ProductLikeUser { get; set; }
        public virtual ICollection<Role> RoleCreatedByNavigation { get; set; }
        public virtual ICollection<Role> RoleDeletedByNavigation { get; set; }
        public virtual ICollection<Shop> ShopCreatedByNavigation { get; set; }
        public virtual ICollection<Shop> ShopDeletedByNavigation { get; set; }
        public virtual ICollection<ShopFollower> ShopFollowerCreatedByNavigation { get; set; }
        public virtual ICollection<ShopFollower> ShopFollowerDeletedByNavigation { get; set; }
        public virtual ICollection<ShopFollower> ShopFollowerUser { get; set; }
        public virtual ICollection<Shop> ShopOwner { get; set; }
        public virtual ICollection<TransactionType> TransactionTypeCreatedByNavigation { get; set; }
        public virtual ICollection<TransactionType> TransactionTypeDeletedByNavigation { get; set; }
    }
}
