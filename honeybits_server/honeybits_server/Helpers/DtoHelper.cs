using System;
using System.Collections.Generic;
using honeybits_server.DTOs;
using honeybits_server.Models;

namespace honeybits_server.Helpers {
    public class DtoHelper {


        public ProductDTO fromProductToDto(Product product, string path) {
            return new ProductDTO {
                ProductId = product.ProductId,
                ProductName = product.ProductName,
                ProductDescription = product.ProductDescription,
                ProductCategoryId = product.ProductCategoryId,
                CreatedBy = product.CreatedBy,
                CreatedDate = product.CreatedDate,
                DeletedBy = product.DeletedBy,
                IsDeleted = product.IsDeleted,
                ProductImages = fromProductImageToDto(product.ProductImage, path),
                ProductLikes = fromProductLikeToDto(product.ProductLike)
            };
        }

        public IEnumerable<ProductImageDTO> fromProductImageToDto(IEnumerable<ProductImage> productImages, string path) {
            List<ProductImageDTO> images = new List<ProductImageDTO>();
            foreach(var image in productImages) {
                images.Add(new ProductImageDTO {
                    ProductImageId = image.ProductImageId,
                    ProductId = image.ProductId,
                    ProductImageDesc = image.ProductImageDescription,
                    ProductImageName = image.ProductImageName,
                    ProductImageType = image.ProductImageType,
                    ImageContent = null, //new ImageProcessor().GetImage(image, path),
                    ImageUrl = image.ProductImageUrl,
                    CreatedBy = image.CreatedBy
                });
            }
            return images;
        }

        public IEnumerable<ProductLikeDTO> fromProductLikeToDto(IEnumerable<ProductLike> productLikes) {
            List<ProductLikeDTO> likes = new List<ProductLikeDTO>();
            foreach(var like in productLikes) {
                likes.Add(new ProductLikeDTO {
                    ProductId = like.ProductId,
                    UserId = like.UserId,
                    ProductLikeId = like.ProductLikeId
                });
            }
            return likes;
        }

        public ProductImageDTO fromProductImageToDto(ProductImage productImage)
        {
            return new ProductImageDTO
            {
                ProductId = productImage.ProductId,
                CreatedBy = productImage.CreatedBy,
                ImageContent = null,
                ImageUrl = productImage.ProductImageUrl,
                ProductImageDesc = productImage.ProductImageDescription,
                ProductImageId = productImage.ProductImageId,
                ProductImageName = productImage.ProductImageName,
                ProductImageType = productImage.ProductImageType
            };
        }
    }
}