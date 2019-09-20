using System;
using System.Collections.Generic;

namespace honeybits_server.Models
{
    public partial class AccessLog
    {
        public int AccessLogId { get; set; }
        public int UserId { get; set; }
        public string IpAddress { get; set; }
        public DateTime? AccessDate { get; set; }

        public virtual Users User { get; set; }
    }
}
