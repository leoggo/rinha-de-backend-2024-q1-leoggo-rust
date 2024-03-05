FROM rust:1.76.0-slim as build

WORKDIR /home

COPY . .

ENV RUSTFLAGS="-C target-feature=+crt-static"

RUN cargo build --release --target x86_64-unknown-linux-gnu

FROM rust:1.76.0-slim

COPY --from=build /home/target/x86_64-unknown-linux-gnu/release/rinha /rinha

EXPOSE 8080

CMD ["/rinha"]