FROM google/cloud-sdk:alpine

RUN apk add --update nodejs npm

RUN apk update && \
    apk add --no-cache bash ttyd sudo nano curl

RUN npm install -g create-gaarf-wf

CMD ["ttyd", "bash"]

#CMD ["ttyd", "bash", "-c", "npm init gaarf-wf -- --diag"]


EXPOSE 7681/tcp