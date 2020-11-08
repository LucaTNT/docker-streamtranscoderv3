FROM ubuntu:latest AS build
RUN apt-get update && apt-get upgrade -y && apt-get install -y git gcc g++ make libvorbis-dev libmad0-dev libmp3lame-dev libflac-dev libfaac-dev && cd /tmp && git clone https://github.com/LucaTNT/streamtranscoder.git && cd /tmp/streamtranscoder/ && ./configure && make && make install DESTDIR=/tmp/streamtranscoder_build

FROM ubuntu:latest
RUN apt-get update && apt-get upgrade -y && apt-get install -y libvorbis0a libogg0 libmad0 libmp3lame0 libvorbisenc2 && rm -rf /var/lib/apt/lists/*
COPY --from=build /tmp/streamtranscoder_build/ /
COPY ./docker-entrypoint.sh /
CMD ["/docker-entrypoint.sh"]
