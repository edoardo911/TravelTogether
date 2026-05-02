const { connect } = require("../services/mongo");

exports.getUserById = async (event, id) => {
    const db = await connect();
    const users = db.collection("users");

    const user = await users.findOne({ uuid: id });
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
            uuid: id,
            name: user.name,
            email: user.email,
        }),
    };
}