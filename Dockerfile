FROM node:18-buster-slim as lambda

ARG PORT=8000
ENV PORT=$PORT
WORKDIR /usr/src
COPY . .
# Install zip in container
RUN apt-get update && apt-get install -y zip
# Enter the src directory, install dependencies, and zip the src directory in the container
RUN cd src && npm install && zip -r lambdas.zip .

FROM localstack/localstack:0.14.3.1
# Copy lambdas.zip into the localstack directory
COPY --from=lambda /usr/src/src/lambdas.zip ./lambdas.zip