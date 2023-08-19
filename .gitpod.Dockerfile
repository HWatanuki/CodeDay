FROM gitpod/workspace-full

RUN sudo apt-get -y update

# Install the latest hpccsystems clienttools and required ML bundles.
WORKDIR /tmp

RUN wget https://github.com/hpcc-systems/HPCC-Platform/releases/download/community_9.0.6-1/hpccsystems-platform-community_9.0.6-1focal_amd64_withsymbols.deb
RUN sudo apt-get install -y --fix-missing ./hpccsystems-platform-community_9.0.6-1focal_amd64_withsymbols.deb
RUN rm -f hpccsystems-platform-community_9.0.6-1focal_amd64_withsymbols.deb
COPY ./environment/environment.xml /etc/HPCCSystems

RUN /etc/init.d/hpcc-init start

COPY ./Datasets/musicmoz /var/lib/HPCCSystems/mydropzone/
COPY ./Datasets/musicmsd.csv /var/lib/HPCCSystems/mydropzone/
COPY ./Datasets/Spotify2000.csv /var/lib/HPCCSystems/mydropzone/

RUN dfuplus action=spray srcfile=/var/lib/HPCCSystems/mydropzone/musicmoz dstcluster=mythor dstname=MIL::IN::MozTracks server=http://localhost:8010 overwrite=1 format=csv


