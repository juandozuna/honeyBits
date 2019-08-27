using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using honeybits_server.Models;
using honeybits_server.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace honeybits_server.Controllers
{
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
        public IActionResult Authenticate([FromBody]Token userParam)
        {
            var user = _userService.Authenticate(userParam.Username, userParam.Password);

            if (user == null)
            {
                return BadRequest("Username or password not ");
            }

            return Ok(user);
        }

        [HttpGet("all")]
        public IActionResult GetAll() => Ok(_userService.GetAll());

        [HttpGet("get_keeper_shop")]
        public IActionResult GetShopOwner() => Ok(_userService.GetKeeperShop(int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value)));
        
        [HttpPost("is_username_available/{username}")]
        public IActionResult IsUsernameAvailable(string username)
        {
            if (string.IsNullOrEmpty(username))
                return BadRequest("Username was empty.");

            return Ok(_userService.IsUsernameAvailable(username));
        }

        [HttpPost("is_email_available")]
        public IActionResult IsEmailAvailable([FromBody]string email)
        {
            if(string.IsNullOrEmpty(email))
                return BadRequest("Email was empty.");

            return Ok(_userService.IsEmailAvailable(email));
        }

    }
}