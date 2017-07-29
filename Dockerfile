FROM centos:6
LABEL inamuu <hoge@gmail.com>

RUN yum -y install \
    vim \
    perl-CPAN \
    gcc \
    ;\
     yum clean all

RUN yes '' | cpan -fi Net::DNS::RR Net::DNS::ZoneFile NetAddr::IP Net::DNS Net::IP Digest::HMAC Digest::SHA1 Digest::MD5 MIME::Base64 Digest::HMAC_SHA1 FindBin MIME::Base64 Getopt::Long File::Temp File::Basename Fcntl IO::Handle Data::GUID

RUN mkdir -p /root/bin/

COPY ./files/ /root/bin/

WORKDIR /root/bin/
RUN curl -OL http://awsmedia.s3.amazonaws.com/catalog/attachments/bindtoroute53.pl \
    && chmod u+x bindtoroute53.pl \
    ;\
    curl -OL http://awsmedia.s3.amazonaws.com/catalog/attachments/dnscurl.pl \
    && chmod u+x dnscurl.pl

CMD ["/sbin/init"]
