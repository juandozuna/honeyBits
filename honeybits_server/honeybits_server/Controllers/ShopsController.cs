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
            if (!ModelState.IsValid)
                return BadRequest();

            shop.CreatedBy = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            shop.CreatedDate = DateTime.Now;

            return Ok(_shopService.Create(shop));
        }

        [HttpGet("all")]
        public IActionResult GetAll() => Ok(_shopService.GetAll());

        [HttpPost("shop_products/{id}")]
        public IActionResult GetProductsByShopId(int id)
        {
            if (id == 0)
                return BadRequest("Id cannot be 0");

            return Ok(_shopService.GetAllProductsByShopId(id));
        }
    }
}