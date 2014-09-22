--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: cube; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;


--
-- Name: EXTENSION cube; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';


--
-- Name: earthdistance; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS earthdistance WITH SCHEMA public;


--
-- Name: EXTENSION earthdistance; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION earthdistance IS 'calculate great-circle distances on the surface of the Earth';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: journeys; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE journeys (
    id integer NOT NULL,
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    original_description text,
    mode character varying(255) NOT NULL,
    bus_route character varying(255),
    start_name character varying(255),
    start_point point,
    end_name character varying(255),
    end_point point,
    distance numeric,
    speed numeric,
    minutes_taken integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: journeys_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE journeys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE journeys_id_seq OWNED BY journeys.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY journeys ALTER COLUMN id SET DEFAULT nextval('journeys_id_seq'::regclass);


--
-- Name: journeys_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY journeys
    ADD CONSTRAINT journeys_pkey PRIMARY KEY (id);


--
-- Name: index_journeys_on_bus_route; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_journeys_on_bus_route ON journeys USING btree (bus_route);


--
-- Name: index_journeys_on_distance; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_journeys_on_distance ON journeys USING btree (distance);


--
-- Name: index_journeys_on_minutes_taken; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_journeys_on_minutes_taken ON journeys USING btree (minutes_taken);


--
-- Name: index_journeys_on_mode; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_journeys_on_mode ON journeys USING btree (mode);


--
-- Name: index_journeys_on_speed; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_journeys_on_speed ON journeys USING btree (speed);


--
-- Name: index_journeys_on_started_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_journeys_on_started_at ON journeys USING btree (started_at);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20131206221926');

INSERT INTO schema_migrations (version) VALUES ('20131206234944');

INSERT INTO schema_migrations (version) VALUES ('20140101145113');
