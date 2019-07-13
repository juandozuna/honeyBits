using System;
using System.Collections.Generic;
using System.Linq;
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
                return BadRequest();
            }

            return Ok(user);
        }

        [HttpGet("all")]
        public IActionResult GetAll() => Ok(_userService.GetAll());
    }
}