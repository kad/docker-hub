FROM clearlinux:latest as final
WORKDIR /work

RUN swupd update --no-boot-update $swupd_args \
    && swupd bundle-add llvm \
    && rm -rf /var/lib/swupd

COPY --from=opencl:packager /work/out/runtime/ /
COPY --from=opencl:builder /work/fft.cl /work/fft.cl
COPY --from=opencl:builder /work/fft /work/fft
COPY --from=opencl:builder /work/*.pgm /work/

CMD 'bash'
