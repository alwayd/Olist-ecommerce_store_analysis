create database project2;
use project2;
show tables;
select * from olist_customers_dataset;
select * from olist_geolocation_dataset;
select * from olist_order_items_dataset;
select * from olist_order_payments_dataset;
select * from olist_order_reviews_dataset;
select * from olist_orders_dataset;
select * from olist_products_dataset;
select * from olist_sellers_dataset;
select * from product_category_name_translation;

#### 1)Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics
select
case 
when weekday(order_purchase_timestamp)>4 then "Weekend"
else "Weekday"
end WN,
count(order_purchase_timestamp) as OPTS 
from olist_orders_dataset
group by WN;
 
#### 2)Number of Orders with review score 5 and payment type as credit card.
select count(olist_order_reviews_dataset.review_score=5) as ReviewCount,
olist_order_payments_dataset.payment_type from 
olist_order_reviews_dataset join olist_order_payments_dataset
on olist_order_reviews_dataset.order_id = olist_order_payments_dataset.order_id
where olist_order_payments_dataset.payment_type ='credit_card'
group by olist_order_payments_dataset.payment_type;

#### 3)Average number of days taken for order_delivered_customer_date for pet_shop
select avg(olist_orders_dataset.order_delivered_customer_date),
olist_products_dataset.product_category_name from
olist_orders_dataset join olist_order_items_dataset
on olist_orders_dataset.order_id = olist_order_items_dataset.order_id
join olist_products_dataset
on olist_products_dataset.product_id = olist_order_items_dataset.product_id
where olist_products_dataset.product_category_name = 'pet_shop'
group by olist_products_dataset.product_category_name;

#### 4)Average price and payment values from customers of sao paulo city
select avg(olist_order_items_dataset.price),avg(olist_order_payments_dataset.payment_value),
olist_geolocation_dataset.geolocation_city from
olist_order_items_dataset join olist_order_payments_dataset
on 	olist_order_items_dataset.order_id = olist_order_payments_dataset.order_id
join olist_sellers_dataset
on olist_order_items_dataset.seller_id = olist_sellers_dataset.seller_id
join olist_geolocation_dataset
on olist_geolocation_dataset.geolocation_zip_code_prefix = olist_sellers_dataset.seller_zip_code_prefix
where olist_geolocation_dataset.geolocation_city =`sao paulo`
group by olist_geolocation_dataset.geolocation_city;
    
    
select avg(olist_order_items_dataset.price),avg(olist_order_payments_dataset.payment_value),
olist_customers_dataset.customer_city from
olist_order_items_dataset join olist_order_payments_dataset
on 	olist_order_items_dataset.order_id = olist_order_payments_dataset.order_id
join olist_orders_dataset
on olist_order_items_dataset.order_id = olist_orders_dataset.order_id
join olist_customers_dataset
on olist_orders_dataset.customer_id = olist_customers_dataset.customer_id
where olist_customers_dataset.customer_city = `sao paulo`
group by olist_customers_dataset.customer_city;    
    
#### 5)Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores.
select olist_orders_dataset.order_delivered_customer_date, olist_orders_dataset.order_purchase_timestamp,
olist_order_reviews_dataset.review_score from
olist_orders_dataset join olist_order_reviews_dataset
on olist_orders_dataset.order_id = olist_order_reviews_dataset.order_id;
