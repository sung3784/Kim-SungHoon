<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<!--
   Dimension by HTML5 UP
   html5up.net | @ajlkn
   Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->

<html>
<head>
<title>H2T</title>
<meta charset="utf-8" />
<meta name="viewport"
   content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="./resources/assets/css/main.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>

$(function(){

   // 유효성검사
   $("#join").on('click', function() {
      
      var userId = $('#userId').val();
      var userPwd = $('#userPwd').val();
      var email = $('#email').val();
      var introduce = $('#introduce').val();
      
      if(userId.length == 0 || userId.length < 3 || userId.length > 7) {
         alert("아이디의 길이는 3~7입니다.");
         return false;
      }
      
      if(userPwd.length==0 || userPwd.length < 3 || userPwd.length > 7) {
         alert("비밀번호의 길이는 3~7입니다.");
         return false;
      }
      
      if(email.length == 0) {
         alert("이메일을 입력해주세요.");
         return false;
      }
      
      if(introduce.length == 0){
         alert("자기소개를 입력해주세요.");
         return false;
      }
      
      $('#user_join').submit();
   });
 
    //회원가입 아이디 중복확인
    $('#idcheck').on('click',function(){

      $('#join').attr('disabled', 'disabled');
      
      var userId = $('#userId').val();
      
      $.ajax({
         url: "user_idCheck",
         type: "get",
         data: {"userId" : userId},
         success: function(result) {
            if(result == 0) {
               alert("아이디를 사용할 수 있습니다."); 
               $('#join').removeAttr('disabled');
               return;
            }else{
               alert("중복된 아이디입니다.");
               return;
            }
         }
      });
   }); 
});

//login validation
$(function(){
   $('#loginUser').on('click',function() {
      var userId = $('#loginUserId').val();
      var userPwd = $('#loginUserPwd').val();
      var returnVar = false;
      
      if(userId.trim().length == 0){
         alert("아이디를 입력해주세요");
         return false;
      }
      
      if(userPwd.trim().length == 0){
         alert("비밀번호를 입력해주세요");
         return false;
      }
   
      $.ajax({
         url: "login_Check",
         type: "get",
         data: {"userId" : userId, "userPwd" : userPwd},
         success: function(result2){
            if(result2 == 0) {
               alert("사용자 정보를 확인해주세요."); 
               returnVar = false;
            }if(result2 == 1)   {
               $('#loginCheck').submit();
            }
         }
      });
   
      return returnVar;
   });
});

</script>

</head>
<body class="is-preload">

   <!-- Wrapper -->
   <div id="wrapper">

      <!-- Header -->
      <header id="header">
         <div class="logo">
            <span class="icon fa-bookmark-o"></span>
         </div>
         <div class="content">
            <div class="inner">
               <h1>H2T</h1>
               <p>
                  H2Tは<a>本で人を繋ぐ</a>という意味でSNSです。
                  <br /> 一緒に本について話しましょう！
               </p>
            </div>
         </div>
         <nav>
            <ul>
               <li><a href="#SIGNUP">SIGN UP</a></li>
               <li><a href="#LOGIN">LOGIN</a></li>
            </ul>
         </nav>
      </header>

      <!-- Main -->
      <div id="main">

         <!-- SIGN UP -->
         <article id="SIGNUP">
            <h2 class="major">SIGN UP</h2>
            <div class="ui two column grid">
               <section>
                  <form method="post" action="user_join">
                     <div class="fields">

                        <div class="field" style="display: flex;">
                           <div>
                              <label for="demo-id">ID</label>
                           </div>
                        </div>

                        <div class="field" style="display: flex; padding-top: 0px;">
                           <div>
                              <input type="text" name="userId" id="userId" value=""
                                 placeholder="ID" />
                           </div>
                           <div style="margin-left: 10px;">
                              <button type="button" id="idcheck">중복확인</button>
                           </div>
                        </div>
                        <div class="field">
                           <label for="demo-email">Email</label> <input type="email"
                              name="email" id="email" value=""
                              placeholder="jane@untitled.tld" />
                        </div>
                        <div class="field">
                           <label for="demo-password">Password</label> <input
                              type="password" name="userPwd" id="userPwd" value=""
                              placeholder="******" />
                        </div>

                        <div class="field">
                           <label for="demo-message">Introduce</label>
                           <textarea name="introduce" id="introduce"
                              placeholder="Enter your introduce" rows="2"></textarea>
                        </div>
                     </div>
                     <ul class="actions">
                        <li><input type="submit" id="join" value="회원가입"
                           class="primary" /></li>
                        <li><input type="reset" value="Reset" /></li>
                     </ul>
                  </form>
               </section>
            </div>
         </article>

         <!-- LOGIN -->
         <article id="LOGIN">
            <h2 class="major">LOGIN</h2>
            <span class="image main"><img
               src="./resources/images/front2.jpg" alt="" /></span>
            <div class="ui horizontal divider">

               <div class="loginForm ui attached segment">
                  <section>
                     <form method="post" action="loginForm" id="loginCheck">
                        <div class="fields">

                           <div class="field half">
                              <label for="demo-login">LOGIN</label> <input id="loginUserId"
                                 name="userId" type="text" placeholder="ID">
                           </div>

                           <div class="field half">
                              <label for="demo-password">Password</label> <input
                                 id="loginUserPwd" name="userPwd" type="password"
                                 placeholder="Password">
                           </div>

                           <div class="field">
                              <br>
                              <ul class="actions" style="float: right;">
                                 <!--
                                       중앙정렬
                                       position: absolute;  left: 50%;   transform: translate(-50%,-50%);  padding: 2rem;
                                         -->
                                 <li><input type="submit" id="loginUser" value="LOGIN"
                                    class="primary" />
                              </ul>
                           </div>
                        </div>
                     </form>
                  </section>

               </div>
            </div>
      </div>
      </article>


      <!-- Footer -->
      <footer id="footer">
         <p class="copyright">&copy; 本</p>
      </footer>

   </div>

   <!-- BG -->
   <div id="bg"></div>

   <!-- Scripts -->
   <script src="./resources/assets/js/jquery.min.js"></script>
   <script src="./resources/assets/js/browser.min.js"></script>
   <script src="./resources/assets/js/breakpoints.min.js"></script>
   <script src="./resources/assets/js/util.js"></script>
   <script src="./resources/assets/js/main.js"></script>

</body>
</html>