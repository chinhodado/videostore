CREATE TABLE Member(
	memberNumber char(7) PRIMARY KEY,
	lastname varchar(20),
	firstname varchar(20),
	email varchar(30),
	password varchar(30)
);

CREATE TABLE BillingInformation(
	memberNumber varchar(7),
	cardNumber char(16),
	type varchar(10) CHECK (type IN ('Visa', 'None', 'Paypal', 'Subscription')),
	FOREIGN KEY (memberNumber) REFERENCES Member ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (memberNumber,cardNumber)
);

CREATE TABLE BillingAddress(
	bAddresID char(7) PRIMARY KEY,
	address1 varchar(40),
	address2 varchar(40),
	city varchar(15),
	phone varchar(15),
	postalcode varchar(6),
	memberNumber char(7),
	FOREIGN KEY (memberNumber) REFERENCES Member ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ShippingAddress(
	sAddresID char(7) PRIMARY KEY,
	address1 varchar(40) NOT NULL,
	address2 varchar(40),
	city varchar(15),
	phone varchar(15),
	postalcode varchar(6),
	memberNumber char(7),
	FOREIGN KEY (memberNumber) REFERENCES Member ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Purchase(
	invoiceNumber char(10) PRIMARY KEY,
	date_ordered date NOT NULL,
	date_shipped date,
	shipping_cost decimal(8,2),
	speed char(10),
	carrier varchar(10),
	memberNumber char(7),
	videoID char(7),
	FOREIGN KEY (memberNumber) REFERENCES Member ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (videoID) REFERENCES Video ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Download(
	memberNumber char(7),
	videoID char(7),
	dateDownload date NOT NULL,
	timeDownload varchar(10),
	fee decimal(8,2),
	FOREIGN KEY (memberNumber) REFERENCES Member ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (videoID) REFERENCES Video ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (memberNumber, VideoID)
);

CREATE TABLE Video(
	videoID char(7) PRIMARY KEY,
	videoName varchar(50),
	yearReleased integer,
	salesprice decimal(8,2),
	genre varchar(10),
	rating decimal(2,2),
	duration decimal(5,2),
	inStock char(1) CHECK (inStock IN ('y','n')),
	directorID char(7),
	imagelink varchar(200),
	FOREIGN KEY (directorID) REFERENCES Director ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Director(
	directorID char(7) PRIMARY KEY,
	lastname varchar(15) NOT NULL,
	firstname varchar(15) NOT NULL,
	date_of_birth varchar(20)
);

CREATE TABLE Award(
	awardID char(5),
	yearAwarded integer,
	description varchar(100),
	category varchar(100),
	PRIMARY KEY (awardID, yearAwarded)
);

CREATE TABLE VideoAwards(
	videoID char(7),
	awardID char(5),
	yearAwarded integer,
	won char(1) CHECK (won IN ('y','n')),
	FOREIGN KEY (videoID) REFERENCES Video ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (awardID,yearAwarded) REFERENCES Award ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (videoID, awardID, yearAwarded)
);

CREATE TABLE Actor(
	actorID char(7) PRIMARY KEY,
	lastname varchar(15) NOT NULL,
	firstname varchar(15) NOT NULL,
	date_of_birth varchar(20),
	IMDB_link varchar(100)
);

CREATE TABLE VideoStar(
	videoID char(7),
	actorID char(7),
	roleName char(10) NOT NULL,
	FOREIGN KEY (videoID) REFERENCES Video ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (actorID) REFERENCES Actor ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (videoID, actorID)
);

CREATE TABLE VideosReturned(
	returnid varchar(20) PRIMARY KEY
	memberNumber char(7),
	videoID char(7),
	returndate varchar(20) NOT NULL,
	FOREIGN KEY (videoID) REFERENCES Video ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (memberNumber) REFERENCES Member ON UPDATE CASCADE ON DELETE CASCADE,
);