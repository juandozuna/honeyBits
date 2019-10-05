using System;
using System.Collections.Generic;
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
                    
                    CreatedDate = DateTime.Now,

                });
            }

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