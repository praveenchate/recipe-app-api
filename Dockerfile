FROM python:3.9-alpine3.13
LABEL maintainer="xhate"

# Use key=value format for ENV
ENV PYTHONBUFFERED=1

# Copy requirements and application code
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app

# Set working directory
WORKDIR /app
EXPOSE 8000

ARG DEV=false

# Install dependencies and set up user
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    /py/bin/pip install flake8 && \
    rm -rf /tmp && \
    adduser --disabled-password --no-create-home django-user

# Update PATH for the virtual environment
ENV PATH="/py/bin:$PATH"

# Run as non-root user
USER django-user
