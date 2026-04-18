FROM alpine:latest
RUN apk add --no-cache podman iptables npm curl nodejs
CMD ["podman", "system", "service", "--time=0", "tcp:0.0.0.0:5656"]
