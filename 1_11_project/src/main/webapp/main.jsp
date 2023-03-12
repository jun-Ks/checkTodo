<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	int result = (Integer) request.getAttribute("result");
	String userId = (String) request.getAttribute("id");
	
	int reg_result = (Integer) request.getAttribute("reg_result");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
        video{
          /*  display: none;  */
           display: block;
            position: fixed; right: 0; bottom: 0;
            min-width: 100%; min-height: 100%;
            width: auto; height: auto; z-index: -100;
            background: url(polina.jpg) no-repeat;
            background-size: cover;
            opacity: 0.5;
        }
  
        #main_content{
            border: 1px solid black;
            border-radius: 50px;
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            margin: auto;
            width: 500px;  
            height: 300px;
            text-align: center;
        }
        #text_box{
            margin-top: 60px;
        }
        #main_txt1{
            font-size: 30px;
        }
        #main_txt3{
            font-size: small;
            border-bottom: 1px solid black;
            padding-bottom: 30px;
        }
        #btn_box{
            /* border: 1px solid black; */
            display: flex;
            justify-content: center;
            margin: 70px auto;
            
        }
        #btn_login{
            margin-right: 10px;
            
        }
        #btn_login > button, #btn_reg > button{
            background-color:transparent;
            border: none;
        }
       
        button{
           cursor: pointer;
        }
        .login_form input{
            width: 200px;
            text-align: center;
            height: 25px;
            margin: 10px;
            border: none;
            border-bottom: 1px solid black;
            background-color:transparent;
        }
        #login_frm{
            display: none;
            /* display: show; */
        }
        #submit{
            cursor: pointer;
        }
        #reg_frm{
            display: none;
            /* display: show; */
            height: 300px;
            margin-top: 30px;
            margin: 0 auto;
            justify-content: center;
            
        }
        #reg_tbl{
            /* border: 1px solid black; */
            margin-left: auto;
            margin-right: auto;
            line-height: 40px;
        }
        #reg_tbl input{
            width: 200px;
            height: 25px;
            background-color: transparent;
            text-align: center;
            border: none;
            border-bottom: 1px solid black;
        }
        #btn_regist{
            height: 25px;
            background-color: transparent;
            cursor: pointer;
        }
    </style>
