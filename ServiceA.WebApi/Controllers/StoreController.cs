using Microsoft.AspNetCore.Mvc;
using Dapr;
using Microsoft.AspNetCore.Http;
using ServiceA.WebApi.Models;
using Dapr.Client;
using Microsoft.AspNetCore.DataProtection.KeyManagement;
using Google.Protobuf.WellKnownTypes;

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
        const string STORE_COMPONENT_NAME = "statestore";

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

        [HttpPost("LogValueFromKey")]
        [Topic(PUBSUB_COMPONENT_NAME, TOPIC_NAME)]
        public Task LogValueFromKey(MessageKey messageKey)
        {
            if (messageKey == null
                || string.IsNullOrEmpty(messageKey.Key))
            {
                _logger.LogWarning("Give a valid key");
            }
            else
            {
                var key = messageKey.Key;
                var value = _config[key];

                _logger.LogInformation($"\nKey: {key}\nValue: {value}");
            }
            return Task.CompletedTask;
        }
   
        [HttpGet("GetStoreValueFromKey")]
        public async Task<ActionResult<string>> GetStoreValueFromKey(string key)
        {
            if (string.IsNullOrEmpty(key))
            {
                return BadRequest("Give a valid key");
            }
            using var client = new DaprClientBuilder().Build();
            var value = await client.GetStateAsync<string>(STORE_COMPONENT_NAME, key);

            if (string.IsNullOrEmpty(value))
            {
                _logger.LogWarning($"Th given key <{key}> has no value in the store");
                return NotFound(key);
            }
            return Ok(value);
        }

        [HttpPost("AddStoreValue")]
        public async Task<ActionResult> AddStoreValue(KeyValue keyValue)
        {
            if (keyValue is null
                || !keyValue.IsValid())
            {
                return BadRequest("The given input is not valid");
            }
            using var client = new DaprClientBuilder().Build();
            await client.SaveStateAsync(STORE_COMPONENT_NAME, keyValue.Key, keyValue.Value);

            return Ok();
        }
    }
}
