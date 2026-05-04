const { connect } = require("../services/mongo");

exports.getUserById = async (event) => {
    const db = await connect();
    const users = db.collection("users");
    const uuid = event.pathParameters.uuid;

    const user = await users.findOne({ uuid });
    if(!user) {
        return {
            statusCode: 404,
            body: "User not found",
        };
    }

    return {
        statusCode: 200,
        body: JSON.stringify({
            id: user._id.toString(),
            uuid: uuid,
            name: user.name,
            email: user.email,
        }),
    };
}