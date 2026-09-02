-- Catalyst CV database schema. Run this in Supabase SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.cvs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null default 'My CV',
  template text not null default 'aurora',
  content jsonb not null default '{}'::jsonb,
  is_premium boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.payments (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  phone text not null,
  amount integer not null,
  merchant_request_id text,
  checkout_request_id text unique,
  receipt text,
  status text not null default 'pending',
  result_code integer,
  result_desc text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.cvs enable row level security;
alter table public.payments enable row level security;

drop policy if exists "users manage own cvs" on public.cvs;
create policy "users manage own cvs" on public.cvs for all using (auth.uid()=user_id) with check (auth.uid()=user_id);

drop policy if exists "users view own payments" on public.payments;
create policy "users view own payments" on public.payments for select using (auth.uid()=user_id);

create index if not exists cvs_user_updated_idx on public.cvs(user_id,updated_at desc);
create index if not exists payments_checkout_idx on public.payments(checkout_request_id);
