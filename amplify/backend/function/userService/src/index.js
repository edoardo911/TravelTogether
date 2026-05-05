const { create } = require("./routes/create");
const { getUserById } = require("./routes/get_user_by_id");
const { getUsersByIDS } = require("./routes/get_users_by_ids");

exports.handler = async (event) => {
    const method = event.httpMethod;
    const resource = event.resource;

    try {
        if(resource === "/create" && method === "POST") {
            return await create(event);
        }
        if(resource === "/users/{uuid}" && method === "GET") {
            return await getUserById(event);
        }
        if(resource === "/group" && method === "PUT") {
            return await getUsersByIDS(event);
        }

        return {
            statusCode: 404,
            body: "Not found",
        };
    } catch(err) {
        console.error(err);
        return {
            statusCode: 500,
            body: JSON.stringify({ error: err.message }),
        };
    }
};
