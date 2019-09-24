using honeybits_server.DTOs;
using honeybits_server.Models;
using honeybits_server.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.Services
{
    public class ProductService : IProductService
    {
        honeybitsContext _context = new honeybitsContext();

        public Product Create(Product product)
        {
            _context.Product.Add(product);
            _context.SaveChanges();

            return product;
        }

        public bool Delete(Product product)
        {
            product.CreatedDate = DateTime.Now;
            product.IsDeleted = true;

            var results = _context.SaveChanges();

            return results > 0;
        }

        public Product Get(int id) => _context.Product.Where(x => x.IsDeleted == false).FirstOrDefault();

        public IEnumerable<Product> GetAll() => _context.Product.ToList();

        public IEnumerable<ProductCategoryDTO> GetProductCategories()
        {
            var categories = _context.ProductCategory.ToList();
            List<ProductCategoryDTO> categoriesDTO = new List<ProductCategoryDTO>();

            foreach(var category in categories) {
                categoriesDTO.Add(new ProductCategoryDTO() {
                    ProductCategoryId = category.ProductCategoryId,
                    ProductCategoryName = category.ProductCategoryName,
                    ProductCategoryDescription = category.ProductCategoryDescription
                });
            }

            return categoriesDTO;
        }

        public IEnumerable<ProductLike> GetProductLikes(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Product> Search(string value)
        {
            throw new NotImplementedException();
        }
    }
}
