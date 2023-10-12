using Microsoft.AspNetCore.Mvc;

namespace redirectr.Controllers;

[ApiController]
[Route("[controller]")]
public class HealthcheckController : ControllerBase
{
    private readonly ILogger<HealthcheckController> _logger;

    public HealthcheckController(ILogger<HealthcheckController> logger)
    {
        _logger = logger;
    }

    [HttpGet(Name = "HealthCheck")]
    public string Get()
    {
        _logger.LogInformation("just got a healthcheck request and everything looks crystal clear");
        return "Nothing but clear skyes up ahead!";
    }
}
