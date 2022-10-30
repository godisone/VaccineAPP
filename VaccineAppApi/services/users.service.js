const {user} = require("../models/user.model");
const bcrypt = require("bcryptjs");
const auth = require("../middleware/auth.js");

const crypto = require("crypto");

async function login({ email, password }, callback) {
  const userModel = await user.findOne({ email });

  if (userModel != null) {
    if (bcrypt.compareSync(password, userModel.password)) {
      const token = auth.generateAccessToken(userModel.toJSON());
      // call toJSON method applied during model instantiation
      return callback(null, { ...userModel.toJSON(), token });
    } else {
      return callback({
        message: "Invalid Username/Password!",
      });
    }
  } else {
    return callback({
      message: "Invalid Username/Password!",
    });
  }
}

async function register(params, callback) {
  if (params.email === undefined) {
    console.log(params.email);
    return callback(
      {
        message: "Email Required",
      },
      ""
    );
  }

  try{
  let isUserExist = await user.findOne({email:params.email});

  if(isUserExist){
    return callback({
        message : "Email already registered!"
    })
  }
}
catch{

}

  const salt = bcrypt.genSaltSync(10);
  params.password = bcrypt.hashSync(params.password, salt);

  const userSchema = new user(params);
  userSchema
    .save()
    .then((response) => {
      return callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}


module.exports = {
  login,
  register,
};