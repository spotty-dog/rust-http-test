FROM rust:1.30 as build

COPY . .

RUN rustup target add x86_64-unknown-linux-musl

RUN cargo build --target x86_64-unknown-linux-musl --release

FROM alpine:latest

COPY --from=build target/x86_64-unknown-linux-musl/release/rust-http-test /rust-http-test

CMD ["/rust-http-test"]
