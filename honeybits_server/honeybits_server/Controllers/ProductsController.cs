using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using honeybits_server.Services.Interfaces;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace honeybits_server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        private readonly IProductService _productService;

        public ProductsController(IProductService productService)
        {
            _productService = productService;
        }

        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            var product = _productService.Get(id);

            if (product == null)
                return NotFound();

            return Ok(product);
        }

        [HttpGet("all")]
        public IActionResult GetAll() => Ok(_productService.GetAll());
    }
}