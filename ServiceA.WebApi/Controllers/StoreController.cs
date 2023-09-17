using Microsoft.AspNetCore.Mvc;
using Dapr;
using Microsoft.AspNetCore.Http;
using ServiceA.WebApi.Models;

namespace ServiceA.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StoreController : ControllerBase
    {
        private readonly IConfiguration _config;
        private readonly ILogger<StoreController> _logger;

        const string PUBSUB_COMPONENT_NAME = "pubsub";
        const string TOPIC_NAME = "dapr_test_topic";

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

            _logger.LogInformation($"\nKey: {key}\nValue: {value}");
            return string.IsNullOrEmpty(value)
                ? await Task.FromResult(NotFound(key))
                : await Task.FromResult(Ok(_config[key]));
        }

        [HttpPost("GetValueFromKey")]
        [Topic(PUBSUB_COMPONENT_NAME, TOPIC_NAME)]
        public Task LogValueFromKey(MessageKey messageKey)
        {
            if (messageKey == null
                || string.IsNullOrEmpty(messageKey.Key))
            {
                _logger.LogWarning("Give a valid key");
            }

            var key = messageKey.Key;
            var value = _config[key];

            _logger.LogInformation($"\nKey: {key}\nValue: {value}");

            return Task.CompletedTask;
        }
    }
}
