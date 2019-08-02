using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace honeybits_server.Model
{
    public partial class honeybitsContext : DbContext
    {
        public honeybitsContext()
        {
        }

        public honeybitsContext(DbContextOptions<honeybitsContext> options)
            : base(options)
        {
        }

        public virtual DbSet<BeeTransaction> BeeTransaction { get; set; }
        public virtual DbSet<Product> Product { get; set; }
        public virtual DbSet<ProductCategory> ProductCategory { get; set; }
        public virtual DbSet<ProductImage> ProductImage { get; set; }
        public virtual DbSet<ProductLike> ProductLike { get; set; }
        public virtual DbSet<Role> Role { get; set; }
        public virtual DbSet<Shop> Shop { get; set; }
        public virtual DbSet<ShopFollower> ShopFollower { get; set; }
        public virtual DbSet<ShopProduct> ShopProduct { get; set; }
        public virtual DbSet<TransactionType> TransactionType { get; set; }
        public virtual DbSet<Users> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseMySql("Server=main-mysql-server.mysql.database.azure.com; Port=3306; Database=honeybits; Uid=mlopez@main-mysql-server; Pwd=@costA19732846;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BeeTransaction>(entity =>
            {
                entity.ToTable("bee_transaction");

                entity.HasIndex(e => e.CreatedBy)
                    .HasName("created_by");

                entity.HasIndex(e => e.DeletedBy)
                    .HasName("deleted_by");

                entity.HasIndex(e => e.TransactionTypeId)
                    .HasName("transaction_type_id");

                entity.HasIndex(e => e.UserId)
                    .HasName("user_id");

                entity.Property(e => e.BeeTransactionId)
                    .HasColumnName("bee_transaction_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.BeeAmount)
                    .HasColumnName("bee_amount")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedBy)
                    .HasColumnName("created_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedDate)
                    .HasColumnName("created_date")
                    .HasColumnType("timestamp")
                    .HasDefaultValueSql("'CURRENT_TIMESTAMP'");

                entity.Property(e => e.DeletedBy)
                    .HasColumnName("deleted_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.DeletedDate)
                    .HasColumnName("deleted_date")
                    .HasColumnType("timestamp");

                entity.Property(e => e.IsDeleted)
                    .HasColumnName("is_deleted")
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("'b\\'0\\''");

                entity.Property(e => e.TransactionTypeId)
                    .HasColumnName("transaction_type_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.UserId)
                    .HasColumnName("user_id")
                    .HasColumnType("int(11)");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.BeeTransactionCreatedByNavigation)
                    .HasForeignKey(d => d.CreatedBy)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("bee_transaction_ibfk_3");

                entity.HasOne(d => d.DeletedByNavigation)
                    .WithMany(p => p.BeeTransactionDeletedByNavigation)
                    .HasForeignKey(d => d.DeletedBy)
                    .HasConstraintName("bee_transaction_ibfk_4");

                entity.HasOne(d => d.TransactionType)
                    .WithMany(p => p.BeeTransaction)
                    .HasForeignKey(d => d.TransactionTypeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("bee_transaction_ibfk_2");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.BeeTransactionUser)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("bee_transaction_ibfk_1");
            });

            modelBuilder.Entity<Product>(entity =>
            {
                entity.ToTable("product");

                entity.HasIndex(e => e.CreatedBy)
                    .HasName("created_by");

                entity.HasIndex(e => e.DeletedBy)
                    .HasName("deleted_by");

                entity.HasIndex(e => e.ProductCategoryId)
                    .HasName("product_category_id");

                entity.Property(e => e.ProductId)
                    .HasColumnName("product_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedBy)
                    .HasColumnName("created_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedDate)
                    .HasColumnName("created_date")
                    .HasColumnType("timestamp")
                    .HasDefaultValueSql("'CURRENT_TIMESTAMP'");

                entity.Property(e => e.DeletedBy)
                    .HasColumnName("deleted_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.DeletedDate)
                    .HasColumnName("deleted_date")
                    .HasColumnType("timestamp");

                entity.Property(e => e.IsDeleted)
                    .HasColumnName("is_deleted")
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("'b\\'0\\''");

                entity.Property(e => e.ProductCategoryId)
                    .HasColumnName("product_category_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.ProductDescription)
                    .HasColumnName("product_description")
                    .HasColumnType("varchar(1000)");

                entity.Property(e => e.ProductName)
                    .IsRequired()
                    .HasColumnName("product_name")
                    .HasColumnType("varchar(255)");

                entity.Property(e => e.ProductPrice)
                    .HasColumnName("product_price")
                    .HasColumnType("decimal(6,2)");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.ProductCreatedByNavigation)
                    .HasForeignKey(d => d.CreatedBy)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("product_ibfk_2");

                entity.HasOne(d => d.DeletedByNavigation)
                    .WithMany(p => p.ProductDeletedByNavigation)
                    .HasForeignKey(d => d.DeletedBy)
                    .HasConstraintName("product_ibfk_3");

                entity.HasOne(d => d.ProductCategory)
                    .WithMany(p => p.Product)
                    .HasForeignKey(d => d.ProductCategoryId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("product_ibfk_1");
            });

            modelBuilder.Entity<ProductCategory>(entity =>
            {
                entity.ToTable("product_category");

                entity.HasIndex(e => e.CreatedBy)
                    .HasName("created_by");

                entity.HasIndex(e => e.DeletedBy)
                    .HasName("deleted_by");

                entity.Property(e => e.ProductCategoryId)
                    .HasColumnName("product_category_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedBy)
                    .HasColumnName("created_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedDate)
                    .HasColumnName("created_date")
                    .HasColumnType("timestamp")
                    .HasDefaultValueSql("'CURRENT_TIMESTAMP'");

                entity.Property(e => e.DeletedBy)
                    .HasColumnName("deleted_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.DeletedDate)
                    .HasColumnName("deleted_date")
                    .HasColumnType("timestamp");

                entity.Property(e => e.IsDeleted)
                    .HasColumnName("is_deleted")
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("'b\\'0\\''");

                entity.Property(e => e.ProductCategoryDescription)
                    .IsRequired()
                    .HasColumnName("product_category_description")
                    .HasColumnType("varchar(500)");

                entity.Property(e => e.ProductCategoryName)
                    .IsRequired()
                    .HasColumnName("product_category_name")
                    .HasColumnType("varchar(255)");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.ProductCategoryCreatedByNavigation)
                    .HasForeignKey(d => d.CreatedBy)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("product_category_ibfk_1");

                entity.HasOne(d => d.DeletedByNavigation)
                    .WithMany(p => p.ProductCategoryDeletedByNavigation)
                    .HasForeignKey(d => d.DeletedBy)
                    .HasConstraintName("product_category_ibfk_2");
            });

            modelBuilder.Entity<ProductImage>(entity =>
            {
                entity.ToTable("product_image");

                entity.HasIndex(e => e.CreatedBy)
                    .HasName("created_by");

                entity.HasIndex(e => e.DeletedBy)
                    .HasName("deleted_by");

                entity.HasIndex(e => e.ProductId)
                    .HasName("product_id");

                entity.Property(e => e.ProductImageId)
                    .HasColumnName("product_image_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedBy)
                    .HasColumnName("created_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedDate)
                    .HasColumnName("created_date")
                    .HasColumnType("timestamp")
                    .HasDefaultValueSql("'CURRENT_TIMESTAMP'");

                entity.Property(e => e.DeletedBy)
                    .HasColumnName("deleted_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.DeletedDate)
                    .HasColumnName("deleted_date")
                    .HasColumnType("timestamp");

                entity.Property(e => e.IsDeleted)
                    .HasColumnName("is_deleted")
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("'b\\'0\\''");

                entity.Property(e => e.ProductId)
                    .HasColumnName("product_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.ProductImageDescription)
                    .HasColumnName("product_image_description")
                    .HasColumnType("varchar(500)");

                entity.Property(e => e.ProductImageName)
                    .IsRequired()
                    .HasColumnName("product_image_name")
                    .HasColumnType("varchar(255)");

                entity.Property(e => e.ProductImageType)
                    .IsRequired()
                    .HasColumnName("product_image_type")
                    .HasColumnType("varchar(15)");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.ProductImageCreatedByNavigation)
                    .HasForeignKey(d => d.CreatedBy)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("product_image_ibfk_2");

                entity.HasOne(d => d.DeletedByNavigation)
                    .WithMany(p => p.ProductImageDeletedByNavigation)
                    .HasForeignKey(d => d.DeletedBy)
                    .HasConstraintName("product_image_ibfk_3");

                entity.HasOne(d => d.Product)
                    .WithMany(p => p.ProductImage)
                    .HasForeignKey(d => d.ProductId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("product_image_ibfk_1");
            });

            modelBuilder.Entity<ProductLike>(entity =>
            {
                entity.ToTable("product_like");

                entity.HasIndex(e => e.CreatedBy)
                    .HasName("created_by");

                entity.HasIndex(e => e.DeletedBy)
                    .HasName("deleted_by");

                entity.HasIndex(e => e.ProductId)
                    .HasName("product_id");

                entity.HasIndex(e => e.UserId)
                    .HasName("user_id");

                entity.Property(e => e.ProductLikeId)
                    .HasColumnName("product_like_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedBy)
                    .HasColumnName("created_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedDate)
                    .HasColumnName("created_date")
                    .HasColumnType("timestamp")
                    .HasDefaultValueSql("'CURRENT_TIMESTAMP'");

                entity.Property(e => e.DeletedBy)
                    .HasColumnName("deleted_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.DeletedDate)
                    .HasColumnName("deleted_date")
                    .HasColumnType("timestamp");

                entity.Property(e => e.IsDeleted)
                    .HasColumnName("is_deleted")
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("'b\\'0\\''");

                entity.Property(e => e.ProductId)
                    .HasColumnName("product_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.UserId)
                    .HasColumnName("user_id")
                    .HasColumnType("int(11)");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.ProductLikeCreatedByNavigation)
                    .HasForeignKey(d => d.CreatedBy)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("product_like_ibfk_3");

                entity.HasOne(d => d.DeletedByNavigation)
                    .WithMany(p => p.ProductLikeDeletedByNavigation)
                    .HasForeignKey(d => d.DeletedBy)
                    .HasConstraintName("product_like_ibfk_4");

                entity.HasOne(d => d.Product)
                    .WithMany(p => p.ProductLike)
                    .HasForeignKey(d => d.ProductId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("product_like_ibfk_2");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.ProductLikeUser)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("product_like_ibfk_1");
            });

            modelBuilder.Entity<Role>(entity =>
            {
                entity.ToTable("role");

                entity.HasIndex(e => e.CreatedBy)
                    .HasName("created_by");

                entity.HasIndex(e => e.DeletedBy)
                    .HasName("deleted_by");

                entity.Property(e => e.RoleId)
                    .HasColumnName("role_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedBy)
                    .HasColumnName("created_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedDate)
                    .HasColumnName("created_date")
                    .HasColumnType("timestamp")
                    .HasDefaultValueSql("'CURRENT_TIMESTAMP'");

                entity.Property(e => e.DeletedBy)
                    .HasColumnName("deleted_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.DeletedDate)
                    .HasColumnName("deleted_date")
                    .HasColumnType("timestamp");

                entity.Property(e => e.Description)
                    .IsRequired()
                    .HasColumnName("description")
                    .HasColumnType("varchar(255)");

                entity.Property(e => e.IsDeleted)
                    .HasColumnName("is_deleted")
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("'b\\'0\\''");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.RoleCreatedByNavigation)
                    .HasForeignKey(d => d.CreatedBy)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("role_ibfk_1");

                entity.HasOne(d => d.DeletedByNavigation)
                    .WithMany(p => p.RoleDeletedByNavigation)
                    .HasForeignKey(d => d.DeletedBy)
                    .HasConstraintName("role_ibfk_2");
            });

            modelBuilder.Entity<Shop>(entity =>
            {
                entity.ToTable("shop");

                entity.HasIndex(e => e.CreatedBy)
                    .HasName("created_by");

                entity.HasIndex(e => e.DeletedBy)
                    .HasName("deleted_by");

                entity.HasIndex(e => e.OwnerId)
                    .HasName("owner_id");

                entity.HasIndex(e => e.ShopName)
                    .HasName("shop_name")
                    .IsUnique();

                entity.Property(e => e.ShopId)
                    .HasColumnName("shop_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedBy)
                    .HasColumnName("created_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedDate)
                    .HasColumnName("created_date")
                    .HasColumnType("timestamp")
                    .HasDefaultValueSql("'CURRENT_TIMESTAMP'");

                entity.Property(e => e.DeletedBy)
                    .HasColumnName("deleted_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.DeletedDate)
                    .HasColumnName("deleted_date")
                    .HasColumnType("timestamp");

                entity.Property(e => e.IsDeleted)
                    .HasColumnName("is_deleted")
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("'b\\'0\\''");

                entity.Property(e => e.OwnerId)
                    .HasColumnName("owner_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.ShopDescription)
                    .IsRequired()
                    .HasColumnName("shop_description")
                    .HasColumnType("varchar(255)");

                entity.Property(e => e.ShopName)
                    .IsRequired()
                    .HasColumnName("shop_name")
                    .HasColumnType("varchar(255)");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.ShopCreatedByNavigation)
                    .HasForeignKey(d => d.CreatedBy)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("shop_ibfk_2");

                entity.HasOne(d => d.DeletedByNavigation)
                    .WithMany(p => p.ShopDeletedByNavigation)
                    .HasForeignKey(d => d.DeletedBy)
                    .HasConstraintName("shop_ibfk_3");

                entity.HasOne(d => d.Owner)
                    .WithMany(p => p.ShopOwner)
                    .HasForeignKey(d => d.OwnerId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("shop_ibfk_1");
            });

            modelBuilder.Entity<ShopFollower>(entity =>
            {
                entity.ToTable("shop_follower");

                entity.HasIndex(e => e.CreatedBy)
                    .HasName("created_by");

                entity.HasIndex(e => e.DeletedBy)
                    .HasName("deleted_by");

                entity.HasIndex(e => e.ShopId)
                    .HasName("shop_id");

                entity.HasIndex(e => e.UserId)
                    .HasName("user_id");

                entity.Property(e => e.ShopFollowerId)
                    .HasColumnName("shop_follower_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedBy)
                    .HasColumnName("created_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedDate)
                    .HasColumnName("created_date")
                    .HasColumnType("timestamp")
                    .HasDefaultValueSql("'CURRENT_TIMESTAMP'");

                entity.Property(e => e.DeletedBy)
                    .HasColumnName("deleted_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.DeletedDate)
                    .HasColumnName("deleted_date")
                    .HasColumnType("timestamp");

                entity.Property(e => e.IsDeleted)
                    .HasColumnName("is_deleted")
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("'b\\'0\\''");

                entity.Property(e => e.ShopId)
                    .HasColumnName("shop_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.UserId)
                    .HasColumnName("user_id")
                    .HasColumnType("int(11)");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.ShopFollowerCreatedByNavigation)
                    .HasForeignKey(d => d.CreatedBy)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("shop_follower_ibfk_3");

                entity.HasOne(d => d.DeletedByNavigation)
                    .WithMany(p => p.ShopFollowerDeletedByNavigation)
                    .HasForeignKey(d => d.DeletedBy)
                    .HasConstraintName("shop_follower_ibfk_4");

                entity.HasOne(d => d.Shop)
                    .WithMany(p => p.ShopFollower)
                    .HasForeignKey(d => d.ShopId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("shop_follower_ibfk_2");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.ShopFollowerUser)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("shop_follower_ibfk_1");
            });

            modelBuilder.Entity<ShopProduct>(entity =>
            {
                entity.ToTable("shop_product");

                entity.Property(e => e.ShopProductId)
                    .HasColumnName("shop_product_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedBy)
                    .HasColumnName("created_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedDate)
                    .HasColumnName("created_date")
                    .HasColumnType("timestamp")
                    .HasDefaultValueSql("'CURRENT_TIMESTAMP'");

                entity.Property(e => e.DeletedBy)
                    .HasColumnName("deleted_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.DeletedDate)
                    .HasColumnName("deleted_date")
                    .HasColumnType("timestamp");

                entity.Property(e => e.IsDeleted)
                    .HasColumnName("is_deleted")
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("'b\\'0\\''");

                entity.Property(e => e.ProductId)
                    .HasColumnName("product_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.ShopId)
                    .HasColumnName("shop_id")
                    .HasColumnType("int(11)");
            });

            modelBuilder.Entity<TransactionType>(entity =>
            {
                entity.ToTable("transaction_type");

                entity.HasIndex(e => e.CreatedBy)
                    .HasName("created_by");

                entity.HasIndex(e => e.DeletedBy)
                    .HasName("deleted_by");

                entity.Property(e => e.TransactionTypeId)
                    .HasColumnName("transaction_type_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedBy)
                    .HasColumnName("created_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.CreatedDate)
                    .HasColumnName("created_date")
                    .HasColumnType("timestamp")
                    .HasDefaultValueSql("'CURRENT_TIMESTAMP'");

                entity.Property(e => e.DeletedBy)
                    .HasColumnName("deleted_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.DeletedDate)
                    .HasColumnName("deleted_date")
                    .HasColumnType("timestamp");

                entity.Property(e => e.IsDeleted)
                    .HasColumnName("is_deleted")
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("'b\\'0\\''");

                entity.Property(e => e.TransactionType1)
                    .IsRequired()
                    .HasColumnName("transaction_type")
                    .HasColumnType("varchar(250)");

                entity.Property(e => e.TransactionTypeDescription)
                    .HasColumnName("transaction_type_description")
                    .HasColumnType("varchar(500)");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.TransactionTypeCreatedByNavigation)
                    .HasForeignKey(d => d.CreatedBy)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("transaction_type_ibfk_1");

                entity.HasOne(d => d.DeletedByNavigation)
                    .WithMany(p => p.TransactionTypeDeletedByNavigation)
                    .HasForeignKey(d => d.DeletedBy)
                    .HasConstraintName("transaction_type_ibfk_2");
            });

            modelBuilder.Entity<Users>(entity =>
            {
                entity.HasKey(e => e.UserId)
                    .HasName("PRIMARY");

                entity.ToTable("users");

                entity.HasIndex(e => e.DeletedBy)
                    .HasName("deleted_by");

                entity.HasIndex(e => e.Email)
                    .HasName("email")
                    .IsUnique();

                entity.HasIndex(e => e.RoleId)
                    .HasName("role_id");

                entity.Property(e => e.UserId)
                    .HasColumnName("user_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.Birtdate)
                    .HasColumnName("birtdate")
                    .HasColumnType("datetime");

                entity.Property(e => e.CreatedDate)
                    .HasColumnName("created_date")
                    .HasColumnType("timestamp")
                    .HasDefaultValueSql("'CURRENT_TIMESTAMP'");

                entity.Property(e => e.DeletedBy)
                    .HasColumnName("deleted_by")
                    .HasColumnType("int(11)");

                entity.Property(e => e.DeletedDate)
                    .HasColumnName("deleted_date")
                    .HasColumnType("timestamp");

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasColumnName("email")
                    .HasColumnType("varchar(255)");

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasColumnName("first_name")
                    .HasColumnType("varchar(255)");

                entity.Property(e => e.IsDeleted)
                    .HasColumnName("is_deleted")
                    .HasColumnType("bit(1)")
                    .HasDefaultValueSql("'b\\'0\\''");

                entity.Property(e => e.LastName)
                    .IsRequired()
                    .HasColumnName("last_name")
                    .HasColumnType("varchar(255)");

                entity.Property(e => e.Passwd)
                    .IsRequired()
                    .HasColumnName("passwd")
                    .HasColumnType("varchar(255)");

                entity.Property(e => e.RoleId)
                    .HasColumnName("role_id")
                    .HasColumnType("int(11)");

                entity.Property(e => e.Username)
                    .IsRequired()
                    .HasColumnName("username")
                    .HasColumnType("varchar(255)");

                entity.HasOne(d => d.DeletedByNavigation)
                    .WithMany(p => p.InverseDeletedByNavigation)
                    .HasForeignKey(d => d.DeletedBy)
                    .HasConstraintName("users_ibfk_2");

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.Users)
                    .HasForeignKey(d => d.RoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("users_ibfk_1");
            });
        }
    }
}
