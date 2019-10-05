using System.Collections.Generic;
using honeybits_server.DTOs;

namespace honeybits_server.Services.Interfaces {
    public interface IProductImageService
    {
        ProductImageDTO Get(int Id);
        ProductImageDTO Create(ProductImageDTO data);
        bool Delete(int Id);
        IEnumerable<ProductImageDTO> GetAllProductsImages(int productId);
        IEnumerable<ProductImageDTO> GetAllImages();
    }
}