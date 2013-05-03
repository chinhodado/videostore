--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: project; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA project;


ALTER SCHEMA project OWNER TO postgres;

SET search_path = project, pg_catalog;

--
-- Name: actor_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE actor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.actor_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: actor; Type: TABLE; Schema: project; Owner: postgres; Tablespace: 
--

CREATE TABLE actor (
    actorid character(7) DEFAULT nextval('actor_id_seq'::regclass) NOT NULL,
    lastname character varying(15) NOT NULL,
    firstname character varying(15) NOT NULL,
    date_of_birth character varying(20),
    imdb_link character varying(100)
);


ALTER TABLE project.actor OWNER TO postgres;

--
-- Name: award_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE award_id_seq
    START WITH 80000
    INCREMENT BY 1
    MINVALUE 80000
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.award_id_seq OWNER TO postgres;

--
-- Name: award; Type: TABLE; Schema: project; Owner: postgres; Tablespace: 
--

CREATE TABLE award (
    awardid character(5) DEFAULT nextval('award_id_seq'::regclass) NOT NULL,
    yearawarded integer NOT NULL,
    description character varying(100) NOT NULL,
    category character varying(100) NOT NULL
);


ALTER TABLE project.award OWNER TO postgres;

--
-- Name: billingaddress_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE billingaddress_id_seq
    START WITH 6000100
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.billingaddress_id_seq OWNER TO postgres;

--
-- Name: billingaddress; Type: TABLE; Schema: project; Owner: postgres; Tablespace: 
--

CREATE TABLE billingaddress (
    baddresid character(7) DEFAULT nextval('billingaddress_id_seq'::regclass) NOT NULL,
    address1 character varying(40) NOT NULL,
    address2 character varying(40),
    city character varying(15),
    phone character varying(15),
    postalcode character varying(6),
    membernumber character(7)
);


ALTER TABLE project.billingaddress OWNER TO postgres;

--
-- Name: billinginformation; Type: TABLE; Schema: project; Owner: postgres; Tablespace: 
--

CREATE TABLE billinginformation (
    membernumber character varying(7) NOT NULL,
    cardnumber character(16) NOT NULL,
    type character varying(15),
    CONSTRAINT billinginformation_type_check CHECK (((type)::text = ANY (ARRAY[('Visa'::character varying)::text, ('None'::character varying)::text, ('Paypal'::character varying)::text, ('Subscription'::character varying)::text])))
);


ALTER TABLE project.billinginformation OWNER TO postgres;

--
-- Name: director; Type: TABLE; Schema: project; Owner: postgres; Tablespace: 
--

CREATE TABLE director (
    directorid character(7) NOT NULL,
    lastname character varying(15) NOT NULL,
    firstname character varying(15) NOT NULL,
    date_of_birth character varying(20)
);


ALTER TABLE project.director OWNER TO postgres;

--
-- Name: download; Type: TABLE; Schema: project; Owner: postgres; Tablespace: 
--

CREATE TABLE download (
    membernumber character(7) NOT NULL,
    videoid character(7) NOT NULL,
    timedownload character varying(10),
    fee numeric(8,2),
    datedownload date NOT NULL
);


ALTER TABLE project.download OWNER TO postgres;

--
-- Name: invoice_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE invoice_id_seq
    START WITH 7000000000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.invoice_id_seq OWNER TO postgres;

--
-- Name: member_id_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE member_id_seq
    START WITH 5000040
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.member_id_seq OWNER TO postgres;

--
-- Name: member; Type: TABLE; Schema: project; Owner: postgres; Tablespace: 
--

CREATE TABLE member (
    membernumber character(7) DEFAULT nextval('member_id_seq'::regclass) NOT NULL,
    lastname character varying(20),
    firstname character varying(20),
    email character varying(30),
    password character varying(30)
);


ALTER TABLE project.member OWNER TO postgres;

--
-- Name: most_oscar; Type: TABLE; Schema: project; Owner: postgres; Tablespace: 
--

CREATE TABLE most_oscar (
    dname text,
    videoid character(7),
    videoname character varying(50),
    number_oscar_won bigint
);


ALTER TABLE project.most_oscar OWNER TO postgres;

--
-- Name: purchase; Type: TABLE; Schema: project; Owner: postgres; Tablespace: 
--

CREATE TABLE purchase (
    invoicenumber character(10) DEFAULT nextval('invoice_id_seq'::regclass) NOT NULL,
    date_shipped character varying(20),
    shipping_cost numeric(8,2) DEFAULT 2,
    speed character(10) DEFAULT 'Normal'::bpchar,
    carrier character varying(10) DEFAULT 'Fedex'::character varying,
    membernumber character(7),
    videoid character(7),
    date_ordered date NOT NULL
);


ALTER TABLE project.purchase OWNER TO postgres;

--
-- Name: shippingaddress; Type: TABLE; Schema: project; Owner: postgres; Tablespace: 
--

CREATE TABLE shippingaddress (
    saddresid character(7) NOT NULL,
    address1 character varying(40) NOT NULL,
    address2 character varying(40),
    city character varying(15),
    phone character varying(15),
    postalcode character varying(6),
    membernumber character(7)
);


ALTER TABLE project.shippingaddress OWNER TO postgres;

--
-- Name: video; Type: TABLE; Schema: project; Owner: postgres; Tablespace: 
--

CREATE TABLE video (
    videoid character(7) NOT NULL,
    videoname character varying(50) NOT NULL,
    yearreleased integer NOT NULL,
    salesprice numeric(8,2) DEFAULT 10,
    genre character varying(10),
    rating character varying(10),
    duration numeric(5,2),
    instock character(1) DEFAULT 'y'::bpchar,
    directorid character(7),
    imagelink character varying(200),
    CONSTRAINT video_instock_check CHECK ((instock = ANY (ARRAY['y'::bpchar, 'n'::bpchar])))
);


ALTER TABLE project.video OWNER TO postgres;

--
-- Name: videoawards; Type: TABLE; Schema: project; Owner: postgres; Tablespace: 
--

CREATE TABLE videoawards (
    videoid character(7) NOT NULL,
    awardid character(5) NOT NULL,
    yearawarded integer NOT NULL,
    won character(1),
    CONSTRAINT videoawards_won_check CHECK ((won = ANY (ARRAY['y'::bpchar, 'n'::bpchar])))
);


ALTER TABLE project.videoawards OWNER TO postgres;

--
-- Name: videosreturned; Type: TABLE; Schema: project; Owner: postgres; Tablespace: 
--

CREATE TABLE videosreturned (
    membernumber character(7),
    videoid character(7),
    returnid integer NOT NULL,
    returndate character varying(20) NOT NULL
);


ALTER TABLE project.videosreturned OWNER TO postgres;

--
-- Name: videosreturned_returnid_seq; Type: SEQUENCE; Schema: project; Owner: postgres
--

CREATE SEQUENCE videosreturned_returnid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project.videosreturned_returnid_seq OWNER TO postgres;

--
-- Name: videosreturned_returnid_seq; Type: SEQUENCE OWNED BY; Schema: project; Owner: postgres
--

ALTER SEQUENCE videosreturned_returnid_seq OWNED BY videosreturned.returnid;


--
-- Name: videostar; Type: TABLE; Schema: project; Owner: postgres; Tablespace: 
--

CREATE TABLE videostar (
    videoid character(7) NOT NULL,
    actorid character(7) NOT NULL,
    rolename character(40) NOT NULL
);


ALTER TABLE project.videostar OWNER TO postgres;

--
-- Name: returnid; Type: DEFAULT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY videosreturned ALTER COLUMN returnid SET DEFAULT nextval('videosreturned_returnid_seq'::regclass);


--
-- Data for Name: actor; Type: TABLE DATA; Schema: project; Owner: postgres
--

