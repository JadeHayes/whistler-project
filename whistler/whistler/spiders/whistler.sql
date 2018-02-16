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
\.


--
-- Name: catusers_catuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('catusers_catuser_id_seq', 188, true);


--
-- Data for Name: lifts; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY lifts (lift_id, name, status, mountain) FROM stdin;
1	Wizard Express	Closed	Blackcomb
2	Solar Coaster Express	Closed	Blackcomb
3	Excalibur Gondola	Open	Blackcomb
4	Excelerator Express	Closed	Blackcomb
5	Magic Chair	Closed	Blackcomb
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
1	5	Prices in Whistler actual for housing would be an issue so you would likely be living in Pemberton or down towards Squamish \n	62	77
2	1	\nSquamish will give you the best value and is a nice compromise between being close to the mountains and the city. \n	122	74
3	3	\nI've lived in all these places.\n\nKelowna was where I was born and raised so It has a special place in my heart. Kelowna is great year round	126	81
4	3	\nI don't think whistler in a rental would be the ideal place for a family with a young baby imo. It's a resort town. You'd be better looking	8	19
5	4	\nSquamish. It's exactly what you're looking for. Whistler has better restaurants, but it's nothing compared to Vancouver. You want to be clo	107	3
6	2	\nNorth Vancouver would be ideal. Tons of great elementary and high schools as well as the local mountains!\n	38	10
7	3	\nI live in Vancouver, but go to Whistler to snowboard a lot. I would suggest Whistler or Squamish based on what you have said about your int	59	16
8	4	\nI live in Vancouver, my parents have a place in Whistler and inlaws are in the Okanagan, Kamloops though but I have some insight for Kelown	134	53
9	2	\nWhere do you live in Ireland? Do you like where you live now? Are you looking for a change? What place is most similar to where you live no	17	41
10	2	\nim booked for next week, been riding for 20+ years but never gone heli.  is it worth the $1000?  would you do it in whistler again?\n	44	34
11	2	\nPeople think these are getting a bit spammy, especially sub begging right in the title. Maybe space your submissions out a bit unless you h	33	13
12	3	\nsorry to break it to you, but in whistler thats cl whoopsed as "sluff"\n\nI have been totally buried inbounds (ruby chute) with a sz2 slide w	65	38
13	1	\nSlush/ice at the lower runs?\n	24	68
14	5	\nTrying to plan for my Whistler vacation later this month.. Does the chest strapped go pro give the best forward viewpoint in your opinion?\n	58	43
15	4	\nI was at Whistler from 21st-26th....We got a lot of snow, but visibility on the peaks was not great. Maybe 4 hours total visibility at the 	121	6
16	3	\nHey - you hopped on my lift today! I had to call ski patrol to get them to talk to you at the top - hope you managed to help them out in ta	30	90
17	1	\nIt's been bad for quite a few years now but you are not helping yourself coming in during the height of the season especially when there is	128	92
18	2	\nYou'll need to find housing before you get a job... It's pretty much the only criteria at the moment.\n	21	78
19	4	\nSack off staff housing and find people to live with. So much more fun. \n	58	25
20	4	\n> Do you have any recommendations for me? Is the housing crisis in Whistler still bad or has it settled down? I really don't know I'm heari	53	92
21	2	\nNo one wants to see this\n	127	99
22	5	\nNice editing mate, looks like an awesome day! I get there next week from Australia, it’s been a dream of mine to go to Whistler for the l	68	57
23	3	\nTake the bus, I have a car and the bus is the only way I get around in the winter. Drops you right at the base, and it takes about 4 minute	6	42
24	4	\nBicycle\n	118	59
25	2	\nVery easy to find parking at Base 2. But if you don’t want to drive, you can take the bus or taxi\n	53	83
26	4	\nThere are 4 bus stops in Nordic. \n\n1 just off Highway 99 at the Northern-most Nordic entrance.\n\n1 just at the base of Nordic drive.\n\n1 most	24	15
27	3	\nThanks. Driving will probably be the best way. Couldn't remember just how much parking there was. \n	67	38
28	2	\nVery helpful! Thank you. \n	60	72
29	1	\nI took the whistler taxi every day I was there for this, no problems just give yourself enough time.\n	101	34
30	2	\nWe ended up driving from Nordic drive & parking in lot #1. Only $10CAD for all day & it's a short walk to the Village Gondola. \n	42	35
31	4	\nIf you're by yourself, the whistler shuttle is your best (and cheapest) bet. Google whistler shuttle, and you can reserve a ride. It's $60 	62	13
32	1	\n[Here](https://www.whistler.com/getting-here/road/shuttle/) is a page that has a couple shuttle options. \nThe first two are easiest as the 	5	88
33	5	\nAirport to Whistler\n\nPacific Coach\nWhistler Shuttle\n\nVancouver Downtown(ish): Get on the sky train, pay $4 I think, take the train for 15 m	51	93
34	3	\n$30 the greyhound to Whistler. \n	91	35
35	3	\nDepending on how long you're staying, just renting a car might not be a bad option. I just looked into it for a weekend in march and it was	90	32
36	2	\nWhen the Saddle is groomed, the only way to go is straight down.\n	106	57
37	3	\nRented boards for 8 years, finally bought my own setup (bataleon goliath 2018 w/ Burton cartels) \n\nhttps://www.instagram.com/p/BevlpekhcDU\n	53	15
38	4	\nCan anybody id this jacket? https://imgur.com/a/tj2Pi\n	102	99
39	2	\nWhat's the next bit of gear you're planning to buy, and why that brand/model? \n\nFor me, next up is boots (not sure on model, gotta find a g	105	26
40	4	\nIs it just me or is the Olympic commentary absolutely woeful? Watching slope style and all they seem to be able to do is count spins and mi	112	63
41	5	\nI'm a newish snowboarder guy that's been renting for the past 5 years looking to get my own board and bindings. I already have a pair of bo	117	11
42	1	\nLooking to make first purchase and was looking at a Ride Crook 155. I’m 5’ 11” roughly 245. Is 155 too small or would I have problems	133	94
43	2	\nI currently ride a libtech Travis rice pro 161.5. Looking for a more playful park/butter board, any recommendations? Currently considering 	116	54
44	3	\nTwo questions for today. \n1) I’m on my second year with burton concord boots which are a dual boa boot. I generally only tighten the lowe	99	96
45	4	\nThinking about buying a new board. I mainly ride all mountain/resort; groomers, trees, moguls but not any park. Right now I'm on a Lib Tech	137	65
46	5	\nPretty new snowboarder here buying my first board. Considering a used Burton Hero I found on Craigslist. \n\nIs [this damage on the nose](htt	47	52
47	3	\nI'm looking to get my first board in the coming months. I am still new so I am not positive on what area I want to focus on yet. My boots a	38	29
48	5	\nQuestion about left lower back fatigue:\n\nI can't ride switch yet, so I'm always looking over my left shoulder and my torso is turned down t	1	82
110	4	\nYeah Roundtop! That’s where my school had ski club \n	64	87
49	4	\nHey guys! I currently ride an Arbor A-frame and was looking for a more playful board when I ride with my girlfriend. It would be for practi	83	100
50	5	\nI'm getting old- 48. I only owned 1 board since 1996. A Burton Floater. I just laid it on my floor and it has a slight camber bend. I had t	25	85
51	5	\nIs padding worth it? I'm new to snowboarding and got a set of wrist guards, but my friend told me I should look into getting some padding f	41	20
52	4	\nDoes anyone know what board this is? A friend of mine wants to know if I want to take it off her hands since she got it for free by taking 	88	90
53	3	\nDamn, that's so cool!! \n	124	22
54	5	\nAre we in 3018?\n	10	97
55	2	\nThis was so awesome to watch, I can’t imagine the praise the team who pulled it all off are getting and the raise whoever’s idea it was	103	22
56	3	\nWas waiting for it to say send nudes... someone get on this... all the karma will be yours.\n	95	28
57	3	\nThis is pretty rad\n	94	46
58	1	\nThat was awesome. They should've had more drones loaded with cameras I think\n	128	39
59	5	\nMad\n	74	99
60	2	\nJust watched that part on TV is pretty impressive!\n	1	4
61	1	\nWhen I first saw this gif I thought it was crazy that they went through all the sports!\n\nNope....just snowboarding! ya boys\n	87	23
62	4	\nThis was filmed in December just in case there was inclement weather. \n	126	68
63	1	\nWHAT SORCERY IS THIS\n	50	80
64	3	\n^(Hi, I'm a bot for linking direct images of albums with only 1 image)\n\n**https://i.imgur.com/psELfNH.mp4**\n\n^^[Source](https://github.com/	32	20
65	3	 ^^[Why?](https://github.com/AUTplayed/imguralbumbot/blob/master/README.md) ^^	39	4
66	2	 ^^[Creator](https://np.reddit.com/user/AUTplayed/) ^^	69	15
67	5	 ^^[ignoreme](https://np.reddit.com/message/compose/?to=imguralbumbot&subject=ignoreme&message=ignoreme) ^^	95	82
68	2	 ^^[deletthis](https://np.reddit.com/message/compose/?to=imguralbumbot&subject=delet%20this&message=delet%20this%20du0ksz3) \n	16	4
69	3	\nI kinda feel bad that they actually like these suits, must be hard for them seeing how good the canucks look.\n	56	96
70	4	\nWhat's with the us team and the pants buckled below their  whoopses? Doesn't that affect performance? Isn't that idiotic style about 5 year	18	13
71	4	\nHoly smokes.\n\n\nComing up at 27 now, guess there's still hope for doubles!\n	83	36
72	2	\nlol. I'm nearly 40 now and decided its time to land a backflip.\n\n	11	49
73	2	\nFilthy, man. \n\n\n	123	47
74	3	\nDamn dude, well done! The suspense of not knowing if you landed it for that couple seconds after is well worth it too. Camera guy/chick pic	43	10
75	3	\nI'm 43 and on day 9 of this snowboarding melarky.  There's time?\n	44	96
76	1	\nSick man\n	103	62
77	1	\nClean!\n	135	35
78	1	\nNoice!!!!!!!\n	30	82
79	4	\nThere's still hope! Not quite doubles but here's my 45 year old buddy throwing down https://streamable.com/q0bww\n	105	79
80	3	\nGnarly bro, my dads 55 and still goin strong, u got plenty more time. Sick trick tho!\n	38	19
81	2	\nI'm 47. I'm happy if I get to the bottom without falling over.\n	39	43
82	2	\nLOL i recognize this video, UCI board club? I didn't realize you were almost 40 though...\n	4	50
83	1	\nDaaamn I through a backflip like that too for years but never had the balls to go for a double lol on a jump that size do you just huck it 	59	71
84	4	\nolderboi does a flip x 2\n	38	97
85	5	\nCraig McMorris is the hero we truly need\n	16	76
86	3	\nAll the one guy can talk about is what stance the riders are it’s so annoying\n	90	65
87	3	\nI nearly died when the one guy didn't know what a speed check was.  Then during the same run he acted like he had always known and how dare	122	90
88	2	\nThey are awful. Literally all they know about snowboarding is stance and spins. No mention of corks or anything like that\n	99	24
89	1	\nNeed to get yourselves some BBC commentators, they mentioned his bindings coming off\n	77	17
90	4	\nHoly  whoops. Not giving any credit to the riders. Just being super nitpicky on the smallest things. This guy sounds like he’s never snow	92	8
91	2	\nWant Craig McMorris instead? Get yourself over to olympics.cbc.ca. It might be region locked but you can work your way around that, you hav	120	39
92	4	\nBoth commentators in the US are awful!  Is the color guy the one that keeps counting rotations?  One of them might be British?  The other g	84	39
93	3	\nI heard them say a rider’s run was significantly hurt because he speed checked...... SPEED CHECKED 🤦♂️\n	87	83
94	2	\nThe bbc guys are pretty great, they certainly talked about the binding. \n	61	72
95	3	\nBBC guys are great, they know their stuff and they're keeping it very light hearted. Definitely worth getting a VPN and getting on the BBC 	41	55
96	1	\nHaha I came here to start this thread love you guys.. and they were ragging on riders for coming off early on that first rainbow, which the	85	29
97	4	\nThe Canadian ones aren’t great either, but at least we got a play by play of the Finnish coach knitting at the top. \n	57	87
98	2	\n whoops yeah man!  Such a fun trick.  Keep on sending it!\n	11	47
99	3	\nNice Man! How did you go about learning a spin/flip like This? I'm already nervous enough when it comes to just spinning, I can't imagine t	107	34
100	4	\nRodeos are my favorite trick to watch! As I'm old and I can't do them :(\n\n\n But that was sick!!!\n	39	88
101	4	\nDope! \n	3	18
102	5	\nAye this at roundtop PA ? Local to that spot myself. \n	85	73
103	1	\nShoutout to rmr\n	115	69
104	5	\nI always read titles like this as bull whoops Rodeo. And then I watch the video and think, no, that's not bull whoops. That was really nice	16	9
105	3	\nNice man! I hit roundtop/whitetail almost every weekend!\n	2	31
106	4	\nThat’s sick man wish I could do it \n	72	8
107	1	\nNice!  It already looks pretty good.  A dozen more days doing it and everyone will wonder how you make it look so easy and clean.\n	80	56
108	3	\nAyye u be flexing up liberty too lol\n	125	81
109	2	\nYou doing the contest this Saturday at RT?\n	18	97
111	3	\n whoops I wish my mountain had a night park, 3:30 is way too early for me. I'd love to take a break and then just hit features and drink be	36	96
112	5	\nNice one dude. Looks old school and flippy like they should be. Send it off the bigger side they are way easier when you don't have to Chuc	61	43
113	5	\nDamn you got so much additional air off your pop, thought you were going slow at first. Nice!\n	2	63
114	2	\nWe have Craig McMorris in Canada, so no issue here. You should try to get a Canadian stream. Might be region locked but that can be worked 	30	90
115	1	\nYes. Goofy foot rider btw\n	56	66
116	4	\n"Ohh a hand touch, judges won't like that" "He's not goofy, so hes going the right direction now" "1, 2, 3, and half spins, thats a 1260"..	16	40
117	4	\nI just bought a vpn so I could tune in to CBC. I couldnt take the pain anymore\n	51	41
118	2	\nThe Australian ones are decent\n	95	99
119	3	\nEd leigh commentator for the BBC is pretty good. \n	113	99
120	2	\nThey keep saying it over and over... that difficult to come up with even a little variation  in commentary? \n	129	3
121	4	\nBBC guys are great, definitely worth getting a VPN and getting on their streams\n	94	20
122	5	\nYou have to remember this is a reletively new sport in the Olympics and people may be watching who aren't familiar with the sport, they're 	124	61
123	3	\nI’m just glad that they’ve improved since the days of calling anything “stunts” and “aerials” and “360* rotations” of the f	58	85
124	3	\nDepends where you are.  Canada has Craig Mcmorris, we good.\n	16	89
125	2	\nI'd def crash into that gondola\n	109	61
126	5	\nMethods are awesome. However, imo methods look kinda weird on straight airs. Nice air \n	67	88
127	1	\nI’d totally clip the gondola and go head first into the edge of the jump \n	81	63
128	5	\nGreat video! What stance are you riding, Ryan? \n	12	47
129	1	\nr/mildlyinfurating that I started watching at the end of the first heat, NBC said I only had 5 minutes to watch, and 80% was commercials wh	5	21
130	1	\ni've tried on tramps but i have no idea when i will ever dare trying that on actual snow\n	26	66
131	3	\nNice flip. It's a backflip tho. Underflip would be taking that to switch.\n	38	44
132	4	\nWarning.  Loud.\n\n\n whoops\n\n\nYou\n	115	90
133	3	\nJesus dude I had my headphones off and I still heard it through them.\n	49	82
134	4	\nI'm ready to hop on this bandwagon... where can we get some Donek Ski Poles? Send me a link /u/RyanKnapton\n	114	44
135	5	\nI was teaching a friend how to snowboard 10 years ago and brought along a set of poles for his first day. They were so damn handy, and I di	75	33
136	4	\nSo... would having poles with me actually help me get across flats?\n	92	12
137	1	\nTried snow blades one drunken night, was fun\n	127	6
138	3	\nYep\n	64	40
139	2	\nAnyone here that doesn’t board or ski? Hard to when you live in the south. :(\n	8	49
140	2	\nYeah, I do both. Learned boarding first, was already at an "expert" level (hitting big booters, rails, spins), picked up skiing in like one	38	9
141	5	\nI do up hill.\n	100	20
142	5	\nSure\n	109	89
143	3	\n*raises hand*\n\nNot as good as I snowboard, but I co-coach lessons to adaptive skiers because it's frowned upon for the snowboarders to not 	127	85
144	4	\nI picked up skiing two years ago and love it\n	68	46
145	2	\nYes. I actually learned to how to snowboard and ski at the same time, but I guess if you have to split hairs day one was skiing. I was very	99	95
146	5	\nBanff local, heading out to Lake Louise tomorrow if you are keen!\n	104	38
147	3	\nI’ll be in Banff in 10 days\n	139	62
148	2	\nkillin it\n	95	4
149	1	\nrespect to these ladies for rippin rails. that said i feel like none of them have any style.\n	140	35
150	2	\nTry dropping into the Beckett & Wilde pub in Cham Sud. Great set of guys with local knowledge and a great atmosphere. I go every year and l	75	12
151	3	\nI would probably say Copper. They usually have 2 for 1 deals at local gas stations, but I'm not exactly sure about lodging down there. It c	69	78
152	1	\nYou could stay in Dillon or keystone and go to A Basin. Not too far down the road. I think season p whoops holders at Copper get a few half	60	96
153	5	\nBogus is really easy to get to from Boise. It has some good mixes of terrain and difficulties, with a lot of area to explore. \n\nBe aware th	2	42
154	5	\nTuesday. \n\nThere is no "better" weekend day. Flip a coin. \n	29	5
155	5	\nI prefer Sunday. Traffic getting up there is better and if you stay until last chair and grab apres, traffic should have died down getting 	142	11
156	1	\ncan you please stop posting these dumb whoops videos. \n\nI actually thought he might try it on the top to keep snow from sticking and keep i	21	59
157	4	\nI find it funny the skiers are downvoting that topic, PURELY because i listed the resorts which are skier only with a "-" symbol \n	1	94
158	5	\nWhat size are you? I have a set of Ride Orions in size 10.5 from back in the day. light use. This run big. I am a 11.5 in most boots.  $20 	4	56
159	2	\nI hear the Vans Hi-standard boots are supposedly very soft/flexible. I have them in a 13 and find them to be very comfortable.\n	19	94
160	5	\nNot sure if Burton still makes them but the Moto is a pretty soft boot, I definitely toed the line of breaking my ankles a few times in the	124	62
161	1	\nThanks for all the comments. I'm starting to think that no one currently makes what I'm looking for and will probably have to buy some used	76	53
162	2	\ni’ve thought about this with some dunes not too far away during the summer, it looks like a blast, definitely seeing this renews my inter	67	65
163	3	\nYeah it's not super beginner friendly for boarders, most of the learner slopes have drag lifts which probably isn't a good idea for someone	7	85
164	3	\nYo I sent you a message!\n	39	96
165	1	\nHard for me to say without seeing the size of the van, but if it is too tight you could always take off the bindings of all the boards so y	41	94
166	4	\nIf the minivan has pilot seats, what you can do is place the board with the bindings facing in, slide them between the door and the pilot s	60	6
167	4	\nRent a Thule box if you can. Will give you so much more space. \n	55	61
168	4	\nI can think of two options. \n\nSCS shopping mall with stores like Intersport, Hervis, Blue Tomato, XXL Sports..\n\nhttp://scs.at/en\n\n\nor Sport	14	29
169	4	\n\nYou can also hire equipment there.\n\nIf you're looking for used equipment check out [willhaben](http://www.willhaben.at).	4	59
\.


--
-- Name: ratings_rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('ratings_rating_id_seq', 169, true);


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
6	2	f	t	Northern Lights	Blue
7	2	t	t	Olympic - Lower	Green
8	2	t	t	Olympic - Mid	Green
9	2	t	t	Olympic - Upper	Green
10	2	t	t	Scampland (CLC)	Green
11	2	f	t	Coyote	Blue
12	4	t	t	Ego Bowl - Lower	Green
13	4	t	t	Ego Bowl - Upper	Green
14	1	t	t	Enchanted Forest	Blue
16	2	t	t	Green Acres	Green
17	2	t	t	Marmot	Green
18	2	t	t	Old Crow	Blue
19	2	f	f	Ptarmigan	Blue
20	2	f	f	Ptarmigan - Top	Black
21	2	t	t	Ratfink - Lower 	Blue
22	2	t	t	Raven	Black
23	2	t	t	Sidewinder	Green
24	2	t	t	The School Yard	Green
25	2	t	t	Whiskey Jack - Lower	Green
26	2	t	t	Whiskey Jack - Upper	Green
27	2	t	t	Crossroads	Blue
29	2	t	t	Fallaway	Black
30	1	t	f	Franz's - Lower	Blue
31	2	f	t	Powerline	Black
32	2	t	t	SS Kids Carpet	Green
33	2	t	t	Banana Peel	Blue
34	2	t	t	Bear Cub	Green
36	2	t	t	Dave Murray - Upper	Black
37	2	t	t	Fisheye	Blue
38	1	t	t	Franz's - Upper	Blue
39	2	f	t	Jimmy's Joker	Black
40	2	f	t	Little Red Run	Blue
41	2	t	t	Old Man	Blue
42	2	t	t	Orange Peel	Blue
43	2	t	t	Papoose	Green
45	2	t	t	Porcupine	Green
46	2	f	t	Tokum	Blue
47	2	f	t	Wild Card	Black
48	2	t	t	Burnt Stew	Green
49	2	t	t	G.S.	Blue
51	2	t	t	Harmony Piste	Blue
52	2	t	t	Harmony Ridge	Blue
53	2	t	t	Krumholz	Blue
54	2	f	t	McConkey's - Lower	Black
55	2	t	t	Pika's Traverse	Green
56	2	t	t	Highway 86	Blue
58	2	f	t	Peak to Creek - Lower	Blue
59	2	t	t	Peak to Creek - Upper	Blue
60	2	t	t	Saddle- Last Chance	Blue
61	2	t	t	T-Bar Run	Blue
62	2	t	t	Adagio - Lower	Blue
63	2	t	t	Adagio - Upper	Blue
64	2	f	t	Encore Ridge	Blue
65	2	t	t	Flute Rd.	Green
67	2	t	t	Jeff’s Ode To Joy	Blue
68	4	f	t	Rhapsody Bowl	Blue
69	2	t	t	Symphony Roads	Green
70	2	t	t	Cruiser - Lower	Blue
71	2	t	t	Gear Jammer - Lower	Blue
72	2	f	t	Gear Jammer - Upper	Blue
74	2	t	t	Green Line	Green
75	2	f	t	Grubstake	Blue
76	2	f	t	Home Run	Blue
77	2	f	t	Mainline	Blue
78	2	t	t	Merlins	Blue
79	2	f	t	Merlins	Blue
80	2	t	t	Never Ever - Base 2	Green
81	2	t	t	Schoolmarm	Blue
83	2	t	t	Side Line	Green
84	2	t	t	Tube Park	Green
85	2	t	t	Tube Park ByPass	Green
86	2	t	t	Village Run	Green
88	2	f	f	18' Half Pipe	Black
89	3	t	t	Big Easy Terrain Garden, Sz S	Green
90	2	t	t	Catskinner - Upper	Black
91	2	f	t	Connector	Blue
92	2	t	t	Count-Down	Green
93	2	t	t	Cruiser - Rolls	Blue
95	2	t	t	Easy Out	Green
96	2	f	t	Expresso	Green
97	2	f	t	Free Fall	Black
98	3	t	t	Highest Level Park, Sz XL	Black
99	2	t	t	Honeycomb	Blue
101	3	t	t	Nintendo Terrain Park, sz. M,L	Blue
102	2	t	t	Racers Alley	Black
103	2	t	f	Ross's Gold	Blue
104	2	t	t	Sling Shot	Blue
105	2	t	t	Springboard - Lower	Blue
107	2	t	t	Stoker	Blue
108	2	t	t	Sunset Boulevard	Green
109	2	f	t	Undercut	Green
110	2	t	t	X Course	Black
111	2	f	t	Blowdown	Black
112	2	t	t	Buzzcut	Blue
113	2	t	t	Cougar Milk	Blue
115	2	t	t	Green Line	Green
116	2	t	t	Jersey Cream	Blue
117	4	t	t	Jersey Cream Bowl	Blue
118	2	f	t	Jersey Cream Road	Green
119	2	t	t	Wishbone	Blue
121	2	t	t	Zig Zag	Blue
122	2	t	t	7th Avenue	Green
123	2	t	t	Cloud 9 - Lower	Blue
124	2	t	t	Cloud 9 - Upper	Blue
125	2	t	t	Expressway	Blue
126	2	t	t	Green Line	Green
128	2	t	t	Hugh's Heaven – Upper	Blue
129	2	t	t	Panorama - Lower	Blue
130	2	t	t	Panorama - Upper	Blue
131	2	f	t	Sluiceway	Blue
132	2	t	t	Backstage Pass	Blue
133	2	f	t	Blackcomb Glacier Road	Blue
134	2	t	t	Crystal Glide	Blue
135	2	t	t	Crystal Rd	Green
136	2	f	t	Outer limits	Black
137	2	t	t	Rescue Rd	Blue
138	2	t	t	Ridge Runner	Blue
140	2	t	t	Trapline - Lower	Blue
141	2	t	t	Trapline - Upper	Blue
142	2	t	t	Twist & Shout	Blue
143	2	f	t	White Light - Lower	Blue
1	2	t	t	Adult Learning- Supercarpet	Green
5	2	t	t	Fantastic Upper	Green
15	2	t	t	Enchanted Forest Adventure Zone	Blue
28	2	t	t	Dave Murray - Lower	Black
35	2	t	t	Bear Paw	Black
44	2	t	t	Pony Trail	Green
50	2	t	t	Harmony Outruns	Black
57	2	t	t	Mathew's Traverse	Blue
66	2	t	t	Glissando	Blue
73	2	f	t	Gondola Road	Green
82	2	t	t	Short Horn	Blue
87	2	t	t	Yellow Brick Road	Green
94	2	f	t	Cruiser - Upper	Blue
100	2	t	t	Last Resort	Green
106	2	t	t	Springboard - Mid-Upper	Blue
114	2	t	t	GMC Race Centre	Blue
120	2	t	t	Wishbone - Right	Blue
127	2	t	t	Hugh's Heaven – Lower	Blue
139	1	f	t	Rock & Roll	Blue
144	2	f	t	Blackcomb Glacier	Black
145	2	t	t	Blueline	Blue
146	2	f	t	Brownlie Basin	Black
147	2	t	t	Crystal Traverse	Green
148	2	f	t	Dakine	Black
149	2	f	t	Davies Dervish	Black
150	2	t	t	Glacier Drive	Black
151	2	f	t	Horstman Glacier	Blue
152	2	f	t	Horstman T-Bar Skier Left	Blue
153	2	t	t	Showcase (Skiers Left)	Blue
154	2	t	t	Showcase Face (Skiers Right)	Blue
155	3	t	t	Habitat Terrain Park	Blue
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
47	17	11
48	17	12
49	17	13
50	17	14
51	17	15
52	17	16
53	17	17
54	17	18
55	17	19
56	17	20
57	17	21
58	17	22
59	17	23
60	17	24
61	17	25
62	17	26
63	18	27
64	18	28
65	18	29
66	18	30
67	18	31
68	18	32
69	19	33
70	19	34
71	19	35
72	19	36
73	19	37
74	19	38
75	19	39
76	19	40
77	19	41
78	19	42
79	19	43
80	19	44
81	19	45
82	19	46
83	19	47
84	23	33
85	23	34
86	23	35
87	23	36
88	23	37
89	23	38
90	23	39
91	23	40
92	23	41
93	23	42
94	23	43
95	23	44
96	23	45
97	23	46
98	23	47
99	17	33
100	17	34
101	17	35
102	17	36
103	17	37
104	17	38
105	17	39
106	17	40
107	17	41
108	17	42
109	17	43
110	17	44
111	17	45
112	17	46
113	17	47
114	25	48
115	25	49
116	25	50
117	25	51
118	25	52
119	25	53
120	25	54
121	25	55
122	24	56
123	24	57
124	24	58
125	24	59
126	24	60
127	24	61
128	27	56
129	27	57
130	27	58
131	27	59
132	27	60
133	27	61
134	26	62
135	26	63
136	26	64
137	26	65
138	26	66
139	26	67
140	26	68
141	26	69
142	3	70
143	3	71
144	3	72
145	3	73
146	3	74
147	3	75
148	3	76
149	3	77
150	3	78
151	3	80
152	3	81
153	3	82
154	3	83
155	3	84
156	3	85
157	3	86
158	3	87
159	1	70
160	1	71
161	1	72
162	1	73
163	1	74
164	1	75
165	1	76
166	1	77
167	1	78
168	1	80
169	1	81
170	1	82
171	1	83
172	1	84
173	1	85
174	1	86
175	1	87
176	4	88
177	4	89
178	4	90
179	4	91
180	4	92
181	4	93
182	4	94
183	4	95
184	4	96
185	4	97
186	4	98
187	4	99
188	4	100
189	4	101
190	4	102
191	4	103
192	4	104
193	4	105
194	4	106
195	4	107
196	4	108
197	4	109
198	4	110
199	2	88
200	2	89
201	2	90
202	2	91
203	2	92
204	2	93
205	2	94
206	2	95
207	2	96
208	2	97
209	2	98
210	2	99
211	2	100
212	2	101
213	2	102
214	2	103
215	2	104
216	2	105
217	2	106
218	2	107
219	2	108
220	2	109
221	2	110
222	7	88
223	7	89
224	7	90
225	7	91
226	7	92
227	7	93
228	7	94
229	7	95
230	7	96
231	7	97
232	7	98
233	7	99
234	7	100
235	7	101
236	7	102
237	7	103
238	7	104
239	7	105
240	7	106
241	7	107
242	7	108
243	7	109
244	7	110
245	6	111
246	6	112
247	6	113
248	6	114
249	6	74
250	6	116
251	6	117
252	6	118
253	6	119
254	6	120
255	6	121
256	11	122
257	11	123
258	11	124
259	11	3
260	11	74
261	11	127
262	11	128
263	11	129
264	11	130
265	11	131
266	9	132
267	9	133
268	9	134
269	9	135
270	9	136
271	9	137
272	9	138
273	9	139
274	9	140
275	9	141
276	9	142
277	9	143
278	12	144
279	12	145
280	12	146
281	12	147
282	12	148
283	12	149
284	12	150
285	12	151
286	12	152
287	12	153
288	12	154
289	7	155
\.


--
-- Name: skiruns_lifts_skirun_lift_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('skiruns_lifts_skirun_lift_id_seq', 289, true);


--
-- Name: skiruns_skirun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('skiruns_skirun_id_seq', 155, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY users (user_id, fname, lname, email, zipcode, password, level_id) FROM stdin;
1	Allen	Rojas	ut.sem.Nulla@ipsumPhasellusvitae.com	299823	123	3
2	Declan	Horne	feugiat.placerat.velit@euelit.com	32775	123	2
3	Guy	Williamson	dolor@Maurisvel.org	5788	123	1
4	Imelda	Roman	nonummy.ut.molestie@sedest.org	43903	123	2
5	Suki	Barber	scelerisque.sed.sapien@vitaeodio.com	8545	123	2
6	Julie	Webb	pharetra.ut@seddolor.edu	9533	123	1
7	Kirsten	Barron	tristique.senectus.et@Mauris.com	6753	123	3
8	Quintessa	Conway	odio@Utnecurna.com	15213	123	2
9	Shafira	Graves	in.cursus@inconsequat.net	H3E 4P1	123	2
10	Breanna	Malone	vestibulum.Mauris@consectetueradipiscing.net	2248	123	2
11	Kermit	Hartman	quis@in.net	2965	123	1
12	Jada	Craft	cursus.purus.Nullam@magna.com	09883	123	2
13	Jin	Barker	nulla.In@Quisque.edu	2543	123	3
14	Yvette	Herrera	Suspendisse.sed@Sed.com	61021	123	2
15	Jada	Shepherd	sed@ipsumprimisin.com	58778	123	3
16	Herman	Hamilton	vel.mauris.Integer@odioapurus.ca	42108	123	1
17	Sarah	Ingram	enim@lectus.com	96885	123	3
18	Jeanette	Spears	neque.Morbi.quis@nec.net	25053	123	1
19	Beatrice	Jarvis	vestibulum@parturientmontesnascetur.com	0330 FZ	123	2
20	Ayanna	French	ligula.Aenean.euismod@In.edu	11413	123	3
21	Calista	Park	molestie@elitAliquam.com	H5X 6B3	123	1
22	Hakeem	Burks	orci.Ut.semper@nequeInornare.edu	54713	123	2
23	Orson	Mclean	vitae@montesnasceturridiculus.net	74-433	123	2
24	Wylie	David	Phasellus@noncursusnon.org	99693	123	1
25	Chanda	Ford	tellus.Phasellus@quismassaMauris.net	85-343	123	1
26	Ursula	Hale	penatibus.et@estNunclaoreet.net	39921	123	1
27	Zane	Walls	ipsum.Suspendisse.non@diam.org	25768-193	123	2
28	Kuame	Rhodes	semper@rutrumjustoPraesent.net	K3A 3P3	123	2
29	Carlos	Carney	erat.vel.pede@et.com	74143	123	1
30	Mark	Vargas	vulputate.lacus@vulputatevelit.ca	9333	123	2
31	Germaine	Hart	magnis.dis.parturient@disparturientmontes.com	3673	123	1
32	Sara	Mcdowell	convallis.dolor@pharetra.net	ZX75 7DY	123	2
33	Neil	Reeves	morbi.tristique@orcilobortis.ca	70701	123	3
34	Charity	Hines	Integer.urna@sodaleseliterat.edu	75863	123	3
35	Emmanuel	Glover	justo@magna.net	7493	123	3
36	Chandler	Richmond	quis@velit.ca	17093	123	2
37	Remedios	Montoya	metus.sit.amet@Uttincidunt.edu	3873	123	2
38	Ulla	Graham	metus@metusurna.com	3473	123	1
39	Damian	Henderson	Aenean.egestas@eleifendCrassed.org	38-133	123	3
40	Chancellor	Cash	mauris.erat.eget@volutpatnunc.com	29277-143	123	1
41	Wayne	Barber	lobortis@molestieorci.org	93181	123	3
42	Elijah	Spence	in.cursus.et@risus.com	51795	123	1
43	Hammett	Soto	vestibulum.nec.euismod@utlacusNulla.ca	7223	123	1
44	Justina	Grimes	Aenean.eget@odioauctorvitae.edu	7983	123	1
45	Hayfa	Wolf	at.fringilla@nonjusto.ca	20107	123	2
46	Ferdinand	York	magna@ligula.net	885848	123	3
47	Ralph	Cox	sociis.natoque.penatibus@egestas.edu	04103	123	1
48	Amber	Dunn	Nullam.velit.dui@ultricesposuerecubilia.ca	7263	123	2
49	Tanisha	Parrish	Vestibulum@aliquet.ca	7513 WJ	123	2
50	Serena	Navarro	lacus@est.com	52-273	123	3
51	Barclay	Wilcox	vitae.sodales.nisi@cursusnonegestas.com	75197	123	1
52	Isaac	Rose	libero.Morbi.accumsan@augueeutempor.com	95875	123	3
53	Quon	Robertson	augue@eget.org	13578	123	2
54	Kessie	Gilliam	in.lobortis@Curabiturut.ca	5135	123	3
55	Alexandra	Foreman	Quisque.ornare.tortor@convallisantelectus.ca	69847	123	2
56	Benedict	Mcbride	pede.nec.ante@maurisSuspendissealiquet.net	50603	123	2
57	Baxter	Wood	neque@Aeneansed.com	72153	123	2
58	Desiree	Burt	at.pretium.aliquet@fames.com	2230 ZD	123	2
59	Harlan	Weeks	molestie.tortor@consectetuer.com	627613	123	1
60	Rae	Sampson	Cras.dictum.ultricies@enim.net	115853	123	3
61	Beatrice	Hahn	arcu.Vestibulum@ultrices.com	60165	123	1
62	Abel	Wheeler	Suspendisse@id.com	80753	123	2
63	Ava	Rogers	pretium@ridiculusmusProin.net	TH1 3VG	123	1
64	Cade	Harrell	imperdiet.non.vestibulum@mienimcondimentum.com	603813	123	2
65	Doris	Vega	Proin.vel.arcu@diamProin.edu	51215	123	3
66	Hedwig	Rojas	Aliquam@Phasellus.com	9083	123	2
67	Omar	Martinez	ultricies@lacusEtiam.net	3288	123	3
68	Genevieve	Stanley	orci@blandit.ca	5513	123	1
69	Vera	Lindsey	pede.sagittis@dolor.com	06533	123	3
70	Tate	Johnson	id@magnaUt.org	229077	123	1
71	Gabriel	Donaldson	sem.semper@commodotincidunt.com	57991-323	123	1
72	Iola	Greer	porttitor.scelerisque.neque@vehicularisusNulla.com	21317	123	2
73	Debra	Romero	malesuada.Integer@ametloremsemper.edu	954525	123	1
74	Wynter	Moody	auctor@quisarcu.edu	16293	123	2
75	Sigourney	Anthony	Nulla@egestasAliquam.com	96803	123	1
76	Meghan	Fields	ac@semperduilectus.ca	Q2 9PB	123	3
77	Maryam	Holloway	fringilla@massanonante.edu	91558	123	1
78	Chester	Mcclain	Donec.nibh.enim@Namnullamagna.org	758811	123	2
79	Dominic	Wagner	ipsum.Curabitur@nec.com	W5 4WO	123	1
80	Alyssa	Macias	sollicitudin.orci@Phasellus.org	21603	123	3
81	Harrison	Myers	elementum.at@Duiselementum.org	42-891	123	2
82	Brandon	Hensley	at.nisi.Cum@turpisnecmauris.com	1758	123	1
83	Carissa	Castaneda	in.faucibus@varius.com	60513	123	3
84	Latifah	Simon	amet@ultrices.net	14-091	123	3
85	Ruth	Small	congue.elit.sed@loremvitae.com	02723	123	1
86	Cedric	Sanchez	mattis@AliquamnislNulla.com	94177	123	1
87	Nichole	Irwin	at.iaculis.quis@Nullamut.edu	389853	123	3
88	Avram	Holmes	ridiculus.mus@auguescelerisquemollis.ca	87-203	123	2
89	Camilla	Bruce	Morbi.accumsan@mollisnec.com	3011 QX	123	1
90	Brenden	Tucker	Cras@Integeraliquam.org	5981 EL	123	2
91	Heidi	Wade	erat.nonummy.ultricies@Donec.edu	57753	123	1
92	Jin	Conley	eu.euismod@amet.ca	2198 YW	123	2
93	Rajah	Clark	ultrices.mauris.ipsum@egetlaoreetposuere.net	844213	123	2
94	Cameron	Gill	ipsum@Uttinciduntvehicula.edu	548123	123	3
95	Kevyn	Parrish	dis.parturient.montes@CrasinterdumNunc.edu	968797	123	1
96	Ralph	White	urna.Nunc@ascelerisquesed.edu	52793-653	123	3
97	Faith	Foreman	Nulla@tristiqueac.org	0053	123	1
98	Barrett	Swanson	lorem@sempereratin.org	110903	123	3
99	Daryl	Ramos	vulputate.nisi.sem@consectetuereuismod.edu	ZB5 4PO	123	2
100	Cecilia	Murphy	Duis.mi@feugiatplacerat.com	0135	123	1
\.


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('users_user_id_seq', 100, true);


--
-- Data for Name: weather; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY weather (weather_id, daily_snowfall, overnight_snowfall, forcast_icon, wind_forcast, snow_forcast) FROM stdin;
1	0	0.0	snow	Calm	Cloudy with scattered morning flurries and afternoon sunny periods. Periods of snow redeveloping very late in the day. 
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

