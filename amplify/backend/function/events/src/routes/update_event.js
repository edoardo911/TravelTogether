const { connect } = require("../services/mongo");
const { ObjectId } = require('mongodb');

exports.update = async (event) => {
    const db = await connect();
    const collection = db.collection("events");
    const eventId = event.pathParameters.id;

    const body = JSON.parse(event.body);
    const { name, description, location, duration, date, transportation } = body;

    const result = await collection.updateOne(
        { _id: new ObjectId(eventId) },
        {
            $set: {
                name: name,
                description: description,
                location: location,
                duration: duration,
                date: date,
                transportation: transportation,
            }
        }
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