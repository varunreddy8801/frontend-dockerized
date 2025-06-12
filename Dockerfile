# Fetching the latest node image on alpine linux
FROM node:alpine AS development

# Declaring env
ARG REACT_PROJECT_NAME
ARG NODE_ENV
RUN test -n "${REACT_PROJECT_NAME}}" || (echo "Build argument REACT_PROJECT_NAME needs to be set and non-empty." && false)
RUN test -n "${NODE_ENV}" || (echo "Build argument NODE_ENV needs to be set and non-empty." && false)
ENV REACT_PROJECT_NAME=${REACT_PROJECT_NAME}
ENV NODE_ENV=${NODE_ENV}

# Create a user with uid 1000 and gid 1000
RUN deluser --remove-home node || true && \
    addgroup -g 1000 appgroup && \
    adduser -u 1000 -G appgroup -s /bin/sh -D appuser

# Setting up the work directory
WORKDIR /app

# Change ownership of the app directory to the appuser
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Copy the rest of your application files
COPY --chown=appuser:appgroup ./${REACT_PROJECT_NAME}* .

# Expose the port your app runs on
EXPOSE 3000

# Default command
CMD ["npm", "run", "dev"]
