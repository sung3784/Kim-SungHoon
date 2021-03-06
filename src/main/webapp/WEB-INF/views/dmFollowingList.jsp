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
   <!-- CSS -->
   <link rel="stylesheet" type="text/css" href="./resources/css/feed.css">
   
<style type="text/css">
.profile{
   width: 50px; 
    height: 50px;
    border-radius: 50%;
}
</style>
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
  background: #1c0d01;
  border-color: #231f20;
  border:inherit; 
  color: #fff;
  
  
   border-top-right-radius: 5px;
   border-bottom-right-radius: 5px;
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

</head>
<body>
<!-- ====================================MENU================================================= -->

   <jsp:include page="./topMenu.jsp" flush="false"/>
<!-- ==============================================contetnt====================================================== -->
      <!-- 책 옆면  -->
      <div class="bookBeside">
            
      </div>

      <div class="dmContainer context">
         
         <!--팔로워,팔로잉 리스트 모두 출력  -->
         <div style="margin-top: 3%;">
            <h1 style="text-align: center; color: white;">FollowingList</h1>
            <hr style="width: 95%; color: black;">
         
             <c:forEach var="followingList" items="${followingList}" varStatus="status">
            <div style="margin-top: 15px; margin-left: 10px;">
               <div>
                  <a href="dmRoomGo?followId=${followingList.followId}">
                   <img src="http://10.10.8.226:8888/sns/resources/images/FileRepo/${followingList.saveFile}" class="profile" style="margin-left:2%; width: 50px; height: 50px;">
                   <label style="position: absolute; margin-top: 15px; margin-left: 10px; color: white;">@ ${followingList.followId}</label>
                 </a>
               </div>
            </div>
            </c:forEach>
         </div>
      </div>
   
</body>
</html>