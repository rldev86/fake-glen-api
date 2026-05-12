# Render-ready runtime image for a precompiled Glen ELF.
# Build the Server binary locally, then deploy this folder to Render.
#
# Local build before pushing/deploying:
#   glenc Server.gl -o Server
#
# The produced Server ELF must be Linux x86_64 compatible with Render's runtime.

FROM debian:bookworm-slim

WORKDIR /app

COPY Server /app/Server

RUN chmod +x /app/Server

ENV PORT=10000
EXPOSE 10000

CMD ["/app/Server"]
