const { create } = require("./routes/create");
const { getUserById } = require("./routes/get_user_by_id");

exports.handler = async (event) => {
    const path = event.rawPath || event.path;
    const method = event.httpMethod;

    try {
        //create user
        if(path === "/create" && method === "POST") {
            return await create(event);
        }
        //get user
        if(path.startsWith("/user/") && method === "GET") {
            const id = path.split("/")[2];
            return await getUserById(event, id);
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
