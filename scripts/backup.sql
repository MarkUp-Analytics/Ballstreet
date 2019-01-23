--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
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


--
-- Name: getwinnerslist(); Type: FUNCTION; Schema: public; Owner: ballstreetdev
--

CREATE FUNCTION public.getwinnerslist() RETURNS TABLE(team1 character varying, team2 character varying, matchdate date, winningteam character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
 RETURN QUERY SELECT t1.team_name as team1, t2.team_name as team2, mf.match_fixture_start_date as match_date, t3.team_name as winning_team
     
FROM 
     match_fixtures as mf
     LEFT JOIN team t1 ON t1.team_id=mf.match_fixture_team_1 
     LEFT JOIN team t2 ON t2.team_id=mf.match_fixture_team_2
	 LEFT JOIN team t3 ON t3.team_id=mf.match_fixture_result_won
order by match_date asc;
END; $$;


ALTER FUNCTION public.getwinnerslist() OWNER TO ballstreetdev;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: league; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public.league (
    league_id integer NOT NULL,
    league_name character varying NOT NULL,
    league_tournament_id bigint NOT NULL,
    league_created_by bigint NOT NULL,
    league_created_on date NOT NULL,
    league_minimum_bet integer NOT NULL,
    league_active boolean NOT NULL,
    league_deleted boolean NOT NULL,
    league_shortid character varying
);


ALTER TABLE public.league OWNER TO ballstreetdev;

--
-- Name: league_league_id_seq; Type: SEQUENCE; Schema: public; Owner: ballstreetdev
--

CREATE SEQUENCE public.league_league_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.league_league_id_seq OWNER TO ballstreetdev;

--
-- Name: league_league_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ballstreetdev
--

ALTER SEQUENCE public.league_league_id_seq OWNED BY public.league.league_id;


--
-- Name: league_member; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public.league_member (
    league_member_id integer NOT NULL,
    lm_league_id bigint NOT NULL,
    league_member_user_id bigint NOT NULL,
    league_member_initial_bet_amount numeric,
    league_member_current_bet_amount numeric,
    league_member_active boolean NOT NULL,
    league_member_deleted boolean NOT NULL
);


ALTER TABLE public.league_member OWNER TO ballstreetdev;

--
-- Name: league_member_league_member_id_seq; Type: SEQUENCE; Schema: public; Owner: ballstreetdev
--

CREATE SEQUENCE public.league_member_league_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.league_member_league_member_id_seq OWNER TO ballstreetdev;

--
-- Name: league_member_league_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ballstreetdev
--

ALTER SEQUENCE public.league_member_league_member_id_seq OWNED BY public.league_member.league_member_id;


--
-- Name: match_fixtures; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public.match_fixtures (
    match_fixture_id integer NOT NULL,
    match_fixture_team_1 bigint NOT NULL,
    match_fixture_team_2 bigint NOT NULL,
    match_fixture_tournament_id bigint NOT NULL,
    match_fixture_venue_stadium_id bigint NOT NULL,
    match_fixture_start_date date NOT NULL,
    match_fixture_end_date date NOT NULL,
    match_fixture_toss_time timestamp without time zone NOT NULL,
    match_fixture_result_won bigint,
    match_fixture_result_draw boolean,
    match_fixture_no_result boolean,
    match_fixture_active boolean NOT NULL,
    match_fixture_deleted boolean NOT NULL
);


ALTER TABLE public.match_fixtures OWNER TO ballstreetdev;

--
-- Name: match_fixtures_match_fixture_id_seq; Type: SEQUENCE; Schema: public; Owner: ballstreetdev
--

CREATE SEQUENCE public.match_fixtures_match_fixture_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.match_fixtures_match_fixture_id_seq OWNER TO ballstreetdev;

--
-- Name: match_fixtures_match_fixture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ballstreetdev
--

ALTER SEQUENCE public.match_fixtures_match_fixture_id_seq OWNED BY public.match_fixtures.match_fixture_id;


--
-- Name: member_team_selection; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public.member_team_selection (
    league_member_id bigint NOT NULL,
    match_fixture_id bigint NOT NULL,
    selected_team bigint NOT NULL
);


ALTER TABLE public.member_team_selection OWNER TO ballstreetdev;

--
-- Name: player; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public.player (
    player_id integer NOT NULL,
    player_name character varying NOT NULL,
    player_age integer NOT NULL,
    player_sex character varying NOT NULL,
    player_position character varying NOT NULL,
    player_photo character varying NOT NULL,
    player_active boolean NOT NULL,
    player_deleted boolean NOT NULL,
    player_total_odi_matches integer NOT NULL,
    player_total_odi_runs integer NOT NULL,
    player_total_odi_wickets integer NOT NULL,
    player_total_odi_catches integer NOT NULL,
    player_total_odi_fifties integer NOT NULL,
    player_total_odi_centuries integer NOT NULL,
    player_odi_highest_score character varying NOT NULL,
    player_odi_best_bowling character varying NOT NULL,
    player_total_t20_matches integer NOT NULL,
    player_total_t20_runs integer NOT NULL,
    player_total_t20_wickets integer NOT NULL,
    player_total_t20_catches integer NOT NULL,
    player_total_t20_fifties integer NOT NULL,
    player_total_t20_centuries integer NOT NULL,
    player_t20_highest_score character varying NOT NULL,
    player_t20_best_bowling character varying NOT NULL,
    player_total_test_matches integer NOT NULL,
    player_total_test_runs integer NOT NULL,
    player_total_test_wickets integer NOT NULL,
    player_total_test_catches integer NOT NULL,
    player_total_test_fifties integer NOT NULL,
    player_total_test_centuries integer NOT NULL,
    player_test_highest_score character varying NOT NULL,
    player_test_best_bowling character varying NOT NULL
);


ALTER TABLE public.player OWNER TO ballstreetdev;

--
-- Name: player_player_id_seq; Type: SEQUENCE; Schema: public; Owner: ballstreetdev
--

CREATE SEQUENCE public.player_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_player_id_seq OWNER TO ballstreetdev;

--
-- Name: player_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ballstreetdev
--

ALTER SEQUENCE public.player_player_id_seq OWNED BY public.player.player_id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    role_name character varying NOT NULL,
    role_description character varying NOT NULL
);


