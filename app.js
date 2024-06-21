const productModel = require("./model/product.model");
const express = require("express");
app = new express();
const PORT = process.env.port || 3000;
console.log("Port: " + PORT);
app.use(express.json()); //if data in req.body is in json encoded then it will make it a json type object after parsing it and save it in
//req.body
let pData = [];
app.use(express.urlencoded({ extended: true })); //if url encoded payload is given e.g url?city=karachi&game=pussy+gamer then
// it will make it a json type object after parsing it and save it in req.body

app.listen(PORT, (req, res) => {
  console.log("listening on port " + PORT);
});

//post method: saving data into the database from client side through this my created server
app.post("/api/addProduct", (req, res) => {
  console.log("in add product function: ", req.body);

  const pdata = new productModel({
    id: pData.length + 1,
    Name: req.body.name,
    Price: req.body.price,
    Description: req.body.desc,
  });
  console.log(typeof pdata.id);
  pData.push(pdata);
  res.status(200).send({
    message: "product added successfully",
    data: pData,
    statusCode: "200",
  });
});

//get method: getting data from the database to the client side through this my created server

app.get("/api/getProduct", (req, res) => {
  console.log("in get product function: ");
  if (pData.length > 0) {
    res.status(200).send({
      message: "data found",
      products: pData,
      statusCode: "200",
    });
  } else {
    res.status(200).send({
      message: "no data found",
      products: [],
      statusCode: "200",
    });
  }
});

//put method replaces the whole element  according to parameter
app.put("/api/update/:id", (req, res) => {
  let id = req.params.id * 1;
  console.log("in update Entry1: " + id);
  console.log("req.body: ", req.body);
  let pDataUpdate = pData.find((p) => p.id === id);
  let index = pData.indexOf(pDataUpdate);
  pData[index] = req.body;
  res.status(200).send({
    message: "product updated successfully",
    changedData: pData,
    prevData: pDataUpdate,
    statusCode: "200",
  });
});

//delete data
app.delete("/api/delete/:id", (req, res) => {
  let id = req.params.id * 1;

  console.log("in delete Entry1: " + id);
  console.log("req.body: ", req.body);
  let pDataUpdate = pData.find((p) => p.id === id);
  let index = pData.indexOf(pDataUpdate);
  console.log("index: ", index);
  if (index >= 0) {
    pData.splice(index, 1);
    console.log("pSlice ", pData);
    res.status(200).send({
      message: "successfully Deleted",
      data: pData,
      statusCode: "200",
    });
  } else {
    res.status(200).send({
      message: "Failed Deleted (not found)",
      statusCode: "204",
    });
  }
});
