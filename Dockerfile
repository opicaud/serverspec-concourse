FROM uzyexe/serverspec

COPY assets/ /opt/resource
RUN chmod +x -R /opt/resource

WORKDIR /opt/resource
