using honeybits_server.DTOs;
using honeybits_server.Helpers;
using honeybits_server.Models;
using honeybits_server.Services.Interfaces;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.Services
{
    public class ProductService : IProductService
    {
        honeybitsContext _context = new honeybitsContext();
        private readonly IHostingEnvironment _hostingEnviroment;
        private readonly AppSettings _appSettings;

        public ProductService(IHostingEnvironment hostingEnvironment, IOptions<AppSettings> appSettings)
        {
            _hostingEnviroment = hostingEnvironment;
            _appSettings = appSettings.Value;
        }

        public ProductDTO Create(ProductDTO data)
        {
            var product = new Product();
            var productImages = new List<ProductImage>();
            var productLikes = new List<ProductLike>();

            product.ProductName = data.ProductName;
            product.ProductPrice = data.ProductPrice;
            product.ProductCategoryId = data.ProductCategoryId;
            product.ProductDescription = data.ProductDescription;

            product.CreatedBy = data.CreatedBy;
            product.CreatedDate = DateTime.Now;

            _context.Product.Add(product);
            _context.SaveChanges();

            if (data.ProductImages.Count() > 0)
            {

                foreach (var image in data.ProductImages)
                {
                    productImages.Add(new ProductImage() {
                        ProductId = product.ProductId,
                        ProductImageDescription = image.ProductImageDesc,
                        ProductImageName = image.ProductImageName,
                        ProductImageType = image.ProductImageType,
                        ProductImageUrl = CreateFileImage(image.ProductImageName, product.ProductName, image.ProductImageType, image.ImageContent),
                        CreatedBy = data.CreatedBy,
                        CreatedDate = DateTime.Now
                    });
                }

                _context.ProductImage.AddRange(productImages);
            }

            _context.SaveChanges();
            data.ProductId = product.ProductId;

            return data;
        }

        public string CreateFileImage(string name, string productName, string format, string content)
        {
            string path = Path.Combine(_hostingEnviroment.ContentRootPath, _appSettings.ImageLocation);
            if (!System.IO.Directory.Exists(path))
                System.IO.Directory.CreateDirectory(path);

            string imageName = string.Format("{0}_{1}_{2}.{3}", productName, name, DateTime.Now.ToString("yyyyMMddHHmmss"), format).Replace(" ", "_");
            string imagePath = Path.Combine(path, imageName);

            byte[] imageBytes = Convert.FromBase64String(content);

            File.WriteAllBytes(imagePath, imageBytes);
            
            return imagePath;
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

            foreach (var category in categories)
            {
                categoriesDTO.Add(new ProductCategoryDTO()
                {
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

        public ProductImageDTO AddProductImage(List<ProductImageDTO> data)
        {
            return new ProductImageDTO();
        }
    }
}
