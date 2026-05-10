const { connect } = require("../services/mongo");

function escapeRegExp(string) {
    return string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

exports.searchByName = async (event) => {
    const db = await connect();
    const collection = db.collection("events");
    const name = event.pathParameters.name;

    const events = await collection.find({
        name: {
            $regex: escapeRegExp(name),
            $options: "i"
        }
    }).toArray();
    return {
        statusCode: 200,
        body: JSON.stringify({
            events: events || [],
        }),
    };
}