<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check todo 🖊</title>
<script src="js/jquery-3.3.1.min.js"></script>
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
        header{
            /* border: 1px solid black; */
            height: 200px;
            text-align: center;
            
        }
        #header_txt{
            margin-top: 150px;
            height: 160px;
            /* border: 1px solid black; */
            /* width: 500px; */
            margin: 130px auto;
        }
        #header_main1{
            font-size: 30px;
            cursor: pointer;
        }
        #header_main2{
        	cursor: pointer;
        }
        #login_state{
            margin-top: 25px;
            font-size: 15px;
        }
        #logout{
            margin-top: 10px;
            font-size: 14px;
            cursor: pointer;
        }
        *::-webkit-scrollbar {
            width: 10px; 
        }

        *::-webkit-scrollbar-thumb {
            height: 30%; 
            background: black; 
            border-radius: 0px;
        }

        *::-webkit-scrollbar-track {
            background: transparent;  /*스크롤바 뒷 배경 색상*/
        }
</style>
</head>
<body>
	<header>
        <div id="header_txt">
            <div id="header_main1" onclick="location.href='index.jsp'">Check todo!</div>
            <div id="header_main2" onclick="location.href='index.jsp'">Check your to do list!</div>
            
       	    	<div id="login_state">${userId }님 반가워요, 오늘 하루는 어떤가요?</div>
            <input type="hidden" value="${userId }" id="flag">
            <div>🖊︎</div>
            <div id="logout">Check todo 떠나버리기ㅠㅠ...</div>
        </div>
   	</header>
   	
   	<script>
	    $("#logout").click(function(){
	        confirm("정말로 떠나실건가요? ㅠㅠ");
	        location.href="logout.jsp";
	    });
   	</script>
</body>
</html>