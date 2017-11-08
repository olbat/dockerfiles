FROM olbat/imagemagick AS base

FROM scratch
ARG MAINTAINER
MAINTAINER $MAINTAINER

COPY --from=base \
	/usr/bin/identify \
	/usr/bin/mogrify \
	/usr/bin/montage \
	/usr/bin/display \
	/usr/bin/stream \
	/usr/bin/import \
	/usr/bin/conjure \
	/usr/bin/composite \
	/usr/bin/convert \
	/usr/bin/animate \
	/usr/bin/compare \
	/bin/

COPY --from=base /lib64/ld-linux-x86-64.so.2  /lib64/ld-linux-x86-64.so.2 

COPY --from=base \
	/usr/lib/x86_64-linux-gnu/ImageMagick-6.9.7/modules-Q16/coders/*.so \
	/lib/

COPY --from=base \
	/lib/x86_64-linux-gnu/libbsd.so.0  \
	/lib/x86_64-linux-gnu/libbz2.so.1.0  \
	/lib/x86_64-linux-gnu/libc.so.6  \
	/lib/x86_64-linux-gnu/libdl.so.2  \
	/lib/x86_64-linux-gnu/libexpat.so.1  \
	/lib/x86_64-linux-gnu/libgcc_s.so.1  \
	/lib/x86_64-linux-gnu/libglib-2.0.so.0  \
	/lib/x86_64-linux-gnu/liblzma.so.5  \
	/lib/x86_64-linux-gnu/libm.so.6  \
	/lib/x86_64-linux-gnu/libpcre.so.3  \
	/lib/x86_64-linux-gnu/libpthread.so.0  \
	/lib/x86_64-linux-gnu/librt.so.1  \
	/lib/x86_64-linux-gnu/libz.so.1  \
	/usr/lib/x86_64-linux-gnu/libcairo.so.2  \
	/usr/lib/x86_64-linux-gnu/libdatrie.so.1  \
	/usr/lib/x86_64-linux-gnu/libdjvulibre.so.21  \
	/usr/lib/x86_64-linux-gnu/libffi.so.6  \
	/usr/lib/x86_64-linux-gnu/libfftw3.so.3  \
	/usr/lib/x86_64-linux-gnu/libfontconfig.so.1  \
	/usr/lib/x86_64-linux-gnu/libfreetype.so.6  \
	/usr/lib/x86_64-linux-gnu/libgobject-2.0.so.0  \
	/usr/lib/x86_64-linux-gnu/libgomp.so.1  \
	/usr/lib/x86_64-linux-gnu/libgraphite2.so.3  \
	/usr/lib/x86_64-linux-gnu/libgthread-2.0.so.0  \
	/usr/lib/x86_64-linux-gnu/libHalf.so.12  \
	/usr/lib/x86_64-linux-gnu/libharfbuzz.so.0  \
	/usr/lib/x86_64-linux-gnu/libicudata.so.57  \
	/usr/lib/x86_64-linux-gnu/libicui18n.so.57  \
	/usr/lib/x86_64-linux-gnu/libicuuc.so.57  \
	/usr/lib/x86_64-linux-gnu/libIex-2_2.so.12  \
	/usr/lib/x86_64-linux-gnu/libIlmImf-2_2.so.22  \
	/usr/lib/x86_64-linux-gnu/libIlmThread-2_2.so.12  \
	/usr/lib/x86_64-linux-gnu/libImath-2_2.so.12  \
	/usr/lib/x86_64-linux-gnu/libjbig.so.0  \
	/usr/lib/x86_64-linux-gnu/libjpeg.so.62  \
	/usr/lib/x86_64-linux-gnu/liblcms2.so.2  \
	/usr/lib/x86_64-linux-gnu/liblqr-1.so.0  \
	/usr/lib/x86_64-linux-gnu/libltdl.so.7  \
	/usr/lib/x86_64-linux-gnu/libMagickCore-6.Q16.so.3  \
	/usr/lib/x86_64-linux-gnu/libMagickWand-6.Q16.so.3  \
	/usr/lib/x86_64-linux-gnu/libopenjp2.so.7  \
	/usr/lib/x86_64-linux-gnu/libpango-1.0.so.0  \
	/usr/lib/x86_64-linux-gnu/libpangocairo-1.0.so.0  \
	/usr/lib/x86_64-linux-gnu/libpangoft2-1.0.so.0  \
	/usr/lib/x86_64-linux-gnu/libpixman-1.so.0  \
	/usr/lib/x86_64-linux-gnu/libpng16.so.16  \
	/usr/lib/x86_64-linux-gnu/libstdc++.so.6  \
	/usr/lib/x86_64-linux-gnu/libthai.so.0  \
	/usr/lib/x86_64-linux-gnu/libtiff.so.5  \
	/usr/lib/x86_64-linux-gnu/libwmflite-0.2.so.7  \
	/usr/lib/x86_64-linux-gnu/libX11.so.6  \
	/usr/lib/x86_64-linux-gnu/libXau.so.6  \
	/usr/lib/x86_64-linux-gnu/libxcb-render.so.0  \
	/usr/lib/x86_64-linux-gnu/libxcb-shm.so.0  \
	/usr/lib/x86_64-linux-gnu/libxcb.so.1  \
	/usr/lib/x86_64-linux-gnu/libXdmcp.so.6  \
	/usr/lib/x86_64-linux-gnu/libXext.so.6  \
	/usr/lib/x86_64-linux-gnu/libxml2.so.2  \
	/usr/lib/x86_64-linux-gnu/libXrender.so.1  \
	/lib/

COPY --from=base /usr/lib/x86_64-linux-gnu/ImageMagick-6.9.7 /usr/lib/x86_64-linux-gnu/ImageMagick-6.9.7
COPY --from=base /etc/ImageMagick-6 /etc/ImageMagick-6
COPY --from=base /usr/share/ImageMagick-6 /usr/share/ImageMagick-6

CMD ["/usr/bin/identify"]
