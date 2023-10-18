FROM nimlang/nim:2.0.0

ENV PORT=3000

WORKDIR \anitrivia

COPY . .

RUN apt install -y liblmdb-dev liblmdb0
RUN nimble build -y -d:ssl

EXPOSE $PORT

CMD ["./bin/anitrivia"]
