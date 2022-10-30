const cartService = require("../services/cart-service");
const upload = require("../middleware/prescription.upload");

exports.create = (req, res, next) => {
console.log("req",req);
console.log('req.user.userId,',req.user);
// upload(req, res, function (err) {
//   if (err) {
//     next(err);
//   } else {
//     const path =
//       req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";

  var model = {
    userId: req.user.id,
    products: req.body.products,
    //presScription:path != "" ? "/" + path : "",
  };

  cartService.addCart(model, (error, results) => {
    if (error) {
      return next(error);
    }
    return res.status(200).send({
      messgae: "Success",
      data: results,
    });
  });
}

// exports.create = (req, res, next) => {
//   console.log("req",req);
//   console.log('req.user.userId,',req.user);
//   const path =
//   req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";
  
//     var model = {
//       userId: req.user.id,
//       products: req.body.products,
//       presScription:path != "" ? "/" + path : "",
//     };
  
//     cartService.addCart(model, (error, results) => {
//       if (error) {
//         return next(error);
//       }
//       return res.status(200).send({
//         messgae: "Success",
//         data: results,
//       });
//     });
//   };

exports.findAll = (req, res, next) => {
  cartService.getCart({ userId: req.user.id }, (error, results) => {
    console.log('findAllresults',results);
    if (error) {
      return next(error);
    }
    
    return res.status(200).send({
      messgae: "Success",
      data: results,
    });
  });
};

exports.delete = (req, res, next) => {
    var model = {
      userId: req.user.id,
      productId: req.body.productId,
      qty : req.body.qty,
    };
  
    cartService.removeCartItem(model, (error, results) => {
      if (error) {
        return next(error);
      }
      return res.status(200).send({
        messgae: "Success",
        data: results,
      });
    });
  };
