require("dotenv").config();

const express = require("express");
const errorHandler = require("errorhandler");
const bodyParser = require("body-parser");
const methodOverride = require("method-override");
const logger = require("morgan");
const { pool } = require("./db/config/index");

// car pool
const carPool = require("./db/car_pooling");
// food schema
const food = require("./db/food");

const app = express();
const port = 3000 || process.env.PORT;

app.use(logger("dev"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(methodOverride("_method"));
app.use(errorHandler());

// app.use((req, res, next) => {

// });

app.get("/", (req, res) => {
  res.status(200).json("hey");
});

app.get("/db", (req, res) => {
  pool.query('SELECT * FROM public."User"', (error, results) => {
    if (error) {
      throw error;
    }
    res.status(200).json(results.rows);
  });
});

// Car pooling routes

app.get("/car_pooling/:id", carPool.getCarPoolById);
app.post("/car_pooling", carPool.createCarPool);
app.put("/car_pooling/:id", carPool.updateCarPool);
app.delete("/car_pooling/:id", carPool.deleteCarPool);

// food routes
// food.items
app.get("/food/items/:id", food.items.getItemById);
app.post("/food/items", food.items.createItem);
app.put("/food/items/:id", food.items.updateItem);
app.delete("/food/items/:id", food.items.deleteItem);

//food.order

app.get("/food/order/:id", food.order.getOrderById);
app.post("/food/order", food.order.createOrder);
app.put("/food/order/:id", food.order.updateOrder);
app.delete("/food/order/:id", food.order.deleteOrder);

// food.store
app.get("/food/store/:id", food.store.getStoreById);
app.post("/food/store", food.store.createStore);
app.put("/food/store/:id", food.store.updateStore);
app.delete("/food/store/:id", food.store.deleteStore);

// app.get("/*/:uid", async (req, res) => {});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