ALTER TABLE public.roles OWNER TO ballstreetdev;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: ballstreetdev
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_role_id_seq OWNER TO ballstreetdev;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ballstreetdev
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- Name: sport; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public.sport (
    sport_id integer NOT NULL,
    sport_name character varying NOT NULL,
    sport_description character varying NOT NULL,
    sport_active boolean NOT NULL,
    sport_deleted boolean NOT NULL
);


ALTER TABLE public.sport OWNER TO ballstreetdev;

--
-- Name: sport_sport_id_seq; Type: SEQUENCE; Schema: public; Owner: ballstreetdev
--

CREATE SEQUENCE public.sport_sport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sport_sport_id_seq OWNER TO ballstreetdev;

--
-- Name: sport_sport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ballstreetdev
--

ALTER SEQUENCE public.sport_sport_id_seq OWNED BY public.sport.sport_id;


--
-- Name: stadium; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public.stadium (
    stadium_id integer NOT NULL,
    stadium_name character varying NOT NULL,
    stadium_city character varying NOT NULL,
    stadium_state character varying NOT NULL,
    stadium_country character varying NOT NULL,
    stadium_active boolean NOT NULL,
    stadium_deleted boolean NOT NULL
);


ALTER TABLE public.stadium OWNER TO ballstreetdev;

--
-- Name: stadium_stadium_id_seq; Type: SEQUENCE; Schema: public; Owner: ballstreetdev
--

CREATE SEQUENCE public.stadium_stadium_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stadium_stadium_id_seq OWNER TO ballstreetdev;

--
-- Name: stadium_stadium_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ballstreetdev
--

ALTER SEQUENCE public.stadium_stadium_id_seq OWNED BY public.stadium.stadium_id;


--
-- Name: team; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public.team (
    team_id integer NOT NULL,
    team_name character varying NOT NULL,
    team_image character varying,
    team_active boolean NOT NULL,
    team_deleted boolean NOT NULL,
    team_abbreviation character varying
);


ALTER TABLE public.team OWNER TO ballstreetdev;

--
-- Name: teamMember; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public."teamMember" (
    "teamMember_id" integer NOT NULL,
    "teamMember_team_id" bigint NOT NULL,
    "teamMember_player_id" bigint NOT NULL,
    "teamMember_active" boolean NOT NULL,
    "teamMember_deleted" boolean NOT NULL
);


ALTER TABLE public."teamMember" OWNER TO ballstreetdev;

--
-- Name: teamMember_teamMember_id_seq; Type: SEQUENCE; Schema: public; Owner: ballstreetdev
--