INSERT INTO actor VALUES ('2000005', 'Duvall', 'Robert', 'January 5, 1931', 'http://www.imdb.com/name/nm0000380/?ref_=sr_1');
INSERT INTO actor VALUES ('2000007', 'L. Jackson', 'Samuel', 'December 21, 1948', 'http://www.imdb.com/name/nm0000168/?ref_=sr_1');
INSERT INTO actor VALUES ('2000003', 'Brando', 'Marlon', 'April 3, 1924', 'http://www.imdb.com/name/nm0000008/?ref_=sr_1');
INSERT INTO actor VALUES ('2000004', 'Pacino', 'Al', 'April 25, 1940', 'http://www.imdb.com/name/nm0000199/?ref_=sr_1');
INSERT INTO actor VALUES ('2000015', 'Ledger', 'Heath', 'April 4, 1979', 'http://www.imdb.com/name/nm0005132/?ref_=sr_1');
INSERT INTO actor VALUES ('2000006', 'Travolta', 'John', 'February 18, 1954', 'http://www.imdb.com/name/nm0000237/?ref_=sr_1');
INSERT INTO actor VALUES ('2000017', 'Neeson', 'Liam', 'June 7, 1952', 'http://www.imdb.com/name/nm0000553/?ref_=sr_1');
INSERT INTO actor VALUES ('2000008', 'Roth', 'Tim', 'May 14, 1961', 'http://www.imdb.com/name/nm0000619/?ref_=sr_1');
INSERT INTO actor VALUES ('2000009', 'Wallach', 'Eli', 'December 7, 1915', 'http://www.imdb.com/name/nm0908919/?ref_=sr_1');
INSERT INTO actor VALUES ('2000010', 'Eastwood', 'Clint', 'May 31, 1930', 'http://www.imdb.com/name/nm0000142/?ref_=sr_1');
INSERT INTO actor VALUES ('2000011', 'Van Cleef', 'Lee', 'January 9, 1925', 'http://www.imdb.com/name/nm0001812/?ref_=sr_1');
INSERT INTO actor VALUES ('2000012', 'Balsam', 'Martin', 'November 4, 1919', 'http://www.imdb.com/name/nm0000842/?ref_=sr_1');
INSERT INTO actor VALUES ('2000013', 'Fiedler', 'John', 'February 3, 1925', 'http://www.imdb.com/name/nm0275835/?ref_=sr_1');
INSERT INTO actor VALUES ('2000014', 'Bale', 'Christian', 'January 30, 1974', 'http://www.imdb.com/name/nm0000288/?ref_=sr_1');
INSERT INTO actor VALUES ('2000016', 'Caine', 'Michael', 'March 14, 1933', 'http://www.imdb.com/name/nm0000323/?ref_=sr_3');
INSERT INTO actor VALUES ('2000066', 'Williams', 'Rebecca', 'February 18, 1954', 'http://www.imdb.com/name/nm0931508/?ref_=tt_cl_t2');
INSERT INTO actor VALUES ('2000018', 'Kingsley', 'Ben', 'December 31, 1943', 'http://www.imdb.com/name/nm0001426/?ref_=sr_1');
INSERT INTO actor VALUES ('2000019', 'Bloom', 'Orlando ', 'January 13, 1977', 'http://www.imdb.com/name/nm0089217/?ref_=sr_1');
INSERT INTO actor VALUES ('2000020', 'Bean', 'Sean ', 'April 17, 1959', 'http://www.imdb.com/name/nm0000293/?ref_=sr_1');
INSERT INTO actor VALUES ('2000021', 'Norton', 'Edward', 'August 18, 1969', 'http://www.imdb.com/name/nm0001570/?ref_=sr_1');
INSERT INTO actor VALUES ('2000022', 'Pitt', 'Brad', 'December 18, 1963', 'http://www.imdb.com/name/nm0000093/?ref_=sr_2');
INSERT INTO actor VALUES ('2000023', 'Hamill', 'Mark', 'September 25, 1951', 'http://www.imdb.com/name/nm0000434/?ref_=sr_4');
INSERT INTO actor VALUES ('2000024', 'Ford', 'Harrison', 'July 13, 1942', 'http://www.imdb.com/name/nm0000148/?ref_=sr_1');
INSERT INTO actor VALUES ('2000025', 'Wood', 'Elijah', 'January 28, 1981', 'http://www.imdb.com/name/nm0000704/?ref_=sr_1');
INSERT INTO actor VALUES ('2000026', 'Downey Jr.', 'Robert', 'April 4, 1965', 'http://www.imdb.com/name/nm0000375/?ref_=sr_2');
INSERT INTO actor VALUES ('2000027', 'Johansson', 'Scarlett', 'November 22, 1984', 'http://www.imdb.com/name/nm0424060/?ref_=sr_1');
INSERT INTO actor VALUES ('2000028', 'Berryman', 'Michael', 'September 4, 1948 ', 'http://www.imdb.com/name/nm0077720/?ref_=sr_2');
INSERT INTO actor VALUES ('2000029', 'DiCaprio', 'Leonardo', 'November 11, 1974', 'http://www.imdb.com/name/nm0000138/?ref_=sr_1');
INSERT INTO actor VALUES ('2000030', 'Gordon-Levitt', 'Joseph', 'February 17, 1981', 'http://www.imdb.com/name/nm0330687/?ref_=sr_1');
INSERT INTO actor VALUES ('2000031', 'De Niro', 'Robert', 'August 17, 1943 ', 'http://www.imdb.com/name/nm0000134/?ref_=sr_3');
INSERT INTO actor VALUES ('2000032', 'Mifune', 'Toshirô', 'April 1, 1920 ', 'http://www.imdb.com/name/nm0001536/?ref_=sr_1');
INSERT INTO actor VALUES ('2000033', 'Hanks', 'Tom', 'July 9, 1956 ', 'http://www.imdb.com/name/nm0000158/?ref_=sr_1');
INSERT INTO actor VALUES ('2000035', 'Reeves', 'Keanu', 'September 2, 1964', 'http://www.imdb.com/name/nm0000206/?ref_=sr_1');
INSERT INTO actor VALUES ('2000036', 'Rodrigues', 'Alexandre', 'May 21, 1983', 'http://www.imdb.com/name/nm1179105/?ref_=sr_1');
INSERT INTO actor VALUES ('2000037', 'Foster', 'Jodie', 'November 19, 1962', 'http://www.imdb.com/name/nm0000149/?ref_=sr_1');
INSERT INTO actor VALUES ('2000038', 'Cardinale', 'Claudia', 'April 15, 1938', 'http://www.imdb.com/name/nm0001012/?ref_=sr_1');
INSERT INTO actor VALUES ('2000039', 'Bogart', 'Humphrey', 'December 25, 1899', 'http://www.imdb.com/name/nm0000007/?ref_=sr_1');
INSERT INTO actor VALUES ('2000040', 'Bergman', 'Ingrid', 'August 29, 1915', 'http://www.imdb.com/name/nm0000006/?ref_=sr_1');
INSERT INTO actor VALUES ('2000041', 'Baldwin', 'Stephen', 'May 12, 1966', 'http://www.imdb.com/name/nm0000286/?ref_=sr_1');
INSERT INTO actor VALUES ('2000042', 'Perkins', 'Anthony', 'April 4, 1932', 'http://www.imdb.com/name/nm0000578/?ref_=sr_1');
INSERT INTO actor VALUES ('2000043', 'Pearce', 'Guy', 'October 5, 1967', 'http://www.imdb.com/name/nm0001602/?ref_=sr_1');
INSERT INTO actor VALUES ('2000044', 'Sizemore', 'Tom', 'November 29, 1961', 'http://www.imdb.com/name/nm0001744/?ref_=sr_1');
INSERT INTO actor VALUES ('2000045', 'Brody', 'Adrien', 'April 14, 1973 ', 'http://www.imdb.com/name/nm0004778/?ref_=sr_2');
INSERT INTO actor VALUES ('2000046', 'Allen', 'Tim', 'June 13, 1953', 'http://www.imdb.com/name/nm0000741/?ref_=sr_1');
INSERT INTO actor VALUES ('2000047', 'Crowe', 'Russell', 'April 7, 1964', 'http://www.imdb.com/name/nm0000128/?ref_=sr_2');
INSERT INTO actor VALUES ('2000048', 'Tautou', 'Audrey', 'August 9, 1976 ', 'http://www.imdb.com/name/nm0851582/?ref_=sr_1');
INSERT INTO actor VALUES ('2000049', 'Peck', 'Gregory', 'April 5, 1916', 'http://www.imdb.com/name/nm0000060/?ref_=sr_2');
INSERT INTO actor VALUES ('2000050', 'Woods', 'James', 'April 18, 1947', 'http://www.imdb.com/name/nm0000249/?ref_=sr_1');
INSERT INTO actor VALUES ('2000060', 'Heston', 'Charlton', 'October 4, 1923', 'http://www.imdb.com/name/nm0000032/?ref_=tt_cl_t1');
INSERT INTO actor VALUES ('2000061', 'Hawkins', 'Jack', 'September 14, 1910', 'http://www.imdb.com/name/nm0370144/?ref_=tt_cl_t2');
INSERT INTO actor VALUES ('2000062', 'Harareet', 'Haya', 'September 20, 1931', 'http://www.imdb.com/name/nm0361823/?ref_=tt_cl_t3');
INSERT INTO actor VALUES ('2000063', 'Winslet', 'Kate', 'October 5, 1975', 'http://www.imdb.com/name/nm0000701/?ref_=tt_cl_t2');
INSERT INTO actor VALUES ('2000064', 'Zane', 'Billy', 'February 24, 1966', 'http://www.imdb.com/name/nm0000708/?ref_=tt_cl_t3');
INSERT INTO actor VALUES ('2000002', 'Freeman', 'Morgan', 'June 1, 1937', 'http://www.imdb.com/name/nm0000151/?ref_=sr_1');
INSERT INTO actor VALUES ('2000067', 'Field', 'Sally', 'November 6, 1946', '');
INSERT INTO actor VALUES ('2000068', 'Fishburne', 'Laurence', 'December 1, 1954', 'http://www.imdb.com/title/tt0133093/?ref_=sr_1');
INSERT INTO actor VALUES ('2000069', 'Moss', 'Carrie-Anne', 'August 21, 1967', 'http://www.imdb.com/name/nm0005251/?ref_=tt_cl_t3');
INSERT INTO actor VALUES ('2000070', 'J. Cobb', 'Lee', 'December 8, 1911', 'http://www.imdb.com/name/nm0002011/?ref_=tt_cl_t3');
INSERT INTO actor VALUES ('2000071', 'Firmino', 'Leandro', 'June 23, 1978', 'http://www.imdb.com/name/nm1129884/?ref_=tt_cl_t2');
INSERT INTO actor VALUES ('2000072', 'Haagensen', 'Phellipe', ' Oct 1, 1985', '');


--
-- Name: actor_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('actor_id_seq', 2000072, true);


--
-- Data for Name: award; Type: TABLE DATA; Schema: project; Owner: postgres
--

INSERT INTO award VALUES ('80000', 1995, 'Best Director', 'Best Director');
INSERT INTO award VALUES ('80001', 1995, 'Best Picture', 'Best Picture');
INSERT INTO award VALUES ('80002', 1995, 'Best Film Editing', 'Best Film Editing');
INSERT INTO award VALUES ('80003', 1995, 'Best Actor in a Leading Role', 'Best Actor in a Leading Role');
INSERT INTO award VALUES ('80004', 1995, 'Best Effects, Visual Effects', 'Best Effects, Visual Effects');
INSERT INTO award VALUES ('80005', 1995, 'Best Writing', 'Best Writing');
INSERT INTO award VALUES ('80006', 1973, 'Best Actor in a Leading Role', 'Best Actor in a Leading Role');
INSERT INTO award VALUES ('80007', 1973, 'Best Picture', 'Best Picture');
INSERT INTO award VALUES ('80008', 1973, 'Best Writing', 'Best Writing');
INSERT INTO award VALUES ('80009', 1975, 'Best Actor in a Supporting Role', 'Best Actor in a Supporting Role');
INSERT INTO award VALUES ('80010', 1975, 'Best Art Direction-Set Decoration', 'Best Art Direction-Set Decoration');
INSERT INTO award VALUES ('80011', 1975, 'Best Director', 'Best Director');
INSERT INTO award VALUES ('80012', 1975, 'Best Music, Original Dramatic Score', 'Best Music, Original Dramatic Score');
INSERT INTO award VALUES ('80013', 1975, 'Best Picture', 'Best Picture');
INSERT INTO award VALUES ('80014', 1975, 'Best Writing', 'Best Writing');
INSERT INTO award VALUES ('80015', 1998, 'Best Art Direction-Set Decoration', 'Best Art Direction-Set Decoration');
INSERT INTO award VALUES ('80016', 1998, 'Best Cinematography', 'Best Cinematography');
INSERT INTO award VALUES ('80017', 1998, 'Best Costume Design', 'Best Costume Design');
INSERT INTO award VALUES ('80018', 1998, 'Best Director', 'Best Director');
INSERT INTO award VALUES ('80019', 1998, 'Best Effects, Sound Effects Editing', 'Best Effects, Sound Effects Editing');
INSERT INTO award VALUES ('80020', 1998, 'Best Effects, Visual Effects', 'Best Effects, Visual Effects');
INSERT INTO award VALUES ('80021', 1998, 'Best Film Editing', 'Best Film Editing');
INSERT INTO award VALUES ('80022', 1998, 'Best Music, Original Dramatic Score', 'Best Music, Original Dramatic Score');
INSERT INTO award VALUES ('80023', 1998, 'Best Music, Original Song', 'Best Music, Original Song');
INSERT INTO award VALUES ('80024', 1998, 'Best Picture', 'Best Picture');
INSERT INTO award VALUES ('80025', 1998, 'Best Sound', 'Best Sound');
INSERT INTO award VALUES ('80026', 1998, 'Best Actress in a Leading Role', 'Best Actress in a Leading Role');
INSERT INTO award VALUES ('80027', 1998, 'Best Actress in a Supporting Role', 'Best Actress in a Supporting Role');
INSERT INTO award VALUES ('80028', 1998, 'Best Makeup', 'Best Makeup');
INSERT INTO award VALUES ('80029', 1959, 'Best Actor in a Leading Role', 'Best Actor in a Leading Role');
INSERT INTO award VALUES ('80030', 1959, 'Best Actor in a Supporting Role', 'Best Actor in a Supporting Role');
INSERT INTO award VALUES ('80031', 1959, 'Best Art Direction-Set Decoration, Color', 'Best Art Direction-Set Decoration, Color');
INSERT INTO award VALUES ('80032', 1959, 'Best Cinematography, Color', 'Best Cinematography, Color');
INSERT INTO award VALUES ('80033', 1959, 'Best Costume Design, Color', 'Best Costume Design, Color');
INSERT INTO award VALUES ('80034', 1959, 'Best Director', 'Best Director');
INSERT INTO award VALUES ('80035', 1959, 'Best Effects, Special Effects', 'Best Effects, Special Effects');
INSERT INTO award VALUES ('80036', 1959, 'Best Film Editing', 'Best Film Editing');
INSERT INTO award VALUES ('80037', 1959, 'Best Music of a Dramatic or Comedy Picture', 'Best Music of a Dramatic or Comedy Picture');
INSERT INTO award VALUES ('80038', 1959, 'Best Picture', 'Best Picture');
INSERT INTO award VALUES ('80039', 1959, 'Best Sound', 'Best Sound');
INSERT INTO award VALUES ('80040', 1959, 'Best Writing, Screenplay Based on Material from Another Medium', 'Best Writing, Screenplay Based on Material from Another Medium');
INSERT INTO award VALUES ('80041', 2004, 'Best Art Direction-Set Decoration', 'Best Art Direction-Set Decoration');
INSERT INTO award VALUES ('80042', 2004, 'Best Costume Design', 'Best Costume Design');
INSERT INTO award VALUES ('80043', 2004, 'Best Director', 'Best Director');
INSERT INTO award VALUES ('80044', 2004, 'Best Film Editing', 'Best Film Editing');
INSERT INTO award VALUES ('80045', 2004, 'Best Makeup', 'Best Makeup');
INSERT INTO award VALUES ('80046', 2004, 'Best Music, Original Score', 'Best Music, Original Score');
INSERT INTO award VALUES ('80047', 2004, 'Best Music, Original Song', 'Best Music, Original Song');
INSERT INTO award VALUES ('80048', 2004, 'Best Picture', 'Best Picture');
INSERT INTO award VALUES ('80049', 2004, 'Best Sound Mixing', 'Best Sound Mixing');
INSERT INTO award VALUES ('80050', 2004, 'Best Visual Effects', 'Best Visual Effects');
INSERT INTO award VALUES ('80051', 2004, 'Best Writing, Adapted Screenplay', 'Best Writing, Adapted Screenplay');
INSERT INTO award VALUES ('80052', 1944, 'Best Director', 'Best Director');
INSERT INTO award VALUES ('80053', 1944, 'Best Picture', 'Best Picture');
INSERT INTO award VALUES ('80054', 1944, 'Best Writing, Screenplay', 'Best Writing, Screenplay');
INSERT INTO award VALUES ('80055', 1944, 'Best Actor in a Leading Role', 'Best Actor in a Leading Role');
INSERT INTO award VALUES ('80056', 1944, 'Best Actor in a Supporting Role', 'Best Actor in a Supporting Role');
INSERT INTO award VALUES ('80057', 1944, 'Best Cinematography, Black-and-White', 'Best Cinematography, Black-and-White');
INSERT INTO award VALUES ('80058', 1944, 'Best Film Editing', 'Best Film Editing');
INSERT INTO award VALUES ('80059', 1944, 'Best Music, Scoring of a Dramatic or Comedy Picture', 'Best Music, Scoring of a Dramatic or Comedy Picture');
INSERT INTO award VALUES ('80060', 1995, 'Best Cinematography', 'Best Cinematography');
INSERT INTO award VALUES ('80061', 1995, 'Best Music, Original Score', 'Best Music, Original Score');
INSERT INTO award VALUES ('80062', 1995, 'Best Sound', 'Best Sound');
INSERT INTO award VALUES ('80063', 1958, 'Best Director', 'Best Director');
INSERT INTO award VALUES ('80064', 1958, 'Best Picture', 'Best Picture');
INSERT INTO award VALUES ('80065', 1958, 'Best Writing, Screenplay Based on Material from Another Medium', 'Best Writing, Screenplay Based on Material from Another Medium');


