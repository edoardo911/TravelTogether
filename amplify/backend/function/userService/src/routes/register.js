exports.register = async (event) => {
    const body = JSON.parse(event.body);

    return {
        statusCode: 200,
        body: "TEST",
    };
}