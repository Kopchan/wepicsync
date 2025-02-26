import { FastifyPluginAsync } from 'fastify';
//import fastifySwagger from '@fastify/swagger';
//import fastifySwaggerUi from '@fastify/swagger-ui';

const swaggerPlugin: FastifyPluginAsync = async (fastify, opts) => {
  // Регистрация fastify-swagger
  // TODO: пофиксить (не отображаются маршруты) и вынести
  /*
  fastify.register(fastifySwagger, {
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

  // Регистрация fastify-swagger-ui
  fastify.register(fastifySwaggerUi, {
    routePrefix: '/docs',
  });
  */
};

export default swaggerPlugin;
