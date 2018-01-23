FROM python:2-alpine

RUN pip install toml

ENV DOCKER_ENTRYPOINT /usr/bin/graphite-clickhouse

ADD graphite-clickhouse /usr/bin/graphite-clickhouse
ADD entrypoint.py /usr/bin/entrypoint
ADD config.base.toml /etc/config.base.toml
ADD rollup.xml /etc/graphite-clickhouse/rollup.xml

RUN chmod a+x /usr/bin/graphite-clickhouse /usr/bin/entrypoint

ENTRYPOINT ["/usr/bin/entrypoint"]
