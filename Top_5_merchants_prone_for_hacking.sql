create view Top_5_merchants_prone_for_credit_hacks AS
SELECT 
a.card AS credit_card_number,
a.id_merchant as merchant_id,
d.name as merchant_name,
count(a.card) AS transactions_lessthan_2dollars
FROM transaction a
LEFT JOIN credit_card b ON a.card::text = b.card::text
LEFT JOIN card_holder c ON b.cardholder_id = c.id
LEFT JOIN merchant d on a.id_merchant = d.id
WHERE a.amount < 2.00::double precision
GROUP BY a.card, a.id_merchant, d.name
ORDER BY (count(a.card)) DESC limit 5;