# Glen Fake Clients API

A small Glen HTTP + JSON API designed for examples and Render deployment.

## Files

```text
Server.gl     HTTP API server
Client.gl     Glen client that consumes the API
Dockerfile    Render-ready runtime image for a precompiled Glen ELF
render.yaml   Optional Render Blueprint
```

## Endpoints

```text
GET  /
GET  /health
GET  /clients
GET  /clients/:id
POST /clients/validate
```

## Local run

```bash
glenc Server.gl -o Server
./Server
```

In another terminal:

```bash
glenc Client.gl -o Client
./Client
```

## Render deployment

Render web services should listen on the `PORT` environment variable. This server reads `PORT` and falls back to `7700` locally.

Before deploying, build the Linux ELF:

```bash
glenc Server.gl -o Server
```

Then commit or upload this folder with the compiled `Server` binary and the `Dockerfile`.

On Render:

1. Create a new Web Service.
2. Use Docker as the runtime.
3. Set the service root to this folder if it lives inside a larger repository.
4. Keep `PORT=10000` or let Render provide it.
5. Deploy.

After deploy, call:

```bash
curl https://YOUR-RENDER-SERVICE.onrender.com/health
curl https://YOUR-RENDER-SERVICE.onrender.com/clients
```

Run the Glen client against the deployed API:

```bash
./Client https://YOUR-RENDER-SERVICE.onrender.com
```
