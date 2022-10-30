const categoryController = require("../controllers/categories.controller");
const productsController = require("../controllers/product.controller");
const userController = require("../controllers/users.controller");
const relatedProductController = require("../controllers/related-product.controller");
const cartController = require("../controllers/cart.controller");
const { authenticateToken } = require("../middleware/auth");
const express = require("express");
const router = express.Router();

router.post("/category", categoryController.create);
router.get("/category", categoryController.findAll);
router.get("/category/:id", categoryController.findOne);
router.put("/category/:id", categoryController.update);
router.delete("/category/:id", categoryController.delete);

// Create a new Product
router.post("/product", productsController.create);

// Retrieve all Products
router.get("/product", productsController.findAll);

// Retrieve a single Product with id
router.get("/product/:id", productsController.findOne);

// Update a Product with id
router.put("/product/:id", productsController.update);

// // Delete a Product with id
router.delete("/product/:id", productsController.delete);

router.post("/register", userController.register);
router.post("/login", userController.login);

router.post("/relatedProduct", relatedProductController.create);
router.delete("/relatedProduct/:id", relatedProductController.delete);

router.post("/cart", [authenticateToken], cartController.create);
router.get("/cart", [authenticateToken], cartController.findAll);
router.delete("/cart", [authenticateToken], cartController.delete);

module.exports = router;
