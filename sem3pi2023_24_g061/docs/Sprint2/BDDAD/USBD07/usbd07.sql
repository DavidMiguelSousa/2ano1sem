SELECT PLOT.PLOTID, OT.OPERATIONTYPE, COUNT(OP.OPERATIONID) AS NUM_OF_OPERATIONS
FROM PLOT
JOIN OPERATION OP ON PLOT.PLOTID = OP.PLOTID
JOIN OPERATIONTYPE OT ON OP.OPERATIONTYPEID = OT.OPERATIONTYPEID
WHERE PLOT.PLOTID = 102 AND OP.OPERATIONDATE BETWEEN DATE '2010-01-01' AND DATE '2020-12-31'
GROUP BY PLOT.PLOTID, OT.OPERATIONTYPE
ORDER BY OT.OPERATIONTYPE ASC;