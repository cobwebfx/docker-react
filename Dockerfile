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
# Get from builder phase: the /app/build directory, because that contains everything we need to run the app
COPY --from=builder /app/build /usr/share/nginx/html