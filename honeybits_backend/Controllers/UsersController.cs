using honeybits_backend.Models;
using honeybits_backend.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace honeybits_backend.Controllers {
    
    [Authorize]
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly IUserService _userService;

        public UsersController(IUserService userService)
        {
            _userService = userService;
        }

        [AllowAnonymous]
        [HttpPost("authenticate")]
        public IActionResult Authenticate([FromBody]Token userParam) {
            var user = _userService.Authenticate(userParam.Username, userParam.Password);
            
            if(user == null) {
                return BadRequest();
            }

            return Ok(user);
        }

        [HttpGet("all")]
        public IActionResult GetAll() => Ok(_userService.GetAll());
    }
}