### BUILD PHASE ###
# 'AS' lets us call this out as a separate step

FROM node:alpine AS builder
WORKDIR '/usr/app'

# Install dependencies first (to leverage caching)
COPY './frontend/package.json' './'
COPY './frontend/yarn.lock' './'
RUN yarn

# Copy and build source code
COPY './frontend/' './'
RUN yarn build



### PRODUCTION PHASE ###
# Build the production server with nginx
# Copy the built results from the previous phase

FROM nginx:alpine
WORKDIR '/usr/share/nginx/html'

COPY --from=builder '/usr/app/build/' './'
