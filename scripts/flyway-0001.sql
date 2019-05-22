//INSERT STATEMENTS FOR PROD DB

insert into roles (role_name, role_description)
VALUES('LEAGUE_MEMBER', 'Member of a league with minimum permission'),
('LEAGUE_ADMIN', 'Member who created the league'),
('ADMIN', 'Admin users'),
('TOURNAMENT_ADMIN', 'Member who can create or modify tournament')