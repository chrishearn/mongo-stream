FROM node:10.16-slim
LABEL maintainer="chris.hearn@omono.co"

RUN useradd --create-home --shell /bin/bash --uid 2000 --user-group app \
    && apt-get update \
    && apt-get install -y \
    python \
    python-pip \
    && pip install awscli \
    && apt-get clean \
    && mkdir /app \
    && chown -R app:app /home/app \
    && chown -R app:app /app \
    && wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 \
    && chmod +x /usr/local/bin/dumb-init

COPY --chown=app:app ./bundle ./run.sh /app/
RUN chmod +x /app/run.sh

USER app
WORKDIR /app
RUN cd /app/ && npm install --only=production

# dumb-init is used to ensure signal events (SIGTERM etc) reach the node process
ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["/app/run.sh"]
