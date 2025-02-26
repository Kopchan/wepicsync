import {FastifyPluginAsync} from 'fastify';

const signup: FastifyPluginAsync = async (fastify, opts): Promise<void> => {
  fastify.get('/signup', {
    schema: {
      tags: ['Auth']
    }
  }, async function (request, reply) {
    return 'this is an example'
  })
}

export default signup;