CREATE SEQUENCE public."teamMember_teamMember_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."teamMember_teamMember_id_seq" OWNER TO ballstreetdev;

--
-- Name: teamMember_teamMember_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ballstreetdev
--

ALTER SEQUENCE public."teamMember_teamMember_id_seq" OWNED BY public."teamMember"."teamMember_id";


--
-- Name: team_member_preference; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public.team_member_preference (
    league_member_id bigint NOT NULL,
    team_id bigint NOT NULL,
    rank integer NOT NULL
);


ALTER TABLE public.team_member_preference OWNER TO ballstreetdev;

--
-- Name: team_team_id_seq; Type: SEQUENCE; Schema: public; Owner: ballstreetdev
--

CREATE SEQUENCE public.team_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_team_id_seq OWNER TO ballstreetdev;

--
-- Name: team_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ballstreetdev
--

ALTER SEQUENCE public.team_team_id_seq OWNED BY public.team.team_id;


--
-- Name: tournament; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public.tournament (
    tournament_id integer NOT NULL,
    tournament_sport_id bigint NOT NULL,
    tournament_name character varying NOT NULL,
    tournament_start_date date NOT NULL,
    tournament_end_date date NOT NULL,
    tournament_active boolean NOT NULL,
    tournament_deleted boolean NOT NULL
);


ALTER TABLE public.tournament OWNER TO ballstreetdev;

--
-- Name: tournament_tournament_id_seq; Type: SEQUENCE; Schema: public; Owner: ballstreetdev
--

CREATE SEQUENCE public.tournament_tournament_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tournament_tournament_id_seq OWNER TO ballstreetdev;

--
-- Name: tournament_tournament_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ballstreetdev
--

ALTER SEQUENCE public.tournament_tournament_id_seq OWNED BY public.tournament.tournament_id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public.transactions (
    transaction_id integer NOT NULL,
    transaction_money_from bigint NOT NULL,
    transaction_money_to bigint NOT NULL,
    transaction_money_amonut integer NOT NULL,
    transaction_money_league_id integer NOT NULL,
    transaction_date date NOT NULL,
    transaction_active boolean NOT NULL,
    transaction_deleted boolean NOT NULL
);


ALTER TABLE public.transactions OWNER TO ballstreetdev;

--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: ballstreetdev
--

CREATE SEQUENCE public.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_transaction_id_seq OWNER TO ballstreetdev;

--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ballstreetdev
--

ALTER SEQUENCE public.transactions_transaction_id_seq OWNED BY public.transactions.transaction_id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.user_roles OWNER TO ballstreetdev;

--
-- Name: users; Type: TABLE; Schema: public; Owner: ballstreetdev
--

CREATE TABLE public.users (
    "userID" integer NOT NULL,
    firstname character varying NOT NULL,
    lastname character varying NOT NULL,
    email character varying NOT NULL,
    age integer NOT NULL,
    sex character varying NOT NULL,
    accountcreationdate date NOT NULL,
    password character varying NOT NULL,
    active boolean NOT NULL,
    deleted boolean NOT NULL,
    shortid character varying
);


ALTER TABLE public.users OWNER TO ballstreetdev;

--
-- Name: users_userID_seq; Type: SEQUENCE; Schema: public; Owner: ballstreetdev
--

CREATE SEQUENCE public."users_userID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."users_userID_seq" OWNER TO ballstreetdev;

--
-- Name: users_userID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ballstreetdev
--

ALTER SEQUENCE public."users_userID_seq" OWNED BY public.users."userID";


--
-- Name: league league_id; Type: DEFAULT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.league ALTER COLUMN league_id SET DEFAULT nextval('public.league_league_id_seq'::regclass);


--
-- Name: league_member league_member_id; Type: DEFAULT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.league_member ALTER COLUMN league_member_id SET DEFAULT nextval('public.league_member_league_member_id_seq'::regclass);


--
-- Name: match_fixtures match_fixture_id; Type: DEFAULT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.match_fixtures ALTER COLUMN match_fixture_id SET DEFAULT nextval('public.match_fixtures_match_fixture_id_seq'::regclass);


