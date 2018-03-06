package main

import (
	"encoding/json"
	"io"
	"log"
	"net/http"
)

type BiItem struct {
	Symbol             string `json:"symbol"`
	LastPrice          string `json:"lastPrice"`
	PriceChangePercent string `json:"priceChangePercent"`
}

func index(w http.ResponseWriter, r *http.Request) {
	url := "https://api.binance.com/api/v1/ticker/24hr"
	resp, err := http.Get(url)

	if err != nil {
		log.Fatalln(err.Error())
	}

	var bir []BiItem
	toJson(resp.Body, &bir)

	generateHTML(w, bir, "layout", "res")
}

func toJson(body io.Reader, v interface{}) {
	decoder := json.NewDecoder(body)
	if err := decoder.Decode(v); err != nil {
		log.Fatalln(err.Error())
	}
}
