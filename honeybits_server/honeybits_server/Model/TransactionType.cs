using System;
using System.Collections.Generic;

namespace honeybits_server.Model
{
    public partial class TransactionType
    {
        public TransactionType()
        {
            BeeTransaction = new HashSet<BeeTransaction>();
        }

        public int TransactionTypeId { get; set; }
        public string TransactionType1 { get; set; }
        public string TransactionTypeDescription { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public bool? IsDeleted { get; set; }
        public int? DeletedBy { get; set; }
        public DateTime? DeletedDate { get; set; }

        public virtual Users CreatedByNavigation { get; set; }
        public virtual Users DeletedByNavigation { get; set; }
        public virtual ICollection<BeeTransaction> BeeTransaction { get; set; }
    }
}
