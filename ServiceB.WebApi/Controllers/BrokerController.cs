﻿using Dapr.Client;
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

        [HttpGet("LogValueFromKey")]
        public async Task<ActionResult<string>> LogValueFromKey(string key)
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

        [HttpGet("GetValueFromKey")]
        public async Task<ActionResult<string>> GetValueFromKey(string key)
        {
            if (string.IsNullOrEmpty(key))
            {
                return BadRequest("Give a valid key");
            }

            var httpClient = DaprClient.CreateInvokeHttpClient("service-a");
            var response = await httpClient.GetAsync($"api/Store/GetValueFromKey?key={key}");
            if (response.StatusCode == System.Net.HttpStatusCode.OK)
            {
                string? result = await response.Content.ReadAsStringAsync();
                if (!string.IsNullOrEmpty(result))
                {
                    _logger.LogInformation($"Received for key <{key}> the value <{result}>");
                    return Ok(result);
                }
            }
            return NotFound(response);
        }

        [HttpGet("GetValueFromStore")]
        public async Task<ActionResult<string>> GetValueFromStore(string key)
        {
            if (string.IsNullOrEmpty(key))
            {
                return BadRequest("Give a valid key");
            }

            var httpClient = DaprClient.CreateInvokeHttpClient("service-a");
            var response = await httpClient.GetAsync($"api/Store/GetStoreValueFromKey?key={key}");
            if (response.StatusCode == System.Net.HttpStatusCode.OK)
            {
                string? result = await response.Content.ReadAsStringAsync();
                if (!string.IsNullOrEmpty(result))
                {
                    _logger.LogInformation($"Received for key <{key}> the value <{result}>");
                    return Ok(result);
                }
            }
            return NotFound(response);
        }

        [HttpPost("AddValueToStore")]
        public async Task<ActionResult<string>> AddValueToStore(KeyValue keyValue)
        {
            if (keyValue is null
                || !keyValue.IsValid())
            {
                return BadRequest("The given input is not valid");
            }

            var httpClient = DaprClient.CreateInvokeHttpClient("service-a");
            var response = await httpClient.PostAsJsonAsync<KeyValue>($"api/Store/AddStoreValue", keyValue);
            if (response.StatusCode == System.Net.HttpStatusCode.OK)
            {
                return Ok();
            }
            return Forbid();
        }
    }
}
