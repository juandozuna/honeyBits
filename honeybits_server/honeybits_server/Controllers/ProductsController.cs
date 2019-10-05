using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using honeybits_server.DTOs;
using honeybits_server.Models;
using honeybits_server.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
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
        public IActionResult Create([FromBody]ProductDTO product)
        {
            if(!ModelState.IsValid)
                return BadRequest(ModelState);
         
            product.CreatedBy = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            
            return Ok(_productService.Create(product));
        }

        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            var product = _productService.Get(id);

            if (product == null)
                return NotFound();

            return Ok(product);
        }

        [HttpPost("delete/{id}")]
        public IActionResult Delete(int id)
        {
            var product = _productService.Get(id);
            if (product == null)
                return NotFound();

            var user = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            product.DeletedBy = int.Parse(user);
            

            return Ok(_productService.Delete(product));
        }

        [HttpGet("all")]
        public IActionResult GetAll() => Ok(_productService.GetAll());

        [HttpGet("product_categories")]
        public IActionResult GetAllCategories() => Ok(_productService.GetProductCategories());

        [HttpPost("add_product_images")]
        public IActionResult AddProductImage(List<ProductImageDTO> data) 
        {
            if(!ModelState.IsValid)
                return BadRequest(ModelState);

            _productService.AddProductImage(data);

            return Ok(data);
        }
    }
}