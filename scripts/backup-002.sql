toc.dat                                                                                             0000600 0004000 0002000 00000124253 13427313405 0014450 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       $                    w            ballstreetDev    10.5    10.5 |    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false         �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false         �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false         �           1262    771092    ballstreetDev    DATABASE     �   CREATE DATABASE "ballstreetDev" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE "ballstreetDev";
             gilango@eab.com    false                     2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             gilango@eab.com    false         �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  gilango@eab.com    false    3                     3079    13267    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false         �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1         �            1255    771093    getwinnerslist()    FUNCTION     H  CREATE FUNCTION public.getwinnerslist() RETURNS TABLE(team1 character varying, team2 character varying, matchdate date, winningteam character varying)
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
 '   DROP FUNCTION public.getwinnerslist();
       public       gilango@eab.com    false    3    1         �            1259    771094    league    TABLE     �  CREATE TABLE public.league (
    league_id integer NOT NULL,
    league_name character varying NOT NULL,
    league_tournament_id bigint NOT NULL,
    league_created_by bigint NOT NULL,
    league_created_on date NOT NULL,
    league_minimum_bet integer NOT NULL,
    league_active boolean NOT NULL,
    league_deleted boolean NOT NULL,
    league_shortid character varying,
    league_pin character varying
);
    DROP TABLE public.league;
       public         gilango@eab.com    false    3         �            1259    771100    league_league_id_seq    SEQUENCE     �   CREATE SEQUENCE public.league_league_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.league_league_id_seq;
       public       gilango@eab.com    false    3    196         �           0    0    league_league_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.league_league_id_seq OWNED BY public.league.league_id;
            public       gilango@eab.com    false    197         �            1259    771102    league_member    TABLE     M  CREATE TABLE public.league_member (
    league_member_id integer NOT NULL,
    lm_league_id bigint NOT NULL,
    league_member_user_id bigint NOT NULL,
    league_member_initial_bet_amount numeric,
    league_member_current_bet_amount numeric,
    league_member_active boolean NOT NULL,
    league_member_deleted boolean NOT NULL
);
 !   DROP TABLE public.league_member;
       public         gilango@eab.com    false    3         �            1259    771108 "   league_member_league_member_id_seq    SEQUENCE     �   CREATE SEQUENCE public.league_member_league_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.league_member_league_member_id_seq;
       public       gilango@eab.com    false    3    198         �           0    0 "   league_member_league_member_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.league_member_league_member_id_seq OWNED BY public.league_member.league_member_id;
            public       gilango@eab.com    false    199         �            1259    771110    match_fixtures    TABLE     g  CREATE TABLE public.match_fixtures (
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
 "   DROP TABLE public.match_fixtures;
       public         gilango@eab.com    false    3         �            1259    771113 #   match_fixtures_match_fixture_id_seq    SEQUENCE     �   CREATE SEQUENCE public.match_fixtures_match_fixture_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.match_fixtures_match_fixture_id_seq;
       public       gilango@eab.com    false    200    3         �           0    0 #   match_fixtures_match_fixture_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.match_fixtures_match_fixture_id_seq OWNED BY public.match_fixtures.match_fixture_id;
            public       gilango@eab.com    false    201         �            1259    771115    member_team_selection    TABLE     �   CREATE TABLE public.member_team_selection (
    league_member_id bigint NOT NULL,
    match_fixture_id bigint NOT NULL,
    selected_team bigint NOT NULL
);
 )   DROP TABLE public.member_team_selection;
       public         gilango@eab.com    false    3         �            1259    771118    player    TABLE       CREATE TABLE public.player (
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
    DROP TABLE public.player;
       public         gilango@eab.com    false    3         �            1259    771124    player_player_id_seq    SEQUENCE     �   CREATE SEQUENCE public.player_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.player_player_id_seq;
       public       gilango@eab.com    false    203    3         �           0    0    player_player_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.player_player_id_seq OWNED BY public.player.player_id;
            public       gilango@eab.com    false    204         �            1259    771126    roles    TABLE     �   CREATE TABLE public.roles (
    role_id integer NOT NULL,
    role_name character varying NOT NULL,
    role_description character varying NOT NULL
);
    DROP TABLE public.roles;
       public         gilango@eab.com    false    3         �            1259    771132    roles_role_id_seq    SEQUENCE     �   CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.roles_role_id_seq;
       public       gilango@eab.com    false    3    205         �           0    0    roles_role_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;
            public       gilango@eab.com    false    206         �            1259    771134    sport    TABLE     �   CREATE TABLE public.sport (
    sport_id integer NOT NULL,
    sport_name character varying NOT NULL,
    sport_description character varying NOT NULL,
    sport_active boolean NOT NULL,
    sport_deleted boolean NOT NULL
);
    DROP TABLE public.sport;
       public         gilango@eab.com    false    3         �            1259    771140    sport_sport_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sport_sport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.sport_sport_id_seq;
       public       gilango@eab.com    false    207    3         �           0    0    sport_sport_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.sport_sport_id_seq OWNED BY public.sport.sport_id;
            public       gilango@eab.com    false    208         �            1259    771142    stadium    TABLE     D  CREATE TABLE public.stadium (
    stadium_id integer NOT NULL,
    stadium_name character varying NOT NULL,
    stadium_city character varying NOT NULL,
    stadium_state character varying NOT NULL,
    stadium_country character varying NOT NULL,
    stadium_active boolean NOT NULL,
    stadium_deleted boolean NOT NULL
);
    DROP TABLE public.stadium;
       public         gilango@eab.com    false    3         �            1259    771148    stadium_stadium_id_seq    SEQUENCE     �   CREATE SEQUENCE public.stadium_stadium_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.stadium_stadium_id_seq;
       public       gilango@eab.com    false    3    209         �           0    0    stadium_stadium_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.stadium_stadium_id_seq OWNED BY public.stadium.stadium_id;
            public       gilango@eab.com    false    210         �            1259    771150    team    TABLE     �   CREATE TABLE public.team (
    team_id integer NOT NULL,
    team_name character varying NOT NULL,
    team_image character varying,
    team_active boolean NOT NULL,
    team_deleted boolean NOT NULL,
    team_abbreviation character varying
);
    DROP TABLE public.team;
       public         gilango@eab.com    false    3         �            1259    771156 
   teamMember    TABLE     �   CREATE TABLE public."teamMember" (
    "teamMember_id" integer NOT NULL,
    "teamMember_team_id" bigint NOT NULL,
    "teamMember_player_id" bigint NOT NULL,
    "teamMember_active" boolean NOT NULL,
    "teamMember_deleted" boolean NOT NULL
);
     DROP TABLE public."teamMember";
       public         gilango@eab.com    false    3         �            1259    771159    teamMember_teamMember_id_seq    SEQUENCE     �   CREATE SEQUENCE public."teamMember_teamMember_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public."teamMember_teamMember_id_seq";
       public       gilango@eab.com    false    212    3         �           0    0    teamMember_teamMember_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public."teamMember_teamMember_id_seq" OWNED BY public."teamMember"."teamMember_id";
            public       gilango@eab.com    false    213         �            1259    771161    team_member_preference    TABLE     �   CREATE TABLE public.team_member_preference (
    league_member_id bigint NOT NULL,
    team_id bigint NOT NULL,
    rank integer NOT NULL
);
 *   DROP TABLE public.team_member_preference;
       public         gilango@eab.com    false    3         �            1259    771164    team_team_id_seq    SEQUENCE     �   CREATE SEQUENCE public.team_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.team_team_id_seq;
       public       gilango@eab.com    false    3    211                     0    0    team_team_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.team_team_id_seq OWNED BY public.team.team_id;
            public       gilango@eab.com    false    215         �            1259    771166 
   tournament    TABLE     i  CREATE TABLE public.tournament (
    tournament_id integer NOT NULL,
    tournament_sport_id bigint NOT NULL,
    tournament_name character varying NOT NULL,
    tournament_start_date date NOT NULL,
    tournament_end_date date NOT NULL,
    tournament_active boolean NOT NULL,
    tournament_deleted boolean NOT NULL,
    tournament_venue character varying
);
    DROP TABLE public.tournament;
       public         gilango@eab.com    false    3         �            1259    771172    tournament_tournament_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tournament_tournament_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.tournament_tournament_id_seq;
       public       gilango@eab.com    false    216    3                    0    0    tournament_tournament_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.tournament_tournament_id_seq OWNED BY public.tournament.tournament_id;
            public       gilango@eab.com    false    217         �            1259    771174    transactions    TABLE     x  CREATE TABLE public.transactions (
    transaction_id integer NOT NULL,
    transaction_money_from bigint NOT NULL,
    transaction_money_to bigint NOT NULL,
    transaction_money_amonut integer NOT NULL,
    transaction_money_league_id integer NOT NULL,
    transaction_date date NOT NULL,
    transaction_active boolean NOT NULL,
    transaction_deleted boolean NOT NULL
);
     DROP TABLE public.transactions;
       public         gilango@eab.com    false    3         �            1259    771177    transactions_transaction_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.transactions_transaction_id_seq;
       public       gilango@eab.com    false    3    218                    0    0    transactions_transaction_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.transactions_transaction_id_seq OWNED BY public.transactions.transaction_id;
            public       gilango@eab.com    false    219         �            1259    771179 
   user_roles    TABLE     ]   CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);
    DROP TABLE public.user_roles;
       public         gilango@eab.com    false    3         �            1259    771182    users    TABLE     �  CREATE TABLE public.users (
    userid integer NOT NULL,
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
    DROP TABLE public.users;
       public         gilango@eab.com    false    3         �            1259    771188    users_userID_seq    SEQUENCE     �   CREATE SEQUENCE public."users_userID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."users_userID_seq";
       public       gilango@eab.com    false    3    221                    0    0    users_userID_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."users_userID_seq" OWNED BY public.users.userid;
            public       gilango@eab.com    false    222                    2604    771343    league league_id    DEFAULT     t   ALTER TABLE ONLY public.league ALTER COLUMN league_id SET DEFAULT nextval('public.league_league_id_seq'::regclass);
 ?   ALTER TABLE public.league ALTER COLUMN league_id DROP DEFAULT;
       public       gilango@eab.com    false    197    196                    2604    771344    league_member league_member_id    DEFAULT     �   ALTER TABLE ONLY public.league_member ALTER COLUMN league_member_id SET DEFAULT nextval('public.league_member_league_member_id_seq'::regclass);
 M   ALTER TABLE public.league_member ALTER COLUMN league_member_id DROP DEFAULT;
       public       gilango@eab.com    false    199    198                    2604    771345    match_fixtures match_fixture_id    DEFAULT     �   ALTER TABLE ONLY public.match_fixtures ALTER COLUMN match_fixture_id SET DEFAULT nextval('public.match_fixtures_match_fixture_id_seq'::regclass);
 N   ALTER TABLE public.match_fixtures ALTER COLUMN match_fixture_id DROP DEFAULT;
       public       gilango@eab.com    false    201    200                    2604    771346    player player_id    DEFAULT     t   ALTER TABLE ONLY public.player ALTER COLUMN player_id SET DEFAULT nextval('public.player_player_id_seq'::regclass);
 ?   ALTER TABLE public.player ALTER COLUMN player_id DROP DEFAULT;
       public       gilango@eab.com    false    204    203                     2604    771347    roles role_id    DEFAULT     n   ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);
 <   ALTER TABLE public.roles ALTER COLUMN role_id DROP DEFAULT;
       public       gilango@eab.com    false    206    205         !           2604    771348    sport sport_id    DEFAULT     p   ALTER TABLE ONLY public.sport ALTER COLUMN sport_id SET DEFAULT nextval('public.sport_sport_id_seq'::regclass);
 =   ALTER TABLE public.sport ALTER COLUMN sport_id DROP DEFAULT;
       public       gilango@eab.com    false    208    207         "           2604    771349    stadium stadium_id    DEFAULT     x   ALTER TABLE ONLY public.stadium ALTER COLUMN stadium_id SET DEFAULT nextval('public.stadium_stadium_id_seq'::regclass);
 A   ALTER TABLE public.stadium ALTER COLUMN stadium_id DROP DEFAULT;
       public       gilango@eab.com    false    210    209         #           2604    771350    team team_id    DEFAULT     l   ALTER TABLE ONLY public.team ALTER COLUMN team_id SET DEFAULT nextval('public.team_team_id_seq'::regclass);
 ;   ALTER TABLE public.team ALTER COLUMN team_id DROP DEFAULT;
       public       gilango@eab.com    false    215    211         $           2604    771351    teamMember teamMember_id    DEFAULT     �   ALTER TABLE ONLY public."teamMember" ALTER COLUMN "teamMember_id" SET DEFAULT nextval('public."teamMember_teamMember_id_seq"'::regclass);
 K   ALTER TABLE public."teamMember" ALTER COLUMN "teamMember_id" DROP DEFAULT;
       public       gilango@eab.com    false    213    212         %           2604    771352    tournament tournament_id    DEFAULT     �   ALTER TABLE ONLY public.tournament ALTER COLUMN tournament_id SET DEFAULT nextval('public.tournament_tournament_id_seq'::regclass);
 G   ALTER TABLE public.tournament ALTER COLUMN tournament_id DROP DEFAULT;
       public       gilango@eab.com    false    217    216         &           2604    771353    transactions transaction_id    DEFAULT     �   ALTER TABLE ONLY public.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.transactions_transaction_id_seq'::regclass);
 J   ALTER TABLE public.transactions ALTER COLUMN transaction_id DROP DEFAULT;
       public       gilango@eab.com    false    219    218         '           2604    771354    users userid    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public."users_userID_seq"'::regclass);
 ;   ALTER TABLE public.users ALTER COLUMN userid DROP DEFAULT;
       public       gilango@eab.com    false    222    221         �          0    771094    league 
   TABLE DATA               �   COPY public.league (league_id, league_name, league_tournament_id, league_created_by, league_created_on, league_minimum_bet, league_active, league_deleted, league_shortid, league_pin) FROM stdin;
    public       gilango@eab.com    false    196       3285.dat �          0    771102    league_member 
   TABLE DATA               �   COPY public.league_member (league_member_id, lm_league_id, league_member_user_id, league_member_initial_bet_amount, league_member_current_bet_amount, league_member_active, league_member_deleted) FROM stdin;
    public       gilango@eab.com    false    198       3287.dat �          0    771110    match_fixtures 
   TABLE DATA               i  COPY public.match_fixtures (match_fixture_id, match_fixture_team_1, match_fixture_team_2, match_fixture_tournament_id, match_fixture_venue_stadium_id, match_fixture_start_date, match_fixture_end_date, match_fixture_toss_time, match_fixture_result_won, match_fixture_result_draw, match_fixture_no_result, match_fixture_active, match_fixture_deleted) FROM stdin;
    public       gilango@eab.com    false    200       3289.dat �          0    771115    member_team_selection 
   TABLE DATA               b   COPY public.member_team_selection (league_member_id, match_fixture_id, selected_team) FROM stdin;
    public       gilango@eab.com    false    202       3291.dat �          0    771118    player 
   TABLE DATA                  COPY public.player (player_id, player_name, player_age, player_sex, player_position, player_photo, player_active, player_deleted, player_total_odi_matches, player_total_odi_runs, player_total_odi_wickets, player_total_odi_catches, player_total_odi_fifties, player_total_odi_centuries, player_odi_highest_score, player_odi_best_bowling, player_total_t20_matches, player_total_t20_runs, player_total_t20_wickets, player_total_t20_catches, player_total_t20_fifties, player_total_t20_centuries, player_t20_highest_score, player_t20_best_bowling, player_total_test_matches, player_total_test_runs, player_total_test_wickets, player_total_test_catches, player_total_test_fifties, player_total_test_centuries, player_test_highest_score, player_test_best_bowling) FROM stdin;
    public       gilango@eab.com    false    203       3292.dat �          0    771126    roles 
   TABLE DATA               E   COPY public.roles (role_id, role_name, role_description) FROM stdin;
    public       gilango@eab.com    false    205       3294.dat �          0    771134    sport 
   TABLE DATA               e   COPY public.sport (sport_id, sport_name, sport_description, sport_active, sport_deleted) FROM stdin;
    public       gilango@eab.com    false    207       3296.dat �          0    771142    stadium 
   TABLE DATA               �   COPY public.stadium (stadium_id, stadium_name, stadium_city, stadium_state, stadium_country, stadium_active, stadium_deleted) FROM stdin;
    public       gilango@eab.com    false    209       3298.dat �          0    771150    team 
   TABLE DATA               l   COPY public.team (team_id, team_name, team_image, team_active, team_deleted, team_abbreviation) FROM stdin;
    public       gilango@eab.com    false    211       3300.dat �          0    771156 
   teamMember 
   TABLE DATA               �   COPY public."teamMember" ("teamMember_id", "teamMember_team_id", "teamMember_player_id", "teamMember_active", "teamMember_deleted") FROM stdin;
    public       gilango@eab.com    false    212       3301.dat �          0    771161    team_member_preference 
   TABLE DATA               Q   COPY public.team_member_preference (league_member_id, team_id, rank) FROM stdin;
    public       gilango@eab.com    false    214       3303.dat �          0    771166 
   tournament 
   TABLE DATA               �   COPY public.tournament (tournament_id, tournament_sport_id, tournament_name, tournament_start_date, tournament_end_date, tournament_active, tournament_deleted, tournament_venue) FROM stdin;
    public       gilango@eab.com    false    216       3305.dat �          0    771174    transactions 
   TABLE DATA               �   COPY public.transactions (transaction_id, transaction_money_from, transaction_money_to, transaction_money_amonut, transaction_money_league_id, transaction_date, transaction_active, transaction_deleted) FROM stdin;
    public       gilango@eab.com    false    218       3307.dat �          0    771179 
   user_roles 
   TABLE DATA               6   COPY public.user_roles (user_id, role_id) FROM stdin;
    public       gilango@eab.com    false    220       3309.dat �          0    771182    users 
   TABLE DATA               �   COPY public.users (userid, firstname, lastname, email, age, sex, accountcreationdate, password, active, deleted, shortid) FROM stdin;
    public       gilango@eab.com    false    221       3310.dat            0    0    league_league_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.league_league_id_seq', 20, true);
            public       gilango@eab.com    false    197                    0    0 "   league_member_league_member_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.league_member_league_member_id_seq', 18, true);
            public       gilango@eab.com    false    199                    0    0 #   match_fixtures_match_fixture_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.match_fixtures_match_fixture_id_seq', 5, true);
            public       gilango@eab.com    false    201                    0    0    player_player_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.player_player_id_seq', 1, false);
            public       gilango@eab.com    false    204                    0    0    roles_role_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.roles_role_id_seq', 4, true);
            public       gilango@eab.com    false    206         	           0    0    sport_sport_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.sport_sport_id_seq', 2, true);
            public       gilango@eab.com    false    208         
           0    0    stadium_stadium_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.stadium_stadium_id_seq', 22, true);
            public       gilango@eab.com    false    210                    0    0    teamMember_teamMember_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public."teamMember_teamMember_id_seq"', 1, false);
            public       gilango@eab.com    false    213                    0    0    team_team_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.team_team_id_seq', 9, true);
            public       gilango@eab.com    false    215                    0    0    tournament_tournament_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.tournament_tournament_id_seq', 2, true);
            public       gilango@eab.com    false    217                    0    0    transactions_transaction_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.transactions_transaction_id_seq', 1, false);
            public       gilango@eab.com    false    219                    0    0    users_userID_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."users_userID_seq"', 25, true);
            public       gilango@eab.com    false    222         +           2606    771203    league_member league_member_pk 
   CONSTRAINT     j   ALTER TABLE ONLY public.league_member
    ADD CONSTRAINT league_member_pk PRIMARY KEY (league_member_id);
 H   ALTER TABLE ONLY public.league_member DROP CONSTRAINT league_member_pk;
       public         gilango@eab.com    false    198         )           2606    771205    league league_pk 
   CONSTRAINT     U   ALTER TABLE ONLY public.league
    ADD CONSTRAINT league_pk PRIMARY KEY (league_id);
 :   ALTER TABLE ONLY public.league DROP CONSTRAINT league_pk;
       public         gilango@eab.com    false    196         -           2606    771207     match_fixtures match_fixtures_pk 
   CONSTRAINT     l   ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_pk PRIMARY KEY (match_fixture_id);
 J   ALTER TABLE ONLY public.match_fixtures DROP CONSTRAINT match_fixtures_pk;
       public         gilango@eab.com    false    200         /           2606    771209    player player_pk 
   CONSTRAINT     U   ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pk PRIMARY KEY (player_id);
 :   ALTER TABLE ONLY public.player DROP CONSTRAINT player_pk;
       public         gilango@eab.com    false    203         1           2606    771211    roles roles_pk 
   CONSTRAINT     Q   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pk PRIMARY KEY (role_id);
 8   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pk;
       public         gilango@eab.com    false    205         3           2606    771213    roles roles_role_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);
 C   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_role_name_key;
       public         gilango@eab.com    false    205         5           2606    771215    sport sport_pk 
   CONSTRAINT     R   ALTER TABLE ONLY public.sport
    ADD CONSTRAINT sport_pk PRIMARY KEY (sport_id);
 8   ALTER TABLE ONLY public.sport DROP CONSTRAINT sport_pk;
       public         gilango@eab.com    false    207         7           2606    771217    sport sport_sport_name_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.sport
    ADD CONSTRAINT sport_sport_name_key UNIQUE (sport_name);
 D   ALTER TABLE ONLY public.sport DROP CONSTRAINT sport_sport_name_key;
       public         gilango@eab.com    false    207         9           2606    771219    stadium stadium_pk 
   CONSTRAINT     X   ALTER TABLE ONLY public.stadium
    ADD CONSTRAINT stadium_pk PRIMARY KEY (stadium_id);
 <   ALTER TABLE ONLY public.stadium DROP CONSTRAINT stadium_pk;
       public         gilango@eab.com    false    209         ;           2606    771221    team team_pk 
   CONSTRAINT     O   ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pk PRIMARY KEY (team_id);
 6   ALTER TABLE ONLY public.team DROP CONSTRAINT team_pk;
       public         gilango@eab.com    false    211         =           2606    771223    teamMember teammember_pk 
   CONSTRAINT     e   ALTER TABLE ONLY public."teamMember"
    ADD CONSTRAINT teammember_pk PRIMARY KEY ("teamMember_id");
 D   ALTER TABLE ONLY public."teamMember" DROP CONSTRAINT teammember_pk;
       public         gilango@eab.com    false    212         ?           2606    771225    tournament tournament_pk 
   CONSTRAINT     a   ALTER TABLE ONLY public.tournament
    ADD CONSTRAINT tournament_pk PRIMARY KEY (tournament_id);
 B   ALTER TABLE ONLY public.tournament DROP CONSTRAINT tournament_pk;
       public         gilango@eab.com    false    216         A           2606    771227    transactions transactions_pk 
   CONSTRAINT     f   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pk PRIMARY KEY (transaction_id);
 F   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pk;
       public         gilango@eab.com    false    218         C           2606    771229    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public         gilango@eab.com    false    221         E           2606    771231    users users_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (userid);
 8   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pk;
       public         gilango@eab.com    false    221         F           2606    771232    league league_fk0    FK CONSTRAINT     �   ALTER TABLE ONLY public.league
    ADD CONSTRAINT league_fk0 FOREIGN KEY (league_tournament_id) REFERENCES public.tournament(tournament_id);
 ;   ALTER TABLE ONLY public.league DROP CONSTRAINT league_fk0;
       public       gilango@eab.com    false    196    3135    216         G           2606    771237    league league_fk1    FK CONSTRAINT     ~   ALTER TABLE ONLY public.league
    ADD CONSTRAINT league_fk1 FOREIGN KEY (league_created_by) REFERENCES public.users(userid);
 ;   ALTER TABLE ONLY public.league DROP CONSTRAINT league_fk1;
       public       gilango@eab.com    false    3141    221    196         H           2606    771242    league_member league_member_fk0    FK CONSTRAINT     �   ALTER TABLE ONLY public.league_member
    ADD CONSTRAINT league_member_fk0 FOREIGN KEY (lm_league_id) REFERENCES public.league(league_id);
 I   ALTER TABLE ONLY public.league_member DROP CONSTRAINT league_member_fk0;
       public       gilango@eab.com    false    198    196    3113         I           2606    771247    league_member league_member_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.league_member
    ADD CONSTRAINT league_member_fk1 FOREIGN KEY (league_member_user_id) REFERENCES public.users(userid);
 I   ALTER TABLE ONLY public.league_member DROP CONSTRAINT league_member_fk1;
       public       gilango@eab.com    false    198    3141    221         J           2606    771252 !   match_fixtures match_fixtures_fk0    FK CONSTRAINT     �   ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk0 FOREIGN KEY (match_fixture_team_1) REFERENCES public.team(team_id);
 K   ALTER TABLE ONLY public.match_fixtures DROP CONSTRAINT match_fixtures_fk0;
       public       gilango@eab.com    false    211    3131    200         K           2606    771257 !   match_fixtures match_fixtures_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk1 FOREIGN KEY (match_fixture_team_2) REFERENCES public.team(team_id);
 K   ALTER TABLE ONLY public.match_fixtures DROP CONSTRAINT match_fixtures_fk1;
       public       gilango@eab.com    false    3131    200    211         L           2606    771262 !   match_fixtures match_fixtures_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk2 FOREIGN KEY (match_fixture_tournament_id) REFERENCES public.tournament(tournament_id);
 K   ALTER TABLE ONLY public.match_fixtures DROP CONSTRAINT match_fixtures_fk2;
       public       gilango@eab.com    false    200    216    3135         M           2606    771267 !   match_fixtures match_fixtures_fk3    FK CONSTRAINT     �   ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk3 FOREIGN KEY (match_fixture_venue_stadium_id) REFERENCES public.stadium(stadium_id);
 K   ALTER TABLE ONLY public.match_fixtures DROP CONSTRAINT match_fixtures_fk3;
       public       gilango@eab.com    false    3129    200    209         N           2606    771272 !   match_fixtures match_fixtures_fk4    FK CONSTRAINT     �   ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk4 FOREIGN KEY (match_fixture_result_won) REFERENCES public.team(team_id);
 K   ALTER TABLE ONLY public.match_fixtures DROP CONSTRAINT match_fixtures_fk4;
       public       gilango@eab.com    false    211    3131    200         O           2606    771277 /   member_team_selection member_team_selection_fk0    FK CONSTRAINT     �   ALTER TABLE ONLY public.member_team_selection
    ADD CONSTRAINT member_team_selection_fk0 FOREIGN KEY (league_member_id) REFERENCES public.league_member(league_member_id);
 Y   ALTER TABLE ONLY public.member_team_selection DROP CONSTRAINT member_team_selection_fk0;
       public       gilango@eab.com    false    202    198    3115         P           2606    771282 /   member_team_selection member_team_selection_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.member_team_selection
    ADD CONSTRAINT member_team_selection_fk1 FOREIGN KEY (match_fixture_id) REFERENCES public.match_fixtures(match_fixture_id);
 Y   ALTER TABLE ONLY public.member_team_selection DROP CONSTRAINT member_team_selection_fk1;
       public       gilango@eab.com    false    202    200    3117         Q           2606    771287 /   member_team_selection member_team_selection_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.member_team_selection
    ADD CONSTRAINT member_team_selection_fk2 FOREIGN KEY (selected_team) REFERENCES public.team(team_id);
 Y   ALTER TABLE ONLY public.member_team_selection DROP CONSTRAINT member_team_selection_fk2;
       public       gilango@eab.com    false    211    3131    202         R           2606    771292    teamMember teamMember_fk0    FK CONSTRAINT     �   ALTER TABLE ONLY public."teamMember"
    ADD CONSTRAINT "teamMember_fk0" FOREIGN KEY ("teamMember_team_id") REFERENCES public.team(team_id);
 G   ALTER TABLE ONLY public."teamMember" DROP CONSTRAINT "teamMember_fk0";
       public       gilango@eab.com    false    212    3131    211         S           2606    771297    teamMember teamMember_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public."teamMember"
    ADD CONSTRAINT "teamMember_fk1" FOREIGN KEY ("teamMember_player_id") REFERENCES public.player(player_id);
 G   ALTER TABLE ONLY public."teamMember" DROP CONSTRAINT "teamMember_fk1";
       public       gilango@eab.com    false    212    3119    203         T           2606    771302 1   team_member_preference team_member_preference_fk0    FK CONSTRAINT     �   ALTER TABLE ONLY public.team_member_preference
    ADD CONSTRAINT team_member_preference_fk0 FOREIGN KEY (league_member_id) REFERENCES public.league_member(league_member_id);
 [   ALTER TABLE ONLY public.team_member_preference DROP CONSTRAINT team_member_preference_fk0;
       public       gilango@eab.com    false    198    3115    214         U           2606    771307 1   team_member_preference team_member_preference_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.team_member_preference
    ADD CONSTRAINT team_member_preference_fk1 FOREIGN KEY (team_id) REFERENCES public.team(team_id);
 [   ALTER TABLE ONLY public.team_member_preference DROP CONSTRAINT team_member_preference_fk1;
       public       gilango@eab.com    false    3131    214    211         V           2606    771312    tournament tournament_fk0    FK CONSTRAINT     �   ALTER TABLE ONLY public.tournament
    ADD CONSTRAINT tournament_fk0 FOREIGN KEY (tournament_sport_id) REFERENCES public.sport(sport_id);
 C   ALTER TABLE ONLY public.tournament DROP CONSTRAINT tournament_fk0;
       public       gilango@eab.com    false    207    216    3125         W           2606    771317    transactions transactions_fk0    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_fk0 FOREIGN KEY (transaction_money_from) REFERENCES public.users(userid);
 G   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_fk0;
       public       gilango@eab.com    false    3141    218    221         X           2606    771322    transactions transactions_fk1    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_fk1 FOREIGN KEY (transaction_money_to) REFERENCES public.users(userid);
 G   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_fk1;
       public       gilango@eab.com    false    218    221    3141         Y           2606    771327    transactions transactions_fk2    FK CONSTRAINT     �   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_fk2 FOREIGN KEY (transaction_money_league_id) REFERENCES public.league(league_id);
 G   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_fk2;
       public       gilango@eab.com    false    3113    218    196         Z           2606    771332    user_roles user_roles_fk0    FK CONSTRAINT     |   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_fk0 FOREIGN KEY (user_id) REFERENCES public.users(userid);
 C   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_fk0;
       public       gilango@eab.com    false    221    220    3141         [           2606    771337    user_roles user_roles_fk1    FK CONSTRAINT     }   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_fk1 FOREIGN KEY (role_id) REFERENCES public.roles(role_id);
 C   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_fk1;
       public       gilango@eab.com    false    205    220    3121                                                                                                                                                                                                                                                                                                                                                             3285.dat                                                                                            0000600 0004000 0002000 00000000370 13427313405 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	IIMB Group	1	2	2018-12-02	800	t	f	\N	\N
15	TEST 2	2	20	2019-01-20	10	t	f	o1L8iUFnz	\N
1	Amigos	1	1	2018-12-02	600	t	f	eWRhpRV	\N
19	multiple entry	2	2	2019-02-05	10	t	f	123456	12345678
14	TEST LEAGUE	1	20	2019-01-13	25	t	f	o3eJgJjER	a234dfg
\.


                                                                                                                                                                                                                                                                        3287.dat                                                                                            0000600 0004000 0002000 00000000227 13427313405 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        3	1	1	600	500	t	f
4	1	2	600	550	t	f
5	1	4	600	650	t	f
6	1	6	600	450	t	f
7	1	5	600	400	t	f
11	14	20	\N	\N	t	f
12	15	20	\N	\N	t	f
16	19	2	\N	\N	t	f
\.


                                                                                                                                                                                                                                                                                                                                                                         3289.dat                                                                                            0000600 0004000 0002000 00000000406 13427313405 0014261 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	4	2	1	7	2018-11-19	2018-11-19	2018-11-19 20:00:00	2	\N	\N	t	f
4	9	3	1	1	2018-11-21	2018-11-21	2018-11-21 20:00:00	9	\N	\N	t	f
3	8	7	1	3	2018-11-20	2018-11-20	2018-11-20 20:00:00	7	\N	\N	t	f
5	6	5	1	11	2018-11-22	2018-11-22	2018-11-19 20:00:00	6	\N	\N	t	f
\.


                                                                                                                                                                                                                                                          3291.dat                                                                                            0000600 0004000 0002000 00000000005 13427313405 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3292.dat                                                                                            0000600 0004000 0002000 00000000005 13427313405 0014246 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3294.dat                                                                                            0000600 0004000 0002000 00000000277 13427313405 0014263 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	league member	Member of a league with minimum permission
2	league admin	Member who created the league
3	admin	Admin users
4	tournament admin	Member who can create or modify tournament
\.


                                                                                                                                                                                                                                                                                                                                 3296.dat                                                                                            0000600 0004000 0002000 00000000143 13427313405 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	cricket men	International men cricket	t	f
2	Women's cricket	International women cricket	t	f
\.


                                                                                                                                                                                                                                                                                                                                                                                                                             3298.dat                                                                                            0000600 0004000 0002000 00000002616 13427313405 0014266 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Eden Gardens	Kolkata	West Bengal	India	t	f
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


                                                                                                                  3300.dat                                                                                            0000600 0004000 0002000 00000000406 13427313405 0014241 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	Chennai Super Kings	\N	t	f	CSK
3	Royal Challengers Bangalore	\N	t	f	RCB
4	Mumbai Indians	\N	t	f	MI
5	Rajasthan Royals	\N	t	f	RR
6	Sunrisers Hyderabad	\N	t	f	SRH
7	Kings XI Punjab	\N	t	f	KXIP
8	Delhi Daredevils	\N	t	f	DD
9	Kolkata Knight Riders	\N	t	f	KKR
\.


                                                                                                                                                                                                                                                          3301.dat                                                                                            0000600 0004000 0002000 00000000005 13427313405 0014235 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3303.dat                                                                                            0000600 0004000 0002000 00000000005 13427313405 0014237 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3305.dat                                                                                            0000600 0004000 0002000 00000000152 13427313405 0014244 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	IPL	2019-03-29	2019-05-19	t	f	India
2	1	World Cup 2019	2019-05-30	2019-07-14	t	f	England & Wales
\.


                                                                                                                                                                                                                                                                                                                                                                                                                      3307.dat                                                                                            0000600 0004000 0002000 00000000005 13427313405 0014243 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3309.dat                                                                                            0000600 0004000 0002000 00000000005 13427313405 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3310.dat                                                                                            0000600 0004000 0002000 00000002004 13427313405 0014236 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Gowthaman	Ilango	test@test.com	28	Male	2018-12-02	test	t	f	\N
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


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            restore.sql                                                                                         0000600 0004000 0002000 00000120001 13427313405 0015360 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
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

ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_fk1;
ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_fk0;
ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_fk2;
ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_fk1;
ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_fk0;
ALTER TABLE ONLY public.tournament DROP CONSTRAINT tournament_fk0;
ALTER TABLE ONLY public.team_member_preference DROP CONSTRAINT team_member_preference_fk1;
ALTER TABLE ONLY public.team_member_preference DROP CONSTRAINT team_member_preference_fk0;
ALTER TABLE ONLY public."teamMember" DROP CONSTRAINT "teamMember_fk1";
ALTER TABLE ONLY public."teamMember" DROP CONSTRAINT "teamMember_fk0";
ALTER TABLE ONLY public.member_team_selection DROP CONSTRAINT member_team_selection_fk2;
ALTER TABLE ONLY public.member_team_selection DROP CONSTRAINT member_team_selection_fk1;
ALTER TABLE ONLY public.member_team_selection DROP CONSTRAINT member_team_selection_fk0;
ALTER TABLE ONLY public.match_fixtures DROP CONSTRAINT match_fixtures_fk4;
ALTER TABLE ONLY public.match_fixtures DROP CONSTRAINT match_fixtures_fk3;
ALTER TABLE ONLY public.match_fixtures DROP CONSTRAINT match_fixtures_fk2;
ALTER TABLE ONLY public.match_fixtures DROP CONSTRAINT match_fixtures_fk1;
ALTER TABLE ONLY public.match_fixtures DROP CONSTRAINT match_fixtures_fk0;
ALTER TABLE ONLY public.league_member DROP CONSTRAINT league_member_fk1;
ALTER TABLE ONLY public.league_member DROP CONSTRAINT league_member_fk0;
ALTER TABLE ONLY public.league DROP CONSTRAINT league_fk1;
ALTER TABLE ONLY public.league DROP CONSTRAINT league_fk0;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pk;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pk;
ALTER TABLE ONLY public.tournament DROP CONSTRAINT tournament_pk;
ALTER TABLE ONLY public."teamMember" DROP CONSTRAINT teammember_pk;
ALTER TABLE ONLY public.team DROP CONSTRAINT team_pk;
ALTER TABLE ONLY public.stadium DROP CONSTRAINT stadium_pk;
ALTER TABLE ONLY public.sport DROP CONSTRAINT sport_sport_name_key;
ALTER TABLE ONLY public.sport DROP CONSTRAINT sport_pk;
ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_role_name_key;
ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pk;
ALTER TABLE ONLY public.player DROP CONSTRAINT player_pk;
ALTER TABLE ONLY public.match_fixtures DROP CONSTRAINT match_fixtures_pk;
ALTER TABLE ONLY public.league DROP CONSTRAINT league_pk;
ALTER TABLE ONLY public.league_member DROP CONSTRAINT league_member_pk;
ALTER TABLE public.users ALTER COLUMN userid DROP DEFAULT;
ALTER TABLE public.transactions ALTER COLUMN transaction_id DROP DEFAULT;
ALTER TABLE public.tournament ALTER COLUMN tournament_id DROP DEFAULT;
ALTER TABLE public."teamMember" ALTER COLUMN "teamMember_id" DROP DEFAULT;
ALTER TABLE public.team ALTER COLUMN team_id DROP DEFAULT;
ALTER TABLE public.stadium ALTER COLUMN stadium_id DROP DEFAULT;
ALTER TABLE public.sport ALTER COLUMN sport_id DROP DEFAULT;
ALTER TABLE public.roles ALTER COLUMN role_id DROP DEFAULT;
ALTER TABLE public.player ALTER COLUMN player_id DROP DEFAULT;
ALTER TABLE public.match_fixtures ALTER COLUMN match_fixture_id DROP DEFAULT;
ALTER TABLE public.league_member ALTER COLUMN league_member_id DROP DEFAULT;
ALTER TABLE public.league ALTER COLUMN league_id DROP DEFAULT;
DROP SEQUENCE public."users_userID_seq";
DROP TABLE public.users;
DROP TABLE public.user_roles;
DROP SEQUENCE public.transactions_transaction_id_seq;
DROP TABLE public.transactions;
DROP SEQUENCE public.tournament_tournament_id_seq;
DROP TABLE public.tournament;
DROP SEQUENCE public.team_team_id_seq;
DROP TABLE public.team_member_preference;
DROP SEQUENCE public."teamMember_teamMember_id_seq";
DROP TABLE public."teamMember";
DROP TABLE public.team;
DROP SEQUENCE public.stadium_stadium_id_seq;
DROP TABLE public.stadium;
DROP SEQUENCE public.sport_sport_id_seq;
DROP TABLE public.sport;
DROP SEQUENCE public.roles_role_id_seq;
DROP TABLE public.roles;
DROP SEQUENCE public.player_player_id_seq;
DROP TABLE public.player;
DROP TABLE public.member_team_selection;
DROP SEQUENCE public.match_fixtures_match_fixture_id_seq;
DROP TABLE public.match_fixtures;
DROP SEQUENCE public.league_member_league_member_id_seq;
DROP TABLE public.league_member;
DROP SEQUENCE public.league_league_id_seq;
DROP TABLE public.league;
DROP FUNCTION public.getwinnerslist();
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: gilango@eab.com
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO "gilango@eab.com";

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: gilango@eab.com
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: getwinnerslist(); Type: FUNCTION; Schema: public; Owner: gilango@eab.com
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


ALTER FUNCTION public.getwinnerslist() OWNER TO "gilango@eab.com";

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: league; Type: TABLE; Schema: public; Owner: gilango@eab.com
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
    league_shortid character varying,
    league_pin character varying
);


ALTER TABLE public.league OWNER TO "gilango@eab.com";

--
-- Name: league_league_id_seq; Type: SEQUENCE; Schema: public; Owner: gilango@eab.com
--

CREATE SEQUENCE public.league_league_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.league_league_id_seq OWNER TO "gilango@eab.com";

--
-- Name: league_league_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gilango@eab.com
--

ALTER SEQUENCE public.league_league_id_seq OWNED BY public.league.league_id;


--
-- Name: league_member; Type: TABLE; Schema: public; Owner: gilango@eab.com
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


ALTER TABLE public.league_member OWNER TO "gilango@eab.com";

--
-- Name: league_member_league_member_id_seq; Type: SEQUENCE; Schema: public; Owner: gilango@eab.com
--

CREATE SEQUENCE public.league_member_league_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.league_member_league_member_id_seq OWNER TO "gilango@eab.com";

--
-- Name: league_member_league_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gilango@eab.com
--

ALTER SEQUENCE public.league_member_league_member_id_seq OWNED BY public.league_member.league_member_id;


--
-- Name: match_fixtures; Type: TABLE; Schema: public; Owner: gilango@eab.com
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


ALTER TABLE public.match_fixtures OWNER TO "gilango@eab.com";

--
-- Name: match_fixtures_match_fixture_id_seq; Type: SEQUENCE; Schema: public; Owner: gilango@eab.com
--

CREATE SEQUENCE public.match_fixtures_match_fixture_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.match_fixtures_match_fixture_id_seq OWNER TO "gilango@eab.com";

--
-- Name: match_fixtures_match_fixture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gilango@eab.com
--

ALTER SEQUENCE public.match_fixtures_match_fixture_id_seq OWNED BY public.match_fixtures.match_fixture_id;


--
-- Name: member_team_selection; Type: TABLE; Schema: public; Owner: gilango@eab.com
--

CREATE TABLE public.member_team_selection (
    league_member_id bigint NOT NULL,
    match_fixture_id bigint NOT NULL,
    selected_team bigint NOT NULL
);


ALTER TABLE public.member_team_selection OWNER TO "gilango@eab.com";

--
-- Name: player; Type: TABLE; Schema: public; Owner: gilango@eab.com
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


ALTER TABLE public.player OWNER TO "gilango@eab.com";

--
-- Name: player_player_id_seq; Type: SEQUENCE; Schema: public; Owner: gilango@eab.com
--

CREATE SEQUENCE public.player_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_player_id_seq OWNER TO "gilango@eab.com";

--
-- Name: player_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gilango@eab.com
--

ALTER SEQUENCE public.player_player_id_seq OWNED BY public.player.player_id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: gilango@eab.com
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    role_name character varying NOT NULL,
    role_description character varying NOT NULL
);


