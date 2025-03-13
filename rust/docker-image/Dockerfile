FROM ghcr.io/netwarlan/rust:latest

ENV APP_DIR="/app"

# copy edited run.sh 
COPY run-rust-dedicated-server.sh $APP_DIR/run.sh

## Set working directory
WORKDIR $APP_DIR

## Start the run script
CMD ["bash", "run.sh"]
