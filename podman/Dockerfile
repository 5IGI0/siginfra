FROM alpine:latest
RUN apk add --no-cache podman iptables npm curl nodejs fuse-overlayfs && sed 's|#mount_program = "/usr/bin/fuse-overlayfs"|mount_program = "/usr/bin/fuse-overlayfs"|g' -i /etc/containers/storage.conf
CMD ["podman", "system", "service", "--time=0", "tcp:0.0.0.0:5656"]
