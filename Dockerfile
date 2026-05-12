FROM ubuntu:24.04

WORKDIR /app

COPY . .

RUN chmod +x ./Server

ENV PORT=10000

EXPOSE 10000

CMD ["./Server"]