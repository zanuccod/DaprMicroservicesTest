namespace ServiceB.WebApi.Models
{
    public class KeyValue
    {
        public required string Key { get; set; }
        public required string Value { get; set; }

        public bool IsValid()
        {
            return !string.IsNullOrEmpty(Key)
                && !string.IsNullOrEmpty(Value);
        }
    }
}
