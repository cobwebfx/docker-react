# The first phase is named "builder"
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN yarn install
COPY ./ ./
# Creates build /app/build
RUN yarn build

# Second phase
FROM nginx
# Running EXPOSE on a laptop will have no effect. ElasticBeanstalk knows it is the port number it needs to map for
# incoming traffic
EXPOSE 80
# Get from builder phase: the /app/build directory, because that contains everything we need to run the app
COPY --from=builder /app/build /usr/share/nginx/html