--
-- Name: award_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('award_id_seq', 80065, true);


--
-- Data for Name: billingaddress; Type: TABLE DATA; Schema: project; Owner: postgres
--

INSERT INTO billingaddress VALUES ('6000041', '10 Startsford End', '30 Gallons', 'Manchester', '2222222222', '12345', '5000013');
INSERT INTO billingaddress VALUES ('6000042', '33 Trent Lane', '', 'New York', '5542209993', 'L6B0C3', '5000006');
INSERT INTO billingaddress VALUES ('6000043', '12 Quarter Road', '', 'Ottawa', '6134568888', 'K2B7T2', '5000007');
INSERT INTO billingaddress VALUES ('6000044', '88 Swamp Street', '', 'Ottawa', '2914993833', 'O5O5P2', '5000008');
INSERT INTO billingaddress VALUES ('6000045', '4 Sand Street', '', 'Peterborough', '6548876382', 'R3E2W1', '5000008');
INSERT INTO billingaddress VALUES ('6000001', '597 Deadeye Street', '', 'Ottawa', '1379494469', 'N8A7V1', '5000000');
INSERT INTO billingaddress VALUES ('6000046', '84 Keeper Court', '', 'New York', '3849209523', 'K4J3J2', '5000010');
INSERT INTO billingaddress VALUES ('6000047', '332 Architect Street', '', 'Vancouver', '8930398821', 'L2G2R1', '5000013');
INSERT INTO billingaddress VALUES ('6000048', '98 Memory Lane', '', 'Toronto', '7023340097', 'T2T6E6', '5000009');
INSERT INTO billingaddress VALUES ('6000049', '65 Jesters Court', '', 'Winnipeg', '9024478882', 'Q2E5R8', '5000015');
INSERT INTO billingaddress VALUES ('6000050', '61 Bank Place', '', 'Paris', '9026774442', 'T4E4S5', '5000014');
INSERT INTO billingaddress VALUES ('6000051', '75 Sculpt Street', '', 'London', '6336619999', 'F2I7R7', '5000017');
INSERT INTO billingaddress VALUES ('6000052', '1 Mind Road', '', 'Ottawa', '7443229837', 'A6S8S8', '5000016');
INSERT INTO billingaddress VALUES ('6000053', '90 Farseek Street', '', 'Toronto', '8940294950', 'P4R5R5', '5000016');
INSERT INTO billingaddress VALUES ('6000054', '69 Arbor Lane', '', 'New York', '5559302932', 'P3O3T3', '5000018');
INSERT INTO billingaddress VALUES ('6000055', '2 Mountain Road', '', 'Ottawa', '6130039343', 'K1I1T0', '5000018');
INSERT INTO billingaddress VALUES ('6000056', '839 Minamo Road', '', 'Victoria', '9402934432', 'L2I2V6', '5000024');
INSERT INTO billingaddress VALUES ('6000057', '93 Arcane Lane', '', 'Toronto', '3940392222', 'K6E5N3', '5000023');
INSERT INTO billingaddress VALUES ('6000058', '8 Light Lane', '', 'Calgary', '3908832203', 'T6E2E6', '5000020');
INSERT INTO billingaddress VALUES ('6000059', '3094 Lotus Lane', '', 'Ottawa', '8098886664', 'T5M4P4', '5000029');
INSERT INTO billingaddress VALUES ('6000002', '752 Needle Road', '', 'Toronto', '7390561378', 'P4I5T9', '5000001');
INSERT INTO billingaddress VALUES ('6000003', '517 Vesuva Court', '', 'Vancouver', '5294163506', 'L8A9N8', '5000002');
INSERT INTO billingaddress VALUES ('6000004', '115 Stage Plaza', '', 'Paris', '9869962877', 'T8H0E9', '5000003');
INSERT INTO billingaddress VALUES ('6000005', '33 Rune Walk', '', 'Montreal', '9207394126', 'M7O4T1', '5000004');
INSERT INTO billingaddress VALUES ('6000006', '126 Wayfarer Trail', '', 'Victoria', '2641342013', 'W3E2A0', '5000005');
INSERT INTO billingaddress VALUES ('6000011', '310 Angel Crescent', '', 'Ottawa', '3210310885', 'B9A8N0', '5000010');
INSERT INTO billingaddress VALUES ('6000013', '800 Goldnight Street', '', 'Ottawa', '6750271947', 'G2I2S6', '5000012');
INSERT INTO billingaddress VALUES ('6000014', '556 Nevermore Street', '', 'Ottawa', '6529007386', 'E5N4C6', '5000013');
INSERT INTO billingaddress VALUES ('6000016', '318 Sunblast Road', '', 'Ottawa', '9868618451', 'A2N6G5', '5000015');
INSERT INTO billingaddress VALUES ('6000017', '982 Kite Lane', '', 'Ottawa', '6518235496', 'U6T5V3', '5000016');
INSERT INTO billingaddress VALUES ('6000019', '845 Kings Court', '', 'Ottawa', '2496585365', 'D6AR52', '5000018');
INSERT INTO billingaddress VALUES ('6000021', '8964 Muse Place', '', 'Ottawa', '4521486328', 'W6I7N8', '5000020');
INSERT INTO billingaddress VALUES ('6000023', '348 Retreat Road', '', 'Ottawa', '5032845233', 'S4O6R7', '5000022');
INSERT INTO billingaddress VALUES ('6000027', '8394 Ascension Place', '', 'Ottawa', '2385875882', 'L6U5M5', '5000026');
INSERT INTO billingaddress VALUES ('6000028', '13 Byron Street', '', 'Ottawa', '6135569882', 'S0T4O2', '5000027');
INSERT INTO billingaddress VALUES ('6000029', '57 Charger Street', '', 'Ottawa', '4168852331', 'H2E3L5', '5000028');
INSERT INTO billingaddress VALUES ('6000031', '778 Chandra Road', '', 'Ottawa', '9059954234', 'F2I3R3', '5000030');
INSERT INTO billingaddress VALUES ('6000032', '214 Forge Street', '', 'Ottawa', '2015587432', 'P5U1L1', '5000031');
INSERT INTO billingaddress VALUES ('6000034', '300 Annex Lane', '', 'Ottawa', '4032258741', 'N7O8R8', '5000033');
INSERT INTO billingaddress VALUES ('6000035', '762 Curiosity Road', '', 'Ottawa', '2259886335', 'A4U5R5', '5000034');
INSERT INTO billingaddress VALUES ('6000007', '2 Whispersilk Street', '', 'Quebec City', '9587620041', 'E1Q1I6', '5000006');
INSERT INTO billingaddress VALUES ('6000008', '92 Relic Road', '', 'New York', '8135643848', 'L2O1L1', '5000007');
INSERT INTO billingaddress VALUES ('6000009', '75 Oust Lane', '', 'Washington', '5442430001', 'O1W6N6', '5000008');
INSERT INTO billingaddress VALUES ('6000010', '30 Wizard Street', '', 'Hanoi', '2126678800', 'H1U2M3', '5000009');
INSERT INTO billingaddress VALUES ('6000012', '10 Mizzium Street', '', 'Toronto', '5338794452', 'S7K7I8', '5000011');
INSERT INTO billingaddress VALUES ('6000015', '3 Raven Lane', '', 'Montreal', '6028883223', 'F2A2M3', '5000014');
INSERT INTO billingaddress VALUES ('6000018', '32 Cloud Court', '', 'Calgary', '3056637889', 'F3A2E2', '5000017');
INSERT INTO billingaddress VALUES ('6000020', '688 Snap Street', '', 'Calgary', '9845235554', 'I2N2S4', '5000019');
INSERT INTO billingaddress VALUES ('6000022', '4054 Rebound Road', '', 'Kingston', '5556782421', 'I0N9T9', '5000021');
INSERT INTO billingaddress VALUES ('6000024', '11 Wild Lane', '', 'Kitchener', '9085563113', 'E7V0O3', '5000023');
INSERT INTO billingaddress VALUES ('6000025', '32 Azorius Street', '', 'London', '4135589933', 'K3E3Y6', '5000024');
INSERT INTO billingaddress VALUES ('6000026', '301 Spire Place', '', 'London', '5028875522', 'P6R3A3', '5000025');
INSERT INTO billingaddress VALUES ('6000030', '5 Judge Street', '', 'Hanoi', '9224565588', 'L3A2R2', '5000029');
INSERT INTO billingaddress VALUES ('6000033', '225 Fog Road', '', 'Mumbai', '3007748889', 'B3N4K4', '5000032');
INSERT INTO billingaddress VALUES ('6000036', '43 Adept Place', '', 'Toronto', '8739938475', 'P2O3R2', '5000000');
INSERT INTO billingaddress VALUES ('6000037', '74 Bolas Lane', '', 'Ottawa', '6132236664', 'T2O2R1', '5000002');
INSERT INTO billingaddress VALUES ('6000039', '493 Augur Road', '', 'Kansas', '3894230394', 'U2I1T1', '5000002');
INSERT INTO billingaddress VALUES ('6000040', '52 Court Court', '', 'Montreal', '2291129999', 'Y2O1W1', '5000003');
INSERT INTO billingaddress VALUES ('6000038', '4 Report Road', '', 'Ottawa', '6134440002', 'W3E4N4', '5000004');
INSERT INTO billingaddress VALUES ('6000060', '110 Bloom Road', '', 'Toronto', '3949930923', 'J5U9D8', '5000020');
INSERT INTO billingaddress VALUES ('6000061', '61 Magus Street', '', 'Montreal', '8007423334', 'C5O4F4', '5000028');
INSERT INTO billingaddress VALUES ('6000062', '54 Darksteel Street', '', 'Ottawa', '7084436772', 'A6R6T7', '5000023');
INSERT INTO billingaddress VALUES ('6000063', '10 Journey Street', '', 'Ottawa', '3940338881', 'P6I4C3', '5000019');
INSERT INTO billingaddress VALUES ('6000064', '8492 Auction Street', '', 'New York', '9025778833', 'C3O2D2', '5000021');
INSERT INTO billingaddress VALUES ('6000065', '65 Leng Lane', '', 'Paris', '7034442939', 'R4A3R3', '5000032');
INSERT INTO billingaddress VALUES ('6000066', '55 Golem Street', '', 'New York', '9398832738', 'M3Y5C7', '5000031');
INSERT INTO billingaddress VALUES ('6000067', '3 Fortune Lane', '', 'London', '3940093824', 'T3O7W8', '5000031');
INSERT INTO billingaddress VALUES ('6000068', '98 Halimar Road', '', 'Regina', '8024116653', 'P6T5H5', '5000031');
INSERT INTO billingaddress VALUES ('6000069', '32 Canyon Court', '', 'Victoria', '9056647773', 'D2N3S3', '5000042');
INSERT INTO billingaddress VALUES ('6000070', '93847 Druid Street', '', 'Regina', '6433458493', 'E2R4R4', '5000032');


