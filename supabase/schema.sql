-- Clothing Ecommerce Engine
-- Multi-store ready schema. Run in the dedicated Supabase project.

create extension if not exists pgcrypto;

create table if not exists stores (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text unique not null,
  logo_url text,
  primary_color text default '#111111',
  currency text default 'EGP',
  phone text,
  whatsapp text,
  created_at timestamptz not null default now()
);

create table if not exists categories (
  id uuid primary key default gen_random_uuid(),
  store_id uuid not null references stores(id) on delete cascade,
  name text not null,
  slug text not null,
  image_url text,
  sort_order integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  unique(store_id, slug)
);

create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  store_id uuid not null references stores(id) on delete cascade,
  category_id uuid references categories(id) on delete set null,
  name text not null,
  slug text not null,
  description text,
  price numeric(12,2) not null default 0,
  compare_at_price numeric(12,2),
  sku text,
  is_active boolean not null default true,
  featured boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(store_id, slug)
);

create table if not exists product_variants (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references products(id) on delete cascade,
  color text,
  size text,
  sku text,
  price numeric(12,2),
  stock integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists product_images (
  id uuid primary key default gen_random_uuid(),
  product_id uuid not null references products(id) on delete cascade,
  url text not null,
  alt text,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists customers (
  id uuid primary key default gen_random_uuid(),
  store_id uuid not null references stores(id) on delete cascade,
  name text not null,
  phone text,
  email text,
  address text,
  city text,
  created_at timestamptz not null default now()
);

create table if not exists orders (
  id uuid primary key default gen_random_uuid(),
  store_id uuid not null references stores(id) on delete cascade,
  customer_id uuid references customers(id) on delete set null,
  order_number bigint generated always as identity,
  status text not null default 'pending' check (status in ('pending','confirmed','processing','shipped','delivered','cancelled')),
  payment_status text not null default 'pending' check (payment_status in ('pending','paid','failed','refunded')),
  payment_method text not null default 'cod',
  subtotal numeric(12,2) not null default 0,
  shipping_fee numeric(12,2) not null default 0,
  discount numeric(12,2) not null default 0,
  total numeric(12,2) not null default 0,
  notes text,
  shipping_address text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references orders(id) on delete cascade,
  product_id uuid references products(id) on delete set null,
  variant_id uuid references product_variants(id) on delete set null,
  product_name text not null,
  variant_label text,
  quantity integer not null check (quantity > 0),
  unit_price numeric(12,2) not null,
  line_total numeric(12,2) not null
);

create table if not exists coupons (
  id uuid primary key default gen_random_uuid(),
  store_id uuid not null references stores(id) on delete cascade,
  code text not null,
  discount_type text not null check (discount_type in ('fixed','percent')),
  discount_value numeric(12,2) not null,
  min_order_total numeric(12,2) not null default 0,
  is_active boolean not null default true,
  expires_at timestamptz,
  unique(store_id, code)
);

create table if not exists store_settings (
  store_id uuid primary key references stores(id) on delete cascade,
  hero_title text,
  hero_subtitle text,
  shipping_fee numeric(12,2) not null default 0,
  free_shipping_threshold numeric(12,2),
  cod_enabled boolean not null default true,
  online_payment_enabled boolean not null default false,
  updated_at timestamptz not null default now()
);

create index if not exists idx_products_store on products(store_id);
create index if not exists idx_products_category on products(category_id);
create index if not exists idx_variants_product on product_variants(product_id);
create index if not exists idx_orders_store on orders(store_id);
create index if not exists idx_orders_created on orders(created_at desc);

-- Updated-at helper
create or replace function set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists products_set_updated_at on products;
create trigger products_set_updated_at before update on products
for each row execute function set_updated_at();

drop trigger if exists orders_set_updated_at on orders;
create trigger orders_set_updated_at before update on orders
for each row execute function set_updated_at();

-- RLS is enabled now; policies will be finalized when auth/roles are wired.
alter table stores enable row level security;
alter table categories enable row level security;
alter table products enable row level security;
alter table product_variants enable row level security;
alter table product_images enable row level security;
alter table customers enable row level security;
alter table orders enable row level security;
alter table order_items enable row level security;
alter table coupons enable row level security;
alter table store_settings enable row level security;

-- Public storefront reads active catalog data. Writes are reserved for authenticated admin policies to be added next.
create policy "public read active categories" on categories for select using (is_active = true);
create policy "public read active products" on products for select using (is_active = true);
create policy "public read active variants" on product_variants for select using (is_active = true and exists (select 1 from products p where p.id = product_id and p.is_active = true));
create policy "public read product images" on product_images for select using (exists (select 1 from products p where p.id = product_id and p.is_active = true));
