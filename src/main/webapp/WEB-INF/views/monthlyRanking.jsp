<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- d3 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/4.6.0/d3.min.js"></script>

<!-- anychart -->
<link rel="stylesheet" href="https://cdn.anychart.com/releases/8.3.0/css/anychart-ui.min.css" />
<link rel="stylesheet" href="https://cdn.anychart.com/releases/8.3.0/fonts/css/anychart-font.min.css" />
<script src="https://cdn.anychart.com/releases/8.3.0/js/anychart-base.min.js"></script>
<script src="https://cdn.anychart.com/releases/8.3.0/js/anychart-ui.min.js"></script>
<script src="https://cdn.anychart.com/releases/8.3.0/js/anychart-exports.min.js"></script>
<script src="https://cdn.anychart.com/releases/8.3.0/js/anychart-data-adapter.min.js"></script>
<script src="https://cdn.anychart.com/releases/8.3.0/js/anychart-tag-cloud.min.js"></script>

<link rel="stylesheet" href="http://localhost:8888/sns/resources/css/ranking.css">

<script src="http://localhost:8888/sns/resources/js/bubbleChart.js"></script>
<script src="http://localhost:8888/sns/resources/js/tagCloud.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ranking</title>

</head>
<body>

   <!-- ====================================MENU================================================= -->

   <jsp:include page="./topMenu.jsp" flush="false" />

   <!-- ============================================= List ================================================ -->
	<div class="defaultMain ui bottom attached padded context">
		<div class="ui main container" align="center">
			<div class="grid-container-2" style="margin-top: 30px;">
				<div id="bubbleChart"><svg></svg></div>
				<div id="tagCloud" style="width: 500px; height: 400px;"></div>	
			</div>
			<div class="ui divider"></div>
			<div class="grid-container-2" style="margin-top: 15px;">
				<div id="pie" style="width: 500px; height: 500px;"></div>
				<div style="width: 500px; height: 500px;"></div>
			</div>
			<div class="ui divider"></div>
			<div class="grid-container-3" style="margin-top: 30px;">
				<div id="bookCount" class="item1">1</div>
				<div id="notRead" class="item2">2</div>
				<div id="" class="item3">3</div> 
			</div>
		</div>
	</div>

</body>
</html>