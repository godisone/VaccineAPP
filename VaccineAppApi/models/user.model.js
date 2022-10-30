const mongoose = require("mongoose");


const user = mongoose.model(
  "User",
  mongoose.Schema({
    fullName: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    }
},
    {
        "toJSON": {
            transform: (document, returnedObject) => {
                returnedObject.id = returnedObject._id.toString();
                delete returnedObject._id;
                delete returnedObject.__v;
                //do not reveal passwordHash
                delete returnedObject.password;
            },
        }
    }, {
        timestamps: true
    })
);

/**
 * 1. The userSchema.plugin(uniqueValidator) method won’t let duplicate email id to be stored in the database.
 * 2. The unique: true property in email schema does the internal optimization to enhance the performance.
 */
// UserSchema.plugin(uniqueValidator, { message: "Email already in use." });

// const User = mongoose.model("user", UserSchema);
module.exports ={
    user
};