ALTER TABLE public.roles OWNER TO "gilango@eab.com";

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: gilango@eab.com
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_role_id_seq OWNER TO "gilango@eab.com";

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gilango@eab.com
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- Name: sport; Type: TABLE; Schema: public; Owner: gilango@eab.com
--

CREATE TABLE public.sport (
    sport_id integer NOT NULL,
    sport_name character varying NOT NULL,
    sport_description character varying NOT NULL,
    sport_active boolean NOT NULL,
    sport_deleted boolean NOT NULL
);


ALTER TABLE public.sport OWNER TO "gilango@eab.com";

--
-- Name: sport_sport_id_seq; Type: SEQUENCE; Schema: public; Owner: gilango@eab.com
--

CREATE SEQUENCE public.sport_sport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sport_sport_id_seq OWNER TO "gilango@eab.com";

--
-- Name: sport_sport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gilango@eab.com
--

ALTER SEQUENCE public.sport_sport_id_seq OWNED BY public.sport.sport_id;


--
-- Name: stadium; Type: TABLE; Schema: public; Owner: gilango@eab.com
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


ALTER TABLE public.stadium OWNER TO "gilango@eab.com";

--
-- Name: stadium_stadium_id_seq; Type: SEQUENCE; Schema: public; Owner: gilango@eab.com
--

