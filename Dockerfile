FROM python:3.10.8-alpine@sha256:1497782ebc0e9a050550cccfcdeb89fc4f7c2385d71c62ed33f558741de7c818

ARG PIP_VERSION
ARG SELENIUM_VERSION
ARG GOOGLETRANS_VERSION
ARG REQUESTS_VERSION

RUN apk add --no-cache gcc libc-dev libffi-dev && \
    pip install --no-cache-dir pip=="$PIP_VERSION" && \
    pip install --no-cache-dir --user selenium=="$SELENIUM_VERSION" googletrans=="$GOOGLETRANS_VERSION" requests=="$REQUESTS_VERSION"



FROM python:3.10.8-alpine@sha256:1497782ebc0e9a050550cccfcdeb89fc4f7c2385d71c62ed33f558741de7c818

RUN apk add --no-cache chromium chromium-chromedriver && \
    rm -rf /var/cache/apk/* /tmp/* /usr/share/doc

COPY --from=0 /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH

ADD renew.py .

ENTRYPOINT ["python3", "renew.py"]
