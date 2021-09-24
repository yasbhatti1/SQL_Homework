-- View: public.transaction_less_than_two_dollars

-- DROP VIEW public.transaction_less_than_two_dollars;

CREATE OR REPLACE VIEW public.transaction_less_than_two_dollars
 AS
 SELECT c.id AS cardholder_id,
    c.name AS cardholder_name,
    a.card AS credit_card_number,
    count(a.card) AS transactions_lessthan_2dollars
   FROM transaction a
     LEFT JOIN credit_card b ON a.card::text = b.card::text
     LEFT JOIN card_holder c ON b.cardholder_id = c.id
  WHERE a.amount < 2.00::double precision
  GROUP BY c.id, c.name, a.card
  ORDER BY (count(a.card)) DESC;

ALTER TABLE public.transaction_less_than_two_dollars
    OWNER TO postgres;

