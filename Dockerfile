# FROM python:buster
FROM python:alpine

RUN pip install --upgrade pip ipython

########################################################################################
# liboqs

# dependencies
# RUN apt-get update && apt-get install -y unzip xsltproc doxygen graphviz
RUN apk add --update --no-cache autoconf automake libtool gcc musl-dev \
                                    git make libressl-dev libxslt doxygen graphviz

RUN pip install pytest

# clone repo
WORKDIR /usr/src/
RUN git clone https://github.com/open-quantum-safe/liboqs.git

# install
WORKDIR /usr/src/liboqs/
RUN autoreconf -i && ./configure && make clean && make -j

# liboqs
########################################################################################

WORKDIR /usr/src/liboqs-python/
COPY . .
RUN pip install -e .
ENV LIBOQS_INSTALL_PATH /usr/src/liboqs/.libs/liboqs.so
