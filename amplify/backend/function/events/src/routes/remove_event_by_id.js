const { connect } = require("../services/mongo");
const { ObjectId } = require('mongodb');

exports.removeEventByID = async (event) => {
    const db = await connect();
    const collection = db.collection("events");
    const id = event.pathParameters.id;

    const result = await collection.deleteOne({
        _id: new ObjectId(id),
    });
    if(result.deletedCount === 1) {
        return {
            statusCode: 200,
            body: "",
        };
    }
    return {
        statusCode: 404,
        body: "Document not found",
    };
}