--
-- Name: billingaddress_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('billingaddress_id_seq', 6000075, true);


--
-- Data for Name: billinginformation; Type: TABLE DATA; Schema: project; Owner: postgres
--

INSERT INTO billinginformation VALUES ('5000015', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000016', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000017', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000018', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000019', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000020', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000021', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000023', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000024', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000025', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000026', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000027', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000028', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000029', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000030', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000031', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000032', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000033', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000034', '123456789000    ', 'Visa');
INSERT INTO billinginformation VALUES ('5000001', '4536685636575343', 'Visa');
INSERT INTO billinginformation VALUES ('5000000', '1234567890003454', 'Visa');
INSERT INTO billinginformation VALUES ('5000002', '1212121212121212', 'Visa');
INSERT INTO billinginformation VALUES ('5000003', '2323232323232323', 'Visa');
INSERT INTO billinginformation VALUES ('5000004', '3434343434343434', 'Visa');
INSERT INTO billinginformation VALUES ('5000005', '4545454545454545', 'Visa');
INSERT INTO billinginformation VALUES ('5000006', '5656565656565656', 'Visa');
INSERT INTO billinginformation VALUES ('5000007', '6767676767676767', 'Visa');
INSERT INTO billinginformation VALUES ('5000008', '7878787878787878', 'Visa');
INSERT INTO billinginformation VALUES ('5000009', '5858585858585858', 'Visa');
INSERT INTO billinginformation VALUES ('5000010', '9090909090909090', 'Visa');
INSERT INTO billinginformation VALUES ('5000011', '123456789000    ', 'Paypal');
INSERT INTO billinginformation VALUES ('5000012', '123456789000    ', 'Paypal');
INSERT INTO billinginformation VALUES ('5000013', '123456789000    ', 'Paypal');
INSERT INTO billinginformation VALUES ('5000014', '123456789000    ', 'Paypal');
INSERT INTO billinginformation VALUES ('5000022', '123456789000    ', 'None');


--
-- Data for Name: director; Type: TABLE DATA; Schema: project; Owner: postgres
--

INSERT INTO director VALUES ('0000001', 'Darabont', 'Frank', 'January 28, 1959');
INSERT INTO director VALUES ('0000002', 'Ford Coppola', 'Francis', 'April 7, 1939');
INSERT INTO director VALUES ('0000003', 'Tarantino', 'Quentin', 'March 27, 1963');
INSERT INTO director VALUES ('0000004', 'Leone', 'Sergio', 'January 3, 1929');
INSERT INTO director VALUES ('0000005', 'Lumet', 'Sidney', 'June 25, 1924');
INSERT INTO director VALUES ('0000006', 'Nolan', 'Christopher', 'July 30, 1970');
INSERT INTO director VALUES ('0000007', 'Spielberg', 'Steven', 'December 18, 1946');
INSERT INTO director VALUES ('0000008', 'Jackson', 'Peter', 'October 31, 1961');
INSERT INTO director VALUES ('0000009', 'Fincher', 'David', 'August 28, 1962');
INSERT INTO director VALUES ('0000010', 'Kershner', 'Irvin', 'April 29, 1923');
INSERT INTO director VALUES ('0000011', 'Forman', 'Milos', 'February 18, 1932');
INSERT INTO director VALUES ('0000012', 'Scorsese', 'Martin', 'November 17, 1942');
INSERT INTO director VALUES ('0000013', 'Lucas', 'George', 'May 14, 1944');
INSERT INTO director VALUES ('0000014', 'Kurosawa', 'Akira', 'March 23, 1910');
INSERT INTO director VALUES ('0000015', 'Zemeckis', 'Robert', 'May 14, 1951');
INSERT INTO director VALUES ('0000016', 'Andy', 'Wachowski', 'December 29, 1967');
INSERT INTO director VALUES ('0000017', 'Meirelles', 'Fernando', 'November 9, 1955');
INSERT INTO director VALUES ('0000018', 'Demme', 'Jonathan', 'February 22, 1944');
INSERT INTO director VALUES ('0000019', 'Curtiz', 'Michael', 'December 24, 1886');
INSERT INTO director VALUES ('0000020', 'Singer', 'Bryan', 'September 17, 1965');
INSERT INTO director VALUES ('0000021', 'Hitchcock', 'Alfred', 'August 13, 1899');
INSERT INTO director VALUES ('0000022', 'Cameron', 'James', 'August 16, 1954');
INSERT INTO director VALUES ('0000023', 'Polanski', 'Roman', 'August 18, 1933');
INSERT INTO director VALUES ('0000024', 'Unkrich', 'Lee', 'August 8, 1967');
INSERT INTO director VALUES ('0000025', 'Scott', 'Ridley', 'November 30, 1937');
INSERT INTO director VALUES ('0000026', 'Jeunet', 'Jean-Pierre', 'September 3, 1953');
INSERT INTO director VALUES ('0000027', 'Mulligan', 'Robert', 'August 23, 1925');
INSERT INTO director VALUES ('0000028', 'Whedon', 'Joss', 'June 23, 1964');
INSERT INTO director VALUES ('0000029', 'Wyler', 'William', 'July 1, 1902');


--
-- Data for Name: download; Type: TABLE DATA; Schema: project; Owner: postgres
--

INSERT INTO download VALUES ('5000000', '1000000', '17:00', 5.00, '2013-04-01');
INSERT INTO download VALUES ('5000000', '1000001', '17:00', 5.00, '2013-04-02');
INSERT INTO download VALUES ('5000001', '1000002', '17:00', 5.00, '2013-04-03');
INSERT INTO download VALUES ('5000001', '1000003', '17:00', 5.00, '2013-04-04');
INSERT INTO download VALUES ('5000002', '1000004', '17:00', 5.00, '2013-04-05');
INSERT INTO download VALUES ('5000002', '1000005', '17:00', 5.00, '2013-04-06');
INSERT INTO download VALUES ('5000003', '1000006', '17:00', 5.00, '2013-04-07');
INSERT INTO download VALUES ('5000003', '1000007', '17:00', 5.00, '2013-04-08');
INSERT INTO download VALUES ('5000004', '1000007', '17:00', 5.00, '2013-04-09');
INSERT INTO download VALUES ('5000005', '1000008', '17:00', 5.00, '2013-04-10');
INSERT INTO download VALUES ('5000005', '1000009', '17:00', 5.00, '2013-04-11');
INSERT INTO download VALUES ('5000006', '1000010', '17:00', 5.00, '2013-04-12');
INSERT INTO download VALUES ('5000006', '1000011', '17:00', 5.00, '2013-04-13');
INSERT INTO download VALUES ('5000007', '1000012', '17:00', 5.00, '2013-04-14');
INSERT INTO download VALUES ('5000007', '1000013', '17:00', 5.00, '2013-04-15');
INSERT INTO download VALUES ('5000008', '1000014', '17:00', 5.00, '2013-04-16');
INSERT INTO download VALUES ('5000008', '1000015', '17:00', 5.00, '2013-04-17');
INSERT INTO download VALUES ('5000009', '1000015', '17:00', 5.00, '2013-04-18');
INSERT INTO download VALUES ('5000009', '1000016', '17:00', 5.00, '2013-04-18');
INSERT INTO download VALUES ('5000010', '1000010', '17:00', 5.00, '2013-04-14');
INSERT INTO download VALUES ('5000010', '1000018', '17:00', 5.00, '2013-04-19');
INSERT INTO download VALUES ('5000011', '1000015', '17:00', 5.00, '2013-04-11');
INSERT INTO download VALUES ('5000011', '1000021', '17:00', 5.00, '2013-04-01');
INSERT INTO download VALUES ('5000011', '1000023', '17:00', 5.00, '2013-04-01');
INSERT INTO download VALUES ('5000012', '1000028', '17:00', 5.00, '2013-04-01');
INSERT INTO download VALUES ('5000012', '1000030', '17:00', 5.00, '2013-04-01');
INSERT INTO download VALUES ('5000007', '1000001', '13:25', 5.00, '2013-03-12');
INSERT INTO download VALUES ('5000030', '1000015', '15:24', 5.00, '2012-05-05');
INSERT INTO download VALUES ('5000031', '1000015', '12:08', 5.00, '2012-09-05');
INSERT INTO download VALUES ('5000032', '1000015', '02:01', 5.00, '2012-05-07');
INSERT INTO download VALUES ('5000029', '1000018', '03:02', 5.00, '2011-09-08');
INSERT INTO download VALUES ('5000028', '1000018', '03:02', 5.00, '2011-09-08');
INSERT INTO download VALUES ('5000027', '1000018', '03:02', 5.00, '2011-09-08');
INSERT INTO download VALUES ('5000026', '1000018', '03:02', 5.00, '2011-09-08');
INSERT INTO download VALUES ('5000025', '1000018', '03:02', 5.00, '2011-09-08');


--
-- Name: invoice_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('invoice_id_seq', 7000000054, true);


--
-- Data for Name: member; Type: TABLE DATA; Schema: project; Owner: postgres
--

