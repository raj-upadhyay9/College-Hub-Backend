require("dotenv").config();

const express = require("express");
const errorHandler = require("errorhandler");
const bodyParser = require("body-parser");
const methodOverride = require("method-override");
const logger = require("morgan");
const { pool } = require("./config/db/index");

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

// app.get("/*/:uid", async (req, res) => {});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
