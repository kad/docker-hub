ARG swupd_args

FROM clearlinux:latest as packager

RUN swupd update --no-boot-update $swupd_args \
    && swupd bundle-add wget unzip lftp package-utils \
    && rm -rf /var/lib/swupd

WORKDIR /work

RUN mkdir -p rpms/{dev,runtime} && pwd && source /etc/os-release \
    && cd rpms/dev \
    && lftp -c "o https://download.clearlinux.org/releases/$VERSION_ID/clear/x86_64/os/Packages/; mget opencl-headers-dev*.rpm ocl-icd-dev*.rpm ocl-icd-lib*.rpm" \
    && cd ../runtime \
    && lftp -c "o https://download.clearlinux.org/releases/$VERSION_ID/clear/x86_64/os/Packages/; mget clinfo-bin*.rpm intel-compute-runtime-data*.rpm intel-compute-runtime-lib*.rpm intel-gmmlib-lib*.rpm intel-graphics-compiler-lib*.rpm libva-lib*.rpm ocl-icd-lib*.rpm opencl-clang-lib*.rpm" \
    && cd ../.. && du -shc .

RUN mkdir -p out/{dev,runtime} \
    && for p in `ls rpms/dev/*.rpm`; do rpm2cpio $p | (cd out/dev/; cpio -i -d -u --quiet); done \
    && (cd out/dev ; echo "Development files:"; find . -type f -or -type l) \
    && for p in `ls rpms/runtime/*.rpm`; do rpm2cpio $p | (cd out/runtime/; cpio -i -d -u --quiet); done \
    && (cd out/runtime ; echo "Runtime files:" ; find . -type f -or -type l) \
    && du -shc out/*

RUN wget -q https://us.fixstars.com/dl/opencl/samples.zip \
    && unzip -q samples.zip -d samples/ \
    && mkdir opencl-example \
    && cp samples/6-1/fft/{fft.cl,fft.cpp,pgm.h,lena.pgm} opencl-example/ \
    && du -shc opencl-example/*

CMD 'bash'
