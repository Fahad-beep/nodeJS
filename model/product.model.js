const mongoose = require("mongoose");

const productModelSchema = new mongoose.Schema(
  {
    id: { type: Number, required: true },
    Name: { type: String, required: true },
    Price: { type: Number, required: true },
    Description: { type: String, required: true },
  },
  { _id: false }
);
const productModel = mongoose.model("product", productModelSchema);
module.exports = productModel;
