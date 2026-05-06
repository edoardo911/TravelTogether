const { connect } = require("../services/mongo");
const { ObjectId } = require('mongodb');

exports.getUsersByIDS = async (event) => {
    const db = await connect();
    const users = db.collection("users");
    const body = JSON.parse(event.body);

    const ids = body["ids"].map(e => new ObjectId(e));

    const result = await users.find({
        _id: { $in: ids },
    }).toArray();

    return {
        statusCode: 200,
        body: JSON.stringify({
            "users": result || [],
        }),
    };
}