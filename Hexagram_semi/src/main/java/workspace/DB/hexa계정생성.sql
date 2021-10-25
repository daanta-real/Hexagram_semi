
--hexa계정 생성 : 아이디 hexa 비번 hexa
create user hexa identified by hexa;

--로그인 권한 부여
grant create session to hexa;

--connect, resource 권한 부여
grant connect, resource to hexa;

--view 권한 부여
grant create view to hexa;