--
-- Name: player player_id; Type: DEFAULT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.player ALTER COLUMN player_id SET DEFAULT nextval('public.player_player_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- Name: sport sport_id; Type: DEFAULT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.sport ALTER COLUMN sport_id SET DEFAULT nextval('public.sport_sport_id_seq'::regclass);


--
-- Name: stadium stadium_id; Type: DEFAULT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.stadium ALTER COLUMN stadium_id SET DEFAULT nextval('public.stadium_stadium_id_seq'::regclass);


--
-- Name: team team_id; Type: DEFAULT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.team ALTER COLUMN team_id SET DEFAULT nextval('public.team_team_id_seq'::regclass);


--
-- Name: teamMember teamMember_id; Type: DEFAULT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public."teamMember" ALTER COLUMN "teamMember_id" SET DEFAULT nextval('public."teamMember_teamMember_id_seq"'::regclass);


--
-- Name: tournament tournament_id; Type: DEFAULT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.tournament ALTER COLUMN tournament_id SET DEFAULT nextval('public.tournament_tournament_id_seq'::regclass);


--
-- Name: transactions transaction_id; Type: DEFAULT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.transactions_transaction_id_seq'::regclass);


--
-- Name: users userID; Type: DEFAULT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.users ALTER COLUMN "userID" SET DEFAULT nextval('public."users_userID_seq"'::regclass);


--
-- Data for Name: league; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public.league (league_id, league_name, league_tournament_id, league_created_by, league_created_on, league_minimum_bet, league_active, league_deleted, league_shortid) FROM stdin;
1	Amigos	1	1	2018-12-02	600	t	f	\N
2	IIMB Group	1	2	2018-12-02	800	t	f	\N
14	TEST LEAGUE	1	20	2019-01-13	25	t	f	o3eJgJjER
15	TEST 2	2	20	2019-01-20	10	t	f	o1L8iUFnz
\.


--
-- Data for Name: league_member; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public.league_member (league_member_id, lm_league_id, league_member_user_id, league_member_initial_bet_amount, league_member_current_bet_amount, league_member_active, league_member_deleted) FROM stdin;
3	1	1	600	500	t	f
4	1	2	600	550	t	f
5	1	4	600	650	t	f
6	1	6	600	450	t	f
7	1	5	600	400	t	f
11	14	20	\N	\N	t	f
12	15	20	\N	\N	t	f
\.


--
-- Data for Name: match_fixtures; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public.match_fixtures (match_fixture_id, match_fixture_team_1, match_fixture_team_2, match_fixture_tournament_id, match_fixture_venue_stadium_id, match_fixture_start_date, match_fixture_end_date, match_fixture_toss_time, match_fixture_result_won, match_fixture_result_draw, match_fixture_no_result, match_fixture_active, match_fixture_deleted) FROM stdin;
2	4	2	1	7	2018-11-19	2018-11-19	2018-11-19 20:00:00	2	\N	\N	t	f
4	9	3	1	1	2018-11-21	2018-11-21	2018-11-21 20:00:00	9	\N	\N	t	f
3	8	7	1	3	2018-11-20	2018-11-20	2018-11-20 20:00:00	7	\N	\N	t	f
5	6	5	1	11	2018-11-22	2018-11-22	2018-11-19 20:00:00	6	\N	\N	t	f
\.


--
-- Data for Name: member_team_selection; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public.member_team_selection (league_member_id, match_fixture_id, selected_team) FROM stdin;
\.


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public.player (player_id, player_name, player_age, player_sex, player_position, player_photo, player_active, player_deleted, player_total_odi_matches, player_total_odi_runs, player_total_odi_wickets, player_total_odi_catches, player_total_odi_fifties, player_total_odi_centuries, player_odi_highest_score, player_odi_best_bowling, player_total_t20_matches, player_total_t20_runs, player_total_t20_wickets, player_total_t20_catches, player_total_t20_fifties, player_total_t20_centuries, player_t20_highest_score, player_t20_best_bowling, player_total_test_matches, player_total_test_runs, player_total_test_wickets, player_total_test_catches, player_total_test_fifties, player_total_test_centuries, player_test_highest_score, player_test_best_bowling) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public.roles (role_id, role_name, role_description) FROM stdin;
1	league member	Member of a league with minimum permission
2	league admin	Member who created the league
3	admin	Admin users
4	tournament admin	Member who can create or modify tournament
\.


--
-- Data for Name: sport; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public.sport (sport_id, sport_name, sport_description, sport_active, sport_deleted) FROM stdin;
1	cricket men	International men cricket	t	f
2	Women's cricket	International women cricket	t	f
\.


--
-- Data for Name: stadium; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public.stadium (stadium_id, stadium_name, stadium_city, stadium_state, stadium_country, stadium_active, stadium_deleted) FROM stdin;
1	Eden Gardens	Kolkata	West Bengal	India	t	f
2	M. A. Chidambaram Stadium	Chennai	Tamil Nadu	India	t	f
3	Feroz Shah Kotla Ground	Delhi	Delhi	India	t	f
4	Brabourne Stadium	Mumbai	Maharashtra	India	t	f
5	Green Park Stadium	Kanpur	Uttar Pradesh	India	t	f
6	M. Chinnaswamy Stadium	Bangalore	Karnataka	India	t	f
7	Wankhede Stadium	Mumbai	Maharashtra	India	t	f
8	Barabati Stadium	Cuttak	Odisha	India	t	f
9	Punjab Cricket Association IS Bindra Stadium	Mohali	Punjab	India	t	f
10	Dr. Y. S. Rajasekhara Reddy ACA–VDCA Cricket Stadium	Visakhapatnam	Andhra Pradesh	India	t	f
11	Rajiv Gandhi International Cricket Stadium	Hyderabad	Telangana	India	t	f
12	Holkar Stadium	Indore	Madhya Pradesh	India	t	f
13	Vidarbha Cricket Association Stadium	Nagpur	Maharashtra	India	t	f
14	Maharashtra Cricket Association Stadium	Pune	Maharashtra	India	t	f
15	Saurashtra Cricket Association Stadium	Rajkot	Gujarat	India	t	f
16	JSCA International Cricket Stadium	Ranchi	Jharkhand	India	t	f
17	Himachal Pradesh Cricket Association Stadium	Dharamshala	Himachal Pradesh	India	t	f
18	Greater Noida Sports Complex Ground	Greater Noida	Uttar Pradesh	India	t	f
19	Barsapara Stadium	Guwahati	Assam	India	t	f
20	Greenfield International Stadium	Thiruvananthapuram	Kerala	India	t	f
21	Rajiv Gandhi International Cricket Stadium	Dehradun	Uttarakhand	India	t	f
22	Bharat Ratna Shri Atal Bihari Vajpayee Ekana Cricket Stadium	Lucknow	Uttar Pradesh	India	t	f
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public.team (team_id, team_name, team_image, team_active, team_deleted, team_abbreviation) FROM stdin;
2	Chennai Super Kings	\N	t	f	CSK
3	Royal Challengers Bangalore	\N	t	f	RCB
4	Mumbai Indians	\N	t	f	MI
5	Rajasthan Royals	\N	t	f	RR
6	Sunrisers Hyderabad	\N	t	f	SRH
7	Kings XI Punjab	\N	t	f	KXIP
8	Delhi Daredevils	\N	t	f	DD
9	Kolkata Knight Riders	\N	t	f	KKR
\.


--
-- Data for Name: teamMember; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public."teamMember" ("teamMember_id", "teamMember_team_id", "teamMember_player_id", "teamMember_active", "teamMember_deleted") FROM stdin;
\.


--
-- Data for Name: team_member_preference; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public.team_member_preference (league_member_id, team_id, rank) FROM stdin;
\.


--
-- Data for Name: tournament; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public.tournament (tournament_id, tournament_sport_id, tournament_name, tournament_start_date, tournament_end_date, tournament_active, tournament_deleted) FROM stdin;
1	1	IPL	2019-03-29	2019-05-19	t	f
2	1	World Cup 2019	2019-05-30	2019-07-14	t	f
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public.transactions (transaction_id, transaction_money_from, transaction_money_to, transaction_money_amonut, transaction_money_league_id, transaction_date, transaction_active, transaction_deleted) FROM stdin;
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public.user_roles (user_id, role_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ballstreetdev
--

COPY public.users ("userID", firstname, lastname, email, age, sex, accountcreationdate, password, active, deleted, shortid) FROM stdin;
1	Gowthaman	Ilango	test@test.com	28	Male	2018-12-02	test	t	f	\N
2	Mithun Ganesh	Sivagurunathan	test2@test.com	28	Male	2018-12-02	test	t	f	\N
4	Shriram Narayan	Kannusami	test3@test.com	28	Male	2018-12-02	test	t	f	\N
5	Rajeshwaran	B	test4@test.com	28	Male	2018-12-02	test	t	f	\N
6	Zeeshan	Farkudeen Chanraj	test5@test.com	28	Male	2018-12-02	test	t	f	\N
7	Sikkandar Fazil	S	test6@test.com	28	Male	2018-12-02	test	t	f	\N
8	Suriya	Manivannan	test7@test.com	28	Male	2018-12-02	test	t	f	\N
9	Viwaswan	Balu	test8@test.com	28	Male	2018-12-02	test	t	f	\N
15	test	test	test1@test.com	28	Male	2018-12-16	$2a$08$Gz5Vz5hEFJ/he98TxoGTqe20JZ.3A2oH4F05n.uGWW5dtMBZwgwZm	t	f	\N
18	testq	testq	testq@test.com	28	Male	2018-12-22	$2a$08$8PoFPb8cv4QYiT1nDKq5oOC9zNk7bnyK5OWjpdeY9f9sQfHklB95i	t	f	\N
20	test	test	hello@hell.com	28	Male	2018-12-24	$2a$08$yn4aJ/zfjrT/LmoFN82cN.Roe3UjNqZP9FqrIgFq0oljjGGPnlI56	t	f	J88ZyLzNm
21	M89	K399	mithsee@gmail.com	28	Male	2018-12-26	$2a$08$RlzCTDaoEXaJz5ZUdviB7ewRDtbe9bykdJEtoWAPGhy1OHAoLD5Cy	t	f	sfjsfCWUB
\.


--
-- Name: league_league_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ballstreetdev
--

SELECT pg_catalog.setval('public.league_league_id_seq', 15, true);


--
-- Name: league_member_league_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ballstreetdev
--

SELECT pg_catalog.setval('public.league_member_league_member_id_seq', 12, true);


--
-- Name: match_fixtures_match_fixture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ballstreetdev
--

SELECT pg_catalog.setval('public.match_fixtures_match_fixture_id_seq', 5, true);


--
-- Name: player_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ballstreetdev
--

SELECT pg_catalog.setval('public.player_player_id_seq', 1, false);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ballstreetdev
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 4, true);


--
-- Name: sport_sport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ballstreetdev
--

SELECT pg_catalog.setval('public.sport_sport_id_seq', 2, true);


--
-- Name: stadium_stadium_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ballstreetdev
--

SELECT pg_catalog.setval('public.stadium_stadium_id_seq', 22, true);


--
-- Name: teamMember_teamMember_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ballstreetdev
--

SELECT pg_catalog.setval('public."teamMember_teamMember_id_seq"', 1, false);


--
-- Name: team_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ballstreetdev
--

SELECT pg_catalog.setval('public.team_team_id_seq', 9, true);


--
-- Name: tournament_tournament_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ballstreetdev
--

SELECT pg_catalog.setval('public.tournament_tournament_id_seq', 2, true);


--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ballstreetdev
--

SELECT pg_catalog.setval('public.transactions_transaction_id_seq', 1, false);


--
-- Name: users_userID_seq; Type: SEQUENCE SET; Schema: public; Owner: ballstreetdev
--

SELECT pg_catalog.setval('public."users_userID_seq"', 25, true);


--
-- Name: league_member league_member_pk; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.league_member
    ADD CONSTRAINT league_member_pk PRIMARY KEY (league_member_id);


--
-- Name: league league_pk; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.league
    ADD CONSTRAINT league_pk PRIMARY KEY (league_id);


--
-- Name: match_fixtures match_fixtures_pk; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_pk PRIMARY KEY (match_fixture_id);


--
-- Name: player player_pk; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pk PRIMARY KEY (player_id);


--
-- Name: roles roles_pk; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pk PRIMARY KEY (role_id);


--
-- Name: roles roles_role_name_key; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);


