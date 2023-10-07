create TABLE "entries" (
  "id" bigserial PRIMARY KEY NOT NULL,
  "account_id" bigint,
  "amount" bigint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

create TABLE "accounts" (
  "id" bigserial PRIMARY KEY NOT NULL,
  "owner" varchar NOT NULL,
  "balance" bigint NOT NULL,
  "currency" varchar NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

create TABLE "transfers" (
  "id" bigserial PRIMARY KEY NOT NULL,
  "from_account_id" bigint,
  "to_account_id" bigint,
  "amount" bigint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

create index on "entries" ("account_id");

create index on "accounts" ("owner");

create index on "transfers" ("from_account_id");

create index on "transfers" ("to_account_id");

create index on "transfers" ("from_account_id", "to_account_id");

comment on column "entries"."amount" is 'can be positive or negative';

comment on column "transfers"."amount" is 'must be positive';

alter table "entries" add FOREIGN KEY ("account_id") REFERENCES "accounts" ("id");

alter table "transfers" add FOREIGN KEY ("from_account_id") REFERENCES "accounts" ("id");

alter table "transfers" add FOREIGN KEY ("to_account_id") REFERENCES "accounts" ("id");