INSERT INTO member VALUES ('5000000', 'Mark', 'Sila', 'mark@mail.com', 'password');
INSERT INTO member VALUES ('5000001', 'John', 'Doe', 'john@mail.com', 'pass');
INSERT INTO member VALUES ('5000002', 'Wayne', 'Rooney', 'rooney@mail.com', 'pass');
INSERT INTO member VALUES ('5000003', 'Frank', 'Lampard', 'lampard@mail.com', 'pass');
INSERT INTO member VALUES ('5000004', 'Terry', 'John', 'terry@mail.com', 'pass');
INSERT INTO member VALUES ('5000005', 'Check', 'Petr', 'petr@mail.com', 'pass');
INSERT INTO member VALUES ('5000006', 'Ivanovic', 'Branislav', 'bran@mail.com', 'pass');
INSERT INTO member VALUES ('5000007', 'Drogba', 'Didier', 'didier@mail.com', 'pass');
INSERT INTO member VALUES ('5000008', 'van Persie', 'Robin', 'robin@mail.com', 'pass');
INSERT INTO member VALUES ('5000009', 'Hernandez', 'Javier', 'javier@mail.com', 'pass');
INSERT INTO member VALUES ('5000010', 'Young', 'Ashley', 'ashley@mail.com', 'pass');
INSERT INTO member VALUES ('5000011', 'Giggs', 'Ryan', 'ryan@mail.com', 'pass');
INSERT INTO member VALUES ('5000012', 'Scholes', 'Paul', 'paul@mail.com', 'pass');
INSERT INTO member VALUES ('5000013', 'Carrick', 'Michael', 'carrick@mail.com', 'pass');
INSERT INTO member VALUES ('5000014', 'Cleverly', 'Tom', 'cleverly@mail.com', 'pass');
INSERT INTO member VALUES ('5000015', 'Neville', 'Gary', 'gary@mail.com', 'pass');
INSERT INTO member VALUES ('5000016', 'da Silva', 'Rafael', 'rafael@mail.com', 'pass');
INSERT INTO member VALUES ('5000017', 'da Silva', 'Fabio', 'fabio@mail.com', 'pass');
INSERT INTO member VALUES ('5000018', 'Evra', 'Patrick', 'evra@mail.com', 'pass');
INSERT INTO member VALUES ('5000019', 'Vidic', 'Nemanja', 'vidic@mail.com', 'pass');
INSERT INTO member VALUES ('5000020', 'Ferdinand', 'Rio', 'rio@mail.com', 'pass');
INSERT INTO member VALUES ('5000021', 'Evans', 'Johnny', 'evans@mail.com', 'pass');
INSERT INTO member VALUES ('5000022', 'de Gea', 'David', 'degea@mail.com', 'pass');
INSERT INTO member VALUES ('5000023', 'Nani', 'Luis', 'nani@mail.com', 'pass');
INSERT INTO member VALUES ('5000024', 'Ronaldo', 'Cristiano', 'ronaldo@mail.com', 'pass');
INSERT INTO member VALUES ('5000025', 'Messi', 'Lionel', 'messi@mail.com', 'pass');
INSERT INTO member VALUES ('5000026', 'Puyol', 'Carlos', 'puyol@mail.com', 'pass');
INSERT INTO member VALUES ('5000027', 'Pique', 'Gerrard', 'pique@mail.com', 'pass');
INSERT INTO member VALUES ('5000028', 'Villa', 'David', 'villa@mail.com', 'pass');
INSERT INTO member VALUES ('5000029', 'Masquerano', 'Javier', 'masque@mail.com', 'pass');
INSERT INTO member VALUES ('5000030', 'Tello', 'Cristian', 'tello@mail.com', 'pass');
INSERT INTO member VALUES ('5000031', 'Casillas', 'Iker', 'iker@mail.com', 'pass');
INSERT INTO member VALUES ('5000032', 'Ozil', 'Mesut', 'ozil@mail.com', 'pass');
INSERT INTO member VALUES ('5000033', 'di Maria', 'Angel', 'maria@mail.com', 'pass');
INSERT INTO member VALUES ('5000034', 'Minami', 'Alice', 'alice@mail.com', 'pass');
INSERT INTO member VALUES ('5000040', 'abc', 'xyz', NULL, NULL);
INSERT INTO member VALUES ('5000041', 'Do', 'Trung', 'chin.bimbo@gmail.com', 'password');
INSERT INTO member VALUES ('5000042', 'boo', 'adnan', 'abc', 'pass');
INSERT INTO member VALUES ('5000044', 'f', 'm', 'f', 'f');


--
-- Name: member_id_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('member_id_seq', 5000044, true);


--
-- Data for Name: purchase; Type: TABLE DATA; Schema: project; Owner: postgres
--

