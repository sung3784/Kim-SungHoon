<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Book add </title>


   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <link rel="stylesheet" type="text/css" href="./resources/semanticUI/semantic.css">
   <script src="./resources/semanticUI/semantic.js"></script>
   <link rel="stylesheet" href="./resources/css/menubar.css">
   <script src="./resources/js/menubar.js"></script>
   
   <!-- CSS & JavaScript -->
   <link rel="stylesheet" href="http://localhost:8888/sns/resources/css/topMenu.css">
   <script src="http://localhost:8888/sns/resources/js/topMenu.js"></script>

   <!-- CSS -->
   <link rel="stylesheet" type="text/css" href="./resources/css/feed.css">
   
<style type="text/css">
body{
   overflow: hidden;
   
}

.dmContainer {
  width: 40%;
  height: 80vh;
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  -webkit-transform: translateX(-50%);
  overflow: hidden;
  margin-top: 7%;
  border: 1px solid #dddddd;  
  background: linear-gradient( to right, #1c0d01 , black ); /*#231f20  */
 /*  background: #231f20;  */ ////////////////
  border-color: #231f20;
  border:inherit; 
  color: #fff;
  
 
   border-top-right-radius: 5px;
   border-bottom-right-radius: 5px;
  
}


#dmList{
  position:absolute;
  top:40%;
  left:50%;
  transform:translate(-50%, -50%);
}

#recentList{
   background:white;
   display: flex;
   margin-top: 10px;
   width: 100%; 
   color: black;
   
} 
 
.bookBeside{
   
   margin-top:7%;
   margin-left:28%;
   width: 3%; 
   height: 80%;
   background-color: #0b0500;
   
   border-top-left-radius: 5px;
   border-bottom-left-radius: 5px;
} 
</style>

<style type="text/css">
.btn {
  display: inline-block; 
  background: transparent;
  text-transform: uppercase;
  font-weight: 500;
  font-style: normal;
  font-size: 0.625rem;
  letter-spacing: 0.3em;
  color: rgba(223,190,106,0.7);
  border-radius: 0;
  padding: 18px 80px 20px;
  transition: all 0.7s ease-out;
  background: linear-gradient(270deg, rgba(223,190,106,0.8), rgba(146,111,52,0.8), rgba(34,34,34,0), rgba(34,34,34,0));
  background-position: 1% 50%;
  background-size: 300% 300%;
  text-decoration: none;
  margin: 0.625rem;
  border: none;
  border: 1px solid rgba(223,190,106,0.3);
  position:absolute;
  top:85%;
  left:50%;
  transform:translate(-50%, -50%);
}

.btn:hover {
  color: #fff;
  border: 1px solid rgba(223,190,106,0);
  color: $white;
  background-position: 99% 50%;
}

</style>

</head>
<body>
<!-- ====================================MENU================================================= -->

   <jsp:include page="./topMenu.jsp" flush="false"/>

<!-- ==============================================contetnt====================================================== -->

      <!-- 책 옆면  -->
      <div class="bookBeside">
            
      </div>

      <!-- 책 최근내역리스트 -->
      <div class="dmContainer context">
         <div class="row">
               <div class="title"  style="margin-top: 15%; height: 100px; text-align: center;">
                  <font size="100px;"> CHAT HISTORY</font>
               </div>
              
               <div id="dmList" class="dmList" style="margin-top: 10%;">
                  <!-- dm방 출력되는 곳 -->
                  <c:forEach var="list" items="${dmContentList}">
                    <div id="recentList">
                         <div style="width:50px;margin-left:10px;">@<a href="dmRoomGo?followId=${list.toId}">${list.toId}</a></div>
                         <div style="width: 150px;margin-left: 20px;text-overflow: ellipsis;overflow:hidden;display: block;white-space:nowrap;">${list.dmContent}</div>
                         
                         <div style="width:10px;">
                         <c:if test="${list.alarmCheck==0}">
                         <span class="alarm_icon"><img src="./resources/images/problem_icon.png" style="margin-left:5px; margin-top:1px; width: 15px; height: 15px;"></span>
                         </c:if>
                         </div>
                         <div style="margin-left: 7%; width: 150px;">${list.dmRegdate}</div>
                    </div>
                 </c:forEach>
               </div>
               
                <div>
                   <a href="dmFollowingListGo" class="btn" >DM</a> 
               </div>
               
            </div>
       </div>
   
<script type="text/javascript">
   setInterval(function(){
      $(".alarm_icon").toggle();
   },1000);
</script>


</body>
</html>