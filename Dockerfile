FROM google/cloud-sdk:alpine

RUN apk add --update nodejs npm

RUN apk update && \
    apk add --no-cache bash ttyd sudo nano curl

RUN wget -qO /bin/pnpm "https://github.com/pnpm/pnpm/releases/latest/download/pnpm-linuxstatic-x64" && chmod +x /bin/pnpm

RUN npm install -g create-gaarf-wf
#RUN pnpm create gaarf-wf

CMD ["ttyd", "--debug=7", "bash"]

#CMD ["ttyd", "bash", "-c", "npm init gaarf-wf -- --diag"]


EXPOSE 7681/tcp