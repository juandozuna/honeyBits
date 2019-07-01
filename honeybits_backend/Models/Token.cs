namespace honeybits_backend.Models {
    public class Token {
        public string token { get; set; }
        public long ExpirationTime { get; set; }
    }
}