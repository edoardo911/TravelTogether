const { getEventsByUUID } = require("./routes/get_events_by_uuid");
const { removeEventByID } = require("./routes/remove_event_by_id");
const { enroll } = require("./routes/enroll");
const { dismiss } = require("./routes/dismiss");

exports.handler = async (event) => {
    const method = event.httpMethod;
    const resource = event.resource;

    try {
        if(resource === "/events/{uuid}" && method === "GET") {
            return await getEventsByUUID(event);
        }
        if(resource === "/remove/{id}" && method === "DELETE") {
            return await removeEventByID(event);
        }
        if(resource === "/enroll/{id}" && method === "PUT") {
            return await enroll(event);
        }
        if(resource === "/dismiss/{id}" && method === "PUT") {
            return await dismiss(event);
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
