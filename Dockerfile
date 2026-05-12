FROM ubuntu:24.04
WORKDIR /app
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates libssl3 \
    && rm -rf /var/lib/apt/lists/*
COPY . .
RUN chmod +x ./Server
ENV PORT=10000
EXPOSE 10000
CMD ["./Server"]
