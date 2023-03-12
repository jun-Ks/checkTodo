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
<title>Insert title here</title>
</head>
<style>
        .main {
            
            margin-top: 50px;
           	margin-left : auto;
           	margin-right: auto;
           	margin-bottom: auto;
            text-align: center;
            height: 700px;
        }
       /*modal*/
        .outer {
            /* display: block; */
            display: none;
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
            height: 570px;
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
            
            height: 80px;
            text-align: center;
            line-height: 25px;
        }
        #today_list{
            display: table;
            /* border: 1px solid black;  */
           
            width: 450px;f
            height: 200px;
            margin: 0px auto;
            align-items: center;
            text-align: center;
        }
        /* start */
        #title{
            height: 40px;
           /*   border: 1px solid black; */ 
            margin: 0 auto;
            font-size: 35px;
            text-align: center;
        }
        #reg_ymd{
            margin-top: 20px;
            margin-bottom: 40px;
        }
        #reg_form{
            margin: 30px auto;
            width: 500px;
            height: 500px;
            text-align: center;
        }
        #reg_todo{
            width: 450px;
            height: 500px;
            margin: 0 auto;
            overflow: hidden;
        }
       #notice{
            margin-top: 20px;
            margin-bottom: 10px;
            
       }
       #sel_tbl_box{
            /* border: 2px solid blue; */
            margin-top: 10px;
            margin: 0 auto;
            width: 400px;
            height: 400px;
            

       }
       #tbl_selectAll{
            /* border: 1px solid black; */
            width: 300px;
            
            margin-left: auto;
            margin-right: auto;
            text-align: center;
       }
      #tbl_selectAll thead{
        height: 40px;
        font-size: 17px;
      }
      #tbl_selectAll th{
        border-bottom: 1px solid black;
      }
      #tbl_selectAll td{
        height: 40px;
        font-size: 17px;
      }
      #list_box{
        
        /* border: 1px solid black; */
        width: 440px;
        height: 400px;
        margin: 0 auto;
        
      }
      #modal_list{
        margin-top:20px;
        margin-left: auto;
        margin-right: auto;
        width: 250px;
      }
      #modal_list th{
        height: 40px;
        border-bottom: 1px solid black;
      }
      /*cal*/

      #calendarDiv{
        
        height: 400px;
    }
    #cal_tbl{
        font-size: 17px;
        width: 350px;
        height: 400px;
        
        margin-left: auto;
        margin-right: auto;
        text-align: center;
       
        border-collapse: collapse;
    }
    #cal_tbl th{
        border-top: 1px solid black;
        border-bottom: 1px solid black;
        height: 40px;
        font-size: 16px;
        font-weight: normal;
    }
    #cal_tbl td{
        border-top: 1px solid black;
        
    }
    #prev{
        cursor: pointer;
    }
    #next{
        cursor: pointer;
    }
     #com_list::after{
            content: "완료!!";
            font-size: x-small;
            padding: 2px 4px;
            margin: 0 10px;
            border-radius: 2px;
            background-color: black;
            color: white;
    }
    .half_highlight{
        position: relative;
    }
    .half_highlight:after{
        content: '';
        position: absolute;
        bottom: 0;
        left: 16px;
        width: 19px;
        height: 7px;
       background-color: rgba(0, 0, 0, 0.4);
        
        
    }
    #null{
   		word-spacing: -3px;
    }
    #calendarDiv{
    	cursor : pointer;
    }
