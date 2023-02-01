FROM google/cloud-sdk:alpine

RUN apk add --update nodejs npm

RUN apk update && \
    apk add --no-cache bash ttyd sudo nano curl

RUN npm cache clean -f
RUN npm cache verify
RUN npm install -g create-gaarf-wf

CMD ["ttyd", "--debug=7", "bash"]

#CMD ["ttyd", "bash", "-c", "npm init gaarf-wf -- --diag"]


EXPOSE 7681/tcp