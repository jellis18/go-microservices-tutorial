FROM golang:1.19-alpine as builder

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o mailApp ./cmd/api

FROM alpine:latest

RUN mkdir /app
COPY --from=builder /app/mailApp /app 
COPY --from=builder /app/templates templates

CMD ["/app/mailApp"]