FROM golang:bullseye@sha256:cb95e56313475447c4f1ba5262ddd7c6ba2c66cdb62c0c699001e8fa1755480f as go-build
RUN go install github.com/OJ/gobuster/v3@latest
RUN cp $GOPATH/bin/gobuster /usr/local/bin/

FROM debian:bullseye@sha256:7b991788987ad860810df60927e1adbaf8e156520177bd4db82409f81dd3b721

RUN sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list
RUN apt update

RUN apt install -y curl
RUN apt install -y net-tools
RUN apt install -y git
RUN apt install -y golang
RUN apt install -y python3-pip
RUN apt install -y ruby-dev
RUN apt install -y wget

RUN apt install -y ftp
RUN apt install -y hashcat
RUN apt install -y hydra
RUN apt install -y inetutils-ping
RUN apt install -y john
RUN apt install -y mariadb-client
RUN apt install -y nikto
RUN apt install -y nmap
RUN apt install -y redis-tools
RUN apt install -y smbclient
RUN apt install -y sqlmap

RUN rm -rf /var/lib/apt/lists/*

COPY --from=go-build /usr/local/bin/gobuster /usr/local/bin/

WORKDIR /usr/share/wordlists

ADD https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt .

WORKDIR /usr/share/wordlists/dirbuster

ADD https://raw.githubusercontent.com/3ndG4me/KaliLists/master/dirbuster/directory-list-lowercase-2.3-small.txt .
ADD https://raw.githubusercontent.com/3ndG4me/KaliLists/master/dirbuster/directory-list-lowercase-2.3-medium.txt .
ADD https://raw.githubusercontent.com/3ndG4me/KaliLists/master/dirbuster/directory-list-2.3-small.txt .
ADD https://raw.githubusercontent.com/3ndG4me/KaliLists/master/dirbuster/directory-list-2.3-medium.txt .

RUN echo "57d97413d133a4c22d7e463b3347f8c12f45e36d8eba81aea3b7944e3411aa4c directory-list-lowercase-2.3-small.txt" | sha256sum -c
RUN echo "f48f0d560c5494c04a145b3240c8c227a6d3b43a96081c21e3f49098e147519b  directory-list-lowercase-2.3-medium.txt" | sha256sum -c
RUN echo "0153f0943064efd0de1be5ba1ded239e900db77936a3de397255e8e76a796a56  directory-list-2.3-small.txt" | sha256sum -c
RUN echo "54c4dd1a34b29bfb6dc3bf3cb6dda2f1a8d6a6823ea92c01c723f9ae21c742c5  directory-list-2.3-medium.txt" | sha256sum -c

WORKDIR /root

RUN pip install netifaces
RUN git clone https://github.com/lgandx/Responder

CMD ["/bin/bash"]

