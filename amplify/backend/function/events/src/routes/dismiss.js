const { connect } = require("../services/mongo");
const { ObjectId } = require('mongodb');

exports.dismiss = async (event) => {
    const db = await connect();
    const collection = db.collection("events");
    const eventId = event.pathParameters.id;

    const body = JSON.parse(event.body);
    const { id } = body;

    const result = await collection.updateOne(
        { _id: new ObjectId(eventId) },
        { $pull: { participants: id, } }
    );

    if(result.modifiedCount == 1) {
        return {
            statusCode: 200,
            body: "",
        };
    }
    return {
        statusCode: 400,
        body: "Event not modified",
    };
}