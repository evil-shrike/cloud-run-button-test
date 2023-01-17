FROM google/cloud-sdk:alpine

RUN apk add --update nodejs npm

ENV AUTOLOGIN="true" \
    TZ="Etc/UTC"

RUN apk update && \
    apk add --no-cache bash ttyd tzdata sudo nano curl

#CMD ["ttyd", "bash", "--", "-c \"npm init gaarf-wf\""]
CMD ["ttyd", "npm", "--", "init", "gaarf-wf"]

EXPOSE 7681/tcp