"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const serverlessConfiguration = {
    service: 'vpc-delete',
    frameworkVersion: '2',
    custom: {
        webpack: {
            webpackConfig: './webpack.config.js',
            includeModules: true
        }
    },
    plugins: ['serverless-webpack', 'serverless-plugin-typescript'],
    provider: {
        name: 'aws',
        runtime: 'nodejs12.x',
        apiGateway: {
            minimumCompressionSize: 1024,
        },
        environment: {
            AWS_NODEJS_CONNECTION_REUSE_ENABLED: '1',
        },
    },
    functions: {
        hello: {
            handler: 'handler.hello',
            events: [
                {
                    http: {
                        method: 'get',
                        path: 'hello',
                    }
                }
            ]
        }
    }
};
module.exports = serverlessConfiguration;
//# sourceMappingURL=serverless.js.map