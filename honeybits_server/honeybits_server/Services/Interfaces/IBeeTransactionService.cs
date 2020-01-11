using honeybits_server.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.Services.Interfaces
{
    public interface IBeeTransactionService
    {
        bool Delete(int id);
        BeeTransaction Create(BeeTransaction transaction);
        BeeTransaction Update(BeeTransaction transaction);
        BeeTransaction Get(int id);
        IEnumerable<BeeTransaction> GetAll();
    }
}
