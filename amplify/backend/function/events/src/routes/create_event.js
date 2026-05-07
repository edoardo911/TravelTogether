const { connect } = require("../services/mongo");

exports.create = async (event) => {
    const db = await connect();
    const collection = db.collection("events");

    const body = JSON.parse(event.body);
    const { name, description, location, authorUUID, maxParticipants, duration, date, participants, transportation } = body;

    const result = await collection.insertOne({
        name: name,
        description: description,
        location: location,
        authorUUID: authorUUID,
        maxParticipants: maxParticipants,
        duration: duration,
        date: date,
        participants: participants,
        transportation: transportation,
    });

    if(result.acknowledged) {
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