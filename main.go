package main

import (
	"encoding/json"
	"github.com/gorilla/mux"
	"net/http"
	"os"
)

var Commit, Branch, State, TimeStamp string

type Hello struct {
	Commit       string `json:"commit"`
	Branch       string `json:"branch"`
	State        string `json:"state"`
	TimeStamp    string `json:"time"`
	PodName      string `json:"pod_name"`
	PodNameSpace string `json:"pod_name_space"`
}

func SayHello(rw http.ResponseWriter, req *http.Request) {
	podName := os.Getenv("POD_NAME")
	podNS := os.Getenv("POD_NAMESPACE")
	encoder := json.NewEncoder(rw)
	req.Header.Add("Content-Type", "application/json")
	_ = encoder.Encode(Hello{
		Commit:       Commit,
		Branch:       Branch,
		State:        State,
		TimeStamp:    TimeStamp,
		PodName:      podName,
		PodNameSpace: podNS,
	})
}

func main() {
	router := mux.NewRouter()
	router.HandleFunc("/", SayHello)
	_ = http.ListenAndServe(":4343", router)
}
