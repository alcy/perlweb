FROM centos:centos6.6

# Install prequisite packages
ADD mariadb.repo /etc/yum.repos.d/
RUN yum -y install epel-release; yum -y update; yum clean all
RUN yum -y install perl cronolog which git tar bzip2 gcc \
   expat-devel zlib zlib-devel MariaDB-devel openssl-devel; yum clean all

# Install perl -5.22.0
ENV PERLBREW_ROOT /perl5
RUN curl -L http://install.perlbrew.pl | bash
ENV PERLBREW_PERL perl-5.22.0
ENV PATH /perl5/bin:/perl5/perls/${PERLBREW_PERL}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PERLBREW_MANPATH /perl5/perls/${PERLBREW_PERL}/man
ENV PERLBREW_PATH /perl5/bin:/perl5/perls/${PERLBREW_PERL}/bin
RUN /perl5/bin/perlbrew init
RUN /perl5/bin/perlbrew install -j 4 ${PERLBREW_PERL}; perlbrew clean; rm -fr /perl5/perls/perl-*/man
RUN /perl5/bin/perlbrew install-cpanm
RUN /perl5/bin/perlbrew switch ${PERLBREW_PERL}
ENV PERLBREW_SKIP_INIT 1

# Install required CPAN modules
ADD modules /tmp/.modules
RUN cpanm -n < /tmp/.modules

# Remove dev packages
RUN rpm -e gcc cpp ppl cloog-ppl
RUN rpm -qa --queryformat '%{NAME}\n' | grep -- '-devel$' | xargs rpm -e

# Add the perlweb user
RUN groupadd pw && useradd -g pw pw
USER pw
