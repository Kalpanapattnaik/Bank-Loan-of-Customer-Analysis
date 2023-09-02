use finance;
SET GLOBAL log_bin_trust_function_creators = 1; -- This variable controls whether binary logging should trust the stored 
												-- function creators for not to create stored functions that will cause unsafe events
-- KPI 1: Year wise loan amount Stats

select * from finance_1;
## select sum(loan_amnt) as Total_Loan from finance_1;
## select year(issue_d) as Yr from finance_1;
select year(issue_d) as Year,sum(loan_amnt) as Total_Loan from finance_1 group by year(issue_d) order by year(issue_d);
-- Method 1:
select year(issue_d) as Year,concat(cast(sum(loan_amnt)/1000000 as decimal(10,2)),'M') as Total_Loan from finance_1 
group by year(issue_d) order by year(issue_d);
-- Method 2:
select year(issue_d) as Year,num_format(sum(loan_amnt)) as Total_Loan from finance_1 
group by year(issue_d) order by year(issue_d);

-- KPI 2: Grade and sub grade wise revol_bal
SELECT * FROM finance_2;
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY','')); -- This supposed you need to make that GROUP BY with non aggregated columns
## SELECT F1.GRADE, F1.SUB_GRADE FROM finance_1 F1;
## SELECT sum(F2.REVOL_BAL) FROM finance_2 F2;
SELECT F1.GRADE, F1.SUB_GRADE, CONCAT(CAST(SUM(REVOL_BAL)/1000000 AS DECIMAL(10,2)),'M') AS TOTAL_REVOL_BAL 
FROM finance_1 F1 JOIN finance_2 F2 ON F1.ID = F2.ID 
GROUP BY F1.grade, F1.sub_grade ORDER BY F1. GRADE;

-- KPI 3: Total Payment for Verified Status Vs Total Payment for Non Verified Status
## select verification_status from finance_1;
## select total_pymnt from finance_2;
select f1.verification_status,num_format(sum(f2.total_pymnt)) as Total_payment 
from finance_1 f1 join finance_2 f2
on f1.id = f2.id where verification_status != 'Source verified' 
group by f1.verification_status;

-- KPI 4: State wise and last_credit_pull_d wise loan status
## select year(last_credit_pull_d) from finance_2;
select year(f2.last_credit_pull_d) as last_credit_pull_d, f1.addr_state, f1.loan_status from finance_1 f1 join finance_2 f2
on f1.id = f2.id group by f2.last_credit_pull_d, f1.addr_state, f1.loan_status order by year(f2.last_credit_pull_d);

Select year(f2.last_credit_pull_d) as last_credit_pull_d, f1.addr_state, count(loan_status) as Loan_status,
max(case when loan_status = 'Fully Paid' then loan_status end) as Fully_Paid,
max(case when loan_status = 'Current' then loan_status end) as Current,
max(case when loan_status = 'Charged Off' then loan_status end) as Charged_off
from finance_1 f1 join finance_2 f2
on f1.id = f2.id group by year(f2.last_credit_pull_d), f1.addr_state, f1.loan_status 
order by year(f2.last_credit_pull_d);

-- KPI 5: Home ownership Vs last payment date stats
select year(f2.last_pymnt_d) as year_of_last_pymnt_d, f1.home_ownership, count(f1.home_ownership) as home_ownership_count
from finance_1 f1 join finance_2 f2
on f1.id = f2.id
group by year(f2.last_pymnt_d),home_ownership order by year(f2.last_pymnt_d);

-- KPI 6: Avg Annual Income By Year
Select Year(issue_d) As Year, Concat(cast(Avg(annual_inc/1000) as decimal(10,2)),'K') As Avg_Income From finance_1
Group By Year(issue_d) Order By Year(issue_d) ;

-- KPI 7: Home Ownership Vs No. of Customers
Select home_ownership, Count(member_id) As Total_Customers
From finance_1 Group by home_ownership order by Count(member_id);

-- KPI 8: Sum of Loan Amount By Purpose
Select purpose, num_format(sum(loan_amnt)) As Loan_Amount
From finance_1 Group By purpose order by sum(loan_amnt);

-- KPI 9: Loan Amount By Loan Status
Select loan_status, num_format(sum(loan_amnt)) As Loan_Amount
From finance_1 Group By loan_status;