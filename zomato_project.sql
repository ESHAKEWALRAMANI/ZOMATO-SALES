select a.userid ,sum(b.price) total_amt_spent from sales a inner join product b on a.product_id = b.product_id group by a.userid

select userid ,count(distinct created_date)distinct_days from sales group by userid

select * from
(select *,rank() over (partition by userid order by created_date) rnk from sales) a where rnk=1

select userid,count(product_id) cnt from sales where product_id=
(select product_id from sales group by product_id order by count(product_id) desc limit 1)
group by userid

select * from
(select *,rank() over (partition by userid order by cnt desc) rnk from
(select userid,product_id,count(product_id) cnt from sales group by userid,product_id)a)b
where rnk = 1

select *from goldusers_signup

select * from
(select c.*, rank() over (partition by userid order by created_date) rnk from
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from sales a inner join
 goldusers_signup b on a.userid=b.userid and created_date>gold_signup_date)c) d where rnk =1;
 
 select * from
(select c.*, rank() over (partition by userid order by created_date desc) rnk from
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from sales a inner join
 goldusers_signup b on a.userid=b.userid and created_date<=gold_signup_date)c) d where rnk =1;


select userid, count(created_date) order_purchased,sum(price) total_amt_spent from
(select c.*, d.price from  
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from sales a inner join
 goldusers_signup b on a.userid=b.userid and created_date<=gold_signup_date) c inner join product d on c.product_id=d.product_id)e
 group by userid;
 
 
 select * from sales;
 select * from product;
 
select userid,sum(total_points)*2.5 total_points_earned from
(select e.*, amt/points total_points from
(select d.*, case when product_id=1 then 5 when product_id = 2 then 2 when product_id=3 then 5 else 0 end as points from
(select c.userid,c.product_id,sum(price) amt from
(select a.*,b.price from sales a inner join product b on a.product_id=b.product_id) c
group by userid,product_id)d)e)f group by userid;


select *,rank() over (order by total_points_earned desc) from
(select product_id,sum(total_points) total_points_earned from
(select e.*, amt/points total_points from
(select d.*, case when product_id=1 then 5 when product_id = 2 then 2 when product_id=3 then 5 else 0 end as points from
(select c.userid,c.product_id,sum(price) amt from
(select a.*,b.price from sales a inner join product b on a.product_id=b.product_id) c
group by userid,product_id)d)e)f group by product_id)f;


select *,rank() over(partition by userid order by created_date)rnk from sales;


select * from sales;

select c.*,case when gold_signup_date is null then 'NA' else rank() over(partition by userid order by created_date desc) end as rnk from
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from sales a left join
 goldusers_signup b on a.userid=b.userid and created_date>=gold_signup_date)c; 
 





 
 
 

 





