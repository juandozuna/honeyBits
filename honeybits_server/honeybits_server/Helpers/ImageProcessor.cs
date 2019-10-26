using System;
using System.IO;
using honeybits_server.DTOs;
using honeybits_server.Models;

namespace honeybits_server.Helpers
{
    public class ImageProcessor
    {
        public string SaveImage(string path, string productName, string name, string format, string content)
        {
            //string path = Path.Combine(_hostingEnviroment.ContentRootPath, _appSettings.ImageLocation);
            if (!System.IO.Directory.Exists(path))
                System.IO.Directory.CreateDirectory(path);

            string imageName = string.Format("{0}_{1}_{2}.{3}", productName, name, DateTime.Now.ToString("yyyyMMddHHmmss"), format).Replace(" ", "_");
            string imagePath = Path.Combine(path, imageName);

            byte[] imageBytes = Convert.FromBase64String(content);

            File.WriteAllBytes(imagePath, imageBytes);
            
            return imagePath;
        }

        public string GetImage(ProductImage productImage) => Convert.ToBase64String(File.ReadAllBytes(productImage.ProductImageUrl));
    }
}