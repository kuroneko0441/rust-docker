FROM rust:1.88.0-alpine AS builder

RUN apk add --no-cache musl-dev

WORKDIR /usr/src/app

# Cache dependencies
COPY Cargo.toml Cargo.lock ./
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --release
RUN rm -rf src

COPY src ./src
RUN touch src/main.rs && cargo build --release

FROM scratch AS runner

COPY --from=builder /usr/src/app/target/release/rust-docker /usr/local/bin/rust-docker

ENTRYPOINT ["rust-docker"]
