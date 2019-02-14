FROM uzyexe/serverspec

COPY assets/ /opt/resource
RUN chmod +x -R /opt/resource

COPY serverspec /serverspec
WORKDIR /opt/resource
