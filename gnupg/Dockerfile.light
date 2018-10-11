FROM olbat/gnupg:stable AS base

FROM scratch
ARG MAINTAINER
MAINTAINER $MAINTAINER

COPY --from=base \
	/usr/bin/gpg \
	/usr/bin/dirmngr \
	/usr/bin/gpg-agent \
	/usr/bin/pinentry \
	/usr/bin/

COPY --from=base /lib64/ld-linux-x86-64.so.2  /lib64/ld-linux-x86-64.so.2 



COPY --from=base \
	/lib/x86_64-linux-gnu/libbz2.so.1.0  \
	/lib/x86_64-linux-gnu/libc.so.6  \
	/lib/x86_64-linux-gnu/libdl.so.2  \
	/lib/x86_64-linux-gnu/libgcrypt.so.20  \
	/lib/x86_64-linux-gnu/libgpg-error.so.0  \
	/lib/x86_64-linux-gnu/libidn.so.11  \
	/lib/x86_64-linux-gnu/libm.so.6  \
	/lib/x86_64-linux-gnu/libpthread.so.0  \
	/lib/x86_64-linux-gnu/libreadline.so.7  \
	/lib/x86_64-linux-gnu/libresolv.so.2  \
	/lib/x86_64-linux-gnu/libtinfo.so.5  \
	/lib/x86_64-linux-gnu/libz.so.1  \
	/usr/lib/x86_64-linux-gnu/libassuan.so.0  \
	/usr/lib/x86_64-linux-gnu/libffi.so.6  \
	/usr/lib/x86_64-linux-gnu/libgmp.so.10  \
	/usr/lib/x86_64-linux-gnu/libgnutls.so.30  \
	/usr/lib/x86_64-linux-gnu/libhogweed.so.4  \
	/usr/lib/x86_64-linux-gnu/libksba.so.8  \
	/usr/lib/x86_64-linux-gnu/liblber-2.4.so.2  \
	/usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2  \
	/usr/lib/x86_64-linux-gnu/libnettle.so.6  \
	/usr/lib/x86_64-linux-gnu/libnpth.so.0  \
	/usr/lib/x86_64-linux-gnu/libp11-kit.so.0  \
	/usr/lib/x86_64-linux-gnu/libsasl2.so.2  \
	/usr/lib/x86_64-linux-gnu/libsqlite3.so.0  \
	/usr/lib/x86_64-linux-gnu/libtasn1.so.6  \
	/lib/

COPY --from=base /etc/passwd /etc/passwd
COPY --from=base /etc/group /etc/group
COPY --from=base /etc/shadow /etc/shadow
COPY --from=base /etc/gnupg /etc/gnupg
COPY --from=base /root/.gnupg /root/.gnupg
COPY --from=base /usr/share/gnupg/sks-keyservers.netCA.pem /usr/share/gnupg/sks-keyservers.netCA.pem

CMD ["/usr/bin/gpg"]
