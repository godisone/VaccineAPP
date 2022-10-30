const mongoose = require("mongoose");
const { stringify } = require("nodemon/lib/utils");

const category = mongoose.model(
    "Category",
    mongoose.Schema(
        {
            categoryName: {
                type: String,
                require:true,
                unique:true,
            },
            categoryDescription:{
                type:String,
                require:false,
            },
            categoryImage: {
                type:String,
            },
        },
        {
        toJSON : {
            transform : function (doc, ret) {
                try{
                ret.categoryId = ret._id.toString();
                }
                catch(ex){
                ret.categoryId = ret.categoryId.toString();
                }
                delete ret._id;
                delete ret._v;
            },
        },
    }
    )
);

module.exports = {
    category,
}