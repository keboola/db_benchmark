SQL file contains 6 usecases. Each does following:
- vytvoří tabulku z CSV
naloaduje do WS full
unloadne do storage full
vytvoří tabulku z csv pro inc
naloaduje tabulku do WS inc
unloadne do storage inc
těch 6 casů je
SPK_NO_PK
SPK_PK
SPK_PK_DK
MPK_NO_PK
MPK_PK
MPK_PK_DK
SPK = Single PK
MPK = Multiple PK
NO_PK be definování PK
PK = definované PK jeden nebo víc
DK = definovaný distribuční klíč