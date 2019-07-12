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
    public class ProductsController : ControllerBase
    {
        private readonly IProductService _productService;

        public ProductsController(IProductService productService)
        {
            _productService = productService;
        }

        [HttpPost("create")]
        public IActionResult Create([FromBody]Product product)
        {
            if(!ModelState.IsValid)
                return BadRequest();

            var user = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

            product.CreatedBy = int.Parse(user);
            product.CreatedDate = DateTime.Now;

            return Ok(_productService.Create(product));
        }

        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            var product = _productService.Get(id);

            if (product == null)
                return NotFound();

            var user = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;


            return Ok(product);
        }

        [HttpPost("{id}")]
        public IActionResult Delete(int id)
        {
            return Ok(true);
        }

        [HttpGet("all")]
        public IActionResult GetAll() => Ok(_productService.GetAll());
    }
}