using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using honeybits_server.Models;
using honeybits_server.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace honeybits_server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ShopsController : ControllerBase
    {
        private readonly IShopService _shopService;

        public ShopsController(IShopService shopService)
        {
            _shopService = shopService;
        }

        [HttpGet("{id}")]
        public IActionResult Get(int Id)
        {
            var shop = _shopService.Get(Id);

            if (shop == null)
                return NotFound();

            return Ok(shop);
        }

        [HttpPost("create")]
        public IActionResult Create([FromBody]Shop shop)
        {
            return Ok();
        }

        [HttpGet("all")]
        public IActionResult GetAll() => Ok(_shopService.GetAll());
    }
}