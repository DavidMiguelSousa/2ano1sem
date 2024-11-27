SELECT PLOT.PLOTID, COUNT(OP.OPERATIONID) AS IRRIGATION_OPERATIONS
FROM PLOT
JOIN OPERATION OP ON PLOT.PLOTID = OP.PLOTID
JOIN OPERATIONTYPE OT ON OP.OPERATIONTYPEID = OT.OPERATIONTYPEID
WHERE OT.OPERATIONTYPE = 'Rega' AND OP.OPERATIONDATE BETWEEN TO_DATE('2010-01-01', 'YYYY-MM-DD') AND TO_DATE('2023-12-31', 'YYYY-MM-DD')
GROUP BY PLOT.PLOTID
ORDER BY IRRIGATION_OPERATIONS DESC;