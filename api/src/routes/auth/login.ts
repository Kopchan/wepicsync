import {FastifyPluginAsync} from "fastify";

const login: FastifyPluginAsync = async (fastify, opts): Promise<void> => {
  fastify.get('/login', {
    schema: {
      tags: ['Auth']
    }
  }, async function (request, reply) {
    return 'this is an example'
  })
}

export default login
