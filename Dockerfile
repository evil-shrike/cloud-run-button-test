FROM google/cloud-sdk

RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
    apt-get install -y nodejs \
    build-essential && \
    node --version && \ 
    npm --version

npm install --global pnpm

# install ttyd
RUN apt-get install -y build-essential cmake git libjson-c-dev libwebsockets-dev
RUN git clone https://github.com/tsl0922/ttyd.git
WORKDIR ./ttyd
RUN cmake .
RUN make && make install

CMD ["ttyd", "--debug=7", "bash"]

EXPOSE 7681/tcp