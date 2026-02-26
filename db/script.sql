--
-- PostgreSQL database dump
--

\restrict gcNHZAB4vNQqiK6WAMzpJEi5G1PXKJ16fnmZVXHNRiwYrK6aWdDSk5ynvOJpqVt

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    name character varying(60) NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer CONSTRAINT order_items_products_id_not_null NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    order_date date NOT NULL,
    delivery_date date NOT NULL,
    pickup_point_id integer NOT NULL,
    user_id integer NOT NULL,
    code character varying(20) NOT NULL,
    status character varying(40) NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: pickup_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickup_points (
    address text NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.pickup_points OWNER TO postgres;

--
-- Name: pickup_points_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pickup_points_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pickup_points_id_seq OWNER TO postgres;

--
-- Name: pickup_points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pickup_points_id_seq OWNED BY public.pickup_points.id;


--
-- Name: producers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producers (
    name text NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.producers OWNER TO postgres;

--
-- Name: producers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.producers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.producers_id_seq OWNER TO postgres;

--
-- Name: producers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.producers_id_seq OWNED BY public.producers.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    sku character varying(20) NOT NULL,
    name character varying(100) NOT NULL,
    price real NOT NULL,
    supplier_id integer NOT NULL,
    producer_id integer NOT NULL,
    category_id integer NOT NULL,
    discount real NOT NULL,
    stock_qty integer NOT NULL,
    description text,
    photo_path text
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    name text NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.suppliers_id_seq OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    name character varying(40) NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_roles_id_seq OWNER TO postgres;

--
-- Name: user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_roles_id_seq OWNED BY public.user_roles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    full_name text NOT NULL,
    login text CONSTRAINT users_email_not_null NOT NULL,
    password character varying(40) NOT NULL,
    role_id integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: with_id; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.with_id (
    id integer NOT NULL
);


ALTER TABLE public.with_id OWNER TO postgres;

--
-- Name: with_id_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.with_id_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.with_id_id_seq OWNER TO postgres;

--
-- Name: with_id_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.with_id_id_seq OWNED BY public.with_id.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: pickup_points id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points ALTER COLUMN id SET DEFAULT nextval('public.pickup_points_id_seq'::regclass);


--
-- Name: producers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producers ALTER COLUMN id SET DEFAULT nextval('public.producers_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- Name: user_roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles ALTER COLUMN id SET DEFAULT nextval('public.user_roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: with_id id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.with_id ALTER COLUMN id SET DEFAULT nextval('public.with_id_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (name, id) FROM stdin;
Женская обувь	1
Мужская обувь	2
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, quantity) FROM stdin;
1	1	18	2
2	1	3	2
3	2	16	1
4	2	1	1
5	3	5	10
6	3	2	10
7	4	4	5
8	4	14	4
9	5	18	2
10	5	3	2
11	6	16	1
12	6	1	1
13	7	5	10
14	7	2	10
15	8	4	5
16	8	14	4
17	9	9	5
18	9	19	1
19	10	24	5
20	10	20	5
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, order_date, delivery_date, pickup_point_id, user_id, code, status) FROM stdin;
1	2025-02-27	2025-04-20	1	5	901	Завершен
2	2022-09-28	2025-04-21	11	2	902	Завершен
3	2025-03-21	2025-04-22	2	3	903	Завершен
4	2025-02-20	2025-04-23	11	4	904	Завершен
5	2025-03-17	2025-04-24	2	5	905	Завершен
6	2025-03-01	2025-04-25	15	2	906	Завершен
7	2025-01-03	2025-04-26	3	3	907	Завершен
8	2025-03-31	2025-04-27	19	4	908	Новый 
9	2025-04-02	2025-04-28	5	5	909	Новый 
10	2025-04-03	2025-04-29	19	5	910	Новый 
\.


--
-- Data for Name: pickup_points; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pickup_points (address, id) FROM stdin;
420151, г. Лесной, ул. Вишневая, 32	1
125061, г. Лесной, ул. Подгорная, 8	2
630370, г. Лесной, ул. Шоссейная, 24	3
400562, г. Лесной, ул. Зеленая, 32	4
614510, г. Лесной, ул. Маяковского, 47	5
410542, г. Лесной, ул. Светлая, 46	6
620839, г. Лесной, ул. Цветочная, 8	7
443890, г. Лесной, ул. Коммунистическая, 1	8
603379, г. Лесной, ул. Спортивная, 46	9
603721, г. Лесной, ул. Гоголя, 41	10
410172, г. Лесной, ул. Северная, 13	11
614611, г. Лесной, ул. Молодежная, 50	12
454311, г.Лесной, ул. Новая, 19	13
660007, г.Лесной, ул. Октябрьская, 19	14
603036, г. Лесной, ул. Садовая, 4	15
394060, г.Лесной, ул. Фрунзе, 43	16
410661, г. Лесной, ул. Школьная, 50	17
625590, г. Лесной, ул. Коммунистическая, 20	18
625683, г. Лесной, ул. 8 Марта	19
450983, г.Лесной, ул. Комсомольская, 26	20
394782, г. Лесной, ул. Чехова, 3	21
603002, г. Лесной, ул. Дзержинского, 28	22
450558, г. Лесной, ул. Набережная, 30	23
344288, г. Лесной, ул. Чехова, 1	24
614164, г.Лесной,  ул. Степная, 30	25
394242, г. Лесной, ул. Коммунистическая, 43	26
660540, г. Лесной, ул. Солнечная, 25	27
125837, г. Лесной, ул. Шоссейная, 40	28
125703, г. Лесной, ул. Партизанская, 49	29
625283, г. Лесной, ул. Победы, 46	30
614753, г. Лесной, ул. Полевая, 35	31
426030, г. Лесной, ул. Маяковского, 44	32
450375, г. Лесной ул. Клубная, 44	33
625560, г. Лесной, ул. Некрасова, 12	34
630201, г. Лесной, ул. Комсомольская, 17	35
190949, г. Лесной, ул. Мичурина, 26	36
\.


--
-- Data for Name: producers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producers (name, id) FROM stdin;
Рос	1
Marco Tozzi	2
Rieker	3
Alessio Nesca	4
Kari	5
CROSBY	6
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, sku, name, price, supplier_id, producer_id, category_id, discount, stock_qty, description, photo_path) FROM stdin;
1	G783F5	Ботинки	5900	2	1	2	2	8	Мужские ботинки Рос-Обувь кожаные с натуральным мехом	4.jpg
2	D572U8	Кроссовки	4100	1	1	2	3	6	129615-4 Кроссовки мужские	6.jpg
3	F635R4	Ботинки	3244	1	2	1	2	13	Ботинки Marco Tozzi женские демисезонные, размер 39, цвет бежевый	2.jpg
4	F572H7	Туфли	2700	2	2	1	2	14	Туфли Marco Tozzi женские летние, размер 39, цвет черный	7.jpg
5	J384T6	Ботинки	3800	1	3	2	2	16	B3430/14 Полуботинки мужские Rieker	5.jpg
6	B431R5	Ботинки	2700	1	3	2	2	5	Мужские кожаные ботинки/мужские ботинки	\N
7	M542T5	Кроссовки	2800	1	3	2	5	3	Кроссовки мужские TOFA	\N
8	K358H6	Тапочки	599	2	3	2	3	2	Тапочки мужские син р.41	\N
9	B320R5	Туфли	4300	2	3	1	2	6	Туфли Rieker женские демисезонные, размер 41, цвет коричневый	9.jpg
10	O754F4	Туфли	5400	1	3	1	4	18	Туфли женские демисезонные Rieker артикул 55073-68/37	\N
11	F427R5	Ботинки	11800	1	3	1	4	11	Ботинки на молнии с декоративной пряжкой FRAU	\N
12	D268G5	Туфли	4399	1	3	1	3	12	Туфли Rieker женские демисезонные, размер 36, цвет коричневый	\N
13	H535R5	Ботинки	2300	1	3	1	2	7	Женские Ботинки демисезонные	\N
14	D329H3	Полуботинки	1890	1	4	1	4	4	Полуботинки Alessio Nesca женские 3-30797-47, размер 37, цвет: бордовый	8.jpg
15	C436G5	Ботинки	10200	2	4	1	2	9	Ботинки женские, ARGO, размер 40	\N
16	H782T5	Туфли	4499	2	5	2	4	5	Туфли kari мужские классика MYZ21AW-450A, размер 43, цвет: черный	3.jpg
17	J542F5	Тапочки	500	2	5	2	3	12	Тапочки мужские Арт.70701-55-67син р.41	\N
18	А112Т4	Ботинки	4990	2	5	1	3	6	Женские Ботинки демисезонные kari	1.jpg
19	G432E4	Туфли	2800	2	5	1	3	15	Туфли kari женские TR-YR-413017, размер 37, цвет: черный	10.jpg
20	E482R4	Полуботинки	1800	2	5	1	2	14	Полуботинки kari женские MYZ20S-149, размер 41, цвет: черный	\N
21	G531F4	Ботинки	6600	2	5	1	2	9	Ботинки женские зимние ROMER арт. 893167-01 Черный	\N
22	D364R4	Туфли	12400	2	5	1	2	5	Туфли Luiza Belly женские Kate-lazo черные из натуральной замши	\N
23	L754R4	Полуботинки	1700	2	5	1	2	7	Полуботинки kari женские WB2020SS-26, размер 38, цвет: черный	\N
24	S213E3	Полуботинки	2156	1	6	2	3	6	407700/01-01 Полуботинки мужские CROSBY	\N
25	S634B5	Кеды	5500	1	6	2	3	6	Кеды Caprice мужские демисезонные, размер 42, цвет черный	\N
26	K345R4	Полуботинки	2100	1	6	2	2	3	407700/01-02 Полуботинки мужские CROSBY	\N
27	S326R5	Тапочки	9900	1	6	2	3	15	Мужские кожаные тапочки Профиль С.Дали 	\N
28	P764G4	Туфли	6800	2	6	1	3	15	Туфли женские, ARGO, размер 38	\N
29	N457T5	Полуботинки	4600	2	6	1	3	13	Полуботинки Ботинки черные зимние, мех	\N
30	T324F5	Сапоги	4699	2	6	1	2	5	Сапоги замша Цвет: синий	\N
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (name, id) FROM stdin;
Обувь для вас	1
Kari	2
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (name, id) FROM stdin;
Авторизированный клиент	1
Менеджер	2
Администратор	3
Роль сотрудника	4
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (full_name, login, password, role_id, id) FROM stdin;
ФИО	Логин	Пароль	4	1
Никифорова Весения Николаевна	94d5ous@gmail.com	uzWC67	3	2
Сазонов Руслан Германович	uth4iz@mail.com	2L6KZG	3	3
Одинцов Серафим Артёмович	yzls62@outlook.com	JlFRCZ	3	4
Степанов Михаил Артёмович	1diph5e@tutanota.com	8ntwUp	2	5
Ворсин Петр Евгеньевич	tjde7c@yahoo.com	YOyhfR	2	6
Старикова Елена Павловна	wpmrc3do@tutanota.com	RSbvHv	2	7
Михайлюк Анна Вячеславовна	5d4zbu@tutanota.com	rwVDh9	1	8
Ситдикова Елена Анатольевна	ptec8ym@yahoo.com	LdNyos	1	9
Ворсин Петр Евгеньевич	1qz4kw@mail.com	gynQMT	1	10
Старикова Елена Павловна	4np6se@mail.com	AtnDjr	1	11
\.


--
-- Data for Name: with_id; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.with_id (id) FROM stdin;
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 2, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 20, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: pickup_points_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pickup_points_id_seq', 36, true);


--
-- Name: producers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.producers_id_seq', 6, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 30, true);


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 2, true);


--
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_roles_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 11, true);


--
-- Name: with_id_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.with_id_id_seq', 1, false);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: pickup_points pickup_points_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_pkey PRIMARY KEY (id);


--
-- Name: producers producers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producers
    ADD CONSTRAINT producers_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products products_sku_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_sku_key UNIQUE (sku);


--
-- Name: suppliers suppliers_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_name_key UNIQUE (name);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: user_roles user_roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_name_key UNIQUE (name);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: users users_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: with_id with_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.with_id
    ADD CONSTRAINT with_id_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: order_items order_items_products_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_products_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orders orders_pickup_point_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pickup_point_id_fkey FOREIGN KEY (pickup_point_id) REFERENCES public.pickup_points(id);


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) NOT VALID;


--
-- Name: products products_producer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_producer_id_fkey FOREIGN KEY (producer_id) REFERENCES public.producers(id) NOT VALID;


--
-- Name: products products_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id) NOT VALID;


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.user_roles(id);


--
-- PostgreSQL database dump complete
--

\unrestrict gcNHZAB4vNQqiK6WAMzpJEi5G1PXKJ16fnmZVXHNRiwYrK6aWdDSk5ynvOJpqVt

