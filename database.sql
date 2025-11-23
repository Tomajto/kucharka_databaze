-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.article_images (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  article_id uuid,
  image_url text NOT NULL,
  CONSTRAINT article_images_pkey PRIMARY KEY (id),
  CONSTRAINT article_images_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.articles(id)
);
CREATE TABLE public.articles (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  type text NOT NULL CHECK (type = ANY (ARRAY['internal'::text, 'external'::text])),
  title text NOT NULL,
  author text NOT NULL,
  content text,
  source_url text,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT articles_pkey PRIMARY KEY (id)
);
CREATE TABLE public.recipe_images (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  recipe_id uuid,
  image_url text NOT NULL,
  CONSTRAINT recipe_images_pkey PRIMARY KEY (id),
  CONSTRAINT recipe_images_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id)
);
CREATE TABLE public.recipe_ingredients (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  recipe_id uuid,
  name text NOT NULL,
  amount text,
  CONSTRAINT recipe_ingredients_pkey PRIMARY KEY (id),
  CONSTRAINT recipe_ingredients_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id)
);
CREATE TABLE public.recipe_steps (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  recipe_id uuid,
  step_number integer NOT NULL,
  content text NOT NULL,
  CONSTRAINT recipe_steps_pkey PRIMARY KEY (id),
  CONSTRAINT recipe_steps_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id)
);
CREATE TABLE public.recipes (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text,
  created_at timestamp with time zone DEFAULT now(),
  difficulty text NOT NULL DEFAULT 'lehké'::text CHECK (difficulty = ANY (ARRAY['lehké'::text, 'střední'::text, 'těžké'::text])),
  duration_minutes integer NOT NULL DEFAULT 0,
  category text NOT NULL DEFAULT 'hlavni'::text CHECK (category = ANY (ARRAY['hlavni'::text, 'dezert'::text, 'polevka'::text, 'salat'::text, 'snidane'::text])),
  CONSTRAINT recipes_pkey PRIMARY KEY (id)
);