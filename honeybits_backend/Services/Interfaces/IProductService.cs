using System.Collections.Generic;
using honeybits_backend.Models;

namespace honeybits_backend.Services.Interfaces {
    public interface IProductService
    {
        Product Get(int id);
        Product Create(Product product);
        void Delete(int id);
        IEnumerable<Product> GetAll();
    }
}