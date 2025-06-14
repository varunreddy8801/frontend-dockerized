# Fetching the latest node image on alpine linux
FROM node:lts-alpine AS development

# Declaring env
ARG PROJECT_NAME
ARG NODE_ENV
ARG PORT_HOST
RUN test -n "${PROJECT_NAME}}" || (echo "Build argument PROJECT_NAME needs to be set and non-empty." && false)
RUN test -n "${PORT_HOST}}" || (echo "Build argument PORT_HOST needs to be set and non-empty." && false)
RUN test -n "${NODE_ENV}" || (echo "Build argument NODE_ENV needs to be set and non-empty." && false)
ENV PROJECT_NAME=${PROJECT_NAME}
ENV NODE_ENV=${NODE_ENV}
ENV PORT_HOST=${PORT_HOST}

# Create a user with uid 1000 and gid 1000
RUN deluser --remove-home node || true && \
    addgroup -g 1000 appgroup && \
    adduser -u 1000 -G appgroup -s /bin/sh -D appuser

# Setting up the work directory
WORKDIR /app

# Change ownership of the app directory to the appuser
RUN chown -R appuser:appgroup /app

# Copy the entrypoint script first and make it executable
COPY --chown=appuser:appgroup docker/entrypoint.sh /entrypoint.sh
COPY --chown=appuser:appgroup docker/port-config.sh /port-config.sh
RUN chmod +x /entrypoint.sh /port-config.sh

# Switch to the non-root user
USER appuser

# Copy the rest of your application files
COPY --chown=appuser:appgroup ./${PROJECT_NAME}* .

# Expose the port your app runs on
EXPOSE ${PORT_HOST}

# Docker entrypoint and command
ENTRYPOINT [ "/entrypoint.sh" ]
