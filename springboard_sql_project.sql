/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */

/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SELECT name AS "Fac_mem_fee"
FROM Facilities
WHERE membercost > 0

"Fac_mem_fee"
"Tennis Court 1"
"Tennis Court 2"
"Massage Room 1"
"Massage Room 2"
"Squash Court"

/* Q2: How many facilities do not charge a fee to members? */

SELECT COUNT(name) AS "No_Mem_Fee"
FROM Facilities
WHERE membercost = 0

"No_Mem_Fee"
"4"

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT 	facid,
	name,
	membercost,
	monthlymaintenance
FROM Facilities
WHERE (membercost > 0) AND (membercost < (monthlymaintenance * 0.2))

"facid"		"name"			"membercost"	"monthlymaintenance"
"0"		"Tennis Court 1"	"5.0"		"200"
"1"		"Tennis Court 2"	"5.0"		"200"
"4"		"Massage Room 1"	"9.9"		"3000"
"5"		"Massage Room 2"	"9.9"		"3000"
"6"		"Squash Court"		"3.5"		"80"

/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

SELECT *
FROM Facilities
WHERE facid IN (1, 5)

"facid"	"name"			"membercost"		"guestcost"	"initialoutlay"	"monthlymaintenance"
"1"	"Tennis Court 2"	"5.0"			"25.0"		"8000"		"200"
"5"	"Massage Room 2"	"9.9"			"80.0"		"4000"		"3000"

/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SELECT 	name,
	monthlymaintenance,
	CASE
	    WHEN monthlymaintenance > 100 THEN 'expensive'
	    WHEN monthlymaintenance <= 100 	THEN 'cheap'
	    ELSE NULL
	END AS rate
FROM Facilities

"name"			"monthlymaintenance"	"rate"
"Tennis Court 1"	"200"			"expensive"
"Tennis Court 2"	"200"			"expensive"
"Badminton Court"	"50"			"cheap"
"Table Tennis"		"10"			"cheap"
"Massage Room 1"	"3000"			"expensive"
"Massage Room 2"	"3000"			"expensive"
"Squash Court"		"80"			"cheap"
"Snooker Table"		"15"			"cheap"
"Pool Table"		"15"			"cheap"

/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT 	firstname,
	surname,
	joindate
FROM Members
ORDER BY joindate DESC

"firstname"	"surname"	"joindate"
"Darren"		"Smith"		"2012-09-26 18:08:45"
"Erica"			"Crumpet"	"2012-09-22 08:36:38"
"John"			"Hunt"		"2012-09-19 11:32:45"
"Hyacinth"	"Tupperware"	"2012-09-18 19:32:05"
"Millicent"	"Purview"	"2012-09-18 19:04:01"
"Henry"			"Worthington-Smyth"	"2012-09-17 12:27:15"
"David"			"Farrell"	"2012-09-15 08:22:05"
"Henrietta"	"Rumney"	"2012-09-05 08:42:35"
"Douglas"		"Jones"		"2012-09-02 18:43:05"
"Ramnaresh"	"Sarwin"	"2012-09-01 08:44:42"
"Joan"			"Coplin"	"2012-08-29 08:32:41"
"Anna"			"Mackenzie"	"2012-08-26 09:32:05"
"Matthew"		"Genting"	"2012-08-19 14:55:55"
"David"			"Pinker"	"2012-08-16 11:32:47"
"Timothy"		"Baker"		"2012-08-15 10:34:25"
"Florence"	"Bader"		"2012-08-10 17:52:03"
"Jack"			"Smith"		"2012-08-10 16:22:05"
"Jemima"		"Farrell"	"2012-08-10 14:28:01"
"Anne"			"Baker"		"2012-08-10 14:23:22"
"David"			"Jones"		"2012-08-06 16:32:55"
"Charles"		"Owen"		"2012-08-03 19:42:37"
"Ponder"		"Stibbons"	"2012-07-25 17:09:05"
"Tim"				"Boothe"	"2012-07-25 16:02:35"
"Nancy"			"Dare"		"2012-07-25 08:59:12"
"Burton"		"Tracy"		"2012-07-15 08:52:55"
"Gerald"		"Butters"	"2012-07-09 10:44:09"
"Janice"		"Joplette"	"2012-07-03 10:25:05"
"Tim"				"Rownam"	"2012-07-03 09:32:15"
"Tracy"			"Smith"		"2012-07-02 12:08:23"
"Darren"		"Smith"		"2012-07-02 12:02:05"
"GUEST"			"GUEST"		"2012-07-01 00:00:00"

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT 	DISTINCT fac.name,
	CONCAT(mem.firstname, ' ', mem.surname) AS full_name
FROM Facilities fac
INNER JOIN Bookings boo ON fac.facid = boo.facid
INNER JOIN Members mem ON mem.memid = boo.memid
WHERE fac.name LIKE '%Tennis Court%'
ORDER BY mem.surname, fac.name

