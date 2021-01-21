# 2021-01-21

## TODO

### FULL:
 1. kolik trvá FULL load do dist schema s compounded HASH (READY)
 2. Andrew way s COALESCE (CAST vyhodit) - kolik to přidá/vezme sec a co CASE WHERE? (READY)
 3. kolik "stojí" udělat statistiku "pak" (je to 10% FULL loadu?) (READY)
 4. rozdíl mezi 2 INSERTama vs CTAS (READY)

### INC:
 - dtto FULL + neupdatovat PKEY
 - smazání updatovaných hodnot před insertem vs insert s WHERE pk1<>pk2

## na zamyšlení:
- STATS budeme počítat pořád, protože je prostě spočítat musíme a jen bysme to někam odložili v čase
