--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.10
-- Dumped by pg_dump version 9.5.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE categories (
    category_id integer NOT NULL,
    cat character varying(150)
);


ALTER TABLE categories OWNER TO vagrant;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_category_id_seq OWNER TO vagrant;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE categories_category_id_seq OWNED BY categories.category_id;


--
-- Name: catusers; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE catusers (
    catuser_id integer NOT NULL,
    category_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE catusers OWNER TO vagrant;

--
-- Name: catusers_catuser_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE catusers_catuser_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE catusers_catuser_id_seq OWNER TO vagrant;

--
-- Name: catusers_catuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE catusers_catuser_id_seq OWNED BY catusers.catuser_id;


--
-- Name: foods; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE foods (
    food_id integer NOT NULL,
    name character varying(150),
    description character varying(250),
    location boolean
);


ALTER TABLE foods OWNER TO vagrant;

--
-- Name: foods_food_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE foods_food_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE foods_food_id_seq OWNER TO vagrant;

--
-- Name: foods_food_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE foods_food_id_seq OWNED BY foods.food_id;


--
-- Name: foods_lifts; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE foods_lifts (
    "FL_id" integer NOT NULL,
    lift_id integer NOT NULL,
    food_id integer NOT NULL
);


ALTER TABLE foods_lifts OWNER TO vagrant;

--
-- Name: foods_lifts_FL_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE "foods_lifts_FL_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "foods_lifts_FL_id_seq" OWNER TO vagrant;

--
-- Name: foods_lifts_FL_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE "foods_lifts_FL_id_seq" OWNED BY foods_lifts."FL_id";


--
-- Name: lifts; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE lifts (
    lift_id integer NOT NULL,
    name character varying(150),
    status character varying(150),
    mountain character varying(200)
);


ALTER TABLE lifts OWNER TO vagrant;

--
-- Name: lifts_lift_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE lifts_lift_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lifts_lift_id_seq OWNER TO vagrant;

--
-- Name: lifts_lift_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE lifts_lift_id_seq OWNED BY lifts.lift_id;


--
-- Name: ratings; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE ratings (
    rating_id integer NOT NULL,
    rating integer NOT NULL,
    comment character varying(250),
    skirun_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE ratings OWNER TO vagrant;

--
-- Name: ratings_rating_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE ratings_rating_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ratings_rating_id_seq OWNER TO vagrant;

--
-- Name: ratings_rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE ratings_rating_id_seq OWNED BY ratings.rating_id;


--
-- Name: skill_levels; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE skill_levels (
    level_id integer NOT NULL,
    level character varying(20) NOT NULL
);


ALTER TABLE skill_levels OWNER TO vagrant;

--
-- Name: skill_levels_level_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE skill_levels_level_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE skill_levels_level_id_seq OWNER TO vagrant;

--
-- Name: skill_levels_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE skill_levels_level_id_seq OWNED BY skill_levels.level_id;


--
-- Name: skiruns; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE skiruns (
    skirun_id integer NOT NULL,
    category_id integer,
    groomed boolean,
    status boolean,
    name character varying(200),
    level character varying(200)
);


ALTER TABLE skiruns OWNER TO vagrant;

--
-- Name: skiruns_lifts; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE skiruns_lifts (
    skirun_lift_id integer NOT NULL,
    lift_id integer NOT NULL,
    skirun_id integer NOT NULL
);


ALTER TABLE skiruns_lifts OWNER TO vagrant;

--
-- Name: skiruns_lifts_skirun_lift_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE skiruns_lifts_skirun_lift_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE skiruns_lifts_skirun_lift_id_seq OWNER TO vagrant;

--
-- Name: skiruns_lifts_skirun_lift_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE skiruns_lifts_skirun_lift_id_seq OWNED BY skiruns_lifts.skirun_lift_id;


--
-- Name: skiruns_skirun_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE skiruns_skirun_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE skiruns_skirun_id_seq OWNER TO vagrant;

--
-- Name: skiruns_skirun_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE skiruns_skirun_id_seq OWNED BY skiruns.skirun_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE users (
    user_id integer NOT NULL,
    fname character varying(200) NOT NULL,
    lname character varying(200) NOT NULL,
    email character varying(200) NOT NULL,
    zipcode character varying(200),
    password character varying(64) NOT NULL,
    level_id integer
);


ALTER TABLE users OWNER TO vagrant;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_id_seq OWNER TO vagrant;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: weather; Type: TABLE; Schema: public; Owner: vagrant
--

CREATE TABLE weather (
    weather_id integer NOT NULL,
    daily_snowfall integer,
    overnight_snowfall character varying(150),
    forcast_icon character varying(150),
    wind_forcast character varying(150),
    snow_forcast character varying(150)
);


ALTER TABLE weather OWNER TO vagrant;

--
-- Name: weather_weather_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE weather_weather_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weather_weather_id_seq OWNER TO vagrant;

--
-- Name: weather_weather_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE weather_weather_id_seq OWNED BY weather.weather_id;


--
-- Name: category_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY categories ALTER COLUMN category_id SET DEFAULT nextval('categories_category_id_seq'::regclass);


--
-- Name: catuser_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY catusers ALTER COLUMN catuser_id SET DEFAULT nextval('catusers_catuser_id_seq'::regclass);


--
-- Name: food_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY foods ALTER COLUMN food_id SET DEFAULT nextval('foods_food_id_seq'::regclass);


--
-- Name: FL_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY foods_lifts ALTER COLUMN "FL_id" SET DEFAULT nextval('"foods_lifts_FL_id_seq"'::regclass);


--
-- Name: lift_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY lifts ALTER COLUMN lift_id SET DEFAULT nextval('lifts_lift_id_seq'::regclass);


--
-- Name: rating_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY ratings ALTER COLUMN rating_id SET DEFAULT nextval('ratings_rating_id_seq'::regclass);


--
-- Name: level_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY skill_levels ALTER COLUMN level_id SET DEFAULT nextval('skill_levels_level_id_seq'::regclass);


--
-- Name: skirun_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY skiruns ALTER COLUMN skirun_id SET DEFAULT nextval('skiruns_skirun_id_seq'::regclass);


--
-- Name: skirun_lift_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY skiruns_lifts ALTER COLUMN skirun_lift_id SET DEFAULT nextval('skiruns_lifts_skirun_lift_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Name: weather_id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY weather ALTER COLUMN weather_id SET DEFAULT nextval('weather_weather_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY categories (category_id, cat) FROM stdin;
1	tree
2	groomer
3	park
4	bowl
\.


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('categories_category_id_seq', 4, true);


--
-- Data for Name: catusers; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY catusers (catuser_id, category_id, user_id) FROM stdin;
1	3	1
2	1	2
3	4	2
4	4	3
5	3	3
6	1	3
7	4	4
8	3	4
9	1	4
10	1	5
11	4	5
12	2	6
13	3	7
14	2	8
15	4	9
16	3	9
17	1	9
18	2	9
19	4	10
20	3	10
21	1	10
22	1	11
23	4	11
24	2	12
25	3	13
26	4	14
27	3	14
28	1	14
29	2	14
30	4	15
31	3	15
32	1	15
33	4	16
34	3	16
35	1	16
36	1	17
37	4	17
38	4	18
39	3	18
40	4	19
41	3	19
42	3	20
43	2	21
44	3	22
45	3	23
46	2	24
47	4	25
48	3	25
49	1	25
50	4	26
51	3	26
52	1	26
53	2	26
54	2	27
55	2	28
56	3	29
57	2	30
58	3	31
59	3	32
60	4	33
61	3	33
62	1	33
63	2	33
64	2	34
65	4	35
66	3	35
67	2	36
68	3	37
69	4	38
70	3	38
71	2	39
72	4	40
73	3	40
74	1	40
75	4	41
76	3	41
77	1	41
78	2	41
79	1	42
80	4	42
81	3	43
82	2	44
83	2	45
84	4	46
85	3	46
86	1	46
87	4	47
88	3	47
89	1	47
90	3	48
91	3	49
92	2	50
93	2	51
94	1	52
95	4	52
96	4	53
97	3	53
98	1	53
99	1	54
100	4	54
101	1	55
102	4	55
103	2	56
104	4	57
105	3	57
106	1	57
107	4	58
108	3	58
109	1	58
110	2	59
111	3	60
112	1	61
113	4	61
114	3	62
115	3	63
116	3	64
117	1	65
118	4	65
119	2	66
120	4	67
121	3	67
122	1	67
123	4	68
124	3	68
125	2	69
126	2	70
127	3	71
128	3	72
129	1	73
130	4	73
131	4	74
132	3	74
133	4	75
134	3	75
135	1	75
136	4	76
137	3	76
138	1	76
139	4	77
140	3	77
141	1	77
142	4	78
143	3	78
144	1	78
145	2	78
146	4	79
147	3	79
148	1	79
149	2	79
150	4	80
151	3	80
152	4	81
153	3	81
154	1	81
155	2	81
156	4	82
157	3	82
158	1	82
159	2	83
160	4	84
161	3	84
162	1	84
163	2	84
164	2	85
165	2	86
166	4	87
167	3	87
168	1	87
169	2	88
170	2	89
171	2	90
172	4	91
173	3	91
174	4	92
175	3	92
176	2	93
177	4	94
178	3	94
179	4	95
180	3	95
181	2	96
182	4	97
183	3	97
184	1	97
185	3	98
186	3	99
187	1	100
188	4	100
189	1	101
190	4	101
191	3	101
\.


--
-- Name: catusers_catuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('catusers_catuser_id_seq', 191, true);


--
-- Data for Name: foods; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY foods (food_id, name, description, location) FROM stdin;
1	Fresh Tracks	You're already headed up the mountain, so why not start the day off right with breakfast at the top of Whistler?	f
2	Winemakers Apres Series 	 The popular Winemaker Apres Series at Steeps Grill & Wine Bar atop Whistler Mountain features North America's best wines, paired with locally-sourced culinary delights.	f
3	Christine'S On Blackcomb	Welcome to full-service dining with mountaintop style. Enjoy panoramic views along with classic dishes, prepared with the finest ingredients and a diverse wine list.	f
4	Steeps Grill & Wine Bar	 One of Whistler's full-service dining restaurant, Steeps offers a menu that reflects the fine foods available in British Columbia as well as regional wines in flights, by the glass or bottle. For win	f
5	Chic Pea	Escape the crowds and discover the Chic Pea. Try a toasted flatbread sandwich for lunch or take a break with the kids to sneak in a hot chocolate. You'll find us in the heart of the Family Zone on Whi	f
6	Dusty'S Backside	Begin your day with a hearty breakfast, fresh baking and our cappuccino bar. Just want to get on the mountain(s)? Make a quick pit stop for a grab n' go breakfast for the gondola ride up. Dusty's is o	t
7	Harmony Hut	 Warm up with hot cider and refuel for your next epic run in Harmony Bowl or Symphony Amphitheater (located at 2,115 metres/6,939 feet). 	f
8	Ollies Grilled Cheese Shack 	 Located at Olympic Station (halfway up Whistler Gondola) on Whistler Mountain, Ollies Grilled Cheese shack is the perfect stop for gourmet grilled cheese sandwiches, fries, soups, espresso and snacks	f
9	Raven'S Nest	Raven's Nest is Whistler Blackcomb's first ever all vegetarian restaurant and one of the first of its kind at ski resorts in North America. 	t
10	Roundhouse Lodge	The biggest restaurant in Whistler, and home to our Olympic Legacy display, has three open food courts: Pika's, the Mountain Market and Expressway—featuring a great variety of traditional and intern	f
11	Crystal Hut	 Crystal Hut is a cozy log cabin on Crystal Ridge famous for all-day Belgian waffles and wood-oven baked lunch specialties. Recognized by Sunset Magazine as a Top-10 Mountaintop Restaurant, it sits hi	f
12	Glacier Creek Lodge	 Glacier Creek Lodge is a spectacular, spacious setting with floor-to-ceiling windows and ample seating. You'll find a diverse menu including a fresh sandwich bar and the popular Japanese Udon Noodle 	t
13	Horstman Hut	Horstman Hut is a European-style hut with specialty stews, meats and soups. Enjoy sunny day BBQs on our ridge-top patio, at the top of Blackcomb Mountain. Take Horstman T-Bar or 7th Heaven Express to 	f
14	Rendezvous Lodge	The Rendezvous Lodge's latest menu includes a wok station dishing up customized southeast Asian noodle and rice bowls; a fresh Mexican counter with burritos, tacos and salads; a burger bar using only 	f
15	Rendezvous Lodge	The Rendezvous Lodge's latest menu includes a wok station dishing up customized southeast Asian noodle and rice bowls; a fresh Mexican counter with burritos, tacos and salads; a burger bar using only 	f
16	The Glc 	 Rated one of North America's best après bars by SKI magazine, the GLC is a great choice for groups that are looking for a sophisticated lounge-style restaurant.	f
17	Merlin'S Bar & Grill	One of the most famous party venues in Whistler awaits, amidst incredible views of Blackcomb Mountain, both inside and out.	t
18	Dubh Linn Gate 	 "The Dubh Linn Gate Pubs in Whistler and Vancouver, BC feature live music, traditional Irish fare and the best selection of beer and whiskey on this side of the Atlantic.	t
19	Cinnamon Bear Grille	Refined Hilton eatery serving traditional breakfast, pub grub & Pacific Northwest cuisine at dinner.	t
20	Wizard Grill	Wizard Grill is a Casual Dining restaurant located in Whistler, British Columbia, Canada.	t
21	Starucks Creekside 	 Starbucks uses the highest quality arabica coffee as the base for its espresso drinks. Learn about our unique coffees and espresso drinks today.	t
\.


--
-- Name: foods_food_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('foods_food_id_seq', 21, true);


--
-- Data for Name: foods_lifts; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY foods_lifts ("FL_id", lift_id, food_id) FROM stdin;
1	15	1
2	15	2
3	2	3
4	15	4
5	17	5
6	18	6
7	26	7
8	16	8
9	5	9
10	15	10
11	9	11
12	6	12
13	11	13
14	2	14
15	21	15
16	15	16
17	1	17
18	3	18
19	15	19
20	18	20
21	18	21
\.


--
-- Name: foods_lifts_FL_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('"foods_lifts_FL_id_seq"', 21, true);


--
-- Data for Name: lifts; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY lifts (lift_id, name, status, mountain) FROM stdin;
1	Wizard Express	Closed	Blackcomb
2	Solar Coaster Express	Closed	Blackcomb
3	Excalibur Gondola	Open	Blackcomb
4	Excelerator Express	Closed	Blackcomb
5	Magic Chair	Open	Blackcomb
6	Jersey Cream Express	Closed	Blackcomb
7	Catskinner Chair	Closed	Blackcomb
8	Peak 2 Peak Gondola	Closed	Blackcomb
9	Crystal Ridge Express	Closed	Blackcomb
10	Glacier Express	Closed	Blackcomb
11	7th Heaven Express	Closed	Blackcomb
12	Showcase T-Bar	Closed	Blackcomb
13	Horstman T-Bar	Closed	Blackcomb
14	Coca-Cola Tube Park	Open	Blackcomb
15	Whistler Village Gondola	Closed	Whistler
16	Fitzsimmons Express	Closed	Whistler
17	Garbanzo Express	Closed	Whistler
18	Creekside Gondola	Closed	Whistler
19	Big Red Express	Closed	Whistler
20	Emerald Express	Closed	Whistler
21	Peak 2 Peak Gondola	Closed	Whistler
22	Olympic Chair	Closed	Whistler
23	Franz's Chair	Closed	Whistler
24	Peak Express	Closed	Whistler
25	Harmony 6 Express	Closed	Whistler
26	Symphony Express	Closed	Whistler
27	T-Bars	Closed	Whistler
\.


--
-- Name: lifts_lift_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('lifts_lift_id_seq', 27, true);


--
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY ratings (rating_id, rating, comment, skirun_id, user_id) FROM stdin;
1	5	Prices in Whistler actual for housing would be an issue so you would likely be living in Pemberton or down towards Squamish \n	25	37
2	1	\nSquamish will give you the best value and is a nice compromise between being close to the mountains and the city. \n	11	63
3	1	\nI've lived in all these places.\n\nKelowna was where I was born and raised so It has a special place in my heart. Kelowna is great year round	15	82
4	4	\nI don't think whistler in a rental would be the ideal place for a family with a young baby imo. It's a resort town. You'd be better looking	131	1
5	3	\nSquamish. It's exactly what you're looking for. Whistler has better restaurants, but it's nothing compared to Vancouver. You want to be clo	98	59
6	2	\nNorth Vancouver would be ideal. Tons of great elementary and high schools as well as the local mountains!\n	56	1
7	2	\nI live in Vancouver, but go to Whistler to snowboard a lot. I would suggest Whistler or Squamish based on what you have said about your int	11	33
8	3	\nI live in Vancouver, my parents have a place in Whistler and inlaws are in the Okanagan, Kamloops though but I have some insight for Kelown	137	39
9	4	\nWhere do you live in Ireland? Do you like where you live now? Are you looking for a change? What place is most similar to where you live no	41	40
10	5	\nim booked for next week, been riding for 20+ years but never gone heli.  is it worth the $1000?  would you do it in whistler again?\n	96	68
11	3	\nPeople think these are getting a bit spammy, especially sub begging right in the title. Maybe space your submissions out a bit unless you h	71	39
12	5	\nsorry to break it to you, but in whistler thats cl whoopsed as "sluff"\n\nI have been totally buried inbounds (ruby chute) with a sz2 slide w	64	47
13	2	\nSlush/ice at the lower runs?\n	91	74
14	3	\nTrying to plan for my Whistler vacation later this month.. Does the chest strapped go pro give the best forward viewpoint in your opinion?\n	8	84
15	1	\nI was at Whistler from 21st-26th....We got a lot of snow, but visibility on the peaks was not great. Maybe 4 hours total visibility at the 	81	11
16	1	\nHey - you hopped on my lift today! I had to call ski patrol to get them to talk to you at the top - hope you managed to help them out in ta	27	56
17	5	\nIt's been bad for quite a few years now but you are not helping yourself coming in during the height of the season especially when there is	56	35
18	4	\nYou'll need to find housing before you get a job... It's pretty much the only criteria at the moment.\n	113	48
19	1	\nSack off staff housing and find people to live with. So much more fun. \n	44	13
20	5	\n> Do you have any recommendations for me? Is the housing crisis in Whistler still bad or has it settled down? I really don't know I'm heari	123	68
21	4	\nNo one wants to see this\n	25	27
22	2	\nNice editing mate, looks like an awesome day! I get there next week from Australia, it’s been a dream of mine to go to Whistler for the l	48	91
23	1	\nTake the bus, I have a car and the bus is the only way I get around in the winter. Drops you right at the base, and it takes about 4 minute	18	72
24	5	\nBicycle\n	28	87
25	2	\nVery easy to find parking at Base 2. But if you don’t want to drive, you can take the bus or taxi\n	98	91
26	2	\nThere are 4 bus stops in Nordic. \n\n1 just off Highway 99 at the Northern-most Nordic entrance.\n\n1 just at the base of Nordic drive.\n\n1 most	30	32
27	5	\nThanks. Driving will probably be the best way. Couldn't remember just how much parking there was. \n	126	38
28	3	\nVery helpful! Thank you. \n	56	78
29	2	\nI took the whistler taxi every day I was there for this, no problems just give yourself enough time.\n	109	82
30	1	\nWe ended up driving from Nordic drive & parking in lot #1. Only $10CAD for all day & it's a short walk to the Village Gondola. \n	26	23
31	1	\nIf you're by yourself, the whistler shuttle is your best (and cheapest) bet. Google whistler shuttle, and you can reserve a ride. It's $60 	17	29
32	3	\n[Here](https://www.whistler.com/getting-here/road/shuttle/) is a page that has a couple shuttle options. \nThe first two are easiest as the 	25	51
33	5	\nAirport to Whistler\n\nPacific Coach\nWhistler Shuttle\n\nVancouver Downtown(ish): Get on the sky train, pay $4 I think, take the train for 15 m	98	91
34	1	\n$30 the greyhound to Whistler. \n	141	86
35	5	\nDepending on how long you're staying, just renting a car might not be a bad option. I just looked into it for a weekend in march and it was	49	71
36	2	\nWhen the Saddle is groomed, the only way to go is straight down.\n	105	40
37	4	\nRented boards for 8 years, finally bought my own setup (bataleon goliath 2018 w/ Burton cartels) \n\nhttps://www.instagram.com/p/BevlpekhcDU\n	118	64
38	5	\nCan anybody id this jacket? https://imgur.com/a/tj2Pi\n	61	40
39	3	\nWhat's the next bit of gear you're planning to buy, and why that brand/model? \n\nFor me, next up is boots (not sure on model, gotta find a g	62	13
40	4	\nIs it just me or is the Olympic commentary absolutely woeful? Watching slope style and all they seem to be able to do is count spins and mi	62	73
41	5	\nI'm a newish snowboarder guy that's been renting for the past 5 years looking to get my own board and bindings. I already have a pair of bo	89	4
42	5	\nLooking to make first purchase and was looking at a Ride Crook 155. I’m 5’ 11” roughly 245. Is 155 too small or would I have problems	99	15
43	5	\nI currently ride a libtech Travis rice pro 161.5. Looking for a more playful park/butter board, any recommendations? Currently considering 	90	74
44	4	\nTwo questions for today. \n1) I’m on my second year with burton concord boots which are a dual boa boot. I generally only tighten the lowe	76	68
45	4	\nThinking about buying a new board. I mainly ride all mountain/resort; groomers, trees, moguls but not any park. Right now I'm on a Lib Tech	69	98
46	2	\nPretty new snowboarder here buying my first board. Considering a used Burton Hero I found on Craigslist. \n\nIs [this damage on the nose](htt	114	30
47	4	\nI'm looking to get my first board in the coming months. I am still new so I am not positive on what area I want to focus on yet. My boots a	72	65
48	1	\nQuestion about left lower back fatigue:\n\nI can't ride switch yet, so I'm always looking over my left shoulder and my torso is turned down t	64	92
110	2	\nYeah Roundtop! That’s where my school had ski club \n	130	46
49	2	\nHey guys! I currently ride an Arbor A-frame and was looking for a more playful board when I ride with my girlfriend. It would be for practi	123	75
50	2	\nI'm getting old- 48. I only owned 1 board since 1996. A Burton Floater. I just laid it on my floor and it has a slight camber bend. I had t	140	56
51	3	\nIs padding worth it? I'm new to snowboarding and got a set of wrist guards, but my friend told me I should look into getting some padding f	30	24
52	2	\nDoes anyone know what board this is? A friend of mine wants to know if I want to take it off her hands since she got it for free by taking 	111	13
53	2	\nDamn, that's so cool!! \n	130	87
54	4	\nAre we in 3018?\n	30	75
55	2	\nThis was so awesome to watch, I can’t imagine the praise the team who pulled it all off are getting and the raise whoever’s idea it was	124	70
56	5	\nWas waiting for it to say send nudes... someone get on this... all the karma will be yours.\n	7	70
57	3	\nThis is pretty rad\n	20	1
58	2	\nThat was awesome. They should've had more drones loaded with cameras I think\n	87	45
59	1	\nMad\n	94	14
60	2	\nJust watched that part on TV is pretty impressive!\n	119	8
61	4	\nWhen I first saw this gif I thought it was crazy that they went through all the sports!\n\nNope....just snowboarding! ya boys\n	82	11
62	3	\nThis was filmed in December just in case there was inclement weather. \n	72	50
63	4	\nWHAT SORCERY IS THIS\n	127	43
64	3	\n^(Hi, I'm a bot for linking direct images of albums with only 1 image)\n\n**https://i.imgur.com/psELfNH.mp4**\n\n^^[Source](https://github.com/	9	21
65	4	 ^^[Why?](https://github.com/AUTplayed/imguralbumbot/blob/master/README.md) ^^	17	51
66	2	 ^^[Creator](https://np.reddit.com/user/AUTplayed/) ^^	47	94
67	4	 ^^[ignoreme](https://np.reddit.com/message/compose/?to=imguralbumbot&subject=ignoreme&message=ignoreme) ^^	28	20
68	4	 ^^[deletthis](https://np.reddit.com/message/compose/?to=imguralbumbot&subject=delet%20this&message=delet%20this%20du0ksz3) \n	63	85
69	5	\nI kinda feel bad that they actually like these suits, must be hard for them seeing how good the canucks look.\n	132	64
70	3	\nWhat's with the us team and the pants buckled below their  whoopses? Doesn't that affect performance? Isn't that idiotic style about 5 year	24	73
71	1	\nHoly smokes.\n\n\nComing up at 27 now, guess there's still hope for doubles!\n	66	54
72	3	\nlol. I'm nearly 40 now and decided its time to land a backflip.\n\n	95	21
73	1	\nFilthy, man. \n\n\n	20	69
74	2	\nDamn dude, well done! The suspense of not knowing if you landed it for that couple seconds after is well worth it too. Camera guy/chick pic	40	53
75	3	\nI'm 43 and on day 9 of this snowboarding melarky.  There's time?\n	130	29
76	1	\nSick man\n	81	44
77	2	\nClean!\n	68	44
78	2	\nNoice!!!!!!!\n	107	29
79	5	\nThere's still hope! Not quite doubles but here's my 45 year old buddy throwing down https://streamable.com/q0bww\n	136	50
80	2	\nGnarly bro, my dads 55 and still goin strong, u got plenty more time. Sick trick tho!\n	63	84
81	4	\nI'm 47. I'm happy if I get to the bottom without falling over.\n	35	59
82	1	\nLOL i recognize this video, UCI board club? I didn't realize you were almost 40 though...\n	133	10
83	2	\nDaaamn I through a backflip like that too for years but never had the balls to go for a double lol on a jump that size do you just huck it 	124	81
84	3	\nolderboi does a flip x 2\n	18	13
85	4	\nCraig McMorris is the hero we truly need\n	140	82
86	2	\nAll the one guy can talk about is what stance the riders are it’s so annoying\n	61	78
87	3	\nI nearly died when the one guy didn't know what a speed check was.  Then during the same run he acted like he had always known and how dare	57	28
88	4	\nThey are awful. Literally all they know about snowboarding is stance and spins. No mention of corks or anything like that\n	76	75
89	1	\nNeed to get yourselves some BBC commentators, they mentioned his bindings coming off\n	141	16
90	5	\nHoly  whoops. Not giving any credit to the riders. Just being super nitpicky on the smallest things. This guy sounds like he’s never snow	25	51
91	2	\nWant Craig McMorris instead? Get yourself over to olympics.cbc.ca. It might be region locked but you can work your way around that, you hav	108	42
92	5	\nBoth commentators in the US are awful!  Is the color guy the one that keeps counting rotations?  One of them might be British?  The other g	123	66
93	1	\nI heard them say a rider’s run was significantly hurt because he speed checked...... SPEED CHECKED 🤦♂️\n	49	30
94	1	\nThe bbc guys are pretty great, they certainly talked about the binding. \n	64	1
95	5	\nBBC guys are great, they know their stuff and they're keeping it very light hearted. Definitely worth getting a VPN and getting on the BBC 	41	80
96	1	\nHaha I came here to start this thread love you guys.. and they were ragging on riders for coming off early on that first rainbow, which the	11	85
97	4	\nThe Canadian ones aren’t great either, but at least we got a play by play of the Finnish coach knitting at the top. \n	56	65
98	2	\n whoops yeah man!  Such a fun trick.  Keep on sending it!\n	126	7
99	2	\nNice Man! How did you go about learning a spin/flip like This? I'm already nervous enough when it comes to just spinning, I can't imagine t	20	73
100	3	\nRodeos are my favorite trick to watch! As I'm old and I can't do them :(\n\n\n But that was sick!!!\n	89	12
101	4	\nDope! \n	63	24
102	1	\nAye this at roundtop PA ? Local to that spot myself. \n	140	72
103	4	\nShoutout to rmr\n	96	58
104	4	\nI always read titles like this as bull whoops Rodeo. And then I watch the video and think, no, that's not bull whoops. That was really nice	88	50
105	3	\nNice man! I hit roundtop/whitetail almost every weekend!\n	9	49
106	3	\nThat’s sick man wish I could do it \n	37	80
107	5	\nNice!  It already looks pretty good.  A dozen more days doing it and everyone will wonder how you make it look so easy and clean.\n	71	68
108	1	\nAyye u be flexing up liberty too lol\n	53	46
109	4	\nYou doing the contest this Saturday at RT?\n	124	53
111	5	\n whoops I wish my mountain had a night park, 3:30 is way too early for me. I'd love to take a break and then just hit features and drink be	18	45
112	4	\nNice one dude. Looks old school and flippy like they should be. Send it off the bigger side they are way easier when you don't have to Chuc	16	59
113	1	\nDamn you got so much additional air off your pop, thought you were going slow at first. Nice!\n	3	57
114	2	\nWe have Craig McMorris in Canada, so no issue here. You should try to get a Canadian stream. Might be region locked but that can be worked 	88	75
115	2	\nYes. Goofy foot rider btw\n	41	67
116	5	\n"Ohh a hand touch, judges won't like that" "He's not goofy, so hes going the right direction now" "1, 2, 3, and half spins, thats a 1260"..	8	71
117	4	\nI just bought a vpn so I could tune in to CBC. I couldnt take the pain anymore\n	120	11
118	3	\nThe Australian ones are decent\n	33	53
119	1	\nEd leigh commentator for the BBC is pretty good. \n	111	55
120	2	\nThey keep saying it over and over... that difficult to come up with even a little variation  in commentary? \n	65	94
121	4	\nBBC guys are great, definitely worth getting a VPN and getting on their streams\n	93	81
122	2	\nYou have to remember this is a reletively new sport in the Olympics and people may be watching who aren't familiar with the sport, they're 	62	40
123	5	\nI’m just glad that they’ve improved since the days of calling anything “stunts” and “aerials” and “360* rotations” of the f	31	42
124	1	\nDepends where you are.  Canada has Craig Mcmorris, we good.\n	95	20
125	3	\nI'd def crash into that gondola\n	98	17
126	1	\nMethods are awesome. However, imo methods look kinda weird on straight airs. Nice air \n	22	16
127	5	\nI’d totally clip the gondola and go head first into the edge of the jump \n	92	38
128	1	\nGreat video! What stance are you riding, Ryan? \n	13	15
129	2	\nr/mildlyinfurating that I started watching at the end of the first heat, NBC said I only had 5 minutes to watch, and 80% was commercials wh	130	95
130	2	\ni've tried on tramps but i have no idea when i will ever dare trying that on actual snow\n	38	23
131	2	\nNice flip. It's a backflip tho. Underflip would be taking that to switch.\n	128	27
132	3	\nWarning.  Loud.\n\n\n whoops\n\n\nYou\n	130	62
133	5	\nJesus dude I had my headphones off and I still heard it through them.\n	111	9
134	5	\nI'm ready to hop on this bandwagon... where can we get some Donek Ski Poles? Send me a link /u/RyanKnapton\n	79	67
135	4	\nI was teaching a friend how to snowboard 10 years ago and brought along a set of poles for his first day. They were so damn handy, and I di	94	61
136	3	\nSo... would having poles with me actually help me get across flats?\n	83	94
137	1	\nTried snow blades one drunken night, was fun\n	22	58
138	4	\nYep\n	63	23
139	1	\nAnyone here that doesn’t board or ski? Hard to when you live in the south. :(\n	35	15
140	2	\nYeah, I do both. Learned boarding first, was already at an "expert" level (hitting big booters, rails, spins), picked up skiing in like one	81	72
141	2	\nI do up hill.\n	53	85
142	5	\nSure\n	94	47
143	5	\n*raises hand*\n\nNot as good as I snowboard, but I co-coach lessons to adaptive skiers because it's frowned upon for the snowboarders to not 	111	34
144	3	\nI picked up skiing two years ago and love it\n	101	55
145	5	\nYes. I actually learned to how to snowboard and ski at the same time, but I guess if you have to split hairs day one was skiing. I was very	3	86
146	4	\nBanff local, heading out to Lake Louise tomorrow if you are keen!\n	103	22
147	4	\nI’ll be in Banff in 10 days\n	46	69
148	4	\nkillin it\n	7	20
149	3	\nrespect to these ladies for rippin rails. that said i feel like none of them have any style.\n	39	80
150	5	\nTry dropping into the Beckett & Wilde pub in Cham Sud. Great set of guys with local knowledge and a great atmosphere. I go every year and l	29	55
151	3	\nI would probably say Copper. They usually have 2 for 1 deals at local gas stations, but I'm not exactly sure about lodging down there. It c	31	36
152	1	\nYou could stay in Dillon or keystone and go to A Basin. Not too far down the road. I think season p whoops holders at Copper get a few half	122	28
153	1	\nBogus is really easy to get to from Boise. It has some good mixes of terrain and difficulties, with a lot of area to explore. \n\nBe aware th	1	2
154	1	\nTuesday. \n\nThere is no "better" weekend day. Flip a coin. \n	134	15
155	2	\nI prefer Sunday. Traffic getting up there is better and if you stay until last chair and grab apres, traffic should have died down getting 	73	41
156	3	\ncan you please stop posting these dumb whoops videos. \n\nI actually thought he might try it on the top to keep snow from sticking and keep i	131	60
157	5	\nI find it funny the skiers are downvoting that topic, PURELY because i listed the resorts which are skier only with a "-" symbol \n	33	64
158	1	\nWhat size are you? I have a set of Ride Orions in size 10.5 from back in the day. light use. This run big. I am a 11.5 in most boots.  $20 	42	79
159	4	\nI hear the Vans Hi-standard boots are supposedly very soft/flexible. I have them in a 13 and find them to be very comfortable.\n	39	51
160	2	\nNot sure if Burton still makes them but the Moto is a pretty soft boot, I definitely toed the line of breaking my ankles a few times in the	139	35
161	5	\nThanks for all the comments. I'm starting to think that no one currently makes what I'm looking for and will probably have to buy some used	23	82
162	2	\ni’ve thought about this with some dunes not too far away during the summer, it looks like a blast, definitely seeing this renews my inter	101	49
163	2	\nYeah it's not super beginner friendly for boarders, most of the learner slopes have drag lifts which probably isn't a good idea for someone	136	70
164	5	\nYo I sent you a message!\n	15	72
165	3	\nHard for me to say without seeing the size of the van, but if it is too tight you could always take off the bindings of all the boards so y	74	27
166	5	\nIf the minivan has pilot seats, what you can do is place the board with the bindings facing in, slide them between the door and the pilot s	72	28
167	5	\nRent a Thule box if you can. Will give you so much more space. \n	47	54
168	4	\nI can think of two options. \n\nSCS shopping mall with stores like Intersport, Hervis, Blue Tomato, XXL Sports..\n\nhttp://scs.at/en\n\n\nor Sport	31	12
169	4	\n\nYou can also hire equipment there.\n\nIf you're looking for used equipment check out [willhaben](http://www.willhaben.at).	89	18
170	4	Hi Rachel!	7	101
171	5	sooo coool	20	101
172	5	yayyyyyyyyyy	3	101
173	5	yayyyyy	9	101
174	5	Hi!!!	12	101
\.


--
-- Name: ratings_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('ratings_rating_id_seq', 174, true);


--
-- Data for Name: skill_levels; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY skill_levels (level_id, level) FROM stdin;
1	green
2	blue
3	black
\.


--
-- Name: skill_levels_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('skill_levels_level_id_seq', 3, true);


--
-- Data for Name: skiruns; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY skiruns (skirun_id, category_id, groomed, status, name, level) FROM stdin;
2	2	f	t	Crabapple	Blue
3	2	t	t	Expressway	Green
4	2	f	t	Fantastic Lower	Blue
5	2	t	t	Fantastic Upper	Green
6	2	f	t	Northern Lights	Blue
7	2	t	t	Olympic - Lower	Green
8	2	t	t	Olympic - Mid	Green
10	2	t	t	Scampland (CLC)	Green
11	2	f	t	Club 21	Black
12	2	f	t	Cougar Park, Sz XS, S	TerrainPark
13	2	f	t	Coyote	Blue
14	4	t	t	Ego Bowl - Lower	Green
15	4	t	t	Ego Bowl - Upper	Green
16	1	f	t	Enchanted Forest	Blue
18	2	f	t	Goat's Gully	Black
19	2	t	t	Green Acres	Green
20	3	f	t	Habitat Terrain Park	TerrainPark
21	2	f	t	In Deep	Black
22	2	f	t	Jolly Green Giant	Blue
23	2	t	t	Marmot	Green
24	2	t	t	Old Crow	Blue
25	2	f	f	Ptarmigan	Blue
26	2	f	f	Ptarmigan - Top	Black
27	2	f	t	Ratfink	Black
28	2	t	t	Ratfink - Lower 	Blue
29	2	t	t	Raven	Black
30	2	f	t	Seppo's	Black
32	2	t	t	Sidewinder	Green
33	2	t	t	The School Yard	Green
34	2	f	t	Unsanctioned	Black
35	2	t	t	Whiskey Jack - Lower	Green
36	2	t	t	Whiskey Jack - Upper	Green
37	2	f	t	Crossroads	Blue
39	2	f	t	Fallaway	Black
40	1	f	t	Franz's - Lower	Blue
41	2	f	t	Powerline	Black
42	2	t	t	SS Kids Carpet	Green
43	2	t	t	Banana Peel	Blue
44	2	t	t	Bear Cub	Green
46	2	t	t	Dave Murray - Upper	Black
47	2	t	t	Fisheye	Blue
48	1	t	t	Franz's - Upper	Blue
49	2	f	t	Franz's Meadows	Black
50	2	f	t	Jimmy's Joker	Black
51	2	f	t	Little Red Run	Blue
52	2	f	t	Old Man	Blue
53	2	t	t	Orange Peel	Blue
54	2	t	t	Papoose	Green
56	2	t	t	Porcupine	Green
57	2	t	t	Tokum	Blue
58	2	f	t	Wild Card	Black
59	2	f	t	Back Bowl	Black
60	2	f	t	Boomer Bowl	Black
62	2	f	t	Camel Humps	Black
63	2	f	t	Chunky's Choice	Black
64	2	f	t	G.S.	Blue
65	2	f	t	Harmony Outruns	Black
66	2	f	t	Harmony Piste	Blue
67	2	f	t	Harmony Ridge	Blue
68	2	f	t	Krumholz	Blue
70	2	f	t	Low Roll	Black
71	2	f	t	McConkey's - Lower	Black
72	2	t	t	Pika's Traverse	Green
73	4	f	t	Rhapsody Bowl	Blue
74	2	f	t	Robertson's	Black
75	2	f	t	Sun Bowl	Black
77	2	f	t	The Glades	Blue
78	2	f	t	Bagel Bowl	Black
79	2	f	t	Big Timber	Black
80	2	f	t	Cockalorum	DoubleBlack
81	2	f	t	Doom & Gloom	Black
83	2	f	t	Frog Hollow	Black
84	2	f	t	Grand Finale	Black
85	2	f	t	Headwall	Blue
86	2	t	t	Highway 86	Blue
87	2	f	t	Home Run	Black
88	2	f	t	Kadenwood Trail	Blue
89	2	f	t	Left Hook	Black
91	2	f	t	Monday's	DoubleBlack
92	2	f	t	Peak to Creek - Lower	Blue
93	2	t	t	Peak to Creek - Upper	Blue
94	2	f	t	Ridge Run	Blue
95	2	t	t	Saddle- Last Chance	Blue
96	2	f	t	Shale Slope	Black
98	2	f	t	Surprise	Black
99	2	t	t	T-Bar Run	Blue
100	2	f	t	The Cirque	DoubleBlack
101	2	f	t	West Bowl	Black
102	2	f	t	West Cirque	DoubleBlack
103	2	f	t	West Ridge	Black
105	2	t	t	Adagio - Lower	Blue
106	2	f	t	Adagio - Upper	Blue
107	2	f	t	Encore Ridge	Blue
108	2	f	t	Flute Bowl	DoubleBlack
109	2	t	t	Flute Rd.	Green
110	2	t	t	Glissando	Blue
112	2	t	t	Jeff’s Ode To Joy	Blue
113	2	f	t	North Flute Bowl	DoubleBlack
114	4	f	t	Rhapsody Bowl	Blue
115	2	f	t	Staccato Glades	Blue
116	2	t	t	Symphony Roads	Green
117	2	t	t	Cruiser - Lower	Blue
118	2	f	t	Gear Jammer - Lower	Blue
120	2	f	t	Gondola Road	Green
121	2	t	t	Green Line	Green
122	2	f	t	Grubstake	Blue
123	2	f	t	Home Run	Blue
124	2	f	t	Mainline	Blue
125	2	t	t	Merlins	Blue
126	2	f	t	Merlins	Blue
127	2	t	t	Never Ever - Base 2	Green
128	2	t	t	Schoolmarm	Blue
130	2	t	t	Side Line	Green
131	2	f	t	Tube Park	Green
132	2	t	t	Tube Park ByPass	Green
133	2	t	t	Village Run	Green
135	2	f	f	18' Half Pipe	TerrainPark
136	2	f	t	Bark Sandwich	Black
137	3	t	t	Big Easy Terrain Garden, Sz S	TerrainPark
138	2	f	t	Black Magic	Black
139	2	f	t	Catskinner - Upper	Black
141	2	f	t	Count-Down	Green
142	2	f	t	Cruiser - Rolls	Blue
143	2	f	t	Cruiser - Upper	Blue
1	2	t	t	Adult Learning- Supercarpet	Green
9	2	t	t	Olympic - Upper	Green
17	2	t	t	Enchanted Forest Adventure Zone	Blue
31	2	f	t	Side Order	Black
38	2	t	t	Dave Murray - Lower	Black
45	2	f	t	Bear Paw	Black
55	2	t	t	Pony Trail	Green
61	2	t	t	Burnt Stew	Green
69	2	f	t	Little Whistler	Black
76	2	f	t	Symphony Bowl	Blue
82	2	f	t	Dusty's Descent	Black
90	2	t	t	Mathew's Traverse	Blue
97	2	f	t	Stephan's Chute	DoubleBlack
104	2	f	t	Whistler Bowl	Black
111	2	f	t	Glissando Glades	Blue
119	2	f	t	Gear Jammer - Upper	Blue
129	2	f	t	Short Horn	Blue
134	2	t	t	Yellow Brick Road	Green
140	2	t	t	Connector	Blue
144	2	f	t	Cruiser Bumps	Black
145	2	t	t	Easy Out	Green
146	2	f	t	Expresso	Green
147	2	f	t	Free Fall	Black
148	2	f	t	Gnarly Knots	Black
149	3	t	t	Highest Level Park, Sz XL	TerrainPark
150	2	t	t	Honeycomb	Blue
151	2	t	t	Last Resort	Green
152	2	f	t	Little Cub	Black
153	3	t	t	Nintendo Terrain Park, sz. M,L	TerrainPark
154	2	f	t	Pruned Paradise	Black
155	2	f	t	Racers Alley	Black
156	2	f	t	Raptor's Ride	Black
157	2	f	t	Renegade	Black
158	2	t	t	Ross's Gold	Blue
159	2	t	t	Sling Shot	Blue
160	2	f	t	So Sweet	Black
161	2	f	t	Sorcerer	Black
162	2	t	t	Springboard - Lower	Blue
163	2	t	t	Springboard - Mid-Upper	Blue
164	2	f	t	Stoker	Blue
165	2	f	t	Stoker Bumps	Black
166	2	t	t	Sunset Boulevard	Green
167	2	f	t	Undercut	Green
168	2	f	t	Watch Out	Black
169	2	f	t	Where's Joe	Black
170	2	t	t	X Course	Black
171	2	f	t	Yard Sale	Black
172	2	f	t	Blowdown	Black
173	2	t	t	Buzzcut	Blue
174	2	t	t	Cougar Milk	Blue
175	2	t	t	GMC Race Centre	Blue
176	2	t	t	Green Line	Green
177	2	t	t	Jersey Cream	Blue
178	4	t	t	Jersey Cream Bowl	Blue
179	2	t	t	Jersey Cream Road	Green
180	2	f	t	Jersey Cream Wall	Black
181	2	t	t	Wishbone	Blue
182	2	t	t	Wishbone - Right	Blue
183	2	t	t	Zig Zag	Blue
184	2	t	t	7th Avenue	Green
185	2	f	t	Angel Dust	Black
186	2	t	t	Cloud 9 - Lower	Blue
187	2	t	t	Cloud 9 - Upper	Blue
188	2	f	t	Everglades	Black
189	2	t	t	Expressway	Blue
190	2	t	t	Green Line	Green
191	2	t	t	Hugh's Heaven – Lower	Blue
192	2	t	t	Hugh's Heaven – Upper	Blue
193	2	f	t	Lakeside Bowl	Black
194	2	t	t	Panorama - Lower	Blue
195	2	t	t	Panorama - Upper	Blue
196	2	f	t	Sluiceway	Blue
197	2	f	t	Sunburn	Black
198	2	f	t	Xhiggy's Meadow	Black
199	2	f	t	Arthur's Choice	Black
200	2	f	t	Backstage Pass	Blue
201	2	t	t	Blackcomb Glacier Road	Blue
202	2	t	t	Crystal Glide	Blue
203	2	t	t	Crystal Rd	Green
204	2	f	t	In the Spirit	Black
205	2	f	t	Log Jam	Black
206	2	f	t	Outer limits	DoubleBlack
207	2	t	t	Rescue Rd	Blue
208	2	f	t	Rider's Revenge	Black
209	2	t	t	Ridge Runner	Blue
210	1	f	t	Rock & Roll	Blue
211	2	t	t	Trapline - Lower	Blue
212	2	t	t	Trapline - Upper	Blue
213	2	t	t	Twist & Shout	Blue
214	2	f	t	White Light - Lower	Blue
215	2	f	t	Blackcomb Glacier	Black
216	2	f	t	Blow Hole	DoubleBlack
217	2	t	t	Blueline	Blue
218	2	f	t	Brownlie Basin	Black
219	2	t	t	Crystal Traverse	Green
220	2	f	t	Dakine	Black
221	2	f	t	Davies Dervish	Black
222	2	f	t	Diamond Bowl	DoubleBlack
223	2	f	t	Garnet Bowl	DoubleBlack
224	2	f	t	Glacier Drive	Black
225	2	t	t	Horstman Glacier	Blue
226	2	t	t	Horstman T-Bar Skier Left	Blue
227	2	f	t	Overbite	Black
228	2	f	t	Pakalolo	DoubleBlack
229	2	f	t	Quasar	Black
230	2	f	t	Ruby Bowl	DoubleBlack
231	2	f	t	Saphire Bowl	DoubleBlack
232	2	f	t	Saudan Couloir	DoubleBlack
233	2	f	t	Secret Bowl	Black
234	2	f	t	Secret Chute	Black
235	2	t	t	Showcase (Skiers Left)	Blue
236	2	f	t	Showcase Face (Skiers Right)	Blue
237	2	f	t	Staircase	Black
238	2	f	t	Sylvain	DoubleBlack
239	2	f	t	The Bite	Black
240	2	f	t	The Next Level	Black
\.


--
-- Data for Name: skiruns_lifts; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY skiruns_lifts (skirun_lift_id, lift_id, skirun_id) FROM stdin;
1	15	1
2	15	2
3	15	3
4	15	4
5	15	5
6	15	6
7	15	7
8	15	8
9	15	9
10	15	10
11	22	1
12	22	2
13	22	3
14	22	4
15	22	5
16	22	6
17	22	7
18	22	8
19	22	9
20	22	10
21	16	1
22	16	2
23	16	3
24	16	4
25	16	5
26	16	6
27	16	7
28	16	8
29	16	9
30	16	10
31	20	11
32	20	12
33	20	13
34	20	14
35	20	15
36	20	16
37	20	17
38	20	18
39	20	19
40	20	20
41	20	21
42	20	22
43	20	23
44	20	24
45	20	25
46	20	26
47	20	27
48	20	28
49	20	29
50	20	30
51	20	31
52	20	32
53	20	33
54	20	34
55	20	35
56	20	36
57	17	11
58	17	12
59	17	13
60	17	14
61	17	15
62	17	16
63	17	17
64	17	18
65	17	19
66	17	20
67	17	21
68	17	22
69	17	23
70	17	24
71	17	25
72	17	26
73	17	27
74	17	28
75	17	29
76	17	30
77	17	31
78	17	32
79	17	33
80	17	34
81	17	35
82	17	36
83	18	37
84	18	38
85	18	39
86	18	40
87	18	41
88	18	42
89	19	43
90	19	44
91	19	45
92	19	46
93	19	47
94	19	48
95	19	49
96	19	50
97	19	51
98	19	52
99	19	53
100	19	54
101	19	55
102	19	56
103	19	57
104	19	58
105	23	43
106	23	44
107	23	45
108	23	46
109	23	47
110	23	48
111	23	49
112	23	50
113	23	51
114	23	52
115	23	53
116	23	54
117	23	55
118	23	56
119	23	57
120	23	58
121	17	43
122	17	44
123	17	45
124	17	46
125	17	47
126	17	48
127	17	49
128	17	50
129	17	51
130	17	52
131	17	53
132	17	54
133	17	55
134	17	56
135	17	57
136	17	58
137	25	59
138	25	60
139	25	61
140	25	62
141	25	63
142	25	64
143	25	65
144	25	66
145	25	67
146	25	68
147	25	69
148	25	70
149	25	71
150	25	72
151	25	73
152	25	74
153	25	75
154	25	76
155	25	77
156	24	78
157	24	79
158	24	80
159	24	81
160	24	82
161	24	83
162	24	84
163	24	85
164	24	86
165	24	87
166	24	88
167	24	89
168	24	90
169	24	91
170	24	92
171	24	93
172	24	94
173	24	95
174	24	96
175	24	97
176	24	98
177	24	99
178	24	100
179	24	101
180	24	102
181	24	103
182	24	104
183	27	78
184	27	79
185	27	80
186	27	81
187	27	82
188	27	83
189	27	84
190	27	85
191	27	86
192	27	87
193	27	88
194	27	89
195	27	90
196	27	91
197	27	92
198	27	93
199	27	94
200	27	95
201	27	96
202	27	97
203	27	98
204	27	99
205	27	100
206	27	101
207	27	102
208	27	103
209	27	104
210	26	105
211	26	106
212	26	107
213	26	108
214	26	109
215	26	110
216	26	111
217	26	112
218	26	113
219	26	73
220	26	115
221	26	116
222	3	117
223	3	118
224	3	119
225	3	120
226	3	121
227	3	122
228	3	87
229	3	124
230	3	125
231	3	127
232	3	128
233	3	129
234	3	130
235	3	131
236	3	132
237	3	133
238	3	134
239	1	117
240	1	118
241	1	119
242	1	120
243	1	121
244	1	122
245	1	87
246	1	124
247	1	125
248	1	127
249	1	128
250	1	129
251	1	130
252	1	131
253	1	132
254	1	133
255	1	134
256	4	135
257	4	136
258	4	137
259	4	138
260	4	139
261	4	140
262	4	141
263	4	142
264	4	143
265	4	144
266	4	145
267	4	146
268	4	147
269	4	148
270	4	149
271	4	150
272	4	151
273	4	152
274	4	153
275	4	154
276	4	155
277	4	156
278	4	157
279	4	158
280	4	159
281	4	160
282	4	161
283	4	162
284	4	163
285	4	164
286	4	165
287	4	166
288	4	167
289	4	168
290	4	169
291	4	170
292	4	171
293	2	135
294	2	136
295	2	137
296	2	138
297	2	139
298	2	140
299	2	141
300	2	142
301	2	143
302	2	144
303	2	145
304	2	146
305	2	147
306	2	148
307	2	149
308	2	150
309	2	151
310	2	152
311	2	153
312	2	154
313	2	155
314	2	156
315	2	157
316	2	158
317	2	159
318	2	160
319	2	161
320	2	162
321	2	163
322	2	164
323	2	165
324	2	166
325	2	167
326	2	168
327	2	169
328	2	170
329	2	171
330	7	135
331	7	136
332	7	137
333	7	138
334	7	139
335	7	140
336	7	141
337	7	142
338	7	143
339	7	144
340	7	145
341	7	146
342	7	147
343	7	148
344	7	149
345	7	150
346	7	151
347	7	152
348	7	153
349	7	154
350	7	155
351	7	156
352	7	157
353	7	158
354	7	159
355	7	160
356	7	161
357	7	162
358	7	163
359	7	164
360	7	165
361	7	166
362	7	167
363	7	168
364	7	169
365	7	170
366	7	171
367	6	172
368	6	173
369	6	174
370	6	175
371	6	121
372	6	177
373	6	178
374	6	179
375	6	180
376	6	181
377	6	182
378	6	183
379	11	184
380	11	185
381	11	186
382	11	187
383	11	188
384	11	3
385	11	121
386	11	191
387	11	192
388	11	193
389	11	194
390	11	195
391	11	196
392	11	197
393	11	198
394	9	199
395	9	200
396	9	201
397	9	202
398	9	203
399	9	204
400	9	205
401	9	206
402	9	207
403	9	208
404	9	209
405	9	210
406	9	211
407	9	212
408	9	213
409	9	214
410	12	215
411	12	216
412	12	217
413	12	218
414	12	219
415	12	220
416	12	221
417	12	222
418	12	223
419	12	224
420	12	225
421	12	226
422	12	227
423	12	228
424	12	229
425	12	230
426	12	231
427	12	232
428	12	233
429	12	234
430	12	235
431	12	236
432	12	237
433	12	238
434	12	239
435	12	240
\.


--
-- Name: skiruns_lifts_skirun_lift_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('skiruns_lifts_skirun_lift_id_seq', 435, true);


--
-- Name: skiruns_skirun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('skiruns_skirun_id_seq', 240, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY users (user_id, fname, lname, email, zipcode, password, level_id) FROM stdin;
1	Allen	Rojas	ut.sem.Nulla@ipsumPhasellusvitae.com	299823	123	2
2	Declan	Horne	feugiat.placerat.velit@euelit.com	32775	123	2
3	Guy	Williamson	dolor@Maurisvel.org	5788	123	1
4	Imelda	Roman	nonummy.ut.molestie@sedest.org	43903	123	3
5	Suki	Barber	scelerisque.sed.sapien@vitaeodio.com	8545	123	1
6	Julie	Webb	pharetra.ut@seddolor.edu	9533	123	3
7	Kirsten	Barron	tristique.senectus.et@Mauris.com	6753	123	1
8	Quintessa	Conway	odio@Utnecurna.com	15213	123	3
9	Shafira	Graves	in.cursus@inconsequat.net	H3E 4P1	123	1
10	Breanna	Malone	vestibulum.Mauris@consectetueradipiscing.net	2248	123	3
11	Kermit	Hartman	quis@in.net	2965	123	3
12	Jada	Craft	cursus.purus.Nullam@magna.com	09883	123	2
13	Jin	Barker	nulla.In@Quisque.edu	2543	123	3
14	Yvette	Herrera	Suspendisse.sed@Sed.com	61021	123	2
15	Jada	Shepherd	sed@ipsumprimisin.com	58778	123	1
16	Herman	Hamilton	vel.mauris.Integer@odioapurus.ca	42108	123	3
17	Sarah	Ingram	enim@lectus.com	96885	123	3
18	Jeanette	Spears	neque.Morbi.quis@nec.net	25053	123	3
19	Beatrice	Jarvis	vestibulum@parturientmontesnascetur.com	0330 FZ	123	3
20	Ayanna	French	ligula.Aenean.euismod@In.edu	11413	123	1
21	Calista	Park	molestie@elitAliquam.com	H5X 6B3	123	1
22	Hakeem	Burks	orci.Ut.semper@nequeInornare.edu	54713	123	3
23	Orson	Mclean	vitae@montesnasceturridiculus.net	74-433	123	2
24	Wylie	David	Phasellus@noncursusnon.org	99693	123	2
25	Chanda	Ford	tellus.Phasellus@quismassaMauris.net	85-343	123	2
26	Ursula	Hale	penatibus.et@estNunclaoreet.net	39921	123	2
27	Zane	Walls	ipsum.Suspendisse.non@diam.org	25768-193	123	3
28	Kuame	Rhodes	semper@rutrumjustoPraesent.net	K3A 3P3	123	3
29	Carlos	Carney	erat.vel.pede@et.com	74143	123	2
30	Mark	Vargas	vulputate.lacus@vulputatevelit.ca	9333	123	3
31	Germaine	Hart	magnis.dis.parturient@disparturientmontes.com	3673	123	1
32	Sara	Mcdowell	convallis.dolor@pharetra.net	ZX75 7DY	123	2
33	Neil	Reeves	morbi.tristique@orcilobortis.ca	70701	123	1
34	Charity	Hines	Integer.urna@sodaleseliterat.edu	75863	123	2
35	Emmanuel	Glover	justo@magna.net	7493	123	3
36	Chandler	Richmond	quis@velit.ca	17093	123	3
37	Remedios	Montoya	metus.sit.amet@Uttincidunt.edu	3873	123	3
38	Ulla	Graham	metus@metusurna.com	3473	123	1
39	Damian	Henderson	Aenean.egestas@eleifendCrassed.org	38-133	123	2
40	Chancellor	Cash	mauris.erat.eget@volutpatnunc.com	29277-143	123	3
41	Wayne	Barber	lobortis@molestieorci.org	93181	123	1
42	Elijah	Spence	in.cursus.et@risus.com	51795	123	3
43	Hammett	Soto	vestibulum.nec.euismod@utlacusNulla.ca	7223	123	2
44	Justina	Grimes	Aenean.eget@odioauctorvitae.edu	7983	123	1
45	Hayfa	Wolf	at.fringilla@nonjusto.ca	20107	123	3
46	Ferdinand	York	magna@ligula.net	885848	123	2
47	Ralph	Cox	sociis.natoque.penatibus@egestas.edu	04103	123	1
48	Amber	Dunn	Nullam.velit.dui@ultricesposuerecubilia.ca	7263	123	2
49	Tanisha	Parrish	Vestibulum@aliquet.ca	7513 WJ	123	3
50	Serena	Navarro	lacus@est.com	52-273	123	2
51	Barclay	Wilcox	vitae.sodales.nisi@cursusnonegestas.com	75197	123	2
52	Isaac	Rose	libero.Morbi.accumsan@augueeutempor.com	95875	123	2
53	Quon	Robertson	augue@eget.org	13578	123	3
54	Kessie	Gilliam	in.lobortis@Curabiturut.ca	5135	123	2
55	Alexandra	Foreman	Quisque.ornare.tortor@convallisantelectus.ca	69847	123	2
56	Benedict	Mcbride	pede.nec.ante@maurisSuspendissealiquet.net	50603	123	1
57	Baxter	Wood	neque@Aeneansed.com	72153	123	2
58	Desiree	Burt	at.pretium.aliquet@fames.com	2230 ZD	123	1
59	Harlan	Weeks	molestie.tortor@consectetuer.com	627613	123	1
60	Rae	Sampson	Cras.dictum.ultricies@enim.net	115853	123	1
61	Beatrice	Hahn	arcu.Vestibulum@ultrices.com	60165	123	3
62	Abel	Wheeler	Suspendisse@id.com	80753	123	1
63	Ava	Rogers	pretium@ridiculusmusProin.net	TH1 3VG	123	1
64	Cade	Harrell	imperdiet.non.vestibulum@mienimcondimentum.com	603813	123	3
65	Doris	Vega	Proin.vel.arcu@diamProin.edu	51215	123	1
66	Hedwig	Rojas	Aliquam@Phasellus.com	9083	123	3
67	Omar	Martinez	ultricies@lacusEtiam.net	3288	123	3
68	Genevieve	Stanley	orci@blandit.ca	5513	123	3
69	Vera	Lindsey	pede.sagittis@dolor.com	06533	123	2
70	Tate	Johnson	id@magnaUt.org	229077	123	3
71	Gabriel	Donaldson	sem.semper@commodotincidunt.com	57991-323	123	1
72	Iola	Greer	porttitor.scelerisque.neque@vehicularisusNulla.com	21317	123	1
73	Debra	Romero	malesuada.Integer@ametloremsemper.edu	954525	123	2
74	Wynter	Moody	auctor@quisarcu.edu	16293	123	2
75	Sigourney	Anthony	Nulla@egestasAliquam.com	96803	123	1
76	Meghan	Fields	ac@semperduilectus.ca	Q2 9PB	123	3
77	Maryam	Holloway	fringilla@massanonante.edu	91558	123	2
78	Chester	Mcclain	Donec.nibh.enim@Namnullamagna.org	758811	123	3
79	Dominic	Wagner	ipsum.Curabitur@nec.com	W5 4WO	123	3
80	Alyssa	Macias	sollicitudin.orci@Phasellus.org	21603	123	2
81	Harrison	Myers	elementum.at@Duiselementum.org	42-891	123	1
82	Brandon	Hensley	at.nisi.Cum@turpisnecmauris.com	1758	123	2
83	Carissa	Castaneda	in.faucibus@varius.com	60513	123	1
84	Latifah	Simon	amet@ultrices.net	14-091	123	3
85	Ruth	Small	congue.elit.sed@loremvitae.com	02723	123	1
86	Cedric	Sanchez	mattis@AliquamnislNulla.com	94177	123	1
87	Nichole	Irwin	at.iaculis.quis@Nullamut.edu	389853	123	1
88	Avram	Holmes	ridiculus.mus@auguescelerisquemollis.ca	87-203	123	2
89	Camilla	Bruce	Morbi.accumsan@mollisnec.com	3011 QX	123	1
90	Brenden	Tucker	Cras@Integeraliquam.org	5981 EL	123	1
91	Heidi	Wade	erat.nonummy.ultricies@Donec.edu	57753	123	1
92	Jin	Conley	eu.euismod@amet.ca	2198 YW	123	3
93	Rajah	Clark	ultrices.mauris.ipsum@egetlaoreetposuere.net	844213	123	3
94	Cameron	Gill	ipsum@Uttinciduntvehicula.edu	548123	123	1
95	Kevyn	Parrish	dis.parturient.montes@CrasinterdumNunc.edu	968797	123	2
96	Ralph	White	urna.Nunc@ascelerisquesed.edu	52793-653	123	1
97	Faith	Foreman	Nulla@tristiqueac.org	0053	123	1
98	Barrett	Swanson	lorem@sempereratin.org	110903	123	3
99	Daryl	Ramos	vulputate.nisi.sem@consectetuereuismod.edu	ZB5 4PO	123	1
100	Cecilia	Murphy	Duis.mi@feugiatplacerat.com	0135	123	2
101	jade	hayes	Jade.e.Hayes@gmail.com	94610	123	3
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('users_user_id_seq', 101, true);


--
-- Data for Name: weather; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY weather (weather_id, daily_snowfall, overnight_snowfall, forcast_icon, wind_forcast, snow_forcast) FROM stdin;
1	2	1.78	night-snow	Calm	Mainly sunny. 
\.


--
-- Name: weather_weather_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('weather_weather_id_seq', 1, true);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: catusers_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY catusers
    ADD CONSTRAINT catusers_pkey PRIMARY KEY (catuser_id);


--
-- Name: foods_lifts_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY foods_lifts
    ADD CONSTRAINT foods_lifts_pkey PRIMARY KEY ("FL_id");


--
-- Name: foods_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY foods
    ADD CONSTRAINT foods_pkey PRIMARY KEY (food_id);


--
-- Name: lifts_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY lifts
    ADD CONSTRAINT lifts_pkey PRIMARY KEY (lift_id);


--
-- Name: ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (rating_id);


--
-- Name: skill_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY skill_levels
    ADD CONSTRAINT skill_levels_pkey PRIMARY KEY (level_id);


--
-- Name: skiruns_lifts_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY skiruns_lifts
    ADD CONSTRAINT skiruns_lifts_pkey PRIMARY KEY (skirun_lift_id);


--
-- Name: skiruns_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY skiruns
    ADD CONSTRAINT skiruns_pkey PRIMARY KEY (skirun_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: weather_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY weather
    ADD CONSTRAINT weather_pkey PRIMARY KEY (weather_id);


--
-- Name: catusers_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY catusers
    ADD CONSTRAINT catusers_category_id_fkey FOREIGN KEY (category_id) REFERENCES categories(category_id);


--
-- Name: catusers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY catusers
    ADD CONSTRAINT catusers_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: foods_lifts_food_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY foods_lifts
    ADD CONSTRAINT foods_lifts_food_id_fkey FOREIGN KEY (food_id) REFERENCES foods(food_id);


--
-- Name: foods_lifts_lift_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY foods_lifts
    ADD CONSTRAINT foods_lifts_lift_id_fkey FOREIGN KEY (lift_id) REFERENCES lifts(lift_id);


--
-- Name: ratings_skirun_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_skirun_id_fkey FOREIGN KEY (skirun_id) REFERENCES skiruns(skirun_id);


--
-- Name: ratings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY ratings
    ADD CONSTRAINT ratings_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: skiruns_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY skiruns
    ADD CONSTRAINT skiruns_category_id_fkey FOREIGN KEY (category_id) REFERENCES categories(category_id);


--
-- Name: skiruns_lifts_lift_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY skiruns_lifts
    ADD CONSTRAINT skiruns_lifts_lift_id_fkey FOREIGN KEY (lift_id) REFERENCES lifts(lift_id);


--
-- Name: skiruns_lifts_skirun_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY skiruns_lifts
    ADD CONSTRAINT skiruns_lifts_skirun_id_fkey FOREIGN KEY (skirun_id) REFERENCES skiruns(skirun_id);


--
-- Name: users_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_level_id_fkey FOREIGN KEY (level_id) REFERENCES skill_levels(level_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

