DB_NAME=simplebank

.PHONY: postgres createdb dropdb stop_postgres delete_postgres migrateup migratedown sqlc test server

postgres:
	@echo "Starting postgres..."
	@docker run --name=postgres -e POSTGRES_USER=peter -e POSTGRES_PASSWORD=password -p 5432:5432 -d postgres:15.3-alpine
	@echo "Postgres started."

stop_postgres:
	@echo "Stopping postgres..."
	@docker stop postgres
	@echo "Postgres stopped."

delete_postgres:
	@echo "Deleting postgres..."
	@docker rm -f postgres
	@echo "Postgres deleted."

createdb:
	@echo "Creating database..."
	@docker exec -it postgres createdb -U peter -h localhost -p 5432 -e $(DB_NAME)
	@echo "Database created."

dropdb:
	@echo "Dropping database..."
	@docker exec -it postgres dropdb -U peter -h localhost -p 5432 -e $(DB_NAME)
	@echo "Database dropped."

migrateup:
	@migrate -path db/migration -database "postgresql://peter:password@localhost:5432/$(DB_NAME)?sslmode=disable" -verbose up

migratedown:
	@migrate -path db/migration -database "postgresql://peter:password@localhost:5432/$(DB_NAME)?sslmode=disable" -verbose down

sqlc:
	@sqlc generate

test:
	@go test -v -cover ./...

server:
	@go run main.go