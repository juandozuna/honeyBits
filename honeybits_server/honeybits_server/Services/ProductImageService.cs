using System.Collections.Generic;
using honeybits_server.DTOs;
using honeybits_server.Services.Interfaces;

namespace honeybits_server.Services {
    public class ProductImageService : IProductImageService
    {
        public ProductImageDTO Create(ProductImageDTO data)
        {
            throw new System.NotImplementedException();
        }

        public bool Delete(int Id)
        {
            throw new System.NotImplementedException();
        }

        public ProductImageDTO Get(int Id)
        {
            throw new System.NotImplementedException();
        }

        public IEnumerable<ProductImageDTO> GetAllImages()
        {
            throw new System.NotImplementedException();
        }

        public IEnumerable<ProductImageDTO> GetAllProductsImages(int productId)
        {
            throw new System.NotImplementedException();
        }
    }
}