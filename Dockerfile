# Multistep build process

# Step 1
FROM node:16-alpine as builder

WORKDIR /app

COPY ./package.json ./
RUN npm install

COPY ./ ./

RUN npm run build

# Step 2
FROM nginx
EXPOSE 80
COPY --from=builder ./app/build ./usr/share/nginx/html

# --from=builder -----> this means copy from builder phase

# ./usr/share/nginx/html ----> This location is the location where we need to store the static contents to serve by the nginx server ----> Taken from g=nginx official image
