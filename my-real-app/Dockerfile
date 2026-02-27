FROM node:20-alpine
# Set environment to production
ENV NODE_ENV=production

# Install native dependencies for Strapi/Postgres
RUN apk add --no-cache build-base gcc autoconf automake libtool zlib-dev libpng-dev vips-dev

WORKDIR /opt/
# Only copy the essential package files
COPY package.json ./

# Install dependencies - adding --ignore-engines to bypass strict version checks
RUN yarn install --ignore-engines

ENV PATH="/opt/node_modules/.bin:$PATH"

WORKDIR /opt/app
COPY . .
RUN yarn build
EXPOSE 1337
CMD ["yarn", "start"]