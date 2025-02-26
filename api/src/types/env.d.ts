import '@fastify/env';
import { EnvSchema } from '@/config';

declare module 'fastify' {
  interface FastifyInstance {
    config: EnvSchema;
  }
}
