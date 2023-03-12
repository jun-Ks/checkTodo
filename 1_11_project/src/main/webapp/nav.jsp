<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
  		nav{
            /* border: 1px solid black; */
            margin-top: 10px;
            height: 60px;
            justify-content: center;
        }
        #manu{
            display: flex;
            margin : 0 auto;
            justify-content:space-around;
            list-style: none;
            white-space:nowrap;
            height: 20px;
            padding-top: 10px;
            border-top: 1px solid black; 
            border-bottom: 1px solid black;
            cursor: pointer;
            /* width: 1300px; */
            height: 30px;
        }
        #today_reg, #today_todolist, #yesterday_todolist, #todolist_all{
            text-shadow: 2px 2px 10px gray;
        }
        
	</style>
</head>
<body>
	<nav>
        <div id="manu">
            <div id="today_reg" onclick="location.href='regToday.jsp'">『오늘 할 일 등록』</div>
            <div id="today_todolist" onclick="location.href='todayTodoList.jsp'">『오늘의 to do list』</div>
            <div id="todolist_all" onclick="location.href='selectOne.jsp'">『to do list 모두 보기』</div>
        </div>
    </nav>
</body>
</html>