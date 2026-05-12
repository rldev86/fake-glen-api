# Glen Render Fake Clients API - performance build

This example is tuned for large JSON responses.

Changes:

- Generates 5,000 fake clients once at startup.
- Caches the complete `/clients` JSON string in memory.
- Serves `/clients` with `HttpResponse.json(CACHED_CLIENTS_JSON)` instead of rebuilding JSON per request.
- Uses `HttpServer.onHost("0.0.0.0", port)` for Render and Docker.
- Client avoids printing thousands of lines by default and reports network/parse timings.
- Client runs independent calls with `Thread.spawn`.

## Local run

```bash
glenc Server.gl -o Server
./Server
```

In another terminal:

```bash
glenc Client.gl -o Client
./Client http://127.0.0.1:7700
```

## Render

Deploy with the included Dockerfile. Render provides `PORT`; the server reads it automatically.

```bash
./Client https://YOUR-SERVICE.onrender.com
```

## Benchmark

```bash
curl -o /dev/null -s -w "status=%{http_code} time=%{time_total}s size=%{size_download}\n" http://127.0.0.1:7700/clients
```

## Performance notes

For large JSON responses, do not rebuild the full JSON tree on every request. This example precomputes the `/clients` response once at startup and serves the cached JSON string.

The client intentionally prints only the first 10 clients. Printing 5,000 lines can dominate the benchmark and hides the actual HTTP/JSON cost.

For real production APIs, prefer pagination:

```text
GET /clients?page=1&limit=100
```

Returning 5,000 objects is useful for stress tests, but public APIs should usually page large lists.
