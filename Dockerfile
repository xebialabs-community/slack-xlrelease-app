FROM python:3.7.2-alpine

ENV APP_ROOT=/opt/xebialabs
ENV APP_HOME=${APP_ROOT}/slack-xlrelease-app

# Copy bot resources
COPY bot/ ${APP_HOME}/bot/
COPY templates/ ${APP_HOME}/templates/

COPY app.py config.py Pipfile ${APP_HOME}/

WORKDIR ${APP_HOME}

RUN pip install pipenv && \
    pipenv install

EXPOSE 5000

ENV CLIENT_ID="" \
    CLIENT_SECRET="" \
    SIGNING_SECRET="" \
    VAULT_TOKEN="" \
    VAULT_URL=http://vault:8200 \
    REDIS_HOST=redis \
    REDIS_PORT=6379

CMD ["pipenv", "run", "gunicorn", "app:app", "-b", "0.0.0.0:5000"]