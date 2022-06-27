exports.handler = async (event, context) => {
    const msg = event.Records[0].body;
    
    console.log(`Message: ${msg}`);
};