CREATE SEQUENCE public.stadium_stadium_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stadium_stadium_id_seq OWNER TO "gilango@eab.com";

--
-- Name: stadium_stadium_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gilango@eab.com
--

ALTER SEQUENCE public.stadium_stadium_id_seq OWNED BY public.stadium.stadium_id;


--
-- Name: team; Type: TABLE; Schema: public; Owner: gilango@eab.com
--

CREATE TABLE public.team (
    team_id integer NOT NULL,
    team_name character varying NOT NULL,
    team_image character varying,
    team_active boolean NOT NULL,
    team_deleted boolean NOT NULL,
    team_abbreviation character varying
);


ALTER TABLE public.team OWNER TO "gilango@eab.com";

--
-- Name: teamMember; Type: TABLE; Schema: public; Owner: gilango@eab.com
--

CREATE TABLE public."teamMember" (
    "teamMember_id" integer NOT NULL,
    "teamMember_team_id" bigint NOT NULL,
    "teamMember_player_id" bigint NOT NULL,
    "teamMember_active" boolean NOT NULL,
    "teamMember_deleted" boolean NOT NULL
);


ALTER TABLE public."teamMember" OWNER TO "gilango@eab.com";

--
-- Name: teamMember_teamMember_id_seq; Type: SEQUENCE; Schema: public; Owner: gilango@eab.com
--

