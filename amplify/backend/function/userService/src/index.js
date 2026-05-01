const { create } = require("./routes/create")

exports.handler = async (event) => {
    const path = event.path;
    const method = event.httpMethod;

    try {
        if(path === "/create" && method === "POST") {
            return await create(event);
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
