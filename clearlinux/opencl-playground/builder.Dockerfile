FROM clearlinux:latest as builder

WORKDIR /work

RUN swupd update --no-boot-update $swupd_args \
    && swupd bundle-add c-basic \
    && rm -rf /var/lib/swupd

COPY --from=opencl:packager /work/out/dev/ /
COPY --from=opencl:packager /work/opencl-example/* /work/

RUN gcc -g fft.cpp -o fft -lOpenCL -lm

CMD 'bash'