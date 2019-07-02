using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using honeybits_backend.Helpers;
using honeybits_backend.Models;
using honeybits_backend.Models.Enums;
using honeybits_backend.Services.Interfaces;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;

namespace honeybits_backend.Services {
    public class UserService : IUserService
    {
        private List<User> _users = new List<User> {
            new User { Id = 1, Role = Role.Administrator, FirstName = "Admin", LastName = "Admin", Birthdate = DateTime.Now, Username = "Admin", Password = "123456"},
            new User { Id = 2, Role = Role.Developer, FirstName = "Developer", LastName = "Dev", Birthdate = DateTime.Now, Username = "developer", Password = "123456"},
            new User { Id = 3, Role = Role.Customer, FirstName = "Customer", LastName = "Cust", Birthdate = DateTime.Now, Username = "customer", Password = "123456"},
            new User { Id = 4, Role = Role.Keeper, FirstName = "Keeper", LastName = "Keep", Birthdate = DateTime.Now, Username = "keeper", Password = "123456"}
        };

        private readonly AppSettings _appSettings;

        public UserService(IOptions<AppSettings> appSettings){
            _appSettings = appSettings.Value;
        }

        public Token Authenticate(string username, string password)
        {
            var user = _users.SingleOrDefault(x => x.Username == username && x.Password == password);

            if (user == null)
                return null;

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor {
                Subject = new ClaimsIdentity(new Claim[] {
                    new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                    new Claim(ClaimTypes.Role, user.Role.ToString()),
                    new Claim(ClaimTypes.Name, user.FirstName.ToString() + " " + user.LastName.ToString())
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);

            return new Token {
                token = tokenHandler.WriteToken(token)
            };
        }

        public IEnumerable<User> GetAll() => _users.ToList();
    }
}