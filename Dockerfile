FROM golang:1.9.2 as builder
WORKDIR /go/src/github.com/tarkalabs/hellokube
RUN go get -u github.com/golang/dep/cmd/dep
COPY . .
RUN dep ensure
RUN make linux

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
EXPOSE 4343
COPY --from=builder /go/src/github.com/tarkalabs/hellokube/hellokube .
CMD ["./hellokube"]
