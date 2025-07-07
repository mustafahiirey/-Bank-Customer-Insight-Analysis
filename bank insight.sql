-- more insightful question
/* Question: How is the client distribution across different gender, age groups, and occupations? */
with c_distribut as (
select
	CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
		end as age_group,
		gender_name,
		Occupation
from bank)
select * from c_distribut
group by gender_name,age_group,Occupation
/* question :Question: Can you identify which risk profiles (Risk Weighting) are associated with the highest exposure 
to loans, and how this impacts the bank’s overall loan portfolio? */
select 
	Risk_Weighting,
	round(sum(Bank_Loans),0) as total_loans
from bank
group by Risk_Weighting
order by total_loans desc
/*Question : Which occupations hold the highest average bank deposits? Are there any occupations that consistently 
hold significant amounts of deposits? */
select 
	Occupation,
	round(avg(Bank_Deposits),2) as avg_deposit
from bank
group by Occupation
order by avg_deposit desc
/*Question: What is the relationship between the number of credit cards a client holds and their average bank deposits?
Are clients with more credit cards also higher depositors? */
select
	Amount_of_Credit_Cards,
	round(avg(Bank_Deposits),2) as avg_deposit
from bank
group by Amount_of_Credit_Cards
order by avg_deposit
/*Question: Do clients with higher estimated income tend to have higher loan amounts?*/
select
	Client_ID,
	name,
	Estimated_Income,
	Bank_Loans
from Bank
where Estimated_Income > 150000 and Bank_Loans > 500000
/* Question: Are clients who have high superannuation savings also maintaining significant bank deposits?*/
select
	Client_ID,
	name,
	Superannuation_Savings,
	Bank_Deposits
from Bank
where Superannuation_Savings > 70000 and Bank_Deposits > 100000
/* Question: What is the credit card usage behavior across different age groups? 
Do younger clients hold higher credit card balances?*/
select
	CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
		end as age_groups,
		round(sum(Credit_Card_Balance),2) as total_credit_balance
from bank
	group by CASE 
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
		end
	order by total_credit_balance
/*Question: Which bank branches (BRId) are performing the best in terms of total loan amounts and total deposits?*/
select
	BRId,
	round(sum(Bank_Deposits),2) as total_deposit_ammount,
	round(sum(Bank_Loans),2) as total_loans
from bank
group by BRId
/*Question: Identify clients who have credit cards but have not taken any loans.*/
select
	Client_ID,
	name,
	Amount_of_Credit_Cards,
	Bank_Loans
from bank 
where Amount_of_Credit_Cards >=1 and Bank_Loans = 0



/*Question: Who are the clients with high bank deposits but low credit card balances? What does this tell us about their financial habits?*/
select
	Client_ID,
	name,
	Bank_Deposits,
	Credit_Card_Balance
from bank
where Bank_Deposits > 1000000 and Credit_Card_Balance < 5000
/*Question: Who are the clients with the highest superannuation savings but also significant bank loans?*/
select
	Client_ID,
	name,
	Superannuation_Savings,
	Bank_Loans
from bank
where Superannuation_Savings > 70000 and Bank_Loans > 100000
order by Superannuation_Savings
/*Question: How does the wealth distribution (bank deposits, savings, business lending)
vary across different loyalty classifications (e.g., Jade, Platinum)?*/
select 
	Loyalty_Classification,
	round(sum(Bank_Deposits),2) as total_deposit,
	round(sum(Saving_Accounts),2) as total_saving,
	round(sum(Business_Lending),2) as totol_business_lendinh
from bank
group by Loyalty_Classification
order by total_deposit
/*Question: Who are the top clients by credit card balance and bank deposits combined?*/
select top 10
	Client_ID,
	name,
	Credit_Card_Balance,
	Bank_Deposits,
	(Credit_Card_Balance + Bank_Deposits) as total_balance
from bank 
order by total_balance desc 
/*Question: Identify clients with the highest number of properties who are also 
using multiple bank products (credit cards, loans, deposits).*/
select
	Client_ID,
	name,
	Properties_Owned,
	Amount_of_Credit_Cards,
	Bank_Loans,
	Bank_Deposits
from bank
where Amount_of_Credit_Cards >1 and Bank_Loans > 1000000 and Properties_Owned >=2

