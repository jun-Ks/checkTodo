<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 E요일");
	
	int update_result = (Integer) request.getAttribute("result");
%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Check todo 🖊</title>


<style>
     @font-face {
            font-family: 'HBIOS-SYS';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2207-01@1.0/HBIOS-SYS.woff2') format('woff2');
            font-weight: normal;
            font-style: normal;
        }
        *{
            margin:0;
            padding: 0;
            font-family: 'HBIOS-SYS';
        }
        body{
            background-color: #eee;
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
         #today_tbl{
             width: 450px;
             margin: 10px auto auto auto;
             text-align: center;
             border-collapse: collapse;
         }
         #today_tbl th{
             height: 30px;
             border-bottom: 1px solid black;
             
         }
         #today_tbl th:nth-child(2){
             font-size: 17px;
         }
         #today_tbl td{
             height: 40px;
         }
         #today_tbl button{
             background-color: transparent;
             border: 1px solid black;
             border-radius: 10px;
             width: 35px;
             height: 30px;
             cursor: pointer;
         }
         #list{
            text-align: center;
            border: none;
            border-bottom: 1px solid black;
            padding: 3px;
            font-size: 14px;
            outline: none;
            background-color: transparent;
         }
         #notice{
            
            margin-top: 30px;
            font-size: 14px;
         }
         #tbl_box{
         	
         	height: 310px;
         	overflow-y: scroll;
         }
        #todo_time{
        	background-color: transparent;
        	border : none;
        	border-bottom:1px solid black;
        	outline:none;
        }
</style>
</head>
<body>
<script src="js/jquery-3.3.1.min.js"></script>
<body>
 <jsp:include page="header.jsp"/>
 <jsp:include page="nav.jsp"/>
     <section class="reg_today">
         <div id="title">
             『오늘의 to do list』
         </div>
         <div id="reg_form">
             <div id="reg_ymd"><% out.print(sdf.format(date)); %></div>
             <fieldset id="reg_todo">
                 <legend>『오늘의 해야 할 일』</legend>
                    <div id="notice">*수정방법*<br> 할 일을 다시 쓰고 수정버튼을 클릭하세요.</div>
                     <div id="tbl_box">
	                     <table id="today_tbl">
	                     <thead>
	                         <tr>
	                             <!-- <th>check</th> -->
	                             <th>list NO </th>
	                             <th>시간</th>
	                             <th>to do list</th>
	                             <th>수정</th>
	                             <th>삭제</th>
	                         </tr>
	                     </thead>
	                     <tbody id="tbody">
	                        <tr>
	                            
	                        </tr>
	                     </tbody>
	                         
	                     </table>
                	 </div>
             </fieldset>
         </div>
     </section>
    
    <input type="hidden" id="userId" value="${userId }">
    <script>
	    todayList();
	    
	    const tbody = document.querySelector("#tbody");
	   
	    function todayList() {
			const xhr = new XMLHttpRequest();
			
			xhr.onload = function() {
				let jsonStr = this.responseText; 
				let obj = JSON.parse(jsonStr);
				tbody.replaceChildren();
				let cnt = 0;
				for(let i = 0; i < obj.length; i++){
					cnt++;
					tbody.innerHTML += "<tr><td>"+ cnt +"</td><td><input type='time' id='todo_time' value='"+obj[i].todo_time+"'</td><td><input type='text' id='list' name='list' value='" + obj[i].list +"'></td><td><button id='btn_update'  value='"+obj[i].listNo+"'>수정</button></td><td><button id='btn_del' value='"+obj[i].listNo+"'>삭제</button></td></tr>"
					
				}
			}
	    	const userId = document.querySelector("#userId").value;
			
			xhr.open("GET", "getTodayListAll.do?id=" + userId, true); 
			xhr.send(); 
		}
	    
	    $("#tbody").on('click', '#btn_update', function(e) {
		    
		    const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				let result = this.responseText;
				if(result == 1){
					alert("수정이 완료 되었어요!");
					
				}else{
					alert("수정실패 ㅠㅠ.....");
				}
				todayList();
				
			}
			xhttp.open("POST", "update.do");
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			let listNo = e.target.value;
			let time = e.target.parentElement.parentElement.children[1].children[0].value;
			let list = e.target.parentElement.parentElement.children[2].children[0].value;
			
			
			let uId = document.querySelector("#userId").value;
			
			let uData = "listNo=" + listNo + "&time=" + time + "&id=" + uId +"&list=" + list;
			xhttp.send(uData);
		});
	    
		$("#tbody").on('click', '#btn_del', function(e) {
		    
		    const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				let result = this.responseText;
				if(result == 1){
					alert("삭제가 완료 되었어요!");
					
				}else{
					alert("삭제실패 ㅠㅠ.....");
				}
				todayList();
				
			}
			xhttp.open("POST", "delete.do");
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			let listNo = e.target.value;
			let uData = "listNo=" + listNo;
			xhttp.send(uData);
		});
    </script>
    
</body>
</html>