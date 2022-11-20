FROM rust:latest as back_build

# create a new empty project
RUN USER=root cargo new --bin back
WORKDIR /back

# copy files
COPY ./back/Cargo.lock ./Cargo.lock
COPY ./back/Cargo.toml ./Cargo.toml

# this build step caches dependencies
RUN cargo build --release
RUN rm src/*.rs

# copy source tree
COPY ./back/src ./src
COPY ./back/images ./images

# build for release
RUN rm ./target/release/deps/back*
RUN cargo build --release

FROM node:latest as front_build
WORKDIR /front

RUN npm install -g elm tailwindcss parcel
COPY ./front/elm.json .
COPY ./front/index.js .
COPY ./front/index.html .
COPY ./front/tailwind.config.js .
COPY ./front/tailwind_input.css .
COPY ./front/src ./src
RUN npx tailwindcss -i ./tailwind_input.css -o ./tailwind_watcher.css

RUN parcel build index.html

# final
FROM debian:buster-slim

# copy the build artifact from the build stage
COPY --from=back_build /back/target/release/back ./back/run
COPY --from=back_build /back/images ./back/images
COPY --from=front_build /front/dist ./front/dist

# set the startup command to run
CMD ["./back/run"]

EXPOSE 7878
