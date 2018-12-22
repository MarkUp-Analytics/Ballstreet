SELECT t1.team_name as team1, t2.team_name as team2, mf.match_fixture_start_date as match_date, t3.team_name as winning_team
     
FROM 
     match_fixtures as mf
     LEFT JOIN team t1 ON t1.team_id=mf.match_fixture_team_1 
     LEFT JOIN team t2 ON t2.team_id=mf.match_fixture_team_2
	 LEFT JOIN team t3 ON t3.team_id=mf.match_fixture_result_won
order by match_date asc;
	 