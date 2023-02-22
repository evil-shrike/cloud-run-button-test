FROM google/cloud-sdk:alpine
RUN apk add --update nodejs npm
RUN apk update &&  apk add --no-cache bash ttyd tzdata sudo nano curl
EXPOSE 7681/tcp
RUN npm install -g create-gaarf-wf
COPY answers.json .
COPY precreate.sh .
COPY ads-queries ads-queries
COPY bq-queries bq-queries
CMD ["ttyd", "bash", "-c", "npm init gaarf-wf -- --answers=answers.json"]