</head>
<body>
 <video muted autoplay loop>
        <source src="back_video.mov">
        <div id="bg"></div>
    </video>
    <section class=".main_box">
        <div id="main_content">
            <div id="text_box">
                <div id="main_txt1">Check todo!</div>
                <div id="main_txt2">check your to do list!</div>
                <div id="main_txt3">당신의 하루를 체크해보세요!</div>
            </div>
            <div id="btn_box">
                    <div id="btn_login">
                        <button id="loginbtn">로그인하기</button>
                    </div>
                    <div id="btn_reg">
                        <button id="regbtn">회원가입</button>
                    </div>
            </div>

            <section class="login_form">
                <form action="login.do" id="login_frm" method="post">
                    <input type="text" id="id" name="id" placeholder="아이디를 입력해주세요." required><br>
                    <input type="password" id="pw" name="pw" placeholder="비밀번호를 입력해주세요." required><br>
                    <input type="submit" id="submit" value="Check todo!로 입장하기">
                </form>
            </section>
            <section class="regist_form">
                <form action="regMem.do" id="reg_frm" method="post">
                    <table id="reg_tbl">
                        <tr>
                            <th><input type="text" id="reg_id" name="reg_id" placeholder="아이디를 입력해주세요." required></th>
                        </tr>
                         <input type="hidden" id="id_flag" value="0">
                         <input type="hidden" id="pw_flag" value="0">
                         
                        <tbody id="tbody_idcheck">
                        	
                        </tbody>
                        
                        <tr>
                            <th><input type="password" id="reg_pw" name="reg_pw" placeholder="비밀번호를 입력해주세요." required></th>
                        </tr>
                        <tr>
                            <th><input type="password" id="reg_pw2" name="reg_pw2" placeholder="한번 더 입력해주세요." required></th>
                        </tr>
                        <tbody id="tbody_pwcheck">
                        
                        </tbody>
                        <tr>
                            <th><input type="text" id="reg_nickname" name="reg_nickname" placeholder="닉네임을 입력해주세요." required></th>
                        </tr>
                        <tr>
                            <th><input type="submit" id="btn_regist" value="회원가입하기!" onclick="return flag_check()"></th>
                        </tr>
                    </table>
                </form>
            </section>
        </div>
    </section>
	
    <script>
        //로그인폼 텍스트 박스 테두리 삭제
        $("#login_frm input").focus(function(){
            $(this).css("outline", "none");
        });
        $("#submit").mousedown(function(){
            $(this).css("background-color", "lightgray");
        });
        $("#submit").mouseup(function(){
            $(this).css("background-color", "transparent");
        });
        $("#loginbtn").click(function() {
            $("#main_content").animate({bottom : "200px"}, 1000);
            $("#login_frm").slideToggle(250, "linear");
            if($("#reg_frm").css("display") == "block"){
                $("#reg_frm").slideUp(250, "linear");
            };
        });
        $("#regbtn").click(function() {
            $("#main_content").animate({bottom : "200px"}, 1000);
            $("#reg_frm").slideToggle(250, "linear");
            if($("#login_frm").css("display") == "block"){
                $("#login_frm").slideUp(250, "linear");
            }
            
        });
        
        //회원가입폼 텍스트 박스 테두리 삭제
        $("#reg_frm input").focus(function(){
            $(this).css("outline", "none");
        });
        $("#btn_regist").mousedown(function(){
            $(this).css("background-color", "lightgray");
        });
        $("#btn_regist").mouseup(function(){
            $(this).css("background-color", "transparent");
        });
        
        const id_root = document.querySelector("#reg_id");
        const tbody_idcheck = document.querySelector("#tbody_idcheck");
        id_root.addEventListener('keyup', idCheck);
        const id_flag = document.querySelector("#id_flag");
        const pw_flag = document.querySelector("#pw_flag");
        
        function idCheck(e){
    		if(e.keyCode != null){
    			const xhttp = new XMLHttpRequest();
        		xhttp.onload = function() {
        			let idCheck_result = this.responseText; 
        			if(idCheck_result == 1){
        				tbody_idcheck.innerHTML = "<tr><th style='color:red; font-size:13px;'> 사용 중인 아이디 입니다.</th></tr>";
        				id_flag.value = 1;
        			}else{
        				tbody_idcheck.innerHTML = "<tr><th style='color:blue; font-size:13px;'> 사용가능한 아이디 입니다.</th></tr>";
        				id_flag.value = 0;
        			}
        			
        		}
        		const id_value = id_root.value;
        		
        		xhttp.open("GET", "idCheck.do?id=" + id_value, true); 
        			
        		xhttp.send(); 
    		}
    	}
        
        const pw_root = document.querySelector("#reg_pw2");
        const pw_root2 = document.querySelector("#reg_pw");
        const tbody_pwcheck = document.querySelector("#tbody_pwcheck");
    
        
        pw_root2.addEventListener('keyup', function(){
	        if(pw_root.value == pw_root2.value){
	        	tbody_pwcheck.innerHTML ="<tr><th style='color:blue; font-size:13px;'> 사용가능한 비밀번호 입니다. </th></tr>";
	        	pw_flag.value = 0;
	        }else if(pw_root.value != pw_root2.value){
	        	tbody_pwcheck.innerHTML ="<tr><th style='color:red; font-size:13px;'> 비밀번호를 다시 확인해주세요.</th></tr>";
	        	pw_flag.value = 2;
	        }
        });
        
        pw_root.addEventListener('keyup', function(){
	        if(pw_root.value == pw_root2.value){
	        	tbody_pwcheck.innerHTML ="<tr><th style='color:blue; font-size:13px;'> 사용가능한 비밀번호 입니다. </th></tr>";
	        	pw_flag.value = 0;
	        }else if(pw_root.value != pw_root2.value){
	        	tbody_pwcheck.innerHTML ="<tr><th style='color:red; font-size:13px;'> 비밀번호를 다시 확인해주세요.</th></tr>";
	        	pw_flag.value = 2;
	        }
        });
        
       function flag_check(){
        	if(id_flag.value == 1){
        		alert("아이디를 다시 확인해주세요!");
        		id_root.focus();
        		return false;
        	}else if(pw_flag.value == 2){
        		alert("비밀번호를 다시 확인해주세요!");
        		pw_root2.focus();
        		return false;
        	}
        };
    </script>
    
   	<c:if test="${result == 1 }">
   		<%session.setAttribute("userId", userId); %>
   		<script>
   			alert("로그인 성공했어요! \n Check todo로 이동할게요!");
   			
   			location.href="index.jsp";
   		</script>
   	</c:if>
   	
   	<c:if test="${result == 0 }">
   		<script>
   			alert("로그인 실패ㅠㅠ \n 아이디나 비밀번호를 다시 확인해주시겠어요?");
   		</script>
   	</c:if>
   	
   	<c:if test="${reg_result == 1 }">
   		<script>
   			alert("회원가입이 완료되었어요! \n 로그인을 해주세요!");
   			$("#login_frm").slideToggle(250, "linear");
   		</script>
   	</c:if>
</body>
</html>