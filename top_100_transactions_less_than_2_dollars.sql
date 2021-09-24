-- View: public.top_100_transaction_made_between_7_9_am

-- DROP VIEW public.top_100_transaction_made_between_7_9_am;

CREATE OR REPLACE VIEW public.top_100_transaction_made_between_7_9_am
 AS
 SELECT a.id AS transaction_id,
    a.card AS transaction_card,
    a.date AS transaction_date,
    a.amount AS transaction_amount,
    c.name AS transaction_store
   FROM transaction a
     LEFT JOIN credit_card b ON a.card::text = b.card::text
     LEFT JOIN merchant c ON a.id_merchant = c.id
  WHERE a.date::time without time zone >= '07:00:00'::time without time zone AND a.date::time without time zone <= '09:00:00'::time without time zone
  GROUP BY a.id, a.card, a.date, c.name, a.amount
  ORDER BY a.amount DESC
 LIMIT 100;

ALTER TABLE public.top_100_transaction_made_between_7_9_am
    OWNER TO postgres;

