<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	int result = (Integer) request.getAttribute("result");

	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 E요일");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check todo 🖊</title>
<style>
	#com_box{
            width: 150px;
            margin: 10px;
            cursor: pointer;
        }
        #btn_today{
            width: 150px;
            cursor: pointer;
        }
        .reg_today{
            /* border: 1px solid black; */
            margin-top: 50px;
            text-align: center;
            height: 600px;
        }
        #title{
            width: 400px;
            height: 40px;
            /* border: 1px solid black; */
            margin: 0 auto;
            font-size: 35px;
        }
        #reg_ymd{
            margin-top: 30px;
            margin-bottom: 30px;
        }
        #reg_form{
            margin: 30px auto;
            width: 400px;
            height: 500px;
            /* border: 1px solid black; */
        }
        #reg_todo{
            height: 400px;
            
        }
        #todoInput{
            margin-top: 70px;
            width: 250px;
            height: 25px;
            text-align: center;
            border: 1px solid black;
            background-color: transparent;
            outline:none;
            font-size: 13px;
        }
        #todoSubmit{
            border: 1px solid black;
            background-color: transparent;
            height: 25px;
            width: 35px;
            text-align: center;
            cursor: pointer;
        }
        #registed{
            margin-top: 20px;
            
        }
        #registed_content{
            margin-top: 20px;
            line-height: 40px;
            
            overflow-y: scroll;
            height:220px;
        }
        #todo_time{
            background-color: transparent;
            border: 1px solid black;
            text-align: center;
            width: 140px;
            height: 30px;
            position: relative;
            top: 50px;
            outline: 0px;
        }
</style>
</head>
<body>
<jsp:include page="header.jsp"/>
<jsp:include page="nav.jsp"/>
    <section class="reg_today">
        <div id="title">
            『오늘 할 일 등록』
        </div>
        <div id="reg_form">
            <div id="reg_ymd"><% out.print(sdf.format(date)); %></div>
            <fieldset id="reg_todo">
                <legend>『해야 할 일 등록』</legend>
                 
                <form action="regList.do" method="post">
                 	<input type="time" id="todo_time" name="todo_time"><br>
                    <input type="text" id="todoInput" name="todoInput" placeholder="오늘 해야 할 일을 입력해주세요!">
                    <input type="hidden" id="reg_id" name="reg_id" value="${userId }">
                    <input type="submit" id="todoSubmit" value="등록">
                </form>
                <div id="registed">
                    <div id="registed_title">『등록된 할 일』</div>
                    
                    <div id="registed_content">
                        
                    </div>
                </div>
            </fieldset>
        </div>
    </section>
<script>
       
       
       const btn_submit = document.querySelector("#todoSubmit");
        btn_submit.addEventListener("click", function(){
    	   todayList();
       }); 
       
       
       const userId_root = document.querySelector("#reg_id");
       const content_root = document.querySelector("#registed_content");
       
       todayList();
       function todayList(){
    	   const xhr = new XMLHttpRequest();
   		
	   		xhr.onload = function() {
	   			let jsonStr = this.responseText;
	   			
	   			let obj = JSON.parse(jsonStr);
	   			content_root.replaceChildren();
	   			
	   			for(let i = 0; i < obj.length; i++){
	   				if(obj[i].state == 0){
	   					content_root.innerHTML += "<div>" +obj[i].todo_time+ " / "+obj[i].list+ "</div>";
	   				}else if(obj[i].state == 1){
	   					content_root.innerHTML += "<div style='text-decoration: line-through; text-decoration-color: lightcoral;'>"+obj[i].todo_time+" / "+obj[i].list+ "</div>";
	   				}
	   			}
	   		}
	   		const userId = userId_root.value;
	   		
	   		xhr.open("GET", "getTodayListAll.do?id=" + userId, true); 
	   		xhr.send(); 
       }
       let d = new Date(); 

       document.querySelector("#todo_time").value = new Date(d.getTime() - (d.getTimezoneOffset() * 60000)).toISOString().slice(11, 16);
    </script>
    
</body>
</html>