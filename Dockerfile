ARG NODEJS_VERSION="12"

## buildstep base image
FROM balenalib/fincm3-node:${NODEJS_VERSION}-build AS buildstep

WORKDIR /usr/src/app
COPY ./package.json package.json
RUN JOBS=MAX npm install --unsafe-perm --production && npm cache clean --force

## target base image
FROM balenalib/fincm3-node:${NODEJS_VERSION}-run

WORKDIR /usr/src/app
# gather compiled node modules from buildstep
COPY --from=buildstep /usr/src/app/node_modules node_modules

# install required packages
RUN install_packages \
    ftdi-eeprom \
    ethtool

# Move app to filesystem
COPY ./src ./

# Start app
CMD ["bash", "/usr/src/app/start.sh"]