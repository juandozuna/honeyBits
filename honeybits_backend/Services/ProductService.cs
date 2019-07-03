using System.Collections.Generic;
using System.Linq;
using honeybits_backend.Models;
using honeybits_backend.Services.Interfaces;

namespace honeybits_backend.Services {
    public class ProductService : IProductService
    {
        private List<Product> _products = new List<Product> {
            new Product { Id = 1, Name = "Honey Sample", Description = "Sample for testing honey product", Price = (decimal)10.99 },
            new Product { Id = 2, Name = "Clothes Sample", Description = "Sample for testing clothes product", Price = (decimal)10.99 },
            new Product { Id = 3, Name = "Tooling Sample", Description = "Sample for testing tools product", Price = (decimal)10.99 },
            new Product { Id = 4, Name = "Service Sample", Description = "Sample for testing services", Price = (decimal)10.99 },
        };

        public Product Create(Product product)
        {
            throw new System.NotImplementedException();
        }

        public void Delete(int id) => _products.Remove(_products.FirstOrDefault(x => x.Id == id));

        public Product Get(int id) => _products.FirstOrDefault(x => x.Id == id);

        public IEnumerable<Product> GetAll() => _products.ToList();
    }
}