CREATE SEQUENCE public."teamMember_teamMember_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."teamMember_teamMember_id_seq" OWNER TO "gilango@eab.com";

--
-- Name: teamMember_teamMember_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gilango@eab.com
--

ALTER SEQUENCE public."teamMember_teamMember_id_seq" OWNED BY public."teamMember"."teamMember_id";


--
-- Name: team_member_preference; Type: TABLE; Schema: public; Owner: gilango@eab.com
--

CREATE TABLE public.team_member_preference (
    league_member_id bigint NOT NULL,
    team_id bigint NOT NULL,
    rank integer NOT NULL
);


ALTER TABLE public.team_member_preference OWNER TO "gilango@eab.com";

--
-- Name: team_team_id_seq; Type: SEQUENCE; Schema: public; Owner: gilango@eab.com
--

CREATE SEQUENCE public.team_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_team_id_seq OWNER TO "gilango@eab.com";

--
-- Name: team_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gilango@eab.com
--

ALTER SEQUENCE public.team_team_id_seq OWNED BY public.team.team_id;


--
-- Name: tournament; Type: TABLE; Schema: public; Owner: gilango@eab.com
--

CREATE TABLE public.tournament (
    tournament_id integer NOT NULL,
    tournament_sport_id bigint NOT NULL,
    tournament_name character varying NOT NULL,
    tournament_start_date date NOT NULL,
    tournament_end_date date NOT NULL,
    tournament_active boolean NOT NULL,
    tournament_deleted boolean NOT NULL,
    tournament_venue character varying
);


