const productsServices = require("../services/products.service");
const upload = require("../middleware/product.upload.js");

// Create and Save a new Product
exports.create = (req, res, next) => {
  upload(req, res, function (err) {
    if (err) {
      next(err);
    } else {
      const url = req.protocol + "://" + req.get("host");

      const path =
        req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";

      var model = {
        productName: req.body.productName,
        category:req.body.category,
        productShortDescription:req.body.productShortDescription,
        productDescription: req.body.productDescription,
        productPrice: req.body.productPrice,
        productSalePrice:req.body.productSalePrice,
        productSKU:req.body.productSKU,
        productType:req.body.productType,
        stockStatus:req.body.stockStatus,
        productImage: path != "" ? "/" + path : "",
        qtyAvailable : req.body.qtyAvailable,
        //productImage: path != "" ? url + "/" + path : "",
      };

      productsServices.createProduct(model, (error, results) => {
        if (error) {
          return next(error);
        }
        return res.status(200).send({
          message: "Success",
          data: results,
        });
      });
    }
  });
};

// Retrieve all Products from the database.
exports.findAll = (req, res, next) => {
  var model = {
    productIds : req.query.productIds,
    productName: req.query.productName,
    categoryId : req.query.categoryId,
    pageSize : req.query.pageSize,
    page: req.query.page,
    sort: req.query.sort
  };

  productsServices.getProducts(model, (error, results) => {
    console.log('prod',results);
    if (error) {
      return next(error);
    }
    return res.status(200).send({
      message: "Success",
      data: results,
    });
  });
};

// Find a single Tutorial with an id
exports.findOne = (req, res, next) => {
  var model = {
    productId: req.params.id,
  };

  productsServices.getProductById(model, (error, results) => {
    if (error) {
        return next(error);
    }
    else {
        return res.status(200).send({
        message: "Success",
        data: results,
        });
    }
  });
};

// Update a Product by the id in the request
exports.update = (req, res, next) => {
  upload(req, res, function (err) {
    if (err) {
      next(err);
    } else {
      const url = req.protocol + "://" + req.get("host");

      const path =
        req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";

      var model = {
        productId: req.params.id,
        productName: req.body.productName,
        category:req.body.category,
        productShortDescription:req.body.productShortDescription,
        productDescription: req.body.productDescription,
        productPrice: req.body.productPrice,
        productSalePrice:req.body.productSalePrice,
        productSKU:req.body.productSKU,
        productType:req.body.productType,
        stockStatus:req.body.stockStatus,
        productImage: path != "" ? "/" + path : "",
      };

      console.log(model);

      productsServices.updateProduct(model, (error, results) => {
        if (error) {
          return next(error);
        }
        return res.status(200).send({
          message: "Success",
          data: results,
        });
      });
    }
  });
};

// Delete a Product with the specified id in the request
exports.delete = (req, res, next) => {
  var model = {
    productId: req.params.id,
  };

  productsServices.deleteProduct(model, (error, results) => {
    if (error) {
      return next(error);
    }
    return res.status(200).send({
      message: "Success",
      data: results,
    });
  });
};