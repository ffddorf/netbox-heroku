ARG VERSION=latest
FROM netboxcommunity/netbox:$VERSION

RUN apk add --no-cache curl
RUN pip install dj_database_url whitenoise

COPY patch/patch.py /tmp/
RUN /tmp/patch.py

COPY patch/configuration.py /etc/netbox/config/
COPY patch/settings_heroku.py /opt/netbox/netbox/netbox/
ENV DJANGO_SETTINGS_MODULE "netbox.settings_heroku"

# copy static files
RUN mkdir /opt/netbox/netbox/static && \
    SECRET_KEY=123456 WEBHOOKS_ENABLED=NO ./manage.py collectstatic --no-input

ENTRYPOINT [ "/bin/sh", "-c" ]
CMD ["gunicorn", "-c /etc/netbox/config/gunicorn_config.py", "netbox.wsgi"]
