const { connect } = require("../services/mongo");

exports.getEventsByUUID = async (event) => {
    const db = await connect();
    const collection = db.collection("events");
    const uuid = event.pathParameters.uuid;

    const events = await collection.find({ authorUUID: uuid }).toArray();
    return {
        statusCode: 200,
        body: JSON.stringify({
            events: events || [],
        }),
    };
}