INSERT INTO purchase VALUES ('7000000015', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000007', '1000007', '2013-04-11');
INSERT INTO purchase VALUES ('7000000003', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000001', '1000029', '2013-06-06');
INSERT INTO purchase VALUES ('7000000043', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000020', '1000022', '2013-04-01');
INSERT INTO purchase VALUES ('7000000044', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000020', '1000023', '2013-04-01');
INSERT INTO purchase VALUES ('7000000045', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000021', '1000027', '2013-04-01');
INSERT INTO purchase VALUES ('7000000016', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000007', '1000008', '2013-04-12');
INSERT INTO purchase VALUES ('7000000000', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000000', '1000006', '2013-04-01');
INSERT INTO purchase VALUES ('7000000004', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000002', '1000005', '2013-07-07');
INSERT INTO purchase VALUES ('7000000006', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000001', '1000002', '2013-04-02');
INSERT INTO purchase VALUES ('7000000007', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000002', '1000002', '2013-04-03');
INSERT INTO purchase VALUES ('7000000008', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000002', '1000003', '2013-04-04');
INSERT INTO purchase VALUES ('7000000009', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000003', '1000003', '2013-04-05');
INSERT INTO purchase VALUES ('7000000010', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000003', '1000004', '2013-04-06');
INSERT INTO purchase VALUES ('7000000011', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000004', '1000004', '2013-04-07');
INSERT INTO purchase VALUES ('7000000012', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000004', '1000005', '2013-04-08');
INSERT INTO purchase VALUES ('7000000013', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000005', '1000005', '2013-04-09');
INSERT INTO purchase VALUES ('7000000014', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000006', '1000006', '2013-04-10');
INSERT INTO purchase VALUES ('7000000018', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000008', '1000008', '2013-04-13');
INSERT INTO purchase VALUES ('7000000019', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000008', '1000009', '2013-04-14');
INSERT INTO purchase VALUES ('7000000020', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000009', '1000009', '2013-04-15');
INSERT INTO purchase VALUES ('7000000021', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000009', '1000011', '2013-04-16');
INSERT INTO purchase VALUES ('7000000022', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000010', '1000001', '2013-04-17');
INSERT INTO purchase VALUES ('7000000023', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000010', '1000012', '2013-04-18');
INSERT INTO purchase VALUES ('7000000024', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000011', '1000013', '2013-04-19');
INSERT INTO purchase VALUES ('7000000025', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000012', '1000014', '2013-04-20');
INSERT INTO purchase VALUES ('7000000026', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000012', '1000015', '2013-04-21');
INSERT INTO purchase VALUES ('7000000027', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000013', '1000032', '2013-04-22');
INSERT INTO purchase VALUES ('7000000031', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000013', '1000022', '2013-04-23');
INSERT INTO purchase VALUES ('7000000001', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000030', '1000031', '2013-11-02');
INSERT INTO purchase VALUES ('7000000002', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000000', '1000002', '2012-05-05');
INSERT INTO purchase VALUES ('7000000005', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000001', '1000001', '2013-08-08');
INSERT INTO purchase VALUES ('7000000032', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000014', '1000024', '2013-04-01');
INSERT INTO purchase VALUES ('7000000033', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000014', '1000016', '2013-04-01');
INSERT INTO purchase VALUES ('7000000034', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000015', '1000025', '2013-04-01');
INSERT INTO purchase VALUES ('7000000035', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000015', '1000014', '2013-04-01');
INSERT INTO purchase VALUES ('7000000036', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000016', '1000022', '2013-04-01');
INSERT INTO purchase VALUES ('7000000037', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000017', '1000008', '2013-04-01');
INSERT INTO purchase VALUES ('7000000038', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000017', '1000009', '2013-04-01');
INSERT INTO purchase VALUES ('7000000039', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000017', '1000010', '2013-04-01');
INSERT INTO purchase VALUES ('7000000040', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000018', '1000019', '2013-04-01');
INSERT INTO purchase VALUES ('7000000041', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000019', '1000020', '2013-04-01');
INSERT INTO purchase VALUES ('7000000042', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000019', '1000021', '2013-04-01');
INSERT INTO purchase VALUES ('7000000046', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000022', '1000029', '2013-04-01');
INSERT INTO purchase VALUES ('7000000047', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000022', '1000030', '2013-04-01');
INSERT INTO purchase VALUES ('7000000048', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000023', '1000031', '2013-04-01');
INSERT INTO purchase VALUES ('7000000049', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000023', '1000032', '2013-04-01');
INSERT INTO purchase VALUES ('7000000050', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000023', '1000033', '2013-04-01');
INSERT INTO purchase VALUES ('7000000051', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000023', '1000034', '2013-04-01');
INSERT INTO purchase VALUES ('7000000052', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000024', '1000035', '2013-04-01');
INSERT INTO purchase VALUES ('7000000053', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000024', '1000036', '2013-04-01');
INSERT INTO purchase VALUES ('7000000054', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000024', '1000037', '2013-04-01');
INSERT INTO purchase VALUES ('7000000055', 'April 2, 2013', 2.00, 'Normal    ', 'Fedex', '5000007', '1000001', '2013-04-05');
INSERT INTO purchase VALUES ('7000000056', 'April 5, 2013', 2.00, 'Normal    ', 'Fedex', '5000010', '1000009', '2013-04-05');


--
-- Data for Name: shippingaddress; Type: TABLE DATA; Schema: project; Owner: postgres
--

INSERT INTO shippingaddress VALUES ('6000036', '6 Jace Place', '', 'Mumbai', '4037753321', 'T3A2S2', '5000000');
INSERT INTO shippingaddress VALUES ('6000007', '2981 Knowledge Lane', '', 'Quebec City', '7770959801', 'T1D3X5', '5000006');
INSERT INTO shippingaddress VALUES ('6000008', '292 Temple Street', '', 'New York', '8042443388', 'P7A4N6', '5000007');
INSERT INTO shippingaddress VALUES ('6000009', '838 Wurm Walk', '', 'Washington', '2785947303', 'B3S7J6', '5000008');
INSERT INTO shippingaddress VALUES ('6000010', '929 Armada Avenue', '', 'Hanoi', '1609492256', 'S2G9Y5', '5000009');
INSERT INTO shippingaddress VALUES ('6000011', '34 Steel Street', '', 'Ottawa', '4870157621', 'N1G0P5', '5000010');
INSERT INTO shippingaddress VALUES ('6000035', '100 Foo Street', '', 'Ottawa', '8343468556', 'K5Y0X3', '5000034');
INSERT INTO shippingaddress VALUES ('6000001', '435 Chorus Crescent', '', 'Ottawa', '4868807472', 'B6S2W9', '5000000');
INSERT INTO shippingaddress VALUES ('6000002', '93 Storm Street', '', 'Toronto', '7735707522', 'T4S3L2', '5000001');
INSERT INTO shippingaddress VALUES ('6000003', '9048 Casting Court', '', 'Vancouver', '3939285017', 'C3V6E4', '5000002');
INSERT INTO shippingaddress VALUES ('6000004', '4398 Cliff Court', '', 'Paris', '2866242233', 'C2V2B5', '5000003');
INSERT INTO shippingaddress VALUES ('6000005', '273 Slumber Street', '', 'Montreal', '7746264950', 'W5D0L4', '5000004');
INSERT INTO shippingaddress VALUES ('6000006', '371 Pursuit Place', '', 'Victoria', '3624938534', 'L1N2D1', '5000005');
INSERT INTO shippingaddress VALUES ('6000012', '7392 Royal Place', '', 'Toronto', '6682395391', 'N2R8Q6', '5000011');
INSERT INTO shippingaddress VALUES ('6000013', '3902 Cloudpost Court', '', 'Ottawa', '2146116564', 'N3R0N4', '5000012');
INSERT INTO shippingaddress VALUES ('6000015', '72 Township Trail', '', 'Montreal', '5023414559', 'C4H1H2', '5000014');
INSERT INTO shippingaddress VALUES ('6000014', '892 Passage Place', '', 'Ottawa', '7140744457', 'B4N2E7', '5000013');
INSERT INTO shippingaddress VALUES ('6000016', '6 Guardian Glade', '', 'Ottawa', '9510484933', 'L6E0G6', '5000015');
INSERT INTO shippingaddress VALUES ('6000017', '982 Grove Gate', '', 'Ottawa', '8289887269', 'P1E0X9', '5000016');
INSERT INTO shippingaddress VALUES ('6000018', '982 Forest Street', '', 'Calgary', '5981206567', 'C1T8J8', '5000017');
INSERT INTO shippingaddress VALUES ('6000019', '472 Rank Street', '', 'Ottawa', '7003101952', 'R8G0A1', '5000018');
INSERT INTO shippingaddress VALUES ('6000020', '89 Avatar Avenue', '', 'Calgary', '9777166313', 'W3D5H6', '5000019');
INSERT INTO shippingaddress VALUES ('6000021', '6483 Crusade Crescent', '', 'Ottawa', '2243243778', 'C1T9L5', '5000020');
INSERT INTO shippingaddress VALUES ('6000022', '829 Realm Street', '', 'Kingston', '3513470164', 'E9S8E1', '5000021');
INSERT INTO shippingaddress VALUES ('6000023', '78 Charm Court', '', 'Ottawa', '4639917580', 'H2P7J9', '5000022');
INSERT INTO shippingaddress VALUES ('6000024', '22 Ghost Gate', '', 'Kitchener', '6722688053', 'W7R4N2', '5000023');
INSERT INTO shippingaddress VALUES ('6000025', '88 Nightveil Lane', '', 'London', '2197077419', 'S7A9P6', '5000024');
INSERT INTO shippingaddress VALUES ('6000026', '36 Tide Place', '', 'London', '2144964438', 'B1D7D5', '5000025');
INSERT INTO shippingaddress VALUES ('6000027', '91 Shinka Street', '', 'Ottawa', '6541339679', 'N5W1A1', '5000026');
INSERT INTO shippingaddress VALUES ('6000028', '41 Intrepid Avenue', '', 'Ottawa', '4427621628', 'R1H9X3', '5000027');
INSERT INTO shippingaddress VALUES ('6000029', '534 Parallel Place', '', 'Ottawa', '9521257589', 'U1B1E1', '5000028');
INSERT INTO shippingaddress VALUES ('6000030', '53 Basalt Road', '', 'Hanoi', '8367805892', 'I1P0R0', '5000029');
INSERT INTO shippingaddress VALUES ('6000031', '21 Norn Lane', '', 'Ottawa', '4313169916', 'M3N2D8', '5000030');
INSERT INTO shippingaddress VALUES ('6000032', '993 Oros Avenue', '', 'Ottawa', '7905407026', 'E1N2A6', '5000031');
INSERT INTO shippingaddress VALUES ('6000033', '66879 Silverblade Street', '', 'Mumbai', '5916522637', 'C9W8A1', '5000032');
INSERT INTO shippingaddress VALUES ('6000034', '92833 Worship Way', '', 'Ottawa', '7942477447', 'P1L6E0', '5000033');


--
-- Data for Name: video; Type: TABLE DATA; Schema: project; Owner: postgres
--

INSERT INTO video VALUES ('1000018', 'Forrest Gump', 1994, 10.00, 'Drama', 'PG-13', 142.00, 'y', '0000015', 'http://upload.wikimedia.org/wikipedia/en/thumb/6/67/Forrest_Gump_poster.jpg/220px-Forrest_Gump_poster.jpg');
INSERT INTO video VALUES ('1000019', 'The Matrix', 1999, 10.00, 'Action', 'R', 136.00, 'y', '0000016', 'http://upload.wikimedia.org/wikipedia/en/c/c1/The_Matrix_Poster.jpg');
INSERT INTO video VALUES ('1000021', 'City of God', 2002, 10.00, 'Crime', 'R', 130.00, 'y', '0000017', 'http://upload.wikimedia.org/wikipedia/en/thumb/1/10/CidadedeDeus.jpg/215px-CidadedeDeus.jpg');
INSERT INTO video VALUES ('1000022', 'Se7en', 1995, 10.00, 'Crime', 'R', 127.00, 'y', '0000009', 'http://upload.wikimedia.org/wikipedia/en/thumb/6/68/Seven_%28movie%29_poster.jpg/220px-Seven_%28movie%29_poster.jpg');
INSERT INTO video VALUES ('1000023', 'The Silence of the Lambs', 1991, 10.00, 'Crime', 'R', 118.00, 'y', '0000018', 'http://upload.wikimedia.org/wikipedia/en/thumb/8/86/The_Silence_of_the_Lambs_poster.jpg/220px-The_Silence_of_the_Lambs_poster.jpg');
INSERT INTO video VALUES ('1000024', 'Once Upon a Time in the West', 1958, 10.00, 'Adventure', 'PG-13', 175.00, 'y', '0000004', 'http://upload.wikimedia.org/wikipedia/en/thumb/a/a2/Once_upon_a_Time_in_the_West.jpg/260px-Once_upon_a_Time_in_the_West.jpg');
INSERT INTO video VALUES ('1000025', 'Casablanca', 1942, 10.00, 'Drama', 'PG', 102.00, 'y', '0000019', 'http://shop.tcm.com/img/product/resized/012/00373452-904012_catl_360.jpg?k=7a9b88fd&pid=373452&s=catl&sn=tcm');
INSERT INTO video VALUES ('1000026', 'The Usual Suspects', 1995, 10.00, 'Crime', 'R', 106.00, 'y', '0000020', 'http://upload.wikimedia.org/wikipedia/en/thumb/9/9c/Usual_suspects_ver1.jpg/220px-Usual_suspects_ver1.jpg');
INSERT INTO video VALUES ('1000027', 'Raiders of the Lost Ark', 1981, 10.00, 'Action', 'PG', 115.00, 'y', '0000007', 'http://upload.wikimedia.org/wikipedia/en/thumb/4/4b/Raiders.jpg/220px-Raiders.jpg');
INSERT INTO video VALUES ('1000028', 'Psycho', 1960, 10.00, 'Horror', 'UR', 109.00, 'y', '0000021', 'http://upload.wikimedia.org/wikipedia/en/thumb/b/b9/Psycho_%281960%29.jpg/215px-Psycho_%281960%29.jpg');
INSERT INTO video VALUES ('1000029', 'Saving Private Ryan', 1988, 10.00, 'Action', 'R', 169.00, 'y', '0000007', 'http://upload.wikimedia.org/wikipedia/en/thumb/a/ac/Saving_Private_Ryan_poster.jpg/220px-Saving_Private_Ryan_poster.jpg');
INSERT INTO video VALUES ('1000030', 'The Dark Knight Rises', 2012, 10.00, 'Action', 'PG-13', 165.00, 'y', '0000006', 'http://upload.wikimedia.org/wikipedia/en/thumb/8/83/Dark_knight_rises_poster.jpg/220px-Dark_knight_rises_poster.jpg');
INSERT INTO video VALUES ('1000031', 'The Pianist', 2002, 10.00, 'Drama', 'R', 150.00, 'y', '0000023', 'http://upload.wikimedia.org/wikipedia/en/thumb/a/a6/The_Pianist_movie.jpg/215px-The_Pianist_movie.jpg');
INSERT INTO video VALUES ('1000032', 'The Departed', 2006, 10.00, 'Crime', 'R', 151.00, 'y', '0000012', 'http://upload.wikimedia.org/wikipedia/en/thumb/5/50/Departed234.jpg/220px-Departed234.jpg');
INSERT INTO video VALUES ('1000033', 'Toy Story 3', 2010, 10.00, 'Animation', 'G', 103.00, 'y', '0000024', 'http://upload.wikimedia.org/wikipedia/en/thumb/6/69/Toy_Story_3_poster.jpg/220px-Toy_Story_3_poster.jpg');
INSERT INTO video VALUES ('1000034', 'Gladiator', 2000, 10.00, 'Action', 'R', 155.00, 'y', '0000025', 'http://upload.wikimedia.org/wikipedia/en/thumb/8/8d/Gladiator_ver1.jpg/220px-Gladiator_ver1.jpg');
INSERT INTO video VALUES ('1000035', 'Amélie', 2001, 10.00, 'Comedy', 'R', 122.00, 'y', '0000026', 'http://upload.wikimedia.org/wikipedia/en/thumb/5/53/Amelie_poster.jpg/215px-Amelie_poster.jpg');
INSERT INTO video VALUES ('1000036', 'To Kill a Mockingbird', 1962, 10.00, 'Crime', 'UR', 129.00, 'y', '0000027', 'http://upload.wikimedia.org/wikipedia/en/thumb/8/8e/To_Kill_a_Mockingbird_poster.jpg/220px-To_Kill_a_Mockingbird_poster.jpg');
INSERT INTO video VALUES ('1000037', 'Once Upon a Time in America', 1984, 10.00, 'Crime', 'R', 229.00, 'y', '0000004', 'http://upload.wikimedia.org/wikipedia/en/thumb/d/d8/Once_Upon_A_Time_In_America1.jpg/220px-Once_Upon_A_Time_In_America1.jpg');
INSERT INTO video VALUES ('1000038', 'Titanic ', 1997, 10.00, 'Romance', 'PG-13', 194.00, 'y', '0000022', 'http://upload.wikimedia.org/wikipedia/en/thumb/2/22/Titanic_poster.jpg/220px-Titanic_poster.jpg');
INSERT INTO video VALUES ('1000006', '12 Angry Men', 1957, 10.00, 'Drama', 'UR', 96.00, 'y', '0000005', 'http://upload.wikimedia.org/wikipedia/en/thumb/9/91/12_angry_men.jpg/220px-12_angry_men.jpg');
INSERT INTO video VALUES ('1000007', 'The Dark Knight', 2008, 15.00, 'Action', 'PG-13', 152.00, 'y', '0000006', 'http://upload.wikimedia.org/wikipedia/en/thumb/8/8a/Dark_Knight.jpg/220px-Dark_Knight.jpg');
INSERT INTO video VALUES ('1000001', 'The Shawshank Redemption', 1994, 10.00, 'Drama', 'R', 142.00, 'y', '0000001', 'http://upload.wikimedia.org/wikipedia/en/thumb/8/81/ShawshankRedemptionMoviePoster.jpg/220px-ShawshankRedemptionMoviePoster.jpg');
INSERT INTO video VALUES ('1000002', 'The Godfather', 1972, 10.00, 'Drama', 'R', 175.00, 'y', '0000002', 'http://upload.wikimedia.org/wikipedia/en/thumb/1/1c/Godfather_ver1.jpg/215px-Godfather_ver1.jpg');
INSERT INTO video VALUES ('1000003', 'The Godfather: Part II', 1974, 10.00, 'Drama', 'R', 200.00, 'y', '0000002', 'http://upload.wikimedia.org/wikipedia/en/thumb/0/03/Godfather_part_ii.jpg/220px-Godfather_part_ii.jpg');
INSERT INTO video VALUES ('1000004', 'Pulp Fiction', 1994, 10.00, 'Crime', 'R', 154.00, 'y', '0000003', 'http://upload.wikimedia.org/wikipedia/en/thumb/8/82/Pulp_Fiction_cover.jpg/215px-Pulp_Fiction_cover.jpg');
INSERT INTO video VALUES ('1000005', 'The Good, the Bad and the Ugly', 1966, 10.00, 'Adventure', 'UR', 161.00, 'y', '0000004', 'http://upload.wikimedia.org/wikipedia/en/thumb/4/45/Good_the_bad_and_the_ugly_poster.jpg/220px-Good_the_bad_and_the_ugly_poster.jpg');
INSERT INTO video VALUES ('1000008', 'Schindler''s List', 1993, 10.00, 'War', 'R', 195.00, 'y', '0000007', 'http://upload.wikimedia.org/wikipedia/en/thumb/3/38/Schindler%27s_List_movie.jpg/220px-Schindler%27s_List_movie.jpg');
INSERT INTO video VALUES ('1000009', 'The Lord of the Rings: The Return of the King', 2003, 10.00, 'Fantasy', 'PG-13', 201.00, 'y', '0000008', 'http://upload.wikimedia.org/wikipedia/en/thumb/9/9d/Lord_of_the_Rings_-_The_Return_of_the_King.jpg/215px-Lord_of_the_Rings_-_The_Return_of_the_King.jpg');
INSERT INTO video VALUES ('1000010', 'Fight Club', 1999, 10.00, 'Action', 'R', 139.00, 'y', '0000009', 'http://upload.wikimedia.org/wikipedia/en/thumb/f/fc/Fight_Club_poster.jpg/220px-Fight_Club_poster.jpg');
INSERT INTO video VALUES ('1000011', 'Star Wars: Episode V - The Empire Strikes Back', 1980, 10.00, 'Action', 'PG', 124.00, 'y', '0000010', 'http://upload.wikimedia.org/wikipedia/en/thumb/3/3c/SW_-_Empire_Strikes_Back.jpg/220px-SW_-_Empire_Strikes_Back.jpg');
INSERT INTO video VALUES ('1000012', 'The Lord of the Rings: The Fellowship of the Ring', 2001, 10.00, 'Fantasy', 'PG-13', 178.00, 'y', '0000008', 'http://upload.wikimedia.org/wikipedia/en/thumb/0/0c/The_Fellowship_Of_The_Ring.jpg/215px-The_Fellowship_Of_The_Ring.jpg');
INSERT INTO video VALUES ('1000013', 'One Flew Over the Cuckoo''s Nest', 1975, 10.00, 'Drama', 'R', 133.00, 'y', '0000011', 'http://upload.wikimedia.org/wikipedia/en/thumb/2/26/One_Flew_Over_the_Cuckoo%27s_Nest_poster.jpg/220px-One_Flew_Over_the_Cuckoo%27s_Nest_poster.jpg');
INSERT INTO video VALUES ('1000014', 'Inception', 2010, 10.00, 'Action', 'PG-13', 148.00, 'y', '0000006', 'http://upload.wikimedia.org/wikipedia/en/thumb/7/7f/Inception_ver3.jpg/220px-Inception_ver3.jpg');
INSERT INTO video VALUES ('1000039', 'Ben-Hur', 1959, 10.00, 'Adventure', 'G', 213.00, 'y', '0000029', 'http://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Ben_hur_1959_poster.jpg/220px-Ben_hur_1959_poster.jpg');
INSERT INTO video VALUES ('1000015', 'Goodfellas', 1990, 10.00, 'Drama', 'R', 146.00, 'y', '0000012', 'http://upload.wikimedia.org/wikipedia/en/thumb/7/7b/Goodfellas.jpg/220px-Goodfellas.jpg');
INSERT INTO video VALUES ('1000016', 'Star Wars', 1977, 10.00, 'Action', 'PG', 121.00, 'y', '0000013', 'http://upload.wikimedia.org/wikipedia/en/thumb/8/87/StarWarsMoviePoster1977.jpg/220px-StarWarsMoviePoster1977.jpg');
INSERT INTO video VALUES ('1000017', 'Seven Samurai', 1954, 10.00, 'Action', 'UR', 141.00, 'y', '0000014', 'http://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Seven_Samurai_poster.jpg/220px-Seven_Samurai_poster.jpg');
INSERT INTO video VALUES ('1000000', 'The Avengers', 2012, 20.00, 'Action', 'PG-13', 143.00, 'y', '0000028', 'http://upload.wikimedia.org/wikipedia/en/thumb/f/f9/TheAvengers2012Poster.jpg/220px-TheAvengers2012Poster.jpg');
INSERT INTO video VALUES ('1000020', 'The Lord of the Rings: The Two Towers', 2002, 10.00, 'Fantasy', 'PG-13', 179.00, 'y', '0000008', 'http://upload.wikimedia.org/wikipedia/en/thumb/a/ad/Lord_of_the_Rings_-_The_Two_Towers.jpg/215px-Lord_of_the_Rings_-_The_Two_Towers.jpg');


--
-- Data for Name: videoawards; Type: TABLE DATA; Schema: project; Owner: postgres
--

INSERT INTO videoawards VALUES ('1000001', '80001', 1995, 'n');
INSERT INTO videoawards VALUES ('1000001', '80003', 1995, 'n');
INSERT INTO videoawards VALUES ('1000001', '80002', 1995, 'n');
INSERT INTO videoawards VALUES ('1000038', '80015', 1998, 'y');
INSERT INTO videoawards VALUES ('1000002', '80006', 1973, 'y');
INSERT INTO videoawards VALUES ('1000002', '80007', 1973, 'y');
INSERT INTO videoawards VALUES ('1000002', '80008', 1973, 'y');
INSERT INTO videoawards VALUES ('1000003', '80009', 1975, 'y');
INSERT INTO videoawards VALUES ('1000003', '80010', 1975, 'y');
INSERT INTO videoawards VALUES ('1000003', '80011', 1975, 'y');
INSERT INTO videoawards VALUES ('1000003', '80012', 1975, 'y');
INSERT INTO videoawards VALUES ('1000003', '80013', 1975, 'y');
INSERT INTO videoawards VALUES ('1000003', '80014', 1975, 'y');
INSERT INTO videoawards VALUES ('1000038', '80016', 1998, 'y');
INSERT INTO videoawards VALUES ('1000038', '80017', 1998, 'y');
INSERT INTO videoawards VALUES ('1000038', '80018', 1998, 'y');
INSERT INTO videoawards VALUES ('1000038', '80019', 1998, 'y');
INSERT INTO videoawards VALUES ('1000038', '80020', 1998, 'y');
INSERT INTO videoawards VALUES ('1000038', '80021', 1998, 'y');
INSERT INTO videoawards VALUES ('1000038', '80022', 1998, 'y');
INSERT INTO videoawards VALUES ('1000038', '80023', 1998, 'y');
INSERT INTO videoawards VALUES ('1000038', '80024', 1998, 'y');
INSERT INTO videoawards VALUES ('1000038', '80025', 1998, 'y');
INSERT INTO videoawards VALUES ('1000038', '80026', 1998, 'n');
INSERT INTO videoawards VALUES ('1000038', '80027', 1998, 'n');
INSERT INTO videoawards VALUES ('1000038', '80028', 1998, 'n');
INSERT INTO videoawards VALUES ('1000039', '80029', 1959, 'y');
INSERT INTO videoawards VALUES ('1000039', '80030', 1959, 'y');
INSERT INTO videoawards VALUES ('1000039', '80031', 1959, 'y');
INSERT INTO videoawards VALUES ('1000039', '80032', 1959, 'y');
INSERT INTO videoawards VALUES ('1000039', '80033', 1959, 'y');
INSERT INTO videoawards VALUES ('1000039', '80034', 1959, 'y');
INSERT INTO videoawards VALUES ('1000039', '80035', 1959, 'y');
INSERT INTO videoawards VALUES ('1000039', '80036', 1959, 'y');
INSERT INTO videoawards VALUES ('1000039', '80037', 1959, 'y');
INSERT INTO videoawards VALUES ('1000039', '80038', 1959, 'y');
INSERT INTO videoawards VALUES ('1000039', '80039', 1959, 'y');
INSERT INTO videoawards VALUES ('1000039', '80040', 1959, 'n');
INSERT INTO videoawards VALUES ('1000009', '80041', 2004, 'y');
INSERT INTO videoawards VALUES ('1000009', '80042', 2004, 'y');
INSERT INTO videoawards VALUES ('1000009', '80043', 2004, 'y');
INSERT INTO videoawards VALUES ('1000009', '80044', 2004, 'y');
INSERT INTO videoawards VALUES ('1000009', '80045', 2004, 'y');
INSERT INTO videoawards VALUES ('1000009', '80046', 2004, 'y');
INSERT INTO videoawards VALUES ('1000009', '80047', 2004, 'y');
INSERT INTO videoawards VALUES ('1000009', '80048', 2004, 'y');
INSERT INTO videoawards VALUES ('1000009', '80049', 2004, 'y');
INSERT INTO videoawards VALUES ('1000009', '80050', 2004, 'y');
INSERT INTO videoawards VALUES ('1000009', '80051', 2004, 'y');
INSERT INTO videoawards VALUES ('1000025', '80052', 1944, 'y');
INSERT INTO videoawards VALUES ('1000025', '80053', 1944, 'y');
INSERT INTO videoawards VALUES ('1000025', '80054', 1944, 'y');
INSERT INTO videoawards VALUES ('1000025', '80055', 1944, 'n');
INSERT INTO videoawards VALUES ('1000025', '80056', 1944, 'n');
INSERT INTO videoawards VALUES ('1000025', '80057', 1944, 'n');
INSERT INTO videoawards VALUES ('1000025', '80058', 1944, 'n');
INSERT INTO videoawards VALUES ('1000025', '80059', 1944, 'n');
INSERT INTO videoawards VALUES ('1000001', '80060', 1995, 'n');
INSERT INTO videoawards VALUES ('1000001', '80061', 1995, 'n');
INSERT INTO videoawards VALUES ('1000001', '80062', 1995, 'n');
INSERT INTO videoawards VALUES ('1000001', '80005', 1995, 'n');
INSERT INTO videoawards VALUES ('1000006', '80063', 1958, 'n');
INSERT INTO videoawards VALUES ('1000006', '80064', 1958, 'n');
INSERT INTO videoawards VALUES ('1000006', '80065', 1958, 'n');


--
-- Data for Name: videosreturned; Type: TABLE DATA; Schema: project; Owner: postgres
--

INSERT INTO videosreturned VALUES ('5000016', '1000021', 1, 'Dec 2, 2012');
INSERT INTO videosreturned VALUES ('5000018', '1000021', 2, 'Nov 3, 2011');
INSERT INTO videosreturned VALUES ('5000015', '1000004', 3, 'Sep 5, 2012');
INSERT INTO videosreturned VALUES ('5000001', '1000024', 4, 'Oct 2, 2013');


--
-- Name: videosreturned_returnid_seq; Type: SEQUENCE SET; Schema: project; Owner: postgres
--

SELECT pg_catalog.setval('videosreturned_returnid_seq', 4, true);


--
-- Data for Name: videostar; Type: TABLE DATA; Schema: project; Owner: postgres
--

INSERT INTO videostar VALUES ('1000000', '2000026', 'Iron Man                                ');
INSERT INTO videostar VALUES ('1000000', '2000027', 'Black Widow                             ');
INSERT INTO videostar VALUES ('1000018', '2000066', 'Nurse at Park Bench                     ');
INSERT INTO videostar VALUES ('1000002', '2000003', 'Don Vito Corleone                       ');
INSERT INTO videostar VALUES ('1000002', '2000004', 'Michael Corleone                        ');
INSERT INTO videostar VALUES ('1000003', '2000004', 'Michael                                 ');
INSERT INTO videostar VALUES ('1000018', '2000067', 'Mrs. Gump                               ');
INSERT INTO videostar VALUES ('1000004', '2000006', 'Vincent Vega                            ');
INSERT INTO videostar VALUES ('1000019', '2000068', 'Morpheus                                ');
INSERT INTO videostar VALUES ('1000004', '2000008', 'Ringo                                   ');
INSERT INTO videostar VALUES ('1000005', '2000009', 'Tuco                                    ');
INSERT INTO videostar VALUES ('1000005', '2000010', 'Blondie                                 ');
INSERT INTO videostar VALUES ('1000005', '2000011', 'Angel Eyes                              ');
INSERT INTO videostar VALUES ('1000006', '2000012', 'Juror #1                                ');
INSERT INTO videostar VALUES ('1000006', '2000013', 'Juror #2                                ');
INSERT INTO videostar VALUES ('1000007', '2000014', 'Bruce Wayne                             ');
INSERT INTO videostar VALUES ('1000019', '2000069', 'Trinity                                 ');
INSERT INTO videostar VALUES ('1000006', '2000070', 'Juror #3                                ');
INSERT INTO videostar VALUES ('1000007', '2000016', 'Alfred                                  ');
INSERT INTO videostar VALUES ('1000002', '2000005', 'Tom Hagen                               ');
INSERT INTO videostar VALUES ('1000008', '2000018', 'Itzhak Stern                            ');
INSERT INTO videostar VALUES ('1000009', '2000019', 'Legolas                                 ');
INSERT INTO videostar VALUES ('1000009', '2000020', 'Boromir                                 ');
INSERT INTO videostar VALUES ('1000010', '2000021', 'The Narrator                            ');
INSERT INTO videostar VALUES ('1000010', '2000022', 'Tyler Durden                            ');
INSERT INTO videostar VALUES ('1000011', '2000023', 'Luke Skywalker                          ');
INSERT INTO videostar VALUES ('1000011', '2000024', 'Han Solo                                ');
INSERT INTO videostar VALUES ('1000012', '2000019', 'Legolas Greenleaf                       ');
INSERT INTO videostar VALUES ('1000012', '2000020', 'Boromir                                 ');
INSERT INTO videostar VALUES ('1000012', '2000025', 'Frodo Baggins                           ');
INSERT INTO videostar VALUES ('1000013', '2000028', 'Ellis                                   ');
INSERT INTO videostar VALUES ('1000014', '2000029', 'Cobb                                    ');
INSERT INTO videostar VALUES ('1000014', '2000030', 'Arthur                                  ');
INSERT INTO videostar VALUES ('1000015', '2000031', 'James Conway                            ');
INSERT INTO videostar VALUES ('1000016', '2000023', 'Luke Skywalker                          ');
INSERT INTO videostar VALUES ('1000016', '2000024', 'Han Solo                                ');
INSERT INTO videostar VALUES ('1000017', '2000032', 'Kikuchiyo                               ');
INSERT INTO videostar VALUES ('1000018', '2000033', 'Forrest Gump                            ');
INSERT INTO videostar VALUES ('1000019', '2000035', 'Neo                                     ');
INSERT INTO videostar VALUES ('1000020', '2000019', 'Legolas Greenleaf                       ');
INSERT INTO videostar VALUES ('1000021', '2000036', 'Buscapé - Rocket                        ');
INSERT INTO videostar VALUES ('1000022', '2000022', 'Detective David Mills                   ');
INSERT INTO videostar VALUES ('1000003', '2000003', 'Don Vito Corleone                       ');
INSERT INTO videostar VALUES ('1000023', '2000037', 'Clarice Starling                        ');
INSERT INTO videostar VALUES ('1000024', '2000038', 'Jill McBain                             ');
INSERT INTO videostar VALUES ('1000025', '2000039', 'Rick Blaine                             ');
INSERT INTO videostar VALUES ('1000025', '2000040', 'Ilsa Lund                               ');
INSERT INTO videostar VALUES ('1000026', '2000041', 'Michael McManus                         ');
INSERT INTO videostar VALUES ('1000027', '2000024', 'Indiana Jones                           ');
INSERT INTO videostar VALUES ('1000028', '2000042', 'Norman Bates                            ');
INSERT INTO videostar VALUES ('1000029', '2000033', 'Captain Miller                          ');
INSERT INTO videostar VALUES ('1000029', '2000044', 'Sergeant Horvath                        ');
INSERT INTO videostar VALUES ('1000030', '2000014', 'Bruce Wayne                             ');
INSERT INTO videostar VALUES ('1000030', '2000030', 'Blake                                   ');
INSERT INTO videostar VALUES ('1000020', '2000025', 'Frodo                                   ');
INSERT INTO videostar VALUES ('1000031', '2000045', 'Wladyslaw Szpilman                      ');
INSERT INTO videostar VALUES ('1000032', '2000029', 'Billy                                   ');
INSERT INTO videostar VALUES ('1000033', '2000033', 'Woody (voice)                           ');
INSERT INTO videostar VALUES ('1000033', '2000046', 'Buzz Lightyear (voice)                  ');
INSERT INTO videostar VALUES ('1000034', '2000047', 'Maximus                                 ');
INSERT INTO videostar VALUES ('1000035', '2000048', 'Amélie Poulain                          ');
INSERT INTO videostar VALUES ('1000036', '2000049', 'Atticus Finch                           ');
INSERT INTO videostar VALUES ('1000037', '2000031', 'David ''Noodles'' Aaronson                ');
INSERT INTO videostar VALUES ('1000037', '2000050', 'Maximilian ''Max'' Bercovicz              ');
INSERT INTO videostar VALUES ('1000000', '2000004', 'terminator                              ');
INSERT INTO videostar VALUES ('1000039', '2000060', 'Judah Ben-Hur                           ');
INSERT INTO videostar VALUES ('1000039', '2000061', 'Quintus Arrius                          ');
INSERT INTO videostar VALUES ('1000039', '2000062', 'Esther                                  ');
INSERT INTO videostar VALUES ('1000009', '2000025', 'Frodo                                   ');
INSERT INTO videostar VALUES ('1000038', '2000029', 'Jack Dawson                             ');
INSERT INTO videostar VALUES ('1000038', '2000063', 'Rose DeWitt Bukater                     ');
INSERT INTO videostar VALUES ('1000038', '2000064', 'Caledon ''Cal'' Hockley                   ');
INSERT INTO videostar VALUES ('1000001', '2000002', 'Ellis Boyd ''Red'' Redding                ');
INSERT INTO videostar VALUES ('1000007', '2000002', 'Lucius Fox                              ');
INSERT INTO videostar VALUES ('1000022', '2000002', 'Detective Lt. William Somerset          ');
INSERT INTO videostar VALUES ('1000030', '2000002', 'Fox                                     ');
INSERT INTO videostar VALUES ('1000021', '2000071', 'Zé Pequeno                              ');
INSERT INTO videostar VALUES ('1000003', '2000005', 'Tom Hagen                               ');
INSERT INTO videostar VALUES ('1000004', '2000007', 'Jules Winnfield                         ');
INSERT INTO videostar VALUES ('1000021', '2000072', 'Bené - Benny                            ');
INSERT INTO videostar VALUES ('1000007', '2000015', 'Joker                                   ');
INSERT INTO videostar VALUES ('1000008', '2000017', 'Oskar Schindler                         ');


--
-- Name: actor_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (actorid);


--
-- Name: award_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY award
    ADD CONSTRAINT award_pkey PRIMARY KEY (awardid, yearawarded);


--
-- Name: billingaddress_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY billingaddress
    ADD CONSTRAINT billingaddress_pkey PRIMARY KEY (baddresid);


--
-- Name: billinginformation_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY billinginformation
    ADD CONSTRAINT billinginformation_pkey PRIMARY KEY (membernumber, cardnumber);


--
-- Name: director_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY director
    ADD CONSTRAINT director_pkey PRIMARY KEY (directorid);


--
-- Name: download_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY download
    ADD CONSTRAINT download_pkey PRIMARY KEY (membernumber, videoid);


--
-- Name: member_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_pkey PRIMARY KEY (membernumber);


--
-- Name: purchase_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY purchase
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (invoicenumber);


--
-- Name: return_id_pk; Type: CONSTRAINT; Schema: project; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY videosreturned
    ADD CONSTRAINT return_id_pk PRIMARY KEY (returnid);


--
-- Name: shippingaddress_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY shippingaddress
    ADD CONSTRAINT shippingaddress_pkey PRIMARY KEY (saddresid);


--
-- Name: video_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY video
    ADD CONSTRAINT video_pkey PRIMARY KEY (videoid);


--
-- Name: videoawards_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY videoawards
    ADD CONSTRAINT videoawards_pkey PRIMARY KEY (videoid, awardid, yearawarded);


--
-- Name: videostar_pkey; Type: CONSTRAINT; Schema: project; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY videostar
    ADD CONSTRAINT videostar_pkey PRIMARY KEY (videoid, actorid);


--
-- Name: _RETURN; Type: RULE; Schema: project; Owner: postgres
--

CREATE RULE "_RETURN" AS ON SELECT TO most_oscar DO INSTEAD SELECT (((d.firstname)::text || ' '::text) || (d.lastname)::text) AS dname, v.videoid, v.videoname, count(*) AS number_oscar_won FROM video v, videoawards va, director d WHERE (((v.videoid = va.videoid) AND (d.directorid = v.directorid)) AND (va.won = 'y'::bpchar)) GROUP BY v.videoid, d.directorid ORDER BY count(*) DESC LIMIT 3;


--
-- Name: billingaddress_membernumber_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY billingaddress
    ADD CONSTRAINT billingaddress_membernumber_fkey FOREIGN KEY (membernumber) REFERENCES member(membernumber);


--
-- Name: billinginformation_membernumber_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY billinginformation
    ADD CONSTRAINT billinginformation_membernumber_fkey FOREIGN KEY (membernumber) REFERENCES member(membernumber);


--
-- Name: download_membernumber_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY download
    ADD CONSTRAINT download_membernumber_fkey FOREIGN KEY (membernumber) REFERENCES member(membernumber);


--
-- Name: download_videoid_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY download
    ADD CONSTRAINT download_videoid_fkey FOREIGN KEY (videoid) REFERENCES video(videoid);


--
-- Name: purchase_membernumber_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY purchase
    ADD CONSTRAINT purchase_membernumber_fkey FOREIGN KEY (membernumber) REFERENCES member(membernumber);


--
-- Name: purchase_videoid_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY purchase
    ADD CONSTRAINT purchase_videoid_fkey FOREIGN KEY (videoid) REFERENCES video(videoid);


--
-- Name: shippingaddress_membernumber_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY shippingaddress
    ADD CONSTRAINT shippingaddress_membernumber_fkey FOREIGN KEY (membernumber) REFERENCES member(membernumber);


--
-- Name: video_directorid_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY video
    ADD CONSTRAINT video_directorid_fkey FOREIGN KEY (directorid) REFERENCES director(directorid);


--
-- Name: videoawards_awardid_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY videoawards
    ADD CONSTRAINT videoawards_awardid_fkey FOREIGN KEY (awardid, yearawarded) REFERENCES award(awardid, yearawarded);


--
-- Name: videoawards_videoid_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY videoawards
    ADD CONSTRAINT videoawards_videoid_fkey FOREIGN KEY (videoid) REFERENCES video(videoid);


--
-- Name: videosreturned_membernumber_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY videosreturned
    ADD CONSTRAINT videosreturned_membernumber_fkey FOREIGN KEY (membernumber) REFERENCES member(membernumber) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: videosreturned_videoid_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY videosreturned
    ADD CONSTRAINT videosreturned_videoid_fkey FOREIGN KEY (videoid) REFERENCES video(videoid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: videostar_actorid_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY videostar
    ADD CONSTRAINT videostar_actorid_fkey FOREIGN KEY (actorid) REFERENCES actor(actorid) ON DELETE CASCADE;


--
-- Name: videostar_videoid_fkey; Type: FK CONSTRAINT; Schema: project; Owner: postgres
--

ALTER TABLE ONLY videostar
    ADD CONSTRAINT videostar_videoid_fkey FOREIGN KEY (videoid) REFERENCES video(videoid);


--
-- PostgreSQL database dump complete
--

