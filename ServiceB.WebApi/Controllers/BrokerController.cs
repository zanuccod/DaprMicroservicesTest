using Dapr.Client;
using Microsoft.AspNetCore.Mvc;
using ServiceB.WebApi.Models;

namespace ServiceB.WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BrokerController : ControllerBase
    {
        private readonly IConfiguration _config;
        private readonly ILogger<BrokerController> _logger;

        const string PUBSUB_COMPONENT_NAME = "pubsub";
        const string TOPIC_NAME = "dapr_test_topic";

        public BrokerController(IConfiguration config, ILogger<BrokerController> logger)
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

            var messageObj = new MessageKey() { Key = key };

            using var client = new DaprClientBuilder().Build();
            await client.PublishEventAsync(PUBSUB_COMPONENT_NAME, TOPIC_NAME, messageObj);
            
            return Ok();
        }
    }
}
