const mongoose = require("mongoose");

const product = mongoose.model(
  "Products",
  mongoose.Schema(
    {
        productName: {
            type : String,
            require: true,
            unique:true,
        },
        category: {
            type : mongoose.Schema.Types.ObjectId,
            ref: "Category"
        },
        productShortDescription: { 
            type : String,
            require: true,
        }, 
        productDescription: { 
            type : String,
            require: true,
        },
        productPrice: {
            type : Number,
            require: true,
            default:0
        },
        productSalePrice: {
            type : Number,
            require: true,
            default:0
        },
        productImage: {
            type : String
        },
        productSKU: {
            type : String,
            required:false
        },
        productType : {
            type: String,
            required : true,
            default : "simple"
        },
        stockStatus : {
            type: String,
            default : "IN"
        },
        qtyAvailable : {
            type: Number,
            default:0
        },
        isPresReq : {
            type: Boolean,
            default:false
        },
        relatedProducts : [
            {
                type : mongoose.Schema.Types.ObjectId,
                ref : "RelatedProduct"
            }
        ]
        },{ 
        toJSON: {
            transform: function (doc, ret) {
                try{
                ret.productId = ret.productId.toString();
                }
                catch{
                ret.productId = ret._id.toString();
                }
                delete  ret._id;
                delete ret.__v;
            }
        } 
    })
);

module.exports = {
  product
};