ALTER TABLE public.tournament OWNER TO "gilango@eab.com";

--
-- Name: tournament_tournament_id_seq; Type: SEQUENCE; Schema: public; Owner: gilango@eab.com
--

CREATE SEQUENCE public.tournament_tournament_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tournament_tournament_id_seq OWNER TO "gilango@eab.com";

--
-- Name: tournament_tournament_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gilango@eab.com
--

ALTER SEQUENCE public.tournament_tournament_id_seq OWNED BY public.tournament.tournament_id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: gilango@eab.com
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


ALTER TABLE public.transactions OWNER TO "gilango@eab.com";

--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: gilango@eab.com
--

CREATE SEQUENCE public.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_transaction_id_seq OWNER TO "gilango@eab.com";

--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gilango@eab.com
--

ALTER SEQUENCE public.transactions_transaction_id_seq OWNED BY public.transactions.transaction_id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: gilango@eab.com
--

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.user_roles OWNER TO "gilango@eab.com";

--
-- Name: users; Type: TABLE; Schema: public; Owner: gilango@eab.com
--

CREATE TABLE public.users (
    userid integer NOT NULL,
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


ALTER TABLE public.users OWNER TO "gilango@eab.com";

--
-- Name: users_userID_seq; Type: SEQUENCE; Schema: public; Owner: gilango@eab.com
--

CREATE SEQUENCE public."users_userID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."users_userID_seq" OWNER TO "gilango@eab.com";

--
-- Name: users_userID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gilango@eab.com
--

ALTER SEQUENCE public."users_userID_seq" OWNED BY public.users.userid;


--
-- Name: league league_id; Type: DEFAULT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.league ALTER COLUMN league_id SET DEFAULT nextval('public.league_league_id_seq'::regclass);


--
-- Name: league_member league_member_id; Type: DEFAULT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.league_member ALTER COLUMN league_member_id SET DEFAULT nextval('public.league_member_league_member_id_seq'::regclass);


--
-- Name: match_fixtures match_fixture_id; Type: DEFAULT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.match_fixtures ALTER COLUMN match_fixture_id SET DEFAULT nextval('public.match_fixtures_match_fixture_id_seq'::regclass);


--
-- Name: player player_id; Type: DEFAULT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.player ALTER COLUMN player_id SET DEFAULT nextval('public.player_player_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- Name: sport sport_id; Type: DEFAULT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.sport ALTER COLUMN sport_id SET DEFAULT nextval('public.sport_sport_id_seq'::regclass);


--
-- Name: stadium stadium_id; Type: DEFAULT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.stadium ALTER COLUMN stadium_id SET DEFAULT nextval('public.stadium_stadium_id_seq'::regclass);


--
-- Name: team team_id; Type: DEFAULT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.team ALTER COLUMN team_id SET DEFAULT nextval('public.team_team_id_seq'::regclass);


--
-- Name: teamMember teamMember_id; Type: DEFAULT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public."teamMember" ALTER COLUMN "teamMember_id" SET DEFAULT nextval('public."teamMember_teamMember_id_seq"'::regclass);


--
-- Name: tournament tournament_id; Type: DEFAULT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.tournament ALTER COLUMN tournament_id SET DEFAULT nextval('public.tournament_tournament_id_seq'::regclass);


--
-- Name: transactions transaction_id; Type: DEFAULT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.transactions_transaction_id_seq'::regclass);


--
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public."users_userID_seq"'::regclass);


--
-- Data for Name: league; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public.league (league_id, league_name, league_tournament_id, league_created_by, league_created_on, league_minimum_bet, league_active, league_deleted, league_shortid, league_pin) FROM stdin;
\.
COPY public.league (league_id, league_name, league_tournament_id, league_created_by, league_created_on, league_minimum_bet, league_active, league_deleted, league_shortid, league_pin) FROM '$$PATH$$/3285.dat';

--
-- Data for Name: league_member; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public.league_member (league_member_id, lm_league_id, league_member_user_id, league_member_initial_bet_amount, league_member_current_bet_amount, league_member_active, league_member_deleted) FROM stdin;
\.
COPY public.league_member (league_member_id, lm_league_id, league_member_user_id, league_member_initial_bet_amount, league_member_current_bet_amount, league_member_active, league_member_deleted) FROM '$$PATH$$/3287.dat';

--
-- Data for Name: match_fixtures; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public.match_fixtures (match_fixture_id, match_fixture_team_1, match_fixture_team_2, match_fixture_tournament_id, match_fixture_venue_stadium_id, match_fixture_start_date, match_fixture_end_date, match_fixture_toss_time, match_fixture_result_won, match_fixture_result_draw, match_fixture_no_result, match_fixture_active, match_fixture_deleted) FROM stdin;
\.
COPY public.match_fixtures (match_fixture_id, match_fixture_team_1, match_fixture_team_2, match_fixture_tournament_id, match_fixture_venue_stadium_id, match_fixture_start_date, match_fixture_end_date, match_fixture_toss_time, match_fixture_result_won, match_fixture_result_draw, match_fixture_no_result, match_fixture_active, match_fixture_deleted) FROM '$$PATH$$/3289.dat';

--
-- Data for Name: member_team_selection; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public.member_team_selection (league_member_id, match_fixture_id, selected_team) FROM stdin;
\.
COPY public.member_team_selection (league_member_id, match_fixture_id, selected_team) FROM '$$PATH$$/3291.dat';

--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public.player (player_id, player_name, player_age, player_sex, player_position, player_photo, player_active, player_deleted, player_total_odi_matches, player_total_odi_runs, player_total_odi_wickets, player_total_odi_catches, player_total_odi_fifties, player_total_odi_centuries, player_odi_highest_score, player_odi_best_bowling, player_total_t20_matches, player_total_t20_runs, player_total_t20_wickets, player_total_t20_catches, player_total_t20_fifties, player_total_t20_centuries, player_t20_highest_score, player_t20_best_bowling, player_total_test_matches, player_total_test_runs, player_total_test_wickets, player_total_test_catches, player_total_test_fifties, player_total_test_centuries, player_test_highest_score, player_test_best_bowling) FROM stdin;
\.
COPY public.player (player_id, player_name, player_age, player_sex, player_position, player_photo, player_active, player_deleted, player_total_odi_matches, player_total_odi_runs, player_total_odi_wickets, player_total_odi_catches, player_total_odi_fifties, player_total_odi_centuries, player_odi_highest_score, player_odi_best_bowling, player_total_t20_matches, player_total_t20_runs, player_total_t20_wickets, player_total_t20_catches, player_total_t20_fifties, player_total_t20_centuries, player_t20_highest_score, player_t20_best_bowling, player_total_test_matches, player_total_test_runs, player_total_test_wickets, player_total_test_catches, player_total_test_fifties, player_total_test_centuries, player_test_highest_score, player_test_best_bowling) FROM '$$PATH$$/3292.dat';

--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public.roles (role_id, role_name, role_description) FROM stdin;
\.
COPY public.roles (role_id, role_name, role_description) FROM '$$PATH$$/3294.dat';

--
-- Data for Name: sport; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public.sport (sport_id, sport_name, sport_description, sport_active, sport_deleted) FROM stdin;
\.
COPY public.sport (sport_id, sport_name, sport_description, sport_active, sport_deleted) FROM '$$PATH$$/3296.dat';

--
-- Data for Name: stadium; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public.stadium (stadium_id, stadium_name, stadium_city, stadium_state, stadium_country, stadium_active, stadium_deleted) FROM stdin;
\.
COPY public.stadium (stadium_id, stadium_name, stadium_city, stadium_state, stadium_country, stadium_active, stadium_deleted) FROM '$$PATH$$/3298.dat';

--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public.team (team_id, team_name, team_image, team_active, team_deleted, team_abbreviation) FROM stdin;
\.
COPY public.team (team_id, team_name, team_image, team_active, team_deleted, team_abbreviation) FROM '$$PATH$$/3300.dat';

--
-- Data for Name: teamMember; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public."teamMember" ("teamMember_id", "teamMember_team_id", "teamMember_player_id", "teamMember_active", "teamMember_deleted") FROM stdin;
\.
COPY public."teamMember" ("teamMember_id", "teamMember_team_id", "teamMember_player_id", "teamMember_active", "teamMember_deleted") FROM '$$PATH$$/3301.dat';

--
-- Data for Name: team_member_preference; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public.team_member_preference (league_member_id, team_id, rank) FROM stdin;
\.
COPY public.team_member_preference (league_member_id, team_id, rank) FROM '$$PATH$$/3303.dat';

--
-- Data for Name: tournament; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public.tournament (tournament_id, tournament_sport_id, tournament_name, tournament_start_date, tournament_end_date, tournament_active, tournament_deleted, tournament_venue) FROM stdin;
\.
COPY public.tournament (tournament_id, tournament_sport_id, tournament_name, tournament_start_date, tournament_end_date, tournament_active, tournament_deleted, tournament_venue) FROM '$$PATH$$/3305.dat';

--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public.transactions (transaction_id, transaction_money_from, transaction_money_to, transaction_money_amonut, transaction_money_league_id, transaction_date, transaction_active, transaction_deleted) FROM stdin;
\.
COPY public.transactions (transaction_id, transaction_money_from, transaction_money_to, transaction_money_amonut, transaction_money_league_id, transaction_date, transaction_active, transaction_deleted) FROM '$$PATH$$/3307.dat';

--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public.user_roles (user_id, role_id) FROM stdin;
\.
COPY public.user_roles (user_id, role_id) FROM '$$PATH$$/3309.dat';

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: gilango@eab.com
--

COPY public.users (userid, firstname, lastname, email, age, sex, accountcreationdate, password, active, deleted, shortid) FROM stdin;
\.
COPY public.users (userid, firstname, lastname, email, age, sex, accountcreationdate, password, active, deleted, shortid) FROM '$$PATH$$/3310.dat';

--
-- Name: league_league_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gilango@eab.com
--

SELECT pg_catalog.setval('public.league_league_id_seq', 20, true);


--
-- Name: league_member_league_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gilango@eab.com
--

SELECT pg_catalog.setval('public.league_member_league_member_id_seq', 18, true);


--
-- Name: match_fixtures_match_fixture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gilango@eab.com
--

SELECT pg_catalog.setval('public.match_fixtures_match_fixture_id_seq', 5, true);


--
-- Name: player_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gilango@eab.com
--

SELECT pg_catalog.setval('public.player_player_id_seq', 1, false);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gilango@eab.com
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 4, true);


--
-- Name: sport_sport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gilango@eab.com
--

SELECT pg_catalog.setval('public.sport_sport_id_seq', 2, true);


--
-- Name: stadium_stadium_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gilango@eab.com
--

SELECT pg_catalog.setval('public.stadium_stadium_id_seq', 22, true);


--
-- Name: teamMember_teamMember_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gilango@eab.com
--

SELECT pg_catalog.setval('public."teamMember_teamMember_id_seq"', 1, false);


--
-- Name: team_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gilango@eab.com
--

SELECT pg_catalog.setval('public.team_team_id_seq', 9, true);


--
-- Name: tournament_tournament_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gilango@eab.com
--

SELECT pg_catalog.setval('public.tournament_tournament_id_seq', 2, true);


--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gilango@eab.com
--

SELECT pg_catalog.setval('public.transactions_transaction_id_seq', 1, false);


--
-- Name: users_userID_seq; Type: SEQUENCE SET; Schema: public; Owner: gilango@eab.com
--

SELECT pg_catalog.setval('public."users_userID_seq"', 25, true);


--
-- Name: league_member league_member_pk; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.league_member
    ADD CONSTRAINT league_member_pk PRIMARY KEY (league_member_id);


--
-- Name: league league_pk; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.league
    ADD CONSTRAINT league_pk PRIMARY KEY (league_id);


--
-- Name: match_fixtures match_fixtures_pk; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_pk PRIMARY KEY (match_fixture_id);


--
-- Name: player player_pk; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pk PRIMARY KEY (player_id);


--
-- Name: roles roles_pk; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pk PRIMARY KEY (role_id);


--
-- Name: roles roles_role_name_key; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);


