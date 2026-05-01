const { connect } = require("../services/mongo");

exports.create = async (event) => {
    const body = JSON.parse(event.body);
    const { uuid, name, email } = body;

    const db = await connect();
    const users = db.collection("users");

    const result = await users.updateOne(
        { uuid }, {
            $set: {
                uuid,
                email,
                name
            },
            $setOnInsert: {
                createdAt: new Date(),
            },
        },
        { upsert: true }
    );

    return {
        statusCode: 200,
        body: "Success",
    };
}