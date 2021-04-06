
FROM opensuse/leap

LABEL author="Compuware - A BMC Company"
USER root

RUN zypper up -y &&\
	zypper -q --non-interactive install \
	unzip \
	sudo \
	java-11-openjdk \
	git-core \
	wget

ENV JAVA_HOME "/usr/lib64/jvm/java-11-openjdk-11"

#Install Topaz CLI
RUN mkdir /TopazCliInstall
COPY SyncToIspw.sh /TopazCliInstall/SyncToIspw.sh	
RUN wget http://dtw-svngateway.prodti.compuware.com/CommonBundleDepot/products/Enterprise/TopazCLI/207-ci-repo/TopazCLI-linux.gtk.x86_64.zip
RUN mv TopazCLI-linux.gtk.x86_64.zip /TopazCliInstall/TopazCLI-linux.gtk.x86_64.zip
WORKDIR "/TopazCliInstall"
RUN unzip TopazCLI-linux.gtk.x86_64.zip
RUN chmod 777 IspwCLI.sh SyncToIspw.sh

ENTRYPOINT ["/TopazCliInstall/SyncToIspw.sh"]
CMD ["SyncToIspw"]
