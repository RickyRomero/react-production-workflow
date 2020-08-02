### BUILD PHASE ###
# 'AS' lets us call this out as a separate step
# Normally you might use FROM node:alpine AS builder, but this is
# currently broken in AWS, so we use an anonymous builder instead

FROM node:alpine
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

# "0" is the node:alpine image we built earlier
COPY --from=0 '/usr/app/build/' './'

# Normally this doesn't do anything. This is a custom instruction for EBS
EXPOSE 80
