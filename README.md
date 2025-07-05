# rust-docker

This project is a PoC demonstrating how to run a Rust project inside a Docker container.

## Run

```bash
docker run --rm -it $(docker build . --quiet)
```
