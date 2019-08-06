using honeybits_server.Models;
using honeybits_server.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.Services
{
    public class ShopService : IShopService
    {
        private honeybitsContext _context = new honeybitsContext();

        public Shop Create(Shop shop)
        {
            _context.Shop.Add(shop);
            _context.SaveChanges();

            return shop;
        }

        public bool Delete(Shop shop)
        {
            shop.IsDeleted = true;
            shop.DeletedDate = DateTime.Now;
            var result = _context.SaveChanges();

            return result > 0;
        }

        public Shop Get(int id) => _context.Shop.Find(id);

        public IEnumerable<Shop> GetAll() => _context.Shop.ToList();

        public IEnumerable<ShopProduct> GetAllShopsProductsByShopId(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<ShopFollower> GetShopFollowers(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Shop> Search(string value)
        {
            throw new NotImplementedException();
        }

        public Shop Update(Shop shop)
        {
            throw new NotImplementedException();
        }
    }
}
