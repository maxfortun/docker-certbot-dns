FROM certbot/certbot

COPY entrypoint.sh /opt/certbot/
COPY getDomains.sh /opt/certbot/
COPY certbot.sh /opt/certbot/
COPY certbot-auth.sh /opt/certbot/
COPY certbot-cleanup.sh /opt/certbot/
COPY certbot-renew.sh /etc/periodic/daily/

ENTRYPOINT []
CMD [ "/opt/certbot/entrypoint.sh" ]


