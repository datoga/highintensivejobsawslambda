FROM node:16-buster-slim as lambda

WORKDIR /lambda
COPY . .

RUN apt-get update && apt-get install -y zip

RUN cd src/simplelambda && npm install && zip -r simplelambda.zip .
RUN cd src/screenshotslambda && npm install && zip -r screenshotslambda.zip .

FROM localstack/localstack:0.14.3.1

COPY --from=lambda /lambda/src/simplelambda/simplelambda.zip ./simplelambda.zip
COPY --from=lambda /lambda/src/screenshotslambda/screenshotslambda.zip ./screenshotslambda.zip