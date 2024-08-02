FROM ghcr.io/gleam-lang/gleam:v1.3.2-erlang-alpine

WORKDIR /build

COPY ./client /build/client
COPY ./server /build/server
COPY ./shared /build/shared

RUN mkdir -p /build/server/priv

# Compile frontend
RUN cd /build/client \
  && gleam clean \
  && gleam deps download \
  && gleam run -m lustre/dev build --outdir=/build/server/priv

# Compile the project
RUN cd /build/server \
  && gleam export erlang-shipment \
  && mv build/erlang-shipment /app \
  && rm -r /build

# Run the server
WORKDIR /app
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["run"]
