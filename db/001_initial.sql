CREATE EXTENSION IF NOT EXISTS postgis;
CREATE TABLE "acknowledgements" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"alert_key" text NOT NULL,
"date" text NOT NULL
);
CREATE TABLE "audit" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"action" text NOT NULL,
"entity" text NOT NULL,
"date" text NOT NULL,
"request_key" text NOT NULL
);
CREATE TABLE "employees" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"name" text NOT NULL,
"role" text NOT NULL,
"hourly_cents" bigint NOT NULL
);
CREATE TABLE "equipment" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"name" text NOT NULL,
"kind" text NOT NULL,
"hours" bigint NOT NULL,
"service_due" text NOT NULL,
"status" text NOT NULL
);
CREATE TABLE "expenses" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"field_id" text,
"category" text NOT NULL,
"description" text NOT NULL,
"amount_cents" bigint NOT NULL,
"date" text NOT NULL,
"reference" text NOT NULL,
CONSTRAINT "expense_positive" CHECK("expenses"."amount_cents">=0)
);
CREATE TABLE "farms" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"name" text NOT NULL,
"region" text NOT NULL
);
CREATE TABLE "fields" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"farm_id" text NOT NULL,
"name" text NOT NULL,
"area" double precision NOT NULL,
"crop" text NOT NULL,
"variety" text NOT NULL,
"planted" text NOT NULL,
"harvest_date" text NOT NULL,
"target_kg" bigint NOT NULL,
"budget_cents" bigint NOT NULL,
"moisture" bigint NOT NULL,
"soil" text NOT NULL,
"polygon" text NOT NULL,
CONSTRAINT "field_positive_area" CHECK("fields"."area">0)
);
CREATE TABLE "harvests" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"field_id" text NOT NULL,
"batch" text NOT NULL,
"quantity_milli" bigint NOT NULL,
"grade" text NOT NULL,
"storage" text NOT NULL,
"date" text NOT NULL,
"request_key" text NOT NULL,
CONSTRAINT "harvest_positive" CHECK("harvests"."quantity_milli">0)
);
CREATE TABLE "irrigation" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"field_id" text NOT NULL,
"date" text NOT NULL,
"liters" bigint NOT NULL,
"duration" bigint NOT NULL,
"source" text NOT NULL,
"cost_cents" bigint NOT NULL,
"request_key" text NOT NULL,
CONSTRAINT "water_positive" CHECK("irrigation"."liters">0)
);
CREATE TABLE "maintenance" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"equipment_id" text NOT NULL,
"description" text NOT NULL,
"cost_cents" bigint NOT NULL,
"date" text NOT NULL,
"next_due" text NOT NULL,
"request_key" text NOT NULL
);
CREATE TABLE "payments" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"sale_id" text NOT NULL,
"amount_cents" bigint NOT NULL,
"date" text NOT NULL,
"request_key" text NOT NULL,
CONSTRAINT "payment_positive" CHECK("payments"."amount_cents">0)
);
CREATE TABLE "products" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"name" text NOT NULL,
"category" text NOT NULL,
"unit" text NOT NULL,
"cost_cents" bigint NOT NULL,
"reorder_milli" bigint NOT NULL,
"supplier" text NOT NULL,
"expiry" text,
CONSTRAINT "product_cost" CHECK("products"."cost_cents">=0)
);
CREATE TABLE "purchases" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"product_id" text NOT NULL,
"quantity_milli" bigint NOT NULL,
"unit_cents" bigint NOT NULL,
"total_cents" bigint NOT NULL,
"supplier" text NOT NULL,
"date" text NOT NULL,
"status" text NOT NULL,
"request_key" text NOT NULL
);
CREATE TABLE "sales" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"harvest_id" text NOT NULL,
"customer" text NOT NULL,
"quantity_milli" bigint NOT NULL,
"unit_cents" bigint NOT NULL,
"total_cents" bigint NOT NULL,
"paid_cents" bigint DEFAULT 0 NOT NULL,
"date" text NOT NULL,
"request_key" text NOT NULL,
CONSTRAINT "sale_paid_bounds" CHECK("sales"."paid_cents">=0 AND "sales"."paid_cents"<="sales"."total_cents")
);
CREATE TABLE "settings" (
"owner" text PRIMARY KEY NOT NULL,
"low_stock_enabled" bigint DEFAULT 1 NOT NULL,
"overdue_enabled" bigint DEFAULT 1 NOT NULL,
"water_enabled" bigint DEFAULT 1 NOT NULL,
"currency" text DEFAULT 'USD' NOT NULL,
"role" text DEFAULT 'Owner' NOT NULL
);
CREATE TABLE "stock_movements" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"product_id" text NOT NULL,
"field_id" text,
"quantity_milli" bigint NOT NULL,
"amount_cents" bigint NOT NULL,
"kind" text NOT NULL,
"reference" text NOT NULL,
"date" text NOT NULL
);
CREATE TABLE "tasks" (
"id" text PRIMARY KEY NOT NULL,
"owner" text NOT NULL,
"field_id" text NOT NULL,
"employee_id" text NOT NULL,
"title" text NOT NULL,
"kind" text NOT NULL,
"due" text NOT NULL,
"status" text NOT NULL,
"priority" text NOT NULL,
"hours_milli" bigint DEFAULT 0 NOT NULL,
"request_key" text NOT NULL
);
CREATE TABLE "workspaces" (
"owner" text PRIMARY KEY NOT NULL,
"name" text NOT NULL,
"created" text NOT NULL
);
CREATE UNIQUE INDEX "ack_unique" ON "acknowledgements" ("owner","alert_key");
CREATE UNIQUE INDEX "audit_request" ON "audit" ("owner","request_key");
CREATE INDEX "audit_owner_date" ON "audit" ("owner","date");
CREATE UNIQUE INDEX "employees_scope" ON "employees" ("id","owner");
CREATE UNIQUE INDEX "equipment_scope" ON "equipment" ("id","owner");
CREATE UNIQUE INDEX "expense_reference" ON "expenses" ("owner","reference");
CREATE UNIQUE INDEX "farms_scope" ON "farms" ("id","owner");
CREATE UNIQUE INDEX "fields_scope" ON "fields" ("id","owner");
CREATE UNIQUE INDEX "harvest_scope" ON "harvests" ("id","owner");
CREATE UNIQUE INDEX "harvest_request" ON "harvests" ("owner","request_key");
CREATE UNIQUE INDEX "irrigation_request" ON "irrigation" ("owner","request_key");
CREATE UNIQUE INDEX "maintenance_request" ON "maintenance" ("owner","request_key");
CREATE UNIQUE INDEX "payment_request" ON "payments" ("owner","request_key");
CREATE UNIQUE INDEX "products_scope" ON "products" ("id","owner");
CREATE UNIQUE INDEX "purchase_request" ON "purchases" ("owner","request_key");
CREATE UNIQUE INDEX "sale_request" ON "sales" ("owner","request_key");
CREATE INDEX "movement_product_owner" ON "stock_movements" ("owner","product_id");
CREATE UNIQUE INDEX "movement_request" ON "stock_movements" ("owner","reference");
CREATE UNIQUE INDEX "tasks_request" ON "tasks" ("owner","request_key");
CREATE UNIQUE INDEX "sales_scope" ON "sales" ("id","owner");
ALTER TABLE "acknowledgements" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "audit" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "employees" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "equipment" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "expenses" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "expenses" ADD FOREIGN KEY ("field_id","owner") REFERENCES "fields"("id","owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "farms" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "fields" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "fields" ADD FOREIGN KEY ("farm_id","owner") REFERENCES "farms"("id","owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "harvests" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "harvests" ADD FOREIGN KEY ("field_id","owner") REFERENCES "fields"("id","owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "irrigation" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "irrigation" ADD FOREIGN KEY ("field_id","owner") REFERENCES "fields"("id","owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "maintenance" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "maintenance" ADD FOREIGN KEY ("equipment_id","owner") REFERENCES "equipment"("id","owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "payments" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "payments" ADD FOREIGN KEY ("sale_id","owner") REFERENCES "sales"("id","owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "products" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "purchases" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "purchases" ADD FOREIGN KEY ("product_id","owner") REFERENCES "products"("id","owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "sales" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "sales" ADD FOREIGN KEY ("harvest_id","owner") REFERENCES "harvests"("id","owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "settings" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "stock_movements" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "stock_movements" ADD FOREIGN KEY ("product_id","owner") REFERENCES "products"("id","owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "stock_movements" ADD FOREIGN KEY ("field_id","owner") REFERENCES "fields"("id","owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "tasks" ADD FOREIGN KEY ("owner") REFERENCES "workspaces"("owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "tasks" ADD FOREIGN KEY ("field_id","owner") REFERENCES "fields"("id","owner") ON UPDATE no action ON DELETE no action;
ALTER TABLE "tasks" ADD FOREIGN KEY ("employee_id","owner") REFERENCES "employees"("id","owner") ON UPDATE no action ON DELETE no action;
CREATE TABLE field_geometries (field_id text NOT NULL, owner text NOT NULL, geom geometry(Polygon,4326) NOT NULL, updated_at timestamptz NOT NULL DEFAULT now(), PRIMARY KEY(field_id,owner), FOREIGN KEY(field_id,owner) REFERENCES fields(id,owner), CONSTRAINT valid_geometry CHECK(ST_IsValid(geom) AND NOT ST_IsEmpty(geom)));
CREATE INDEX field_geometry_gist ON field_geometries USING GIST(geom);
CREATE TABLE login_attempts (id bigserial PRIMARY KEY, attempted_at timestamptz NOT NULL DEFAULT now());
