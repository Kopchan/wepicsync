using System.Text.Json.Serialization;

namespace PicsyncClient.Models.Response;

public class AuthResponse
{
    [JsonPropertyName("token")]    public string Token    { get; set; }
    [JsonPropertyName("nickname")] public string Nickname { get; set; }
    [JsonPropertyName("isAdmin")]  public bool   isAdmin  { get; set; } = false;
}