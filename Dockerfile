ARG VERSION=latest
FROM netboxcommunity/netbox:$VERSION

RUN apk add --no-cache curl
RUN pip install dj_database_url whitenoise

COPY patch/settings_append.py patch/patch.py /tmp/
RUN cat /tmp/settings_append.py >> /opt/netbox/netbox/netbox/settings.py && \
    rm /tmp/settings_append.py && \
    mkdir /opt/netbox/netbox/static && \
    /tmp/patch.py

COPY patch/config.py /etc/netbox/config/configuration.py

# copy static files
RUN SECRET_KEY=123456 ./manage.py collectstatic --no-input

ENTRYPOINT [ "/bin/sh", "-c" ]
CMD ["gunicorn", "-c /etc/netbox/config/gunicorn_config.py", "netbox.wsgi"]
