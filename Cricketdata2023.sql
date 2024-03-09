--Syntax for creating table--
--Data types: Varchar(n), INT, FLOAT, NUMERIC
--CREATE table tablename(column1 datatype constraint, column2 datatype constraint, ...column n datatype constraint)

CREATE table batting (Player varchar(100),Country varchar(100),	Match_Played varchar(100),
					  Inning varchar(100),	Not_out varchar(100),Runs varchar(100),	High_Score varchar(100),
					  Average varchar(100),	Ball_Faced varchar(100), SR varchar(100), hundred varchar(100),
					  fifty varchar(100),	zeros varchar(100),	four varchar(100),	six varchar(100)) 
					  
CREATE table bowling (Bowlers varchar(100),	Country varchar(100),	Match_Played varchar(100),
					  Innings varchar(100),	Balls varchar(100),	Overs varchar(100),	maiden varchar(100),
					  Runs varchar(100),Wkts varchar(100),	Average varchar(100),	Economy varchar(100),
					  Strike_Rate varchar(100),	fourwicket varchar(100), fivewicket varchar(100))
					  
CREATE table partnership (Partners varchar(100),	Runs varchar(100),	Wkt varchar(100),Team varchar(100),
						  Opposition varchar(100),	Ground varchar(100))
						  
CREATE table best_team (Team varchar(100),	Score varchar(100),	Overs varchar(100),	Run_Rate varchar(100),
						Innings1 varchar(100),	Opposition1 varchar(100),	Venue varchar(100))
				
						
select * from batting
select * from bowling
select * from partnership

--remove extra space from player column (batting table)--
update batting
SET player = TRIM(BOTH ' ' FROM player)

--Q1. Retrieve the names of all bowlers from the table.--
select bowlers from bowling

--Q2:Find the countries represented in the table and count how many bowlers are from each country.--
SELECT country, COUNT(*) AS Bowlercount FROM bowling GROUP BY country 
SELECT country, COUNT(*) AS Bowlercount FROM bowling GROUP BY country ORDER BY country

-- Remove this '_' from maiden column and update bowling table--
UPDATE bowling
set maiden = 0 WHERE maiden='-'

--Q3:Find the bowler(s) with the highest number of midens.
SELECT bowlers from bowling where maiden::integer=(select max(maiden::integer)from bowling)

--Q4: find the bowler who bowled max no. of balls
SELECT bowlers, balls FROM bowling WHERE balls::integer=(SELECT MAX(balls::integer) from bowling)

--Q5:find the bowler and balls who bowled min no. of balls
 SELECT bowlers, balls FROM bowling WHERE balls::integer=(SELECT MIN(balls::integer)FROM bowling)

--Q6:Find the bowler(s) with the lowest number of midens
SELECT bowlers, maiden::integer FROM bowling WHERE maiden::integer=(select min(maiden::integer)from bowling)

--Q7:Identify the bowler(s) with the best economy rate (lowest economy).
SELECT bowlers, economy FROM bowling WHERE economy::float=(SELECT MIN(economy::float)FROM bowling)

--Q8:Find the first five bowler name with lowest economy rate and the number of matched played.
SELECT bowlers, economy, match_played FROM bowling ORDER BY economy::float limit 5

--Q9:Find the bowler(s) with the best strike rate (lowest strike rate).
SELECT bowlers, strike_rate from bowling WHERE strike_rate::NUMERIC=(SELECT MIN(strike_rate::NUMERIC)FROM bowling)

--Q10:Determine the number of bowlers who have taken four or more wickets in a match.
SELECT count(*) As bowlercount FROM bowling WHERE wkts::numeric >=4

--Q11:Find the number of hundreds scored by V Kohli
SELECT hundred FROM batting WHERE player='V Kohli'

--Q12:Find the player who scored maximum runs of thr country NZ
SELECT player FROM batting WHERE runs::numeric=(SELECT MAX(runs::numeric)FROM batting WHERE country='NZ')

--Q13:Find the player who score lowest run from country Australia.
SELECT player FROM batting WHERE runs::numeric=(SELECT MIN(runs::numeric)FROM batting WHERE country='AUS')

--Remove '-' from average column and update batting table
UPDATE batting
SET average=0 WHERE average='-'

--Q14:Find the player who have highest average in the tournament.
SELECT player from batting where average::numeric=(select MAX(average::numeric)from batting)

--Q15:Find the player who have lowest srike rate (Sr) in the tournament.
SELECT player FROM batting WHERE sr::numeric=(SELECT MIN(sr::numeric)FROM batting) 

--Q16:Find the player who have scored maximum runs from country India.
SELECT player from batting WHERE runs::numeric=(SELECT MAX(runs::numeric)FROM batting WHERE country='IND')

--Q17:Find the bolwer name who have taken maximum wickets in the tournament.
SELECT bowlers FROM bowling WHERE wkts::numeric=(SELECT MAX(wkts::numeric)from bowling)

--Q18:Find the bolwer name who have taken maximum four wickets haul in the tournament.
SELECT bowlers FROM bowling WHERE wkts::numeric=4

--Q19:Find the list of bowlers whose economy is below 5
SELECT bowlers FROM bowling WHERE economy::numeric <5

--Q20:Find the bowlers from South Africa who have bowled more than 3 maiden in the tournaments.
SELECT bowlers from bowling WHERE maiden::numeric>3 and country='SA'

--****-------****-------***---------****-----------**----------------------------------------------
SELECT * from partnership

--Add two new column in the partnership table--
ALTER table partnership
add column player_1 varchar(100),
add column player_2 varchar(100)

-- Split the partner column value and add this value to player_1 & player_2 column---
SPLIT_PART
UPDATE partnership
set player_1= TRIM(split_part(partners,',',1)),
player_2= TRIM(split_part(partners,',',2))

--Remove partners column from partnership table
ALTER table partnership
drop column partners

--Update opposition column(remove v)

UPDATE partnership
set opposition= TRIM(leading 'v' from opposition)

----------------------------------------------------------------------
Select * from best_team

--Add two column in the best_team table
ALTER table best_team
add column total_score varchar(100),
add column wckts varchar(100)

--split the value of score column and add this to total_score and wckts column

update best_team
set total_score = split_part(score,'/',1),
wckts = split_part(score,'/',2)

--Find first 5 best team,opposition and score where total score is greater than 350 
SELECT team , opposition1, score FROM best_team WHERE total_score::integer > 350 LIMIT 5

--Find the total score by each of team
SELECT team, sum(total_score::integer) FROM best_team GROUP BY team

----------------------------------------------------------------------
--Change the data type of the column
ALTER table batting
ALTER COLUMN runs type int using runs::integer
ALTER COLUMN not_out type int using not_out::integer
alter column inning type int using inning::integer
ALTER column match_played type int USING match_played::integer
select * from batting

----------------------------------------------------------------------------------













