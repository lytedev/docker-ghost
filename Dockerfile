#
# Each instruction in this file generates a new layer that gets pushed to your local image cache
#

#
# Lines preceeded by # are regarded as comments and ignored
#

#
# The line below states we will base our new image on the Latest Official Ubuntu
FROM ubuntu:17.10

#
# Identify the maintainer of an image
MAINTAINER My Name "myname@somecompany.com"

#
# Update the image to the latest packages
RUN apt-get update
RUN apt-get install build-essential git libgeoip-dev libgmp-dev zlib1g-dev libbz2-dev libmysqlclient-dev libboost-all-dev -y
RUN cd ~ && git clone https://github.com/naanselmo/uc-ghost.git
RUN cd ~/uc-ghost/bncsutil/src/bncsutil && make && make install
RUN cd ~/uc-ghost/StormLib/stormlib/ && make && make install
RUN ln -s /usr/lib/x86_64-linux-gnu/libmysqlclient.so /usr/lib/x86_64-linux-gnu/libmysqlclient_r.so
RUN cd ~/uc-ghost/ghost/ && make
RUN cp ~/uc-ghost/*.cfg ~/uc-ghost/ghost/ && cp ~/uc-ghost/ghost/default.cfg ~/uc-ghost/ghost/ghost.cfg
RUN mkdir mapcfgs maps replays savegames
RUN touch gameloaded.txt gameover.txt phrases.txt motd.txt welcome.txt
CMD [ "/root/uc-ghost/ghost/ghost++"]
