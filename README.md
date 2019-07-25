# HoneyBits Project

## Web API

Routes

URL base: http://honeybits.azurewebsites.net/

### Users


|           URL          | Require token? | Parameters                                                                                                                            |  Returns  |
|:----------------------:|:--------------:|---------------------------------------------------------------------------------------------------------------------------------------|:---------:|
| api/users/authenticate |       No       | username -> string; password -> string;                                                                                               |   token   |
|    api/users/create    |       Yes      | firstname -> string; lastname -> string; email -> string; birthdate -> datetime; roleid -> int; username -> string; passwd -> string; |    User   |
|  api/users/delete/{id} |       Yes      | id -> int                                                                                                                             |    bool   |
|   api/users/get/{id}   |       Yes      | id -> int                                                                                                                             |    bool   |
|      api/users/all     |       Yes      | None                                                                                                                                  | all users |

###### Usuarios de Prueba

Cada uno de los usuarios posee un rol diferente.

| username  | passwd |
|-----------|--------|
| admin     | 123456 |
| developer | 123456 |
| customer  | 123456 |
| keeper    | 123456 |

## Products

|            URL           | Require token? | Parameters                                                                                               |    Result    |
|:------------------------:|:--------------:|----------------------------------------------------------------------------------------------------------|:------------:|
|    api/products/create   |       Yes      | productName -> string; productCategoryId -> int;  productDescription -> string;  productPrice -> decimal |    Product   |
| api/products/delete/{id} |       Yes      | id -> int                                                                                                |    Product   |
|     api/products/{id}    |       Yes      | id -> int                                                                                                |     bool     |
|     api/products/all     |       Yes      | None                                                                                                     | All Products |

####
