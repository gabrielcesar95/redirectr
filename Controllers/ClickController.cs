using Microsoft.AspNetCore.Mvc;

namespace redirectr.Controllers;

[ApiController]
[Route("[controller]")]
public class ClickController : ControllerBase
{
    [HttpGet("{permaLink}")]
    public string Get(string permaLink)
    {
        return @$"you clicked {permaLink}";
    }

    [HttpGet("{permaLink}/{whereFrom}")]
    public string Get(string permaLink, string whereFrom)
    {
        return @$"you clicked {permaLink} and came from {whereFrom}";
    }
}
