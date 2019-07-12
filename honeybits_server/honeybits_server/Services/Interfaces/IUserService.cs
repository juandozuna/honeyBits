using honeybits_server.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.Services.Interfaces
{
    public interface IUserService
    {
        Token Authenticate(string username, string password);
        IEnumerable<Users> GetAll();
    }
}