</style>
<body>
<jsp:include page="header.jsp" />
<jsp:include page="nav.jsp"/>

	<section class="main">
        <div id="title">
            『to do list 모두 보기』
        </div>
        <div id="reg_form">
            <div id="reg_ymd"><% out.print(sdf.format(date)); %></div>
            <fieldset id="reg_todo">
                <legend>『to do list 모두 보기』</legend>
                <div id="notice">*내가 썼던 to do list 들을 확인 해보세요!</div>
                <div id="sel_tbl_box">
                    <div id="calendarDiv"></div>
                       
                    
                </div>
            </fieldset>
         </div>
    </section>
            <!--modal-->
            <section class="outer">
                <div id="today">
                    <button id="btn_x">X</button>
                    <div id="today_head">

                    </div>
                    
                    <div id="today_list">
                        <fieldset id="list">
                            <legend id="title_ymd"></legend>
                            <div id="list_box">
                                <table id="modal_list">
                                    <tbody id="modal_tbody">
                                       
                                    </tbody>
                                </div>
                            </table>
                        </fieldset>
                    </div>
                    
                </div>
            </section>
            <input type="hidden" id="flag" value="${userId }">
	<script>
		$("#btn_x").click(function(){
	        $(".outer").css("display", "none");
	    });
		let getDate = document.querySelector("#reg_ymd").innerText;
		
		let now = new Date();
		let getMonth = now.getMonth()+1;
		let getYear = now.getFullYear(); 
		
		showCalendar(getYear, getMonth);
		function showCalendar(y, m) {
			
		    var text = '<table id="cal_tbl">\n<tr><th colspan=7 style="text-align:center">';
		    text += '<span id="prev" onclick="showCalendar('+(y-1)+','+ m +')"> Y- </span>';
		    text += '<span id="prev" onclick="showCalendar('+(m==1?(y-1)+','+12:y+','+(m-1))+')"> M- </span>';
		    text += "<span id='cal_ym'>[" + y + "년 " + ((m < 10) ? (m) : m) + "월]";
		    text += '<span id="next" onclick="showCalendar('+(m==12?(y+1)+','+1:y+','+(m+1))+');"> M+ </span>';
		    text += '<span id="next" onclick="showCalendar('+(y+1)+','+m+')"> Y+ </span>';
		    text += "</td></tr><tbody id='cal_tbody'>";
		
		    var d1 = (y+(y-y%4)/4-(y-y%100)/100+(y-y%400)/400
		            +m*2+(m*5-m*5%9)/9-(m<3?y%4||y%100==0&&y%400?2:3:4))%7;
		    for (i = 0; i < 42; i++) {
		        if (i%7==0) 
		        	text += "</tr>\n<tr>";
		        if (i < d1 || i >= d1+(m*9-m*9%8)/8%2+(m==2?y%4||y%100==0&&y%400?28:29:30))
		            text += "<td id='days'> </td>";
		        else
		            text += "<td id='days'" + (i%7 ? '' : ' style="color:red;"') + '>' + (i+1-d1) + '</td>';
		    }
		    document.getElementById('calendarDiv').innerHTML = text + '</tr></tbody>\n</table>';
		    
			const modal_tbody = document.querySelector("#modal_tbody");
			
			$("#cal_tbody").on('click', '#days', function selectOne(e) {
				
				$(".outer").css("display", "block");
				let uYear = getYear;
				let uMonth = getMonth;
				let uDay = e.target.innerText;
				let flag = document.querySelector("#flag").value;
				const getYMD_root = document.querySelector("#title_ymd");
				
			    const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					
					let result = this.responseText;
					
					let obj = JSON.parse(result);
					modal_tbody.replaceChildren();
					getYMD_root.innerHTML = "『" + y + "년 " + m +"월 " + uDay + "일』";
					
					if(obj.length == 0){
						modal_tbody.innerHTML = "<tr><div id='null'><br><br><br><br><br> ❝<br> 일정이 추가되지 않은 날 입니다! <br>❞ </div></tr>";
					}
					for(let i = 0; i < obj.length; i ++){	
						
						if(obj[i].state == 1){
							modal_tbody.innerHTML += "<tr><th id='com_list'>"+obj[i].todo_time+" / "+obj[i].list+"</th></tr>";
						}else if(obj[i].state == 0){
							modal_tbody.innerHTML += "<tr><th>"+obj[i].todo_time+" / "+obj[i].list+"</th></tr>";
						}
					}
					
				}
				xhttp.open("POST", "selectOne.do");
				xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				
				
				let uData = "year=" + uYear + "&month=" + uMonth + "&day=" + uDay + "&id=" + flag;
				xhttp.send(uData);
			});
			const cal_tbody_root = document.querySelector("#cal_tbody");
			
			//children[0].innerText
			paintCom();
			
			function paintCom(){
				
				let pYear = getYear;
				
				let pMonth = getMonth;
				let pFlag = document.querySelector("#flag").value;
				
				
			    const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					let result = this.responseText;
					let obj = JSON.parse(result);
					for(let i = 0; i < 5; i++){
						for(let j = 0; j < 7; j++){
							let pDays = document.querySelector("#cal_tbody").children[i].children[j];
								for(let k = 0; k < obj.length; k++){
								if(obj[k] == y + "-" + m + "-" + pDays.innerText){
									pDays.innerHTML = "<div class=half_highlight>" + pDays.innerText + "</div>";
									
									
								}
							}
						}
					}
					
				}
				xhttp.open("POST", "paint.do");
				xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				
				let pData = "year=" + y + "&month=" + m + "&id=" + pFlag;
				
				xhttp.send(pData);
			}
		}
		
	
		
		
		
	</script>
</body>
</html>