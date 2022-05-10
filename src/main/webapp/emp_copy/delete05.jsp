<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete</title>
</head>
<body>
	<form method="post" action="delete05_process.jsp">
		<p>
			사원번호 : <input type="text" name="eno">
		<p>
			사원이름 : <input type="text" name="ename">
		<p>
			직책 : <input type="text" name="job">
		<p>
			매니저 : <input type="text" name="manager">
		<p>
			입사일 : <input type="date" name="hiredate">
		<p>
			연봉 : <input type="text" name="salary">
		<p>
			인센 : <input type="text" name="commission">
		<p>
			부서번호 : <input type="text" name="dno">
		<p>
			<input type="submit" value="전송">
	</form>

</body>
</html>