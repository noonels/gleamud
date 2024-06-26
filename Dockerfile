FROM ghcr.io/gleam-lang/gleam:v1.0.0-erlang-alpine

# Add packages to build non-gleam deps
RUN apk add gcc \
    && apk add musl-dev

# Add project code
COPY . /build/

# Compile the project
RUN cd /build \
    && gleam export erlang-shipment \
    && mv build/erlang-shipment /app \
    && rm -r /build

# Run the server
WORKDIR /app
ENTRYPOINT ["/app/entrypoint.sh"]
EXPOSE 3000
CMD ["run"]