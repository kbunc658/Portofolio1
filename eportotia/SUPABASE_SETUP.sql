-- ============================================
-- E-Portofolio Tia Kamalini - Supabase Setup
-- Jalankan di Supabase SQL Editor
-- ============================================

-- TABLE: site_settings (global config)
CREATE TABLE IF NOT EXISTS site_settings (
  id TEXT PRIMARY KEY DEFAULT 'main',
  hero_title TEXT DEFAULT 'E-Portofolio Tia Kamalini',
  hero_subtitle TEXT DEFAULT 'Pendidikan Profesi Guru (PPG) | Universitas Pendidikan Ganesha',
  hero_image_url TEXT DEFAULT '',
  hero_bg_url TEXT DEFAULT '',
  footer_email TEXT DEFAULT 'madetia92@gmail.com',
  footer_phone TEXT DEFAULT '+62 878-2566-2597',
  footer_text TEXT DEFAULT '© 2026 | E-Portofolio Tia Kamalini | PPG',
  navbar_logo TEXT DEFAULT 'E-Portofolio Tia Kamalini',
  halaman_muka_content JSONB DEFAULT '[]',
  admin_username TEXT DEFAULT 'admin',
  admin_password TEXT DEFAULT 'tia2024',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Insert default row
INSERT INTO site_settings (id) VALUES ('main') ON CONFLICT (id) DO NOTHING;

-- TABLE: pages (each menu/sub-menu page)
CREATE TABLE IF NOT EXISTS pages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  parent_slug TEXT DEFAULT NULL,
  nav_order INTEGER DEFAULT 0,
  is_visible BOOLEAN DEFAULT TRUE,
  page_type TEXT DEFAULT 'content', -- content | landing | artefak
  content JSONB DEFAULT '[]',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Insert default pages
INSERT INTO pages (slug, title, parent_slug, nav_order, page_type) VALUES
  ('halaman-muka', 'Halaman Muka', NULL, 1, 'landing'),
  ('profil', 'Profil', NULL, 2, 'content'),
  ('profil/identitas', 'Identitas', 'profil', 1, 'content'),
  ('profil/keunikan-daerah', 'Keunikan Daerah', 'profil', 2, 'content'),
  ('profil/inspirasi-dan-tujuan', 'Inspirasi dan Tujuan', 'profil', 3, 'content'),
  ('artefak', 'Artefak', NULL, 3, 'content'),
  ('artefak/siklus-1', 'Siklus 1', 'artefak', 1, 'artefak'),
  ('artefak/siklus-2', 'Siklus 2', 'artefak', 2, 'artefak'),
  ('artefak/siklus-3', 'Siklus 3', 'artefak', 3, 'artefak'),
  ('lampiran', 'Lampiran', NULL, 4, 'content'),
  ('lampiran/penilaian-perangkat-pembelajaran', 'Penilaian Perangkat Pembelajaran', 'lampiran', 1, 'content'),
  ('lampiran/penilaian-praktik-mengajar', 'Penilaian Praktik Mengajar', 'lampiran', 2, 'content'),
  ('model-guru', 'Model Guru', NULL, 5, 'content')
ON CONFLICT (slug) DO NOTHING;

-- TABLE: media_items (foto, video, dokumen per halaman)
CREATE TABLE IF NOT EXISTS media_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  page_slug TEXT NOT NULL REFERENCES pages(slug) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT DEFAULT '',
  media_type TEXT DEFAULT 'image', -- image | video | youtube | drive-doc | drive-sheet | slide | link | text
  media_url TEXT DEFAULT '',
  thumbnail_url TEXT DEFAULT '',
  display_order INTEGER DEFAULT 0,
  is_visible BOOLEAN DEFAULT TRUE,
  extra_data JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security but allow anon read (public portfolio)
ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE pages ENABLE ROW LEVEL SECURITY;
ALTER TABLE media_items ENABLE ROW LEVEL SECURITY;

-- Allow public read
CREATE POLICY "public_read_settings" ON site_settings FOR SELECT USING (true);
CREATE POLICY "public_read_pages" ON pages FOR SELECT USING (true);
CREATE POLICY "public_read_media" ON media_items FOR SELECT USING (true);

-- Allow anon full access (admin uses anon key with password check in app)
CREATE POLICY "anon_all_settings" ON site_settings FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "anon_all_pages" ON pages FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "anon_all_media" ON media_items FOR ALL USING (true) WITH CHECK (true);

-- Insert default content for halaman muka
UPDATE pages SET content = '[
  {"type":"hero","title":"E-Portofolio Tia Kamalini","subtitle":"Pendidikan Profesi Guru (PPG) | Universitas Pendidikan Ganesha","image":""},
  {"type":"section","title":"Kampus LPTK","text":"Universitas Pendidikan Ganesha (Undiksha) adalah perguruan tinggi negeri di Singaraja, Bali, yang berfokus pada kependidikan dan non-kependidikan.","map_url":"https://maps-api-ssl.google.com/maps?hl=en-US&ll=-8.116503,115.087643&output=embed&q=-8.116532,115.087733&z=17"},
  {"type":"section","title":"Sekolah PPL","text":"SD Negeri 1 Baktiseraga adalah satuan pendidikan dasar negeri yang berlokasi di Jl. Laksamana, Baktiseraga, Kecamatan Buleleng, Kabupaten Buleleng, Bali.","map_url":"https://maps-api-ssl.google.com/maps?hl=en-US&ll=-8.126752,115.079537&output=embed&q=-8.126769,115.079548&z=17"},
  {"type":"menu-cards","title":"Jelajahi Portofolio","items":[
    {"label":"Profil","slug":"profil","icon":"👤","desc":"Identitas, keunikan daerah, dan inspirasi"},
    {"label":"Artefak","slug":"artefak","icon":"📚","desc":"Siklus 1, 2, dan 3 pembelajaran"},
    {"label":"Lampiran","slug":"lampiran","icon":"📎","desc":"Penilaian perangkat & praktik mengajar"},
    {"label":"Model Guru","slug":"model-guru","icon":"🏫","desc":"Dokumentasi model pembelajaran"}
  ]}
]'::jsonb WHERE slug='halaman-muka';

UPDATE pages SET content = '[
  {"type":"text","title":"Model Guru","text":"Halaman ini berisi dokumentasi dan informasi mengenai model guru dalam program PPG Tia Kamalini."}
]'::jsonb WHERE slug='model-guru';

-- Create storage bucket (run separately in Storage section or via API)
-- Bucket: portfolio-media (public)
