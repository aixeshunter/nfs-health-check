FROM alpine:latest

RUN apk update && apk add --update nfs-utils && rm -rf /var/cache/apk/*

RUN rm /sbin/halt /sbin/poweroff /sbin/reboot

COPY nfs-check /home/nfs-check 
RUN chmod 775 /home/nfs-check

ENTRYPOINT ["/home/nfs-check"]
