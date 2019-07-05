using honeybits_backend.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace honeybits_backend.Controllers {
    
    [Authorize]
    [ApiController]
    [Route("api/[controller]")]
    public class ProductsController : ControllerBase {
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

        [AllowAnonymous]
        [HttpGet("all")]
        public IActionResult GetAll() => Ok(_productService.GetAll());
    }
}