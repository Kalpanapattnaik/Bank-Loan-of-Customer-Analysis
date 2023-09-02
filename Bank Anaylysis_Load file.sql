create database finance;
use finance;


SHOW variables LIKE "secure_file_priv";
DROP table finance_1;
CREATE TABLE  finance_1(
id varchar(255),	
member_id varchar(255),	
loan_amnt varchar(255),	
funded_amnt varchar(255),	
funded_amnt_inv varchar (255),
term varchar(255),
int_rate varchar(255),
installment varchar(255),
grade varchar(255),
sub_grade varchar(255),
emp_title varchar(255),
emp_length varchar(255),
home_ownership varchar(255),
annual_inc varchar(255),
verification_status varchar(255),
issue_d varchar(255),
loan_status varchar(255),
pymnt_plan varchar(255),
desc_ text,
purpose text,
title text,
zip_code varchar(255),
addr_state varchar(255),
dti varchar(255)
);	

DROP table finance_2;
CREATE TABLE  finance_2 (
id varchar(255),
delinq_2yrs varchar(255),
earliest_cr_line varchar(255),
inq_last_6mths varchar(255),
mths_since_last_delinq varchar(255),
mths_since_last_record varchar(255),
open_acc varchar(255),
pub_rec varchar(255),
revol_bal varchar(255),
revol_util varchar(255),
total_acc varchar(255),
initial_list_status varchar(255),
out_prncp varchar(255),
out_prncp_inv varchar(255),
total_pymnt varchar(255),
total_pymnt_inv varchar(255),
total_rec_prncp varchar(255),
total_rec_int varchar(255),
total_rec_late_fee varchar(255),
recoveries varchar(255),
collection_recovery_fee varchar(255),
last_pymnt_d varchar(255), 
last_pymnt_amnt varchar(255),
next_pymnt_d varchar(255),
last_credit_pull_d varchar(255)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Finance_1.csv' INTO TABLE finance_1
  FIELDS TERMINATED BY ',' ENCLOSED BY '"'  
  LINES terminated by '\n'
  ignore 1 lines;
  
  
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Finance_2.csv' INTO TABLE finance_2
  FIELDS TERMINATED BY ',' ENCLOSED BY '"'  
  LINES terminated by '\n'
  ignore 1 lines;