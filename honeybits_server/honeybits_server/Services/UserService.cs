using honeybits_server.Models;
using honeybits_server.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.Services
{
    public class UserService : IUserService
    {
        public Token Authenticate(string username, string password)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Users> GetAll()
        {
            throw new NotImplementedException();
        }
    }
}