"name"			"full_name"
"Tennis Court 1"	"Florence Bader"
"Tennis Court 2"	"Florence Bader"
"Tennis Court 1"	"Anne Baker"
"Tennis Court 1"	"Timothy Baker"
"Tennis Court 2"	"Timothy Baker"
"Tennis Court 2"	"Anne Baker"
"Tennis Court 1"	"Tim Boothe"
"Tennis Court 2"	"Tim Boothe"
"Tennis Court 1"	"Gerald Butters"
"Tennis Court 2"	"Gerald Butters"
"Tennis Court 1"	"Joan Coplin"
"Tennis Court 1"	"Erica Crumpet"
"Tennis Court 1"	"Nancy Dare"
"Tennis Court 2"	"Nancy Dare"
"Tennis Court 1"	"Jemima Farrell"
"Tennis Court 1"	"David Farrell"
"Tennis Court 2"	"Jemima Farrell"
"Tennis Court 2"	"David Farrell"
"Tennis Court 1"	"Matthew Genting"
"Tennis Court 1"	"GUEST GUEST"
"Tennis Court 2"	"GUEST GUEST"
"Tennis Court 1"	"John Hunt"
"Tennis Court 2"	"John Hunt"
"Tennis Court 1"	"Douglas Jones"
"Tennis Court 1"	"David Jones"
"Tennis Court 2"	"David Jones"
"Tennis Court 1"	"Janice Joplette"
"Tennis Court 2"	"Janice Joplette"
"Tennis Court 1"	"Charles Owen"
"Tennis Court 2"	"Charles Owen"
"Tennis Court 1"	"David Pinker"
"Tennis Court 2"	"Millicent Purview"
"Tennis Court 1"	"Tim Rownam"
"Tennis Court 2"	"Tim Rownam"
"Tennis Court 2"	"Henrietta Rumney"
"Tennis Court 1"	"Ramnaresh Sarwin"
"Tennis Court 2"	"Ramnaresh Sarwin"
"Tennis Court 1"	"Jack Smith"
"Tennis Court 1"	"Tracy Smith"
"Tennis Court 2"	"Jack Smith"
"Tennis Court 2"	"Tracy Smith"
"Tennis Court 2"	"Darren Smith"
"Tennis Court 1"	"Ponder Stibbons"
"Tennis Court 2"	"Ponder Stibbons"
"Tennis Court 1"	"Burton Tracy"
"Tennis Court 2"	"Burton Tracy"

/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT  boo.bookid,
	fac.name,
	CONCAT(mem.firstname, ' ', mem.surname) AS Name,
	CASE
	    WHEN boo.memid = 0 THEN fac.guestcost * boo.slots
	    ELSE fac.membercost * boo.slots
	END AS cost
FROM Facilities fac
INNER JOIN Bookings boo ON fac.facid = boo.facid
INNER JOIN Members mem ON mem.memid = boo.memid
WHERE boo.starttime LIKE '2012-09-14%'
AND CASE
    WHEN fac.membercost * boo.slots <> 0 THEN fac.membercost * boo.slots
    ELSE fac.guestcost * boo.slots
END > 30
ORDER BY cost DESC

"bookid"	"name"			"booking"	"cost"
"2946"		"Massage Room 2"	"GUEST GUEST"	"320.0"
"2940"		"Massage Room 1"	"GUEST GUEST"	"160.0"
"2942"		"Massage Room 1"	"GUEST GUEST"	"160.0"
"2937"		"Massage Room 1"	"GUEST GUEST"	"160.0"
"2926"		"Tennis Court 2"	"GUEST GUEST"	"150.0"
"2920"		"Tennis Court 1"	"GUEST GUEST"	"75.0"
"2925"		"Tennis Court 2"	"GUEST GUEST"	"75.0"
"2922"		"Tennis Court 1"	"GUEST GUEST"	"75.0"
"2948"		"Squash Court"		"GUEST GUEST"	"70.0"
"2941"		"Massage Room 1"	"Jemima Farrell"	"39.6"
"2949"		"Squash Court"		"GUEST GUEST"	"35.0"
"2951"		"Squash Court"		"GUEST GUEST"	"35.0"

/* Q9: This time, produce the same result as in Q8, but using a subquery. */

SELECT bookings.*
FROM (
    SELECT boo.bookid,
	   fac.name,
	   CONCAT(mem.firstname, ' ', mem.surname) AS booking,
    	   CASE
	       WHEN boo.memid = 0 THEN fac.guestcost * boo.slots
	       ELSE fac.membercost * boo.slots
	   END AS cost
    FROM Facilities fac
    INNER JOIN Bookings boo ON fac.facid = boo.facid
    INNER JOIN Members mem ON mem.memid = boo.memid
    WHERE boo.starttime LIKE '2012-09-14%'
) bookings
WHERE bookings.cost > 30
ORDER BY bookings.cost DESC

"bookid"	"name"			"booking"	"cost"
"2946"		"Massage Room 2"	"GUEST GUEST"	"320.0"
"2940"		"Massage Room 1"	"GUEST GUEST"	"160.0"
"2942"		"Massage Room 1"	"GUEST GUEST"	"160.0"
"2937"		"Massage Room 1"	"GUEST GUEST"	"160.0"
"2926"		"Tennis Court 2"	"GUEST GUEST"	"150.0"
"2920"		"Tennis Court 1"	"GUEST GUEST"	"75.0"
"2925"		"Tennis Court 2"	"GUEST GUEST"	"75.0"
"2922"		"Tennis Court 1"	"GUEST GUEST"	"75.0"
"2948"		"Squash Court"		"GUEST GUEST"	"70.0"
"2941"		"Massage Room 1"	"Jemima Farrell"	"39.6"
"2949"		"Squash Court"		"GUEST GUEST"	"35.0"
"2951"		"Squash Court"		"GUEST GUEST"	"35.0"

/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

SELECT *
FROM (
	SELECT 	fac.name,
	        SUM(CASE 
			WHEN boo.memid = 0 THEN fac.guestcost * boo.slots
			ELSE fac.membercost * boo.slots
		END) AS cost
	FROM Facilities fac
	INNER JOIN Bookings boo ON fac.facid = boo.facid
	INNER JOIN Members mem ON mem.memid = boo.memid
	GROUP BY fac.name
) rev
WHERE rev.cost < 1000
ORDER BY rev.cost

"facid"	"name"					"total_revenue"
"3"			"Table Tennis"	"180.0"
"7"			"Snooker Table"	"240.0"
"8"			"Pool Table"		"270.0"
