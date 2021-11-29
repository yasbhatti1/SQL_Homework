CREATE TABLE IF NOT EXISTS public.card_holder
(
    id integer NOT NULL DEFAULT nextval('card_holder_id_seq'::regclass),
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT card_holder_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS public.credit_card
(
    card character varying(30) COLLATE pg_catalog."default" NOT NULL,
    cardholder_id smallint NOT NULL,
    CONSTRAINT credit_card_pkey PRIMARY KEY (card),
    CONSTRAINT credit_card_cardholder_id_fkey FOREIGN KEY (cardholder_id)
        REFERENCES public.card_holder (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.merchant
(
    id integer NOT NULL DEFAULT nextval('merchant_id_seq'::regclass),
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    id_merchant_category smallint NOT NULL,
    CONSTRAINT merchant_pkey PRIMARY KEY (id),
    CONSTRAINT merchant_id_merchant_category_fkey FOREIGN KEY (id_merchant_category)
        REFERENCES public.merchant_category (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.merchant_category
(
    id integer NOT NULL DEFAULT nextval('merchant_category_id_seq'::regclass),
    name character varying(30) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT merchant_category_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS public.transaction
(
    id smallint NOT NULL,
    date timestamp without time zone NOT NULL,
    amount double precision NOT NULL,
    card character varying(30) COLLATE pg_catalog."default" NOT NULL,
    id_merchant smallint NOT NULL,
    CONSTRAINT transaction_pkey PRIMARY KEY (id),
    CONSTRAINT transaction_card_fkey FOREIGN KEY (card)
        REFERENCES public.credit_card (card) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT transaction_id_merchant_fkey FOREIGN KEY (id_merchant)
        REFERENCES public.merchant (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
