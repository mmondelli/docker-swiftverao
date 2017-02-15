FROM ubuntu:14.04

MAINTAINER Maria Luiza Mondelli <malumondelli@gmail.com>
EXPOSE 3838

RUN apt-get update

RUN apt-get install -y \
	sqlite3 \
	git \
	openjdk-7-jre \
	openjdk-7-jdk \
	wget \
	mafft \
	raxml \
	software-properties-common \
	gdebi-core 

# ==============
# R PACKAGES ===
# ==============

RUN sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
RUN gpg -a --export E084DAB9 | sudo apt-key add -

RUN apt-get update

RUN apt-get install -y r-base

RUN R -e "install.packages(c('shiny', 'rmarkdown', 'ggplot2', 'sqldf', 'plyr', 'formattable', 'RColorBrewer', 'shinydashboard', 'DT', 'plyr', 'dplyr', 'reshape', 'lubridate', 'scales', 'anytime', 'shinyjs'), repos='https://cloud.r-project.org/')"


# ==============
# SHINY ========
# ==============

RUN wget -O shiny-server.deb http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.3.0.403-amd64.deb
RUN gdebi -n shiny-server.deb

# ==============
# SWIFT-PHYLO ==
# ==============

RUN cd /root; git clone https://github.com/mmondelli/swift-phylo.git
ADD swift-phylo/* /root/swift-phylo/ 
#RUN chmod 777 /root/swift-phylo/env_phylo

# ==============
# PAGERANK =====
# ==============

ADD pagerank/* /root/pagerank/
#RUN cd /home/pagerank; tar xvfz raw.en2.tar.gz raw.en2

# ==============
# SWIFT ========
# ==============

RUN wget http://swift-lang.org/packages/swift-0.96.2.tar.gz && \
    cd /usr/local; tar xvfz /swift-0.96.2.tar.gz; rm /swift-0.96.2.tar.gz; ln -s swift-0.96.2 swift
RUN echo "export PATH=/usr/local/swift/bin:$PATH" >> /etc/bashrc

# ==============
# HPSW-PROF ====
# ==============

RUN cd /srv/shiny-server; git clone https://github.com/mmondelli/swift-prof.git
RUN chmod 755 srv

# ==============
# ADDING FILES =
# ==============

ADD env_verao /root/
ADD uteis/swiftlog /usr/local/swift/bin/
ADD uteis/schema_sqlite.sql /usr/local/swift/etc/provenance/
ADD uteis/tutorial/ /root/tutorial/
ADD uteis/swift_provenance.db /root/

COPY shiny-server.sh /usr/bin/shiny-server.sh
RUN chmod 755 /usr/bin/shiny-server.sh

#USER root
#CMD /usr/bin/shiny-server.sh


 

