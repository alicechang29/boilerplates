import express from "express";
import cors from "cors";
import { NotFoundError } from "./expressError.js";

// const express = require('express');
const app = express();
// allow both form-encoded and json body parsing
app.use(express.json());
app.use(express.urlencoded());
// allow connections to all routes from any browser
app.use(cors());


//ROUTES
app.get('/', function (req, res) {
  res.send({
    hello: "world"
  });
});

app.post('/', function (req, res) {
  const name = req.body.name || "there";
  res.send({
    hello: name
  });
});




/** Handle 404 errors -- this matches everything */
app.use(function (req, res, next) {
  throw new NotFoundError();
});

/** Generic error handler; anything unhandled goes here. */
app.use(function (err, req, res, next) {
  if (process.env.NODE_ENV !== "test") console.error(err.stack);
  const status = err.status || 500;
  const message = err.message;

  return res.status(status).json({
    error: { message, status },
  });
});

export default app;