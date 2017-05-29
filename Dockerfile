
FROM gentoo/stage3-amd64-hardened

RUN emerge-webrsync 

RUN eselect profile set hardened/linux/amd64

RUN emerge --update --deep --newuse @world

RUN sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen

RUN locale-gen

RUN eselect locale set en_US.utf8

RUN . /etc/profile

RUN echo "sys-kernel/hardened-sources symlink" >> /etc/portage/package.use/hardened-sources

RUN emerge sys-kernel/hardened-sources

COPY kernel-configurations/.config.defconfig.netcard.fs /usr/src/linux/.config

RUN cd /usr/src/linux

RUN make && make modules_install
