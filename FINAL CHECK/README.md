# 2021-01-21

## TODO

11:45 Testy na odkazech nejsou vyčištěný, je to připravenej skelet s kódem, kterej teprve (odpoledne) provedu

### FULL:
 1. kolik trvá FULL load do dist schema s compounded HASH (READY -> https://github.com/keboola/db_benchmark/blob/main/FINAL%20CHECK/004_hash-on-multiple-cols.sql)
 2. Andrew way s COALESCE (CAST vyhodit) - kolik to přidá/vezme sec a co CASE WHERE? (READY -> https://github.com/keboola/db_benchmark/blob/main/FINAL%20CHECK/005_andrey_CAST_COALESCE.sql)
 3. kolik "stojí" udělat statistiku "pak" (je to 10% FULL loadu?) (READY -> https://github.com/keboola/db_benchmark/blob/main/FINAL%20CHECK/006_stats_cost.sql)
 4. rozdíl mezi 2 INSERTama vs CTAS (READY -> https://github.com/keboola/db_benchmark/blob/main/FINAL%20CHECK/007_two_inserts_vs_ctas.sql)

### INC:
 - dtto FULL + neupdatovat PKEY (READY -> https://github.com/keboola/db_benchmark/blob/main/FINAL%20CHECK/008_inc_update_nopkey.sql)
 - smazání updatovaných hodnot před insertem vs insert s WHERE pk1<>pk2 (READY -> https://github.com/keboola/db_benchmark/blob/main/FINAL%20CHECK/009_new_rows_approach_old_way.sql AND https://github.com/keboola/db_benchmark/blob/main/FINAL%20CHECK/010_new_rows_approach_other_way.sql)

## na zamyšlení:
- STATS budeme počítat pořád, protože je prostě spočítat musíme a jen bysme to někam odložili v čase
- COPY INTO je někdy podstatně kratší a někdy dost dlouhej

