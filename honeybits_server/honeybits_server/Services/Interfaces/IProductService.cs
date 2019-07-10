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
        Product Create(Product product);
        void Delete(int id);
        IEnumerable<Product> GetAll();
    }
}
