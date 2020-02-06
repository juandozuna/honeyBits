using System;
using System.Collections.Generic;
<<<<<<< HEAD
=======
using System.IO;
using System.Linq;
>>>>>>> 832cb5218e9f089a6a515da4e8ceea798c55c965
using honeybits_server.DTOs;
using honeybits_server.Helpers;
using honeybits_server.Models;
using honeybits_server.Services.Interfaces;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Options;

namespace honeybits_server.Services {
    public class ProductImageService : IProductImageService
    {
        honeybitsContext _context = new honeybitsContext();
        private readonly IHostingEnvironment _hostingEnviroment;
        private readonly AppSettings _appSettings;

        public ProductImageService(IHostingEnvironment hostingEnvironment, IOptions<AppSettings> appSettings)
        {
            _hostingEnviroment = hostingEnvironment;
            _appSettings = appSettings.Value;
        }

        public IEnumerable<ProductImageDTO> Create(List<ProductImageDTO> data)
        {
            List<ProductImage> images = new List<ProductImage>();

            foreach(var image in data) 
            {
                images.Add(new ProductImage {
                    ProductId = image.ProductId,
                    ProductImageName = image.ProductImageName,
                    ProductImageDescription = image.ProductImageDesc,
                    ProductImageType = image.ProductImageType,
                    CreatedBy = 2,
                    CreatedDate = DateTime.Now,
                });
            }

            _context.ProductImage.AddRange(images);
            _context.SaveChanges();

            return data;
        }

        public bool Delete(int Id)
        {
            throw new System.NotImplementedException();
        }

        public ProductImageDTO Get(int Id)
        {
            var productImage = _context.ProductImage.Find(Id);
            
            if(productImage == null)
                return null;

            return new ProductImageDTO() {
                ProductId = productImage.ProductId,
                ProductImageName = productImage.ProductImageName,
                ProductImageDesc = productImage.ProductImageDescription,
                ProductImageId = productImage.ProductImageId,
                ProductImageType = productImage.ProductImageType,
                CreatedBy = productImage.CreatedBy,
                ImageContent = new ImageProcessor().GetImage(productImage, _hostingEnviroment.ContentRootPath.ToString())
            };
        }

        public IEnumerable<ProductImageDTO> GetAllImages()
        {
            throw new System.NotImplementedException();
        }

        public IEnumerable<ProductImageDTO> GetAllProductsImages(int productId)
        {
            throw new System.NotImplementedException();
        }
<<<<<<< HEAD
=======

        public ProductImageDTO ImageByUrl(string imageUrl)
        {
            var pImage = _context.ProductImage.Where(x => x.ProductImageUrl == imageUrl).FirstOrDefault();

            if (pImage == null)
                return null;
                
            
            return new DtoHelper().fromProductImageToDto(pImage);

        }
>>>>>>> 832cb5218e9f089a6a515da4e8ceea798c55c965
    }
}