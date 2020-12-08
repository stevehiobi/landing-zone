"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.hello = void 0;
require("source-map-support/register");
const hello = async (event, _context) => {
    return {
        statusCode: 200,
        body: JSON.stringify({
            message: 'Go Serverless Webpack (Typescript) v1.0! Your function executed successfully!',
            input: event,
        }, null, 2),
    };
};
exports.hello = hello;
//# sourceMappingURL=handler.js.map