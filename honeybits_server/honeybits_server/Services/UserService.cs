﻿using honeybits_server.Helpers;
using honeybits_server.Models;
using honeybits_server.Services.Interfaces;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace honeybits_server.Services
{
    public class UserService : IUserService
    {
        private readonly AppSettings _appSettings;
        private honeybitsContext _context = new honeybitsContext();

        public UserService(IOptions<AppSettings> appSettings)
        {
            _appSettings = appSettings.Value;

        }

        public Token Authenticate(string username, string password)
        {
            var user = _context.Users.SingleOrDefault(x => x.Username == username && x.Passwd == password);

            if (user == null)
                return null;

            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[] {
                    new Claim(ClaimTypes.NameIdentifier, user.UserId.ToString()),
                    new Claim(ClaimTypes.Role, user.RoleId.ToString()),
                    new Claim(ClaimTypes.Name, user.FirstName.ToString() + " " + user.LastName.ToString())
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);

            return new Token
            {
                token = tokenHandler.WriteToken(token)
            };
        }

        public Users Create(Users user)
        {
            _context.Users.Add(user);
            _context.SaveChanges();
            return user;
        }

        public bool Delete(int id)
        {
            _context.Users.Remove(_context.Users.Find(id));
            var r = _context.SaveChanges();
            return r > 0;
        }

        public Users Get(int id) => _context.Users.Find(id);

        public IEnumerable<Users> GetAll() => _context.Users.ToList();

        public Role GetRole(int id)
        {
            var rol = _context.Role.Find(id);

            if (rol == null)
                return null;

            return rol;
        }

        public IEnumerable<Role> GetAllRoles() => _context.Role.ToList();
    }
}
