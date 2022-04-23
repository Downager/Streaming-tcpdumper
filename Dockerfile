FROM gcr.io/google.com/cloudsdktool/cloud-sdk:alpine

COPY . /

RUN apk update && \
    apk add tcpdump --no-cache && \
    rm /var/cache/apk/*

CMD ["./tcpdump.sh"]