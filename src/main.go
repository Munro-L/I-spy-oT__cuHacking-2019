package main

// [START import]
import (
        "fmt"
        "log"
        "net/http"
        "os"
        "encoding/json"
        "github.com/gorilla/mux"
)

// [END import]
// [START main_func]

type storedData struct {
        temp int `json:"temp,omitempty"`
        timeStamp string `json:"timeStamp,omitempty"`
}

var logData []storedData

func GetAllData(w http.ResponseWriter, r *http.Request) {
    json.NewEncoder(w).Encode(logData)
}

func GetSingleData(w http.ResponseWriter, r *http.Request) {
    json.NewEncoder(w).Encode(logData[len(logData)-1])
}

func LogTemp(w http.ResponseWriter, r *http.Request) {

    var data storedData
    _ = json.NewDecoder(r.Body).Decode(&data)
    logData = append(logData, data)

    json.NewEncoder(w).Encode(logData)
}

func main() {

    // [START setting_port]
    port := os.Getenv("PORT")
    router := mux.NewRouter()
    router.HandleFunc("/log", LogTemp).Methods("POST").Schemes("http")
    router.HandleFunc("/getAll", GetAllData).Methods("GET").Schemes("http")
    router.HandleFunc("/getOne", GetSingleData).Methods("GET").Schemes("http")
    router.HandleFunc("/", indexHandler)

        if port == "" {
                port = "8080"
                log.Printf("Defaulting to port %s", port)
        }

        log.Printf("Listening on port %s", port)
        log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), router))
        // [END setting_port]
}

// [END main_func]

// [START indexHandler]


// indexHandler responds to requests with our greeting.
func indexHandler(w http.ResponseWriter, r *http.Request) {

    if r.URL.Path != "/" {
                http.NotFound(w, r)
                return
        }
    json.NewEncoder(w).Encode(logData)
}
