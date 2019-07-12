﻿using honeybits_server.Models;
using honeybits_server.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.Services
{
    public class ProductService : IProductService
    {
        honeybitsContext _context = new honeybitsContext();

        public Product Create(Product product)
        {
            throw new NotImplementedException();
        }

        public void Delete(int id)
        {
            throw new NotImplementedException();
        }

        public Product Get(int id) => _context.Product.Find(id);

        public IEnumerable<Product> GetAll() => _context.Product.ToList();
    }
}
