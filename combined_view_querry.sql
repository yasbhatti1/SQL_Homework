create view transaction_less_than_two_dollars as 
Select  c.id as "cardholder_id", c.name as "cardholder_name",
a.card as "credit_card_number", count(a.card) as "transactions_lessthan_2dollars" 
From transaction as a
Left Join credit_card as b on a.card = b.card
Left Join card_holder as c on b.cardholder_id = c.id
where a.amount < 2.00
Group By c.id, c.name, a.card
order by transactions_lessthan_2dollars desc;

create view top_100_transaction_made_between_7_9_am as
select a.id as transaction_id, a.card as transaction_card,
a.date as transaction_date, a.amount as transaction_amount,
c.name as transaction_store from transaction as a
left join credit_card as b on a.card = b.card
left join merchant as c on a.id_merchant = c.id
where (CAST(a.date as time) between '07:00' and '09:00')
Group by a.id, a.card, a.date, c.name, a.amount
order by transaction_amount desc limit 100;



