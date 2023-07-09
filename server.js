const express = require("express");
const { Pool } = require("pg");
require("dotenv").config();

const app = express();
const port = 8080;
const database = process.env.PG_DATABASE;

const pool = new Pool({
  host: process.env.PG_HOST,
  port: process.env.PG_PORT,
  database: database,
  user: process.env.PG_USER,
  password: process.env.PG_PASSWORD,
});

async function query(statement, values = []) {
  try {
    const client = await pool.connect();
    const result = await client.query(statement, values);
    client.release();
    console.log("statement", statement);
    console.log("values", values);
    // console.log("result", result);
    return result.rows;
  } catch (error) {
    throw error;
  }
}

app.get("/", (_, res) => {
  res.send("Hello World");
});

app.get("/player", async (_, res) => {
  try {
    let sql = `SELECT * FROM player`;
    let result = await query(sql);
    res.json(result);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.get("/event", async (_, res) => {
  try {
    let sql = `SELECT * FROM event`;
    let result = await query(sql);
    res.json(result);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
