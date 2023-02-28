FROM google/cloud-sdk:alpine
RUN apk add --update nodejs npm
RUN apk update &&  apk add --no-cache bash ttyd tzdata sudo nano curl
EXPOSE 7681/tcp
RUN npm install -g create-gaarf-wf
WORKDIR /app
COPY answers.json .
COPY ads-queries ads-queries
COPY bq-queries bq-queries
COPY cloud-run-hooks/main.sh main.sh
#COPY google-ads.yaml .
CMD ["ttyd", "bash", "-c", "./main.sh"]
#CMD ["ttyd", "bash"]