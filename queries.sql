--a,
--return the information about a video whose videoid is given
select v.videoname, v.yearreleased, v.salesprice, v.genre, v.rating, v.duration, v.instock, (d.firstname || ' ' || d.lastname) as dname
from project.video v, project.director d
where v.directorid=d.directorid and v.videoid='1000001';

--b,
--For a given genre, list all the video names together with the last date that it was purchased or downloaded
select  videoname, max(dt)
from    (
        select  videoname, Datelastdownloaded as dt
        from    (SELECT V.VideoName, Max(d.datedownload) as Datelastdownloaded
			FROM Video V, download d
			WHERE V.VideoID = d.VideoID AND V.Genre = 'Drama'
			Group BY v.videoname) dl
        union all
        select  videoname, Datelastpurchased
        from    (SELECT V.VideoName, Max(P.date_ordered) Datelastpurchased
			FROM Video V, Purchase P
			WHERE V.VideoID = P.VideoID AND V.Genre = 'Drama'
			Group BY v.videoname) ps        
        ) SubQueryAlias
        
group by videoname;

--c,
--return the billing information of a member
select b.membernumber, b.cardnumber, b.type
from project.member m, project.billinginformation b 
where m.membernumber=b.membernumber and m.membernumber='5000001';

--return the shipping address of a member
select s.membernumber, s.address1, s.address2, s.city, s.phone, s.postalcode
from project.member m, project.shippingaddress s 
where m.membernumber=s.membernumber and m.membernumber='5000001';

--d,
--Given a specified genre, find the name(s) and email(s) of the members(s) who downloaded it the most often
select m2.firstname, m2.lastname, m2.email, count(*) as numdownload --those who downloaded this genre most often
from project.video v2, project.download d2, project.member m2
where d2.videoid=v2.videoid and m2.membernumber=d2.membernumber and v2.genre='Drama'
group by m2.membernumber
having count(*)>=ALL(select count(*)--the count of each member's number of downloads for this genre
						from project.video v, project.download d, project.member m 
						where d.videoid=v.videoid and m.membernumber=d.membernumber and v.genre='Drama' 
						group by m.membernumber);

--e,
--the total number of video group by directors
select (d.firstname || ' ' || d.lastname) as dname, count(*) as numberofvideo
from project.video v, project.director d
where v.directorid=d.directorid
group by d.directorid
order by numberofvideo DESC;

--f,
--For a specified genre, find the name(s) and price(s) of the video(s) that are returned most often
select v2.videoname, v2.salesprice, count(*) as numreturned
from project.video v2, project.videosreturned d2
where d2.videoid=v2.videoid and v2.genre='Crime'
group by v2.videoid
having count(*)>=ALL(select count(*)
						from project.video v, project.videosreturned d
						where d.videoid=v.videoid and v.genre='Crime' 
						group by v.videoid);

--g,
--Find all member(s) that have a total purchase that is higher than the average purchase
select m2.firstname, m2.lastname, m2.email, count(*)
from member m2, purchase p2
where m2.membernumber=p2.membernumber
group by m2.membernumber
having count(*)>= (select avg(numpurchase) from(
								select count(*) as numpurchase
								from member m, purchase p
								where m.membernumber=p.membernumber
								group by m.membernumber) a);

--h,

	--top 5 bestsellers by purchase
	select v.videoname, count(*)
	from video v, purchase p
	where v.videoid=p.videoid
	group by v.videoid
	order by count(*) DESC
	limit 5;

	--top 5 bestsellers by download
	select v.videoname, count(*)
	from video v, download d
	where v.videoid=d.videoid
	group by v.videoid
	order by count(*) DESC
	limit 5;

--i,
--Find the name(s) and price(s) of the video(s) where no‐one ever bought the DVD or Blu‐ray, but these videos were downloaded more than 4 times
select videoname, salesprice from(
	select v.videoname, v.salesprice,count(*)
	from video v, download d
	where v.videoid=d.videoid
	group by v.videoid
	having count(*)>4
	order by count(*) DESC) a where videoname not in (select v2.videoname from video v2, purchase p2 where v2.videoid=p2.videoid);

--j,
--Find the name(s) and date(s) of birth of the actor(s) that star in the video(s) that are downloaded most frequently
select distinct a2.firstname, a2.lastname, a2.date_of_birth
from actor a2, video v2, videostar vs2
where vs2.actorid=a2.actorid and vs2.videoid=v2.videoid and v2.videoid in(
	select v.videoid
	from video v, download d
	where v.videoid=d.videoid
	group by v.videoid
	order by count(*) DESC
	limit 5);

--k,
--display the top 3 movies with the most number of nominations, along with the number of nomination and their directors
select (d.firstname || ' ' || d.lastname) as dname, v.videoname, count(*)
from video v, videoawards va, director d
where v.videoid=va.videoid and d.directorid=v.directorid
group by v.videoid, d.directorid
order by count(*) DESC
limit 3;

--l,
--get the director of (the movies that has the most nominations but have never won an Oscar)
--it's huge and ugly, I know :( But it works :)
select (d.firstname || ' ' || d.lastname) as dname, v3.videoname, count(*) as num_nominations
from video v3, videoawards va3, director d
where d.directorid=v3.directorid and v3.videoid=va3.videoid and va3.won='n' 
							and v3.videoid not in (
												select v4.videoid
												from video v4, videoawards va4
												where v4.videoid=va4.videoid and va4.won='y')
group by v3.videoid, (d.firstname || ' ' || d.lastname)
having count(*) >=ALL(select count(*)
					from video v2, videoawards va2
					where v2.videoid=va2.videoid and va2.won='n' 
												and v2.videoid not in (
																	select v.videoid
																	from video v, videoawards va
																	where v.videoid=va.videoid and va.won='y')
					group by v2.videoid);

--m,
--return the three movies that won the most number of Oscar awards, along with their directors and main actors
create view most_oscar as
select (d.firstname || ' ' || d.lastname) as dname, v.videoid, v.videoname, count(*) as number_oscar_won
from video v, videoawards va, director d
where v.videoid=va.videoid and d.directorid=v.directorid and va.won='y'
group by v.videoid, d.directorid
order by count(*) DESC
limit 3;

select videoname, string_agg(aname, ', ') as actor_list, dname, number_oscar_won from(
select mo.videoname, (a.firstname || ' ' || a.lastname) as aname, mo.dname, number_oscar_won
from most_oscar mo, actor a, videostar vs
where vs.videoid=mo.videoid and vs.actorid=a.actorid) a
group by videoname, dname, number_oscar_won;