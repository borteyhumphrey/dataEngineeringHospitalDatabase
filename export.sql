--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5
-- Dumped by pg_dump version 15.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: appointment; Type: TABLE; Schema: public; Owner: humphreyborketey
--

CREATE TABLE public.appointment (
    appointment_id integer NOT NULL,
    patient_id integer NOT NULL,
    doc_id integer NOT NULL,
    appointment_date date,
    appointment_time time without time zone,
    visit_purpose text,
    CONSTRAINT appointment_appointment_date_check CHECK ((appointment_date > CURRENT_DATE)),
    CONSTRAINT appointment_appointment_time_check CHECK (((appointment_time)::time with time zone > CURRENT_TIME))
);


ALTER TABLE public.appointment OWNER TO humphreyborketey;

--
-- Name: department; Type: TABLE; Schema: public; Owner: humphreyborketey
--

CREATE TABLE public.department (
    department_id integer NOT NULL,
    department_name text,
    department_head integer
);


ALTER TABLE public.department OWNER TO humphreyborketey;

--
-- Name: doc_patient; Type: TABLE; Schema: public; Owner: humphreyborketey
--

CREATE TABLE public.doc_patient (
    relationship_id integer NOT NULL,
    patient_id integer,
    doc_id integer
);


ALTER TABLE public.doc_patient OWNER TO humphreyborketey;

--
-- Name: inventory; Type: TABLE; Schema: public; Owner: humphreyborketey
--

CREATE TABLE public.inventory (
    item_id integer NOT NULL,
    item_name character varying(256),
    quantity integer,
    reorder_level integer,
    max_capacity integer,
    CONSTRAINT inventory_check CHECK (((reorder_level > 0) AND (reorder_level < max_capacity))),
    CONSTRAINT inventory_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.inventory OWNER TO humphreyborketey;

--
-- Name: patient; Type: TABLE; Schema: public; Owner: humphreyborketey
--

CREATE TABLE public.patient (
    patient_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    date_of_birth date,
    phone_number character varying(15) NOT NULL,
    email character varying(255),
    med_history text,
    current_treatment text,
    CONSTRAINT patient_date_of_birth_check CHECK ((date_of_birth < CURRENT_DATE))
);


ALTER TABLE public.patient OWNER TO humphreyborketey;

--
-- Name: staff; Type: TABLE; Schema: public; Owner: humphreyborketey
--

CREATE TABLE public.staff (
    staff_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    phone_number character varying(15),
    email character varying(100),
    speciality text,
    working_hours text
);


ALTER TABLE public.staff OWNER TO humphreyborketey;

--
-- Name: staff_department; Type: TABLE; Schema: public; Owner: humphreyborketey
--

CREATE TABLE public.staff_department (
    staff_id integer NOT NULL,
    department_id integer NOT NULL,
    is_primary boolean
);


ALTER TABLE public.staff_department OWNER TO humphreyborketey;

--
-- Name: appointment appointment_doc_id_appointment_date_appointment_time_key; Type: CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_doc_id_appointment_date_appointment_time_key UNIQUE (doc_id, appointment_date, appointment_time);


--
-- Name: appointment appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_pkey PRIMARY KEY (appointment_id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);


--
-- Name: doc_patient doc_patient_pkey; Type: CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.doc_patient
    ADD CONSTRAINT doc_patient_pkey PRIMARY KEY (relationship_id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (item_id);


--
-- Name: patient patient_email_key; Type: CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_email_key UNIQUE (email);


--
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (patient_id);


--
-- Name: staff_department staff_department_pkey; Type: CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.staff_department
    ADD CONSTRAINT staff_department_pkey PRIMARY KEY (staff_id, department_id);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (staff_id);


--
-- Name: appointment appointment_doc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_doc_id_fkey FOREIGN KEY (doc_id) REFERENCES public.staff(staff_id);


--
-- Name: appointment appointment_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- Name: department department_department_head_fkey; Type: FK CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_department_head_fkey FOREIGN KEY (department_head) REFERENCES public.staff(staff_id);


--
-- Name: doc_patient doc_patient_doc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.doc_patient
    ADD CONSTRAINT doc_patient_doc_id_fkey FOREIGN KEY (doc_id) REFERENCES public.staff(staff_id);


--
-- Name: doc_patient doc_patient_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.doc_patient
    ADD CONSTRAINT doc_patient_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- Name: staff_department staff_department_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.staff_department
    ADD CONSTRAINT staff_department_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.department(department_id);


--
-- Name: staff_department staff_department_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: humphreyborketey
--

ALTER TABLE ONLY public.staff_department
    ADD CONSTRAINT staff_department_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);


--
-- PostgreSQL database dump complete
--

