package main

import (
	"fmt"
	"log"
	"net/http"
	"to-do-list/pkg/routes"

	_ "github.com/lib/pq"

	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
)

func main() {
	r := mux.NewRouter()

	routes.RegisterTaskRoutes(r)
	routes.RegisterUserRoutes(r)

	// Handle static files
	fs := http.FileServer(http.Dir("static"))
	http.Handle("/static/", http.StripPrefix("/static/", fs))

	// Handle API routes
	http.Handle("/", r)

	a := handlers.CORS(
		handlers.AllowedOrigins([]string{"http://example.com", "https://example.com", "*"}),
		handlers.AllowedMethods([]string{"GET", "POST", "PUT", "DELETE", "OPTIONS"}),
		handlers.AllowedHeaders([]string{"X-Requested-With", "Content-Type", "Authorization"}),
		handlers.ExposedHeaders([]string{"Content-Length"}),
		handlers.AllowCredentials(),
		handlers.MaxAge(3600),
	)(r)

	// Start the server
	ip := "10.10.63.120"
	port := "8065"
	addr := ip + ":" + port
	fmt.Printf("Server is listening on %s...\n", addr)
	log.Fatal(http.ListenAndServe(addr, a))

}
