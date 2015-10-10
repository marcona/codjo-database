CREATE OR REPLACE PACKAGE util_pk AS
  procedure DROPTABLE(p_table VARCHAR2);
  procedure DROPINDEX(p_index VARCHAR2);
  procedure DROPCONSTRAINT(p_cons VARCHAR2);
END util_pk;
/

CREATE OR REPLACE PACKAGE BODY util_pk AS
  procedure DROPTABLE(p_table VARCHAR2) IS
  v_str varchar2(20);
  pragma autonomous_transaction;                                           a
  begin
    v_str:= SYS_CONTEXT('userenv', 'current_schema');
    execute immediate 'drop table ' || v_str || '.' || p_table || ' CASCADE CONSTRAINTS';
    commit;
    --return 0;
    exception
    when others then
         --return 1
         dbms_output.put_line( 'INFO: Table ' || p_table || ' not dropped');
         commit;
  end DROPTABLE;


  procedure DROPINDEX(p_index VARCHAR2) IS
  pragma autonomous_transaction;
  begin
    execute immediate 'drop index ' || p_index;
    commit;
    --return 0;
    exception
    when others then
         --return 1
         dbms_output.put_line( 'INFO: index ' || p_index || ' not dropped');
  end DROPINDEX;

  procedure DROPCONSTRAINT(p_cons VARCHAR2) IS
  pragma autonomous_transaction;
  begin
    execute immediate 'drop constraint ' || p_cons;
    commit;
    --return 0;
    exception
    when others then
         --return 1
         dbms_output.put_line( 'INFO: constraint ' || p_cons || ' not dropped');
  end DROPCONSTRAINT;
END util_pk;
/

--prompt Package util_pk created

--sho err