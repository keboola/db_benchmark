create table protiucty_2Ymy_table with (distribution = round_robin) – This would be a CCI by default as
select b.*,
   count(*) over (
       partition by acctrn_other_account_prefix,
       acctrn_other_account_number,
       acctrn_other_bank_code
   ) as pocet,
   row_number() over (
       partition by acctrn_other_account_prefix,
       acctrn_other_account_number,
       acctrn_other_bank_code
       order by do desc
   ) as poradi
from (
       select acctrn_other_account_prefix,
           acctrn_other_account_number,
           acctrn_other_bank_code,
           acctrn_other_account_name,
           min(acctrn_accounting_date) as od,
           max(acctrn_accounting_date) as do
       from (
               select acctrn_other_account_prefix,
                   acctrn_other_account_number,
                   acctrn_other_bank_code,
                   cast(translate(lower(trim(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
                   replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
                   replace(replace(replace(replace(replace(replace(cast(acctrn_other_account_name as varchar(max)), '#', '#')
                   , '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#')
                   , '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#')
                   , '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#')
                   , '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#'), '#', '#')
                   , '#', '#'), '#', '#'))),
                   '#',
                   '#') as nvarchar(4000)) as acctrn_other_account_name,
                   acctrn_accounting_date
               from [WORKSPACE_112959].[account_transactions_out]
               where acctrn_accounting_flag = 'Y'
                   and isnull(acctrn_other_account_name, '#') <> 'X' - -
                   and acctrn_accounting_date > getdate() - -1
                   and acctrn_other_bank_code not in ('#', #')
                   and acctp_acctp_key in ('#', '#')
                   and acctrn_fee_flag <> 'X'
                   and acctrn_tax_flag <> 'X'
                   and acctrn_reverse_flag <> 'X' -- ####
                   and acctrn_other_bank_code not like '#'
                   and acctrn_other_account_name not like '#'
           ) a
       group by acctrn_other_account_prefix,
           acctrn_other_account_number,
           acctrn_other_bank_code,
           acctrn_other_account_name
   ) b
