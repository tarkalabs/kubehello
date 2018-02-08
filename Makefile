VERSION_PACKAGE=main
COMMIT=`git rev-parse --short -q HEAD`
BRANCH=`git symbolic-ref -q --short HEAD`
STATE=`if [ -n "$(git status --porcelain)" ]; then echo 'dirty'; else echo 'clean'; fi`
TIMESTAMP=`date -u +'%Y-%m-%dT%H:%M:%SZ'`

LDFLAGS=-ldflags "-X ${VERSION_PACKAGE}.Commit=${COMMIT} \
                  -X ${VERSION_PACKAGE}.Branch=${BRANCH} \
                  -X ${VERSION_PACKAGE}.State=${STATE} \
                  -X ${VERSION_PACKAGE}.TimeStamp=${TIMESTAMP}"
linux:
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hellokube ${LDFLAGS} .
mac:
	CGO_ENABLED=0 GOOS=darwin go build -a -installsuffix cgo -o hellokube ${LDFLAGS} .
