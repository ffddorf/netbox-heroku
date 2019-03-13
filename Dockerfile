ARG VERSION=v2.5.8
FROM netboxcommunity/netbox:$VERSION

RUN pip install dj_database_url whitenoise

COPY patch/settings_append.py patch/patch.py /tmp/
RUN cat /tmp/settings_append.py >> /opt/netbox/netbox/netbox/settings.py && \
    rm /tmp/settings_append.py && \
    mkdir /opt/netbox/netbox/static && \
    /tmp/patch.py

COPY patch/docker-entrypoint.sh /opt/netbox/docker-entrypoint.sh
COPY patch/config.py /etc/netbox/config/configuration.py

# copy static files
RUN SECRET_KEY=123456 ./manage.py collectstatic --no-input
