const winston = require('winston');
const Log2gelf = require('winston-log2gelf');

const logger = winston.createLogger({
  transports: [
    new winston.transports.Console({
      handleExceptions: true,
      json: true,
      colorize: true,
    }),
    new Log2gelf({
      host: process.env.GRAYLOG_HOST,
      port: process.env.GRAYLOG_PORT,
      protocol: "https",
      handleExceptions: true,
      environment: process.env.ENVIRONMENT,
      service: process.env.SERVICE,
      release: "1",
      hostname: `${process.env.ENVIRONMENT}-${process.env.SERVICE}-${
        process.env.HOSTNAME
      }`,
    })
  ],
});


exports.logger = logger;
