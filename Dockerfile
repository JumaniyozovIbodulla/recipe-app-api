FROM python:3.10-alpine3.13
LABEL maintainer="kun.uz"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp.requirements.txt
COPY ./requirements.dev.txt /tmp.requirements.dev.txt
COPY ./app /app
COPY requirements.txt /tmp/
COPY requirements.dev.txt /tmp/


WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r /tmp/requirements.txt && \
    if [ "$DEV" = "true" ];\
        then /venv/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser --disabled-password --no-create-home django-user


ENV PATH="/venv/bin:$PATH"

# # USER django-user

# # Use a base image that includes Python
# FROM python:3.10

# # Set a working directory
# WORKDIR /app

# # Install any necessary system packages and dependencies here

# # Create the virtual environment and install packages
# # Create the virtual environment and install packages
# RUN python3 -m venv /venv && \
#     /venv/bin/pip install --upgrade pip && \
#     /venv/bin/pip install -r /tmp/requirements.txt && \
#     rm -rf /tmp


# # Your additional Dockerfile configuration

# # Copy your application files into the container
# COPY requirements.txt /tmp/
# COPY . /app

# # Specify the command to run when the container starts
# CMD ["/venv/bin/python", "your_script.py"]
