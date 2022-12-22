import { serve } from "https://deno.land/std/http/server.ts";
import { config } from "https://deno.land/std/dotenv/mod.ts";

const handler = (request: Request): Response => {
  const body = "Hello world..!";

  return new Response(body, { status: 200 });
};

await serve(handler);
