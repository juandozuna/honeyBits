using honeybits_server.DTOs;
using honeybits_server.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.Services.Interfaces
{
    public interface IProductService
    {
        Product Get(int id);
        ProductDTO Create(ProductDTO data);
        bool Delete(Product product);
        IEnumerable<Product> GetAll();
        IEnumerable<Product> Search(string value);
        IEnumerable<ProductLike> GetProductLikes(int id);
        IEnumerable<ProductCategoryDTO> GetProductCategories();
        ProductImageDTO AddProductImage(List<ProductImageDTO> data);
    }
}
