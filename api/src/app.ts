import { join } from 'node:path';
import AutoLoad, {AutoloadPluginOptions} from '@fastify/autoload';
import { FastifyPluginAsync, FastifyServerOptions } from 'fastify';
import dotenv from "dotenv";
import fastifyEnv from "fastify-env";
import {envSchema} from "@/config";

dotenv.config();

export interface AppOptions extends FastifyServerOptions, Partial<AutoloadPluginOptions> {}

// Pass --options via CLI arguments in command to enable these options.
const options: AppOptions = {}

const app: FastifyPluginAsync<AppOptions> = async (
    fastify,
    opts
): Promise<void> => {
  // Parse environment variables
  await fastify.register(fastifyEnv, {
    schema: envSchema,
    dotenv: true,
    data: process.env,
  });

  const env = fastify.config;

  // Allow any origin
  fastify.register(require('@fastify/cors'), { origin: '*' });

  // Cache users
  fastify.register(require('@fastify/redis'), {
    host: env.REDIS_HOST,
    port: env.REDIS_PORT
  });

  // API documentation
  fastify.register(require('@fastify/swagger'), {
    swagger: {
      info: {
        title: 'WepicSync API',
        description: 'Testing the Fastify swagger API',
        version: '0.1.0',
      },
      externalDocs: {
        url: 'https://swagger.io',
        description: 'Find more info here',
      },
      tags: [
        { name: 'Default', description: 'Test tag' },
      ],
      host: 'localhost:3000',
      schemes: ['http'],
      consumes: ['application/json'],
      produces: ['application/json'],
    },
  });

  // Swagger page
  fastify.register(require('@fastify/swagger-ui'), { routePrefix: '/docs' });

  // Do not touch the following lines

  // This loads all plugins defined in plugins
  // those should be support plugins that are reused
  // through your application
  void fastify.register(AutoLoad, {
    dir: join(__dirname, 'plugins'),
    options: opts
  })

  // This loads all plugins defined in routes
  // define your routes in one of these
  void fastify.register(AutoLoad, {
    dir: join(__dirname, 'routes'),
    options: opts
  })
};

export default app;
export { app, options }
