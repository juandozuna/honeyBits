using System;
using System.Collections.Generic;

namespace honeybits_server.Model
{
    public partial class BeeTransaction
    {
        public int BeeTransactionId { get; set; }
        public int UserId { get; set; }
        public int TransactionTypeId { get; set; }
        public int BeeAmount { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool? IsDeleted { get; set; }
        public int? DeletedBy { get; set; }
        public DateTime? DeletedDate { get; set; }

        public virtual Users CreatedByNavigation { get; set; }
        public virtual Users DeletedByNavigation { get; set; }
        public virtual TransactionType TransactionType { get; set; }
        public virtual Users User { get; set; }
    }
}
