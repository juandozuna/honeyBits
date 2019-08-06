using honeybits_server.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.Services.Interfaces
{
    public interface IShopService
    {
        Shop Get(int id);
        Shop Create(Shop shop);
        Shop Update(Shop shop);
        bool Delete(Shop shop);
        IEnumerable<Shop> GetAll();
        IEnumerable<ShopProduct> GetAllShopsProductsByShopId(int id);
        IEnumerable<Shop> Search(string value);
        IEnumerable<ShopFollower> GetShopFollowers(int id);
    }
}
