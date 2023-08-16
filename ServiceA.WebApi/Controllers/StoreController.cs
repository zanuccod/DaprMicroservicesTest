using Microsoft.AspNetCore.Mvc;

namespace ServiceA.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StoreController : ControllerBase
    {
        private readonly IConfiguration _config;
        private readonly ILogger<StoreController> _logger;

        public StoreController(IConfiguration config, ILogger<StoreController> logger)
        {
            _config = config;
            _logger = logger;
        }

        [HttpGet("GetValueFromKey")]
        public async Task<ActionResult<string>> GetValueFromKey(string key)
        {
            if (string.IsNullOrEmpty(key))
            {
                return BadRequest("Give a valid key");
            }

            var value = _config[key];
            return string.IsNullOrEmpty(value)
                ? await Task.FromResult(NotFound(key))
                : await Task.FromResult(Ok(_config[key]));
        }
    }
}