--
-- Name: sport sport_pk; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.sport
    ADD CONSTRAINT sport_pk PRIMARY KEY (sport_id);


--
-- Name: sport sport_sport_name_key; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.sport
    ADD CONSTRAINT sport_sport_name_key UNIQUE (sport_name);


--
-- Name: stadium stadium_pk; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.stadium
    ADD CONSTRAINT stadium_pk PRIMARY KEY (stadium_id);


--
-- Name: team team_pk; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pk PRIMARY KEY (team_id);


--
-- Name: teamMember teammember_pk; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public."teamMember"
    ADD CONSTRAINT teammember_pk PRIMARY KEY ("teamMember_id");


--
-- Name: tournament tournament_pk; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.tournament
    ADD CONSTRAINT tournament_pk PRIMARY KEY (tournament_id);


--
-- Name: transactions transactions_pk; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pk PRIMARY KEY (transaction_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY ("userID");


--
-- Name: league league_fk0; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.league
    ADD CONSTRAINT league_fk0 FOREIGN KEY (league_tournament_id) REFERENCES public.tournament(tournament_id);


--
-- Name: league league_fk1; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.league
    ADD CONSTRAINT league_fk1 FOREIGN KEY (league_created_by) REFERENCES public.users("userID");


--
-- Name: league_member league_member_fk0; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.league_member
    ADD CONSTRAINT league_member_fk0 FOREIGN KEY (lm_league_id) REFERENCES public.league(league_id);


--
-- Name: league_member league_member_fk1; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.league_member
    ADD CONSTRAINT league_member_fk1 FOREIGN KEY (league_member_user_id) REFERENCES public.users("userID");


--
-- Name: match_fixtures match_fixtures_fk0; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk0 FOREIGN KEY (match_fixture_team_1) REFERENCES public.team(team_id);


--
-- Name: match_fixtures match_fixtures_fk1; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk1 FOREIGN KEY (match_fixture_team_2) REFERENCES public.team(team_id);


--
-- Name: match_fixtures match_fixtures_fk2; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk2 FOREIGN KEY (match_fixture_tournament_id) REFERENCES public.tournament(tournament_id);


--
-- Name: match_fixtures match_fixtures_fk3; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk3 FOREIGN KEY (match_fixture_venue_stadium_id) REFERENCES public.stadium(stadium_id);


--
-- Name: match_fixtures match_fixtures_fk4; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk4 FOREIGN KEY (match_fixture_result_won) REFERENCES public.team(team_id);


--
-- Name: member_team_selection member_team_selection_fk0; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.member_team_selection
    ADD CONSTRAINT member_team_selection_fk0 FOREIGN KEY (league_member_id) REFERENCES public.league_member(league_member_id);


--
-- Name: member_team_selection member_team_selection_fk1; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.member_team_selection
    ADD CONSTRAINT member_team_selection_fk1 FOREIGN KEY (match_fixture_id) REFERENCES public.match_fixtures(match_fixture_id);


--
-- Name: member_team_selection member_team_selection_fk2; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.member_team_selection
    ADD CONSTRAINT member_team_selection_fk2 FOREIGN KEY (selected_team) REFERENCES public.team(team_id);


--
-- Name: teamMember teamMember_fk0; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public."teamMember"
    ADD CONSTRAINT "teamMember_fk0" FOREIGN KEY ("teamMember_team_id") REFERENCES public.team(team_id);


--
-- Name: teamMember teamMember_fk1; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public."teamMember"
    ADD CONSTRAINT "teamMember_fk1" FOREIGN KEY ("teamMember_player_id") REFERENCES public.player(player_id);


--
-- Name: team_member_preference team_member_preference_fk0; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.team_member_preference
    ADD CONSTRAINT team_member_preference_fk0 FOREIGN KEY (league_member_id) REFERENCES public.league_member(league_member_id);


--
-- Name: team_member_preference team_member_preference_fk1; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.team_member_preference
    ADD CONSTRAINT team_member_preference_fk1 FOREIGN KEY (team_id) REFERENCES public.team(team_id);


--
-- Name: tournament tournament_fk0; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.tournament
    ADD CONSTRAINT tournament_fk0 FOREIGN KEY (tournament_sport_id) REFERENCES public.sport(sport_id);


--
-- Name: transactions transactions_fk0; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_fk0 FOREIGN KEY (transaction_money_from) REFERENCES public.users("userID");


--
-- Name: transactions transactions_fk1; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_fk1 FOREIGN KEY (transaction_money_to) REFERENCES public.users("userID");


--
-- Name: transactions transactions_fk2; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_fk2 FOREIGN KEY (transaction_money_league_id) REFERENCES public.league(league_id);


--
-- Name: user_roles user_roles_fk0; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_fk0 FOREIGN KEY (user_id) REFERENCES public.users("userID");


--
-- Name: user_roles user_roles_fk1; Type: FK CONSTRAINT; Schema: public; Owner: ballstreetdev
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_fk1 FOREIGN KEY (role_id) REFERENCES public.roles(role_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: ballstreetdev
--

REVOKE ALL ON SCHEMA public FROM rdsadmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO ballstreetdev;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

