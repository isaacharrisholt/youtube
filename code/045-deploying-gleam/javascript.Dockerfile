FROM ghcr.io/gleam-lang/gleam:v1.4.1-node-alpine

WORKDIR /build

COPY . /build

# Compile the project
RUN cd /build \
  && gleam build --target javascript \
  && mv build/dev/javascript /app \
  && rm -r /build

# Run the server
WORKDIR /app
RUN echo "main()" >> /app/primes/primes.mjs
CMD ["node", "/app/primes/primes.mjs"]
