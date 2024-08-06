FROM ghcr.io/gleam-lang/gleam:v1.4.1-erlang-alpine

WORKDIR /build

COPY . /build

# Compile the project
RUN cd /build \
  && gleam export erlang-shipment \
  && mv build/erlang-shipment /app \
  && rm -r /build

# Run the server
WORKDIR /app
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["run"]
