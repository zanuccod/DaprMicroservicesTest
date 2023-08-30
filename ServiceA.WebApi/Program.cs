using Dapr.Client;
using Dapr.Extensions.Configuration;

var builder = WebApplication.CreateBuilder(args);
/*
 *************************************************************
 * If we would like to add the secret store to the configuration
 *************************************************************
 */
builder.Configuration
    .AddDaprSecretStore("secret-store", new DaprClientBuilder().Build());
// Add services to the container.

builder.Services
    .AddControllers()
    .AddDapr();

builder.Services.AddLogging(loggingBuilder =>
{
    loggingBuilder.AddSeq(serverUrl: "http://localhost:80");
});

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//app.UseHttpsRedirection();

app.UseAuthorization();
app.MapDefaultControllerRoute();
app.UseRouting();

app.UseCloudEvents();
app.MapControllers();
app.MapSubscribeHandler();

app.Run();
