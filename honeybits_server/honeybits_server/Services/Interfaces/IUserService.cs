﻿using honeybits_server.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.Services.Interfaces
{
    public interface IUserService
    {
        Token Authenticate(string username, string password);
        Users Create(Users user);
        Users Delete(int id);
        Users Get(int id);
        IEnumerable<Users> GetAll();
    }
}
