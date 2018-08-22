FROM sdal/rcran-c7sd_auth
MAINTAINER "Daniel Chen" <chend@vt.edu>

## Add RStudio binaries to PATH
ENV PATH /usr/lib/rstudio-server/bin/:$PATH

## Install Download Prerequisites
RUN yum install -y initscripts && \
    cp /etc/pam.d/login /etc/pam.d/rstudio

## Download and Install Rstudio-server
RUN curl -O https://s3.amazonaws.com/rstudio-dailybuilds/rstudio-server-rhel-1.1.444-x86_64.rpm && \
    yum install -y --nogpgcheck rstudio-server-rhel-*.rpm

RUN systemctl enable rstudio-server

# Add default rstudio user with pass rstudio
RUN useradd -m -d /home/rstudio rstudio && echo rstudio:rstudio | chpasswd

# Get the Rprofile.site file
# RUN wget -O /usr/lib64/R/etc/Rprofile.site https://raw.githubusercontent.com/bi-sdal/mro-ldap-ssh-c7/master/Rprofile.site

RUN yum install -y htop

EXPOSE 8787

CMD ["/lib/systemd/systemd"]
#CMD ["/usr/sbin/init"]
