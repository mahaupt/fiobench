FROM alpine:latest

RUN apk --no-cache add make alpine-sdk zlib-dev libaio-dev linux-headers coreutils libaio 
RUN git clone https://github.com/axboe/fio
RUN cd fio && ./configure && make -j`nproc` && make install && cd .. && rm -rf fio
RUN apk --no-cache del make alpine-sdk zlib-dev libaio-dev linux-headers coreutils

VOLUME /tmp
WORKDIR /tmp

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["fio"]
