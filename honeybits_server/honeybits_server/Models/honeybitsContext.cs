using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace honeybits_server.Models
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

        public virtual DbSet<Product> Product { get; set; }
        public virtual DbSet<ProductCategory> ProductCategory { get; set; }
        public virtual DbSet<Role> Role { get; set; }
        public virtual DbSet<Shop> Shop { get; set; }
        public virtual DbSet<ShopProduct> ShopProduct { get; set; }
        public virtual DbSet<Users> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseMySql("Server=main-mysql-server.mysql.database.azure.com; Port=3306; Database=honeybits; Uid=mlopez@main-mysql-server; Pwd=@costA19732846;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Product>(entity =>
            {
                entity.ToTable("product");

                entity.Property(e => e.ProductId).HasColumnName("product_id");

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
            });

            modelBuilder.Entity<ProductCategory>(entity =>
            {
                entity.ToTable("product_category");

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
            });

            modelBuilder.Entity<Role>(entity =>
            {
                entity.ToTable("role");

                entity.Property(e => e.RoleId).HasColumnName("role_id");

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
            });

            modelBuilder.Entity<Shop>(entity =>
            {
                entity.ToTable("shop");

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

            modelBuilder.Entity<Users>(entity =>
            {
                entity.HasKey(e => e.UserId)
                    .HasName("PRIMARY");

                entity.ToTable("users");

                entity.HasIndex(e => e.Email)
                    .HasName("email")
                    .IsUnique();

                entity.Property(e => e.UserId).HasColumnName("user_id");

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
            });
        }
    }
}
