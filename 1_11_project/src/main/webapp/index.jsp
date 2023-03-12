<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 E요일");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check todo 🖊︎</title>
<script src="js/jquery-3.3.1.min.js"></script>
    <style>
        .outer {
            display: block;
            /* display: none; */
            position: absolute;
            top: 0;
            left: 0;
            height: 1100px;
            width: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }
        #today{
            position: fixed;
            border: 1px solid black;
            border-radius: 50px;
            top: 200px;
            bottom: 0;
            left: 0;
            right: 0;
            margin: auto;
            width: 500px;  
            height: 550px;
            background-color: rgba(255, 255, 255, 0.7);
            backdrop-filter: brightness(1.0) blur(10px);
        }
        #btn_x{
            float: right;
            margin-top: 20px;
            margin-right: 30px;
            width: 20px;
            height: 20px;
            background-color: transparent;
            border: 1px solid black;
            cursor: pointer;
        }
        #today_head{
            /* border: 1px solid black; */
            margin-top: 50px;
            height: 80px;
            text-align: center;
            line-height: 25px;
        }
        #today_list{
            display: table;
            /* border: 1px solid black;  */
           
            width: 450px;
            height: 200px;
            margin: 0px auto;
            align-items: center;
            text-align: center;
        }
        #today_list input{
            margin-top: 20px;
            
        }
        #btn_box{
            /* border: 1px solid black; */
            position: relative;
            width: 400px;
            top: 30px;
            display: flex;
            text-align: center;
            margin: 0 auto;

        }
        #btn_box button{
            margin: 0 auto;
            height: 30px;
            background-color: transparent;
            border: 1px solid black;
            
        }
        #com_box{
            width: 150px;
            margin: 10px;
            cursor: pointer;
        }
        #btn_today{
            width: 150px;
            margin-top: 30px;
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
            height: 20px;
            text-align: center;
            border: 1px solid black;
        }
        #todoSubmit{
            border: 1px solid black;
            background-color: transparent;
            height: 22px;
            width: 35px;
            text-align: center;
            cursor: pointer;
        }
        #registed{
            margin-top: 20px;
        }
        #modal_list{
            margin-top: 20px;
      		margin-left: auto;
      		margin-right: auto;
            margin-bottom: 20px;
            line-height: 40px;
            width: 300px; 
            
        }
        #modal_list td{
        	text-align:center;
        }
        #btn_comp{
            background-color: transparent;
            width: 45px;
            height: 25px;
            border: 1px solid black;
           	cursor: pointer;
        }
        #btn_cancel{
            background-color: transparent;
            width: 45px;
            height: 25px;
            border: 1px solid black;
           	cursor: pointer;
        }
        #list{
        	margin: 0 auto;
        	
        	width: 400px;
        	height: 305px;
        	overflow-y: scroll;
        }
       
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<jsp:include page="nav.jsp"/>
<jsp:include page="regToday_index.jsp"/>
    <!-- modal -->
    <section class="outer">
        <div id="today">
            <button id="btn_x">X</button>
            <div id="today_head">
                ${userId}님의<br>오늘 할 일 입니다!
                
                <div id="today_ymd"><% out.print(sdf.format(date)); %></div>
            </div>
            
            <div id="today_list">
                <fieldset id="list">
                    <legend>『to do list』</legend>
                    <table id="modal_list">
                    	<tbody>
                    		
                    	</tbody>
                    </table>
                </fieldset>
            </div>
            <div id="btn_box">
                
                <button id="btn_today">할 일 추가하기</button>
            </div>
            
        </div>
    </section>
	<script>
		$("#btn_x").click(function(){
	        $(".outer").css("display", "none");
	       	location.href = "regToday.jsp";
	    });
		$("#btn_today").click(function(){
			location.href = "regToday.jsp";
		});
		const flag = document.querySelector("#flag").value;
		
		const modal_list = document.querySelector("#modal_list");
		todayList();
		const tbody = document.querySelector("tbody");
		function todayList(){
	    	   const xhr = new XMLHttpRequest();
	   		
		   		xhr.onload = function() {
		   			let jsonStr = this.responseText;
		   			
		   			let obj = JSON.parse(jsonStr);
					
		   			tbody.replaceChildren();
		   			if(obj.length == 0){
		   				tbody.innerHTML = "<tr><th>등록된 일정이 없네요ㅠㅠ..</th><tr><th>신나는 일을 계획하러 가볼까요? ٩(๑>∀<๑)۶ </th></tr>";
		   			}
		   			for(let i = 0; i < obj.length; i++){
		   				if(obj[i].state == 0){
		   					tbody.innerHTML += "<tr><th>" +obj[i].todo_time +" / " +obj[i].list+ "</th><td><button id='btn_comp' value='"+obj[i].listNo+"'>완료✓️</button></td></tr>";
		   				}else if(obj[i].state == 1){
		   					tbody.innerHTML += "<tr><th style='text-decoration: line-through; text-decoration-color: lightcoral;'>" +obj[i].todo_time +" / "+obj[i].list+ "</th><td><button id='btn_cancel' value='"+obj[i].listNo+"'>취소</button></td></tr>";
		   				}
		   			}
		   		}
		   	
		   		xhr.open("GET", "getTodayListAll.do?id=" + flag, true); 
		   		xhr.send(); 
	       }
		
		 $("tbody").on('click', '#btn_comp', function(e) {
			 const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					let line_root = e.target.parentElement.parentElement.children[0]
					let result = this.responseText;
					todayList();
				}
				xhttp.open("POST", "complete.do");
				xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				let listNo = e.target.value;
				
				let uData = "listNo=" + listNo;
				xhttp.send(uData);
			});
		
		 $("tbody").on('click', '#btn_cancel', function(e) {
			 const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					let line_root = e.target.parentElement.parentElement.children[0]
					let result = this.responseText;
					todayList();
				}
				xhttp.open("POST", "cancle.do");
				xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				let listNo = e.target.value;
				
				let uData = "listNo=" + listNo;
				xhttp.send(uData);
		 });
	</script>
    
    
</body>
</html>