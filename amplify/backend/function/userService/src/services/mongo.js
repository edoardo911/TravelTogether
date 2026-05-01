const { MongoClient } = require("mongodb");

let client;
let db;

async function connect() {
    if(db) return db;

    client = new MongoClient(process.env.MONGO_URI);
    await client.connect();

    db = client.db("TravelTogether");
    return db;
}

module.exports = { connect };