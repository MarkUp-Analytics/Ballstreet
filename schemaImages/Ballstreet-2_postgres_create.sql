CREATE TABLE "users" (
	"userID" serial NOT NULL,
	"firstname" varchar NOT NULL,
	"lastname" varchar NOT NULL,
	"email" varchar NOT NULL UNIQUE,
	"age" integer NOT NULL,
	"sex" varchar NOT NULL,
	"accountcreationdate" DATE NOT NULL,
	"password" varchar NOT NULL,
	"active" BOOLEAN NOT NULL,
	"deleted" BOOLEAN NOT NULL,
	CONSTRAINT users_pk PRIMARY KEY ("userID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "roles" (
	"role_id" serial NOT NULL,
	"role_name" varchar NOT NULL UNIQUE,
	"role_description" varchar NOT NULL,
	CONSTRAINT roles_pk PRIMARY KEY ("role_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "tournament" (
	"tournament_id" serial NOT NULL,
	"tournament_sport_id" bigint NOT NULL,
	"tournament_name" varchar NOT NULL,
	"tournament_start_date" DATE NOT NULL,
	"tournament_end_date" DATE NOT NULL,
	"tournament_active" BOOLEAN NOT NULL,
	"tournament_deleted" BOOLEAN NOT NULL,
	CONSTRAINT tournament_pk PRIMARY KEY ("tournament_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "sport" (
	"sport_id" serial NOT NULL,
	"sport_name" varchar NOT NULL UNIQUE,
	"sport_description" varchar NOT NULL,
	"sport_active" BOOLEAN NOT NULL,
	"sport_deleted" BOOLEAN NOT NULL,
	CONSTRAINT sport_pk PRIMARY KEY ("sport_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "team" (
	"team_id" serial NOT NULL,
	"team_name" varchar NOT NULL,
	"team_image" varchar NOT NULL,
	"team_active" BOOLEAN NOT NULL,
	"team_deleted" BOOLEAN NOT NULL,
	CONSTRAINT team_pk PRIMARY KEY ("team_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "teamMember" (
	"teamMember_id" serial NOT NULL,
	"teamMember_team_id" bigint NOT NULL,
	"teamMember_player_id" bigint NOT NULL,
	"teamMember_active" BOOLEAN NOT NULL,
	"teamMember_deleted" BOOLEAN NOT NULL,
	CONSTRAINT teamMember_pk PRIMARY KEY ("teamMember_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "player" (
	"player_id" serial NOT NULL,
	"player_name" varchar NOT NULL,
	"player_age" integer NOT NULL,
	"player_sex" varchar NOT NULL,
	"player_position" varchar NOT NULL,
	"player_photo" varchar NOT NULL,
	"player_active" BOOLEAN NOT NULL,
	"player_deleted" BOOLEAN NOT NULL,
	"player_total_odi_matches" integer NOT NULL,
	"player_total_odi_runs" integer NOT NULL,
	"player_total_odi_wickets" integer NOT NULL,
	"player_total_odi_catches" integer NOT NULL,
	"player_total_odi_fifties" integer NOT NULL,
	"player_total_odi_centuries" integer NOT NULL,
	"player_odi_highest_score" varchar NOT NULL,
	"player_odi_best_bowling" varchar NOT NULL,
	"player_total_t20_matches" integer NOT NULL,
	"player_total_t20_runs" integer NOT NULL,
	"player_total_t20_wickets" integer NOT NULL,
	"player_total_t20_catches" integer NOT NULL,
	"player_total_t20_fifties" integer NOT NULL,
	"player_total_t20_centuries" integer NOT NULL,
	"player_t20_highest_score" varchar NOT NULL,
	"player_t20_best_bowling" varchar NOT NULL,
	"player_total_test_matches" integer NOT NULL,
	"player_total_test_runs" integer NOT NULL,
	"player_total_test_wickets" integer NOT NULL,
	"player_total_test_catches" integer NOT NULL,
	"player_total_test_fifties" integer NOT NULL,
	"player_total_test_centuries" integer NOT NULL,
	"player_test_highest_score" varchar NOT NULL,
	"player_test_best_bowling" varchar NOT NULL,
	CONSTRAINT player_pk PRIMARY KEY ("player_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "match_fixtures" (
	"match_fixture_id" serial NOT NULL,
	"match_fixture_team_1" bigint NOT NULL,
	"match_fixture_team_2" bigint NOT NULL,
	"match_fixture_tournament_id" bigint NOT NULL,
	"match_fixture_venue_stadium_id" bigint NOT NULL,
	"match_fixture_start_date" DATE NOT NULL,
	"match_fixture_end_date" DATE NOT NULL,
	"match_fixture_toss_time" TIMESTAMP NOT NULL,
	"match_fixture_result_won" bigint,
	"match_fixture_result_draw" BOOLEAN,
	"match_fixture_no_result" BOOLEAN,
	"match_fixture_active" BOOLEAN NOT NULL,
	"match_fixture_deleted" BOOLEAN NOT NULL,
	CONSTRAINT match_fixtures_pk PRIMARY KEY ("match_fixture_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "league" (
	"league_id" serial NOT NULL,
	"league_shortid" varchar NOT NULL,
	"league_name" varchar NOT NULL,
	"league_tournament_id" bigint NOT NULL,
	"league_created_by" bigint NOT NULL,
	"league_created_on" DATE NOT NULL,
	"league_minimum_bet" integer NOT NULL,
	"league_active" BOOLEAN NOT NULL,
	"league_deleted" BOOLEAN NOT NULL,
	CONSTRAINT league_pk PRIMARY KEY ("league_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "league_member" (
	"league_member_id" serial NOT NULL,
	"lm_league_id" bigint NOT NULL,
	"league_member_user_id" bigint NOT NULL,
	"league_member_initial_bet_amount" DECIMAL NOT NULL,
	"league_member_current_bet_amount" DECIMAL NOT NULL,
	"league_member_role_id" bigint NOT NULL,
	"league_member_active" BOOLEAN NOT NULL,
	"league_member_deleted" BOOLEAN NOT NULL,
	CONSTRAINT league_member_pk PRIMARY KEY ("league_member_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "stadium" (
	"stadium_id" serial NOT NULL,
	"stadium_name" varchar NOT NULL,
	"stadium_city" varchar NOT NULL,
	"stadium_state" varchar NOT NULL,
	"stadium_country" varchar NOT NULL,
	"stadium_active" BOOLEAN NOT NULL,
	"stadium_deleted" BOOLEAN NOT NULL,
	CONSTRAINT stadium_pk PRIMARY KEY ("stadium_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "user_roles" (
	"user_id" bigint NOT NULL,
	"role_id" bigint NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "member_team_selection" (
	"league_member_id" bigint NOT NULL,
	"match_fixture_id" bigint NOT NULL,
	"selected_team" bigint NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "team_member_preference" (
	"league_member_id" bigint NOT NULL,
	"team_id" bigint NOT NULL,
	"rank" integer NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "transactions" (
	"transaction_id" serial NOT NULL,
	"transaction_money_from" bigint NOT NULL,
	"transaction_money_to" bigint NOT NULL,
	"transaction_money_amonut" integer NOT NULL,
	"transaction_money_league_id" integer NOT NULL,
	"transaction_date" DATE NOT NULL,
	"transaction_active" BOOLEAN NOT NULL,
	"transaction_deleted" BOOLEAN NOT NULL,
	CONSTRAINT transactions_pk PRIMARY KEY ("transaction_id")
) WITH (
  OIDS=FALSE
);





ALTER TABLE "tournament" ADD CONSTRAINT "tournament_fk0" FOREIGN KEY ("tournament_sport_id") REFERENCES "sport"("sport_id");



ALTER TABLE "teamMember" ADD CONSTRAINT "teamMember_fk0" FOREIGN KEY ("teamMember_team_id") REFERENCES "team"("team_id");
ALTER TABLE "teamMember" ADD CONSTRAINT "teamMember_fk1" FOREIGN KEY ("teamMember_player_id") REFERENCES "player"("player_id");


ALTER TABLE "match_fixtures" ADD CONSTRAINT "match_fixtures_fk0" FOREIGN KEY ("match_fixture_team_1") REFERENCES "team"("team_id");
ALTER TABLE "match_fixtures" ADD CONSTRAINT "match_fixtures_fk1" FOREIGN KEY ("match_fixture_team_2") REFERENCES "team"("team_id");
ALTER TABLE "match_fixtures" ADD CONSTRAINT "match_fixtures_fk2" FOREIGN KEY ("match_fixture_tournament_id") REFERENCES "tournament"("tournament_id");
ALTER TABLE "match_fixtures" ADD CONSTRAINT "match_fixtures_fk3" FOREIGN KEY ("match_fixture_venue_stadium_id") REFERENCES "stadium"("stadium_id");
ALTER TABLE "match_fixtures" ADD CONSTRAINT "match_fixtures_fk4" FOREIGN KEY ("match_fixture_result_won") REFERENCES "team"("team_id");

ALTER TABLE "league" ADD CONSTRAINT "league_fk0" FOREIGN KEY ("league_tournament_id") REFERENCES "tournament"("tournament_id");
ALTER TABLE "league" ADD CONSTRAINT "league_fk1" FOREIGN KEY ("league_created_by") REFERENCES "users"("userID");

ALTER TABLE "league_member" ADD CONSTRAINT "league_member_fk0" FOREIGN KEY ("lm_league_id") REFERENCES "league"("league_id");
ALTER TABLE "league_member" ADD CONSTRAINT "league_member_fk1" FOREIGN KEY ("league_member_user_id") REFERENCES "users"("userID");
ALTER TABLE "league_member" ADD CONSTRAINT "league_member_fk2" FOREIGN KEY ("league_member_role_id") REFERENCES "roles"("role_id");


ALTER TABLE "user_roles" ADD CONSTRAINT "user_roles_fk0" FOREIGN KEY ("user_id") REFERENCES "users"("userID");
ALTER TABLE "user_roles" ADD CONSTRAINT "user_roles_fk1" FOREIGN KEY ("role_id") REFERENCES "roles"("role_id");

ALTER TABLE "member_team_selection" ADD CONSTRAINT "member_team_selection_fk0" FOREIGN KEY ("league_member_id") REFERENCES "league_member"("league_member_id");
ALTER TABLE "member_team_selection" ADD CONSTRAINT "member_team_selection_fk1" FOREIGN KEY ("match_fixture_id") REFERENCES "match_fixtures"("match_fixture_id");
ALTER TABLE "member_team_selection" ADD CONSTRAINT "member_team_selection_fk2" FOREIGN KEY ("selected_team") REFERENCES "team"("team_id");

ALTER TABLE "team_member_preference" ADD CONSTRAINT "team_member_preference_fk0" FOREIGN KEY ("league_member_id") REFERENCES "league_member"("league_member_id");
ALTER TABLE "team_member_preference" ADD CONSTRAINT "team_member_preference_fk1" FOREIGN KEY ("team_id") REFERENCES "team"("team_id");

ALTER TABLE "transactions" ADD CONSTRAINT "transactions_fk0" FOREIGN KEY ("transaction_money_from") REFERENCES "users"("userID");
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_fk1" FOREIGN KEY ("transaction_money_to") REFERENCES "users"("userID");
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_fk2" FOREIGN KEY ("transaction_money_league_id") REFERENCES "league"("league_id");

