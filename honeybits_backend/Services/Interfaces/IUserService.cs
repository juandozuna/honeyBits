using System.Collections.Generic;
using honeybits_backend.Models;

namespace honeybits_backend.Services.Interfaces {
    public interface IUserService {
        Token Authenticate (string username, string password);
        IEnumerable<User> GetAll();
    }
}