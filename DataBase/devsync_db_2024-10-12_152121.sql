--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: GreenPulse
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.tags OWNER TO "GreenPulse";

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: GreenPulse
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tags_id_seq OWNER TO "GreenPulse";

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: GreenPulse
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: task_tags; Type: TABLE; Schema: public; Owner: GreenPulse
--

CREATE TABLE public.task_tags (
    task_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


ALTER TABLE public.task_tags OWNER TO "GreenPulse";

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: GreenPulse
--

CREATE TABLE public.tasks (
    id integer NOT NULL,
    created_at date NOT NULL,
    deadline date,
    description character varying(255),
    is_token_modifiable boolean NOT NULL,
    status character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    assigned_to bigint,
    created_by bigint,
    start_date date
);


ALTER TABLE public.tasks OWNER TO "GreenPulse";

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: GreenPulse
--

CREATE SEQUENCE public.tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tasks_id_seq OWNER TO "GreenPulse";

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: GreenPulse
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: GreenPulse
--

CREATE TABLE public.users (
    id integer NOT NULL,
    deletion_tokens integer NOT NULL,
    email character varying(255) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    last_token_refresh_date date,
    password character varying(255) NOT NULL,
    replacement_tokens integer NOT NULL,
    role character varying(255) NOT NULL,
    username character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO "GreenPulse";

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: GreenPulse
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO "GreenPulse";

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: GreenPulse
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: tags tags_name_key; Type: CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_name_key UNIQUE (name);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: task_tags task_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.task_tags
    ADD CONSTRAINT task_tags_pkey PRIMARY KEY (task_id, tag_id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: task_tags unq_task_tags_0; Type: CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.task_tags
    ADD CONSTRAINT unq_task_tags_0 UNIQUE (task_id, tag_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: task_tags fk_task_tags_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.task_tags
    ADD CONSTRAINT fk_task_tags_tag_id FOREIGN KEY (tag_id) REFERENCES public.tags(id);


--
-- Name: task_tags fk_task_tags_task_id; Type: FK CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.task_tags
    ADD CONSTRAINT fk_task_tags_task_id FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: tasks fk_tasks_assigned_to; Type: FK CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_tasks_assigned_to FOREIGN KEY (assigned_to) REFERENCES public.users(id);


--
-- Name: tasks fk_tasks_created_by; Type: FK CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_tasks_created_by FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

