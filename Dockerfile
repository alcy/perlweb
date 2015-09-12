FROM centos:centos6.6
ADD mariadb.repo /etc/yum.repos.d/
RUN yum -y install epel-release; yum -y update; yum clean all
RUN yum -y install perl cronolog which git tar bzip2 gcc \
   expat-devel zlib zlib-devel MariaDB-devel openssl-devel; yum clean all
ENV PERLBREW_ROOT=/perl5
RUN curl -L http://install.perlbrew.pl | bash
RUN /perl5/bin/perlbrew init
RUN /perl5/bin/perlbrew install -j 4 perl-5.22.0; perlbrew clean; rm -fr /perl5/perls/perl-*/man
RUN /perl5/bin/perlbrew install-cpanm
RUN /perl5/bin/perlbrew switch perl-5.22.0

ENV PATH=/perl5/bin:/perl5/perls/perl-5.22.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PERLBREW_PERL=perl-5.22.0
ENV PERLBREW_MANPATH=/perl5/perls/perl-5.22.0/man
ENV PERLBREW_PATH=/perl5/bin:/perl5/perls/perl-5.22.0/bin
ENV PERLBREW_SKIP_INIT=1
ADD modules /tmp/.modules
RUN cpanm -n < /tmp/.modules
RUN rpm -e gcc cpp ppl cloog-ppl
RUN rpm -qa --queryformat '%{NAME}\n' | grep -- '-devel$' | xargs rpm -e  
ENV CBROOTLOCAL=/perlweb/
ENV CBROOT=/perlweb/combust
ENV CBCONFIG=/perlweb/combust.docker.conf

VOLUME /perlweb
WORKDIR /perlweb

EXPOSE 8230
ENTRYPOINT ["combust/bin/httpd"]
