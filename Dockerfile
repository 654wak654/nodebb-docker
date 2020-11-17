FROM node:14-alpine AS build

RUN apk add --no-cache git \
    && cd /opt \
    && git clone -b v1.15.x https://github.com/NodeBB/NodeBB.git nodebb \
    && cd nodebb \
    && cp install/package.json package.json \
    && ./nodebb setup


FROM node:14-alpine

ADD ./supervisor.sh /
RUN chmod +x /supervisor.sh \
    && mkdir -p /etc/nodebb

COPY --from=build /opt/nodebb /opt/nodebb

ENV NODE_ENV=production \
    daemon=false \
    silent=false

WORKDIR /opt/nodebb

EXPOSE 4567

VOLUME ['/etc/nodebb', '/opt/nodebb/public/uploads']

ENTRYPOINT ['ash']
CMD ['/supervisor.sh']
