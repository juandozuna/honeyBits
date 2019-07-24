using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.Models
{
    public class Token
    {
        public string token { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public int Rol { get; set; }
    }
}
