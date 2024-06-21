const { MongoClient } = require("mongodb");
const url = "mongodb://localhost:27017";
const dbName = "Flutter Project Data Base";
async function connection() {
  const client = new MongoClient(url);
  await client.connect();
  const db = client.db(dbName);
  return db;
}

module.exports = connection();
