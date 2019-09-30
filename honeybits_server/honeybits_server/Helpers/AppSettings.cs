using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace honeybits_server.Helpers
{
    public class AppSettings
    {
        public string Secret { get; set; }
        public string ImageLocation { get; set; }
        public string ConnectionString { get; set; }
    }
}