--
-- Name: sport sport_pk; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.sport
    ADD CONSTRAINT sport_pk PRIMARY KEY (sport_id);


--
-- Name: sport sport_sport_name_key; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.sport
    ADD CONSTRAINT sport_sport_name_key UNIQUE (sport_name);


--
-- Name: stadium stadium_pk; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.stadium
    ADD CONSTRAINT stadium_pk PRIMARY KEY (stadium_id);


--
-- Name: team team_pk; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pk PRIMARY KEY (team_id);


--
-- Name: teamMember teammember_pk; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public."teamMember"
    ADD CONSTRAINT teammember_pk PRIMARY KEY ("teamMember_id");


--
-- Name: tournament tournament_pk; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.tournament
    ADD CONSTRAINT tournament_pk PRIMARY KEY (tournament_id);


--
-- Name: transactions transactions_pk; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pk PRIMARY KEY (transaction_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (userid);


--
-- Name: league league_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.league
    ADD CONSTRAINT league_fk0 FOREIGN KEY (league_tournament_id) REFERENCES public.tournament(tournament_id);


--
-- Name: league league_fk1; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.league
    ADD CONSTRAINT league_fk1 FOREIGN KEY (league_created_by) REFERENCES public.users(userid);


--
-- Name: league_member league_member_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.league_member
    ADD CONSTRAINT league_member_fk0 FOREIGN KEY (lm_league_id) REFERENCES public.league(league_id);


--
-- Name: league_member league_member_fk1; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.league_member
    ADD CONSTRAINT league_member_fk1 FOREIGN KEY (league_member_user_id) REFERENCES public.users(userid);


--
-- Name: match_fixtures match_fixtures_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk0 FOREIGN KEY (match_fixture_team_1) REFERENCES public.team(team_id);


--
-- Name: match_fixtures match_fixtures_fk1; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk1 FOREIGN KEY (match_fixture_team_2) REFERENCES public.team(team_id);


--
-- Name: match_fixtures match_fixtures_fk2; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk2 FOREIGN KEY (match_fixture_tournament_id) REFERENCES public.tournament(tournament_id);


--
-- Name: match_fixtures match_fixtures_fk3; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk3 FOREIGN KEY (match_fixture_venue_stadium_id) REFERENCES public.stadium(stadium_id);


--
-- Name: match_fixtures match_fixtures_fk4; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.match_fixtures
    ADD CONSTRAINT match_fixtures_fk4 FOREIGN KEY (match_fixture_result_won) REFERENCES public.team(team_id);


--
-- Name: member_team_selection member_team_selection_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.member_team_selection
    ADD CONSTRAINT member_team_selection_fk0 FOREIGN KEY (league_member_id) REFERENCES public.league_member(league_member_id);


--
-- Name: member_team_selection member_team_selection_fk1; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.member_team_selection
    ADD CONSTRAINT member_team_selection_fk1 FOREIGN KEY (match_fixture_id) REFERENCES public.match_fixtures(match_fixture_id);


--
-- Name: member_team_selection member_team_selection_fk2; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.member_team_selection
    ADD CONSTRAINT member_team_selection_fk2 FOREIGN KEY (selected_team) REFERENCES public.team(team_id);


--
-- Name: teamMember teamMember_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public."teamMember"
    ADD CONSTRAINT "teamMember_fk0" FOREIGN KEY ("teamMember_team_id") REFERENCES public.team(team_id);


--
-- Name: teamMember teamMember_fk1; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public."teamMember"
    ADD CONSTRAINT "teamMember_fk1" FOREIGN KEY ("teamMember_player_id") REFERENCES public.player(player_id);


--
-- Name: team_member_preference team_member_preference_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.team_member_preference
    ADD CONSTRAINT team_member_preference_fk0 FOREIGN KEY (league_member_id) REFERENCES public.league_member(league_member_id);


--
-- Name: team_member_preference team_member_preference_fk1; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.team_member_preference
    ADD CONSTRAINT team_member_preference_fk1 FOREIGN KEY (team_id) REFERENCES public.team(team_id);


--
-- Name: tournament tournament_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.tournament
    ADD CONSTRAINT tournament_fk0 FOREIGN KEY (tournament_sport_id) REFERENCES public.sport(sport_id);


--
-- Name: transactions transactions_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_fk0 FOREIGN KEY (transaction_money_from) REFERENCES public.users(userid);


--
-- Name: transactions transactions_fk1; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_fk1 FOREIGN KEY (transaction_money_to) REFERENCES public.users(userid);


--
-- Name: transactions transactions_fk2; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_fk2 FOREIGN KEY (transaction_money_league_id) REFERENCES public.league(league_id);


--
-- Name: user_roles user_roles_fk0; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_fk0 FOREIGN KEY (user_id) REFERENCES public.users(userid);


--
-- Name: user_roles user_roles_fk1; Type: FK CONSTRAINT; Schema: public; Owner: gilango@eab.com
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_fk1 FOREIGN KEY (role_id) REFERENCES public.roles(role_id);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               