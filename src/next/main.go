package main

import (
	"net/http"
)

func main() {
	mux := http.NewServeMux()

	mux.HandleFunc("/", index)

	server := &http.Server{
		Addr:    "127.0.0.1:5555",
		Handler: mux,
	}

	server.ListenAndServe()
}
