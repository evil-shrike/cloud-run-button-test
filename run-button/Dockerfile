FROM google/cloud-sdk

RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
    apt-get install -y nodejs \
    build-essential && \
    node --version && \ 
    npm --version

npm install --global pnpm
#RUN curl -fsSL https://get.pnpm.io/install.sh | sh -
#RUN wget -qO /bin/pnpm "https://github.com/pnpm/pnpm/releases/latest/download/pnpm-linuxstatic-x64" && chmod +x /bin/pnpm

# install ttyd
RUN apt-get install -y build-essential cmake git libjson-c-dev libwebsockets-dev
RUN git clone https://github.com/tsl0922/ttyd.git
WORKDIR ./ttyd
RUN cmake .
RUN make && make install


RUN npm install -g create-gaarf-wf
#RUN pnpm create gaarf-wf

CMD ["ttyd", "--debug=7", "bash"]

#CMD ["ttyd", "bash", "-c", "npm init gaarf-wf -- --diag"]


EXPOSE 7681/tcp