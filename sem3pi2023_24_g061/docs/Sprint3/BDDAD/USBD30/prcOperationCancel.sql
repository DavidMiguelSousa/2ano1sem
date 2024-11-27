create or replace NONEDITIONABLE PROCEDURE PRCCANCELOPERATION (operationId_in IN Operation.operationId%TYPE) AS
    v_operationDate Operation.operationDate%TYPE;
    v_count         int;
begin
select operationDate
into v_operationDate
from Operation
where operationId = operationId_in;

select count(*)
into v_count
from Operation op
where op.plotId = (select plotId from Operation where operationId = operationId_in)
  and op.operationDate > v_operationDate;

if SYSDATE <= v_operationDate + 3 and v_count = 0 then
    insert into OperationLog(operationId, logTypeId, registeredTimestamp)
    values (operationId_in, 2, CURRENT_TIMESTAMP); -- delete operation if condition is met aka log type equals 2

commit;
else
    RAISE_APPLICATION_ERROR(-20004, 'The operation cannot be canceled: it is either outside the allowed timeframe or has dependent operations.');
end if;

exception
  when NO_DATA_FOUND then
    RAISE_APPLICATION_ERROR(-20005, 'The specified operation could not be found.');
when others then
    rollback;
    raise;
end;