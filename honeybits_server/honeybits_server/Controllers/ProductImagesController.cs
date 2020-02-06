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
    public class ProductImagesController : ControllerBase
    {
        private readonly IProductImageService _productImage;

        public ProductImagesController(IProductImageService productImage)
        {
            _productImage = productImage;
        }

        [HttpPost("get_image")]
        public IActionResult GetImage([FromBody]string imageUrl)
        {
            var pImage = _productImage.ImageByUrl(imageUrl);
            
            if (pImage == null)
                return NotFound();

            var image = System.IO.File.OpenRead(pImage.ImageUrl);
            return File(image, "image/png");
        }
    }
}