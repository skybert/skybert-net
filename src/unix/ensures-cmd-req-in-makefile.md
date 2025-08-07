title: Ensure required cmd in Makefile targets
date: 2025-08-07
category: unix
tags: unix, makefile, make, coding

To conditionally install the [swag]() command required for my
`openapi-generate` target, I find this approach to be both easy and
portable. It works well because `swag` is a Go binary, so I have a way
to install it regardless of the user's platform, using `go install`:

```bash
GOPATH ?= $(HOME)/go/bin
SWAG = $(GOPATH)/swag
openapi-generate:
	test -x $(SWAG) || go install github.com/swaggo/swag/cmd/swag
	$(SWAG) init
	$(SWAG) fmt
```

It's important to note, the variables must be set _outside_ the
target, `openapi-generate`.
