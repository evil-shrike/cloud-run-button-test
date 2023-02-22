FROM google/cloud-sdk:alpine
RUN apk add --update nodejs npm
RUN apk update &&  apk add --no-cache bash ttyd tzdata sudo nano curl
CMD ["ttyd", "bash"] 
EXPOSE 7681/tcp
