FROM uzyexe/serverspec

COPY out.rb /opt/resource/out
COPY check.rb /opt/resource/check
COPY in.rb /opt/resource/in

RUN chmod +x /opt/resource/check
RUN chmod +x /opt/resource/out
RUN chmod +x /opt/resource/in

WORKDIR /opt/resource
