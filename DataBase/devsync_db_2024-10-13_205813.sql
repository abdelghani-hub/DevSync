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
-- Name: requests; Type: TABLE; Schema: public; Owner: GreenPulse
--

CREATE TABLE public.requests (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    task_id bigint NOT NULL,
    type character varying(50) NOT NULL,
    status character varying(10) DEFAULT 'PENDING'::character varying,
    requested_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    responded_at timestamp without time zone
);


ALTER TABLE public.requests OWNER TO "GreenPulse";

--
-- Name: requests_id_seq; Type: SEQUENCE; Schema: public; Owner: GreenPulse
--

CREATE SEQUENCE public.requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.requests_id_seq OWNER TO "GreenPulse";

--
-- Name: requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: GreenPulse
--

ALTER SEQUENCE public.requests_id_seq OWNED BY public.requests.id;


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
-- Name: user_tokens; Type: TABLE; Schema: public; Owner: GreenPulse
--

CREATE TABLE public.user_tokens (
    id integer NOT NULL,
    user_id integer NOT NULL,
    modification_tokens integer,
    deletion_tokens integer,
    last_reset_date timestamp without time zone
);


ALTER TABLE public.user_tokens OWNER TO "GreenPulse";

--
-- Name: user_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: GreenPulse
--

CREATE SEQUENCE public.user_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_tokens_id_seq OWNER TO "GreenPulse";

--
-- Name: user_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: GreenPulse
--

ALTER SEQUENCE public.user_tokens_id_seq OWNED BY public.user_tokens.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: GreenPulse
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    password character varying(255) NOT NULL,
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
-- Name: requests id; Type: DEFAULT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.requests ALTER COLUMN id SET DEFAULT nextval('public.requests_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: user_tokens id; Type: DEFAULT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.user_tokens ALTER COLUMN id SET DEFAULT nextval('public.user_tokens_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: requests requests_pkey; Type: CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT requests_pkey PRIMARY KEY (id);


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
-- Name: user_tokens user_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.user_tokens
    ADD CONSTRAINT user_tokens_pkey PRIMARY KEY (id);


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
-- Name: idx_request_task; Type: INDEX; Schema: public; Owner: GreenPulse
--

CREATE INDEX idx_request_task ON public.requests USING btree (task_id);


--
-- Name: idx_request_user; Type: INDEX; Schema: public; Owner: GreenPulse
--

CREATE INDEX idx_request_user ON public.requests USING btree (user_id);


--
-- Name: requests fk_request_task; Type: FK CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT fk_request_task FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: requests fk_request_user; Type: FK CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.requests
    ADD CONSTRAINT fk_request_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: task_tags fk_task_tags_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.task_tags
    ADD CONSTRAINT fk_task_tags_tag_id FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: task_tags fk_task_tags_task_id; Type: FK CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.task_tags
    ADD CONSTRAINT fk_task_tags_task_id FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tasks fk_tasks_assigned_to; Type: FK CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_tasks_assigned_to FOREIGN KEY (assigned_to) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tasks fk_tasks_created_by; Type: FK CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_tasks_created_by FOREIGN KEY (created_by) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_tokens fk_user_tokens_user_id; Type: FK CONSTRAINT; Schema: public; Owner: GreenPulse
--

ALTER TABLE ONLY public.user_tokens
    ADD CONSTRAINT fk_user_tokens_user_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

