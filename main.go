package main

import (
	"database/sql"
	"github.com/dapetoo/simple-bank/api"
	db "github.com/dapetoo/simple-bank/db/sqlc"
	_ "github.com/lib/pq"
	"log"
)

const (
	dbDriver      = "postgres"
	dbSource      = "postgresql://peter:password@localhost:5432/simplebank?sslmode=disable"
	serverAddress = "0000000:8080"
)

func main() {
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}
	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(serverAddress)
	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}
