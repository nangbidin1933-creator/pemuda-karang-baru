-- PEMUDA KARANG BARU - Supabase setup
-- Jalankan seluruh SQL ini di Supabase > SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.site_content (
  id uuid primary key default gen_random_uuid(), about text not null default 'Wadah pemuda Karang Baru untuk bersatu, berkarya, dan ikut membangun lingkungan yang aktif, kreatif, peduli, dan bermanfaat bagi masyarakat.',
  goal_1 text not null default 'Membangun persatuan dan solidaritas pemuda.', goal_2 text not null default 'Mengembangkan kegiatan sosial, olahraga, budaya, dan kreativitas.', goal_3 text not null default 'Mendorong pemuda aktif dalam pembangunan lingkungan.', updated_at timestamptz not null default now()
);
create table if not exists public.people (id uuid primary key default gen_random_uuid(), name text not null, role text not null default 'Anggota', type text not null check (type in ('pengurus','anggota')), created_at timestamptz not null default now());
create table if not exists public.events (id uuid primary key default gen_random_uuid(), title text not null, event_date text not null, description text not null default '', created_at timestamptz not null default now());
create table if not exists public.photos (id uuid primary key default gen_random_uuid(), title text not null, storage_path text not null, public_url text not null, created_at timestamptz not null default now());

insert into public.site_content (about,goal_1,goal_2,goal_3) select 'Wadah pemuda Karang Baru untuk bersatu, berkarya, dan ikut membangun lingkungan yang aktif, kreatif, peduli, dan bermanfaat bagi masyarakat.','Membangun persatuan dan solidaritas pemuda.','Mengembangkan kegiatan sosial, olahraga, budaya, dan kreativitas.','Mendorong pemuda aktif dalam pembangunan lingkungan.' where not exists (select 1 from public.site_content);
insert into public.people (name,role,type) select * from (values ('Nama Ketua','Ketua Pemuda','pengurus'),('Nama Sekretaris','Sekretaris','pengurus'),('Nama Bendahara','Bendahara','pengurus'),('Anggota Pemuda 01','Anggota','anggota'),('Anggota Pemuda 02','Anggota','anggota'),('Anggota Pemuda 03','Anggota','anggota')) v(name,role,type) where not exists (select 1 from public.people);
insert into public.events (title,event_date,description) select 'Kerja Bakti Lingkungan','12 Oktober 2026','Kegiatan gotong royong bersama warga.' where not exists (select 1 from public.events);

alter table public.site_content enable row level security; alter table public.people enable row level security; alter table public.events enable row level security; alter table public.photos enable row level security;

drop policy if exists "public read site_content" on public.site_content; create policy "public read site_content" on public.site_content for select using (true);
drop policy if exists "authenticated manage site_content" on public.site_content; create policy "authenticated manage site_content" on public.site_content for all to authenticated using (true) with check (true);
drop policy if exists "public read people" on public.people; create policy "public read people" on public.people for select using (true);
drop policy if exists "authenticated manage people" on public.people; create policy "authenticated manage people" on public.people for all to authenticated using (true) with check (true);
drop policy if exists "public read events" on public.events; create policy "public read events" on public.events for select using (true);
drop policy if exists "authenticated manage events" on public.events; create policy "authenticated manage events" on public.events for all to authenticated using (true) with check (true);
drop policy if exists "public read photos" on public.photos; create policy "public read photos" on public.photos for select using (true);
drop policy if exists "authenticated manage photos" on public.photos; create policy "authenticated manage photos" on public.photos for all to authenticated using (true) with check (true);

insert into storage.buckets (id,name,public) values ('activity-photos','activity-photos',true) on conflict (id) do update set public=true;
drop policy if exists "public view activity photos" on storage.objects; create policy "public view activity photos" on storage.objects for select using (bucket_id='activity-photos');
drop policy if exists "authenticated upload activity photos" on storage.objects; create policy "authenticated upload activity photos" on storage.objects for insert to authenticated with check (bucket_id='activity-photos');
drop policy if exists "authenticated update activity photos" on storage.objects; create policy "authenticated update activity photos" on storage.objects for update to authenticated using (bucket_id='activity-photos') with check (bucket_id='activity-photos');
drop policy if exists "authenticated delete activity photos" on storage.objects; create policy "authenticated delete activity photos" on storage.objects for delete to authenticated using (bucket_id='activity-photos');
