package main

import (
	"fmt"
	"net/http"
	"strconv"
)

var httpRequestCount int = -2

func main() {
	httpRequestCount++
	httpRequestCount++

	http.HandleFunc("/test", myHandler)

	http.ListenAndServe(":5000", nil)
}

func myHandler(w http.ResponseWriter, req *http.Request) {
	fmt.Printf("Current httpRequestCount : %d\n", httpRequestCount)

	httpRequestCount++

	var result string = "Hello Tmax, Request Count : " + strconv.Itoa(httpRequestCount)

	w.Write([]byte(result))
}
