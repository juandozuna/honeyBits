using System.Collections.Generic;
<<<<<<< HEAD
=======
using System.IO;
>>>>>>> 832cb5218e9f089a6a515da4e8ceea798c55c965
using honeybits_server.DTOs;

namespace honeybits_server.Services.Interfaces {
    public interface IProductImageService
    {
        ProductImageDTO Get(int Id);
<<<<<<< HEAD
=======
        ProductImageDTO ImageByUrl(string imageUrl);
>>>>>>> 832cb5218e9f089a6a515da4e8ceea798c55c965
        IEnumerable<ProductImageDTO> Create(List<ProductImageDTO> data);
        bool Delete(int Id);
        IEnumerable<ProductImageDTO> GetAllProductsImages(int productId);
        IEnumerable<ProductImageDTO> GetAllImages();
    }
}