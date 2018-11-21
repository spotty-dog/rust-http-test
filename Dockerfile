FROM rust:1.30 as build

RUN apt-get update && apt-get -y install musl-tools

RUN rustup target add x86_64-unknown-linux-musl

COPY Cargo.* ./
COPY src src

RUN cargo build --target x86_64-unknown-linux-musl --release

FROM alpine:3.8

COPY --from=build target/x86_64-unknown-linux-musl/release/rust-http-test /rust-http-test

CMD ["/rust-http-test"]
