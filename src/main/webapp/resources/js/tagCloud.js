
anychart.onDocumentReady(function() {
	anychart.data.loadJsonFile("/sns/getTagFrequency", function(data) {
		var tabCloud = anychart.tagCloud(data);
		tabCloud.angles([0]);
		
		tabCloud.listen("chartDraw", function() {
			var title = tabCloud.title();
			title.enabled(true);
			title.text("실시간 Trend");
			title.fontColor("#000000");
			title.margin(0, 0, 15, 0);
			title.fontSize(20);
		});
		
		tabCloud.container("tagCloud");
		tabCloud.mode("spiral");
		tabCloud.draw();
	});
	
	anychart.data.loadJsonFile("/sns/getBuyCountDistribution", function(data) {
		var pie = anychart.pie(data);
		pie.labels().position("outside");
		pie.connectorStroke({color: "#595959", thickness: 2, dash:"2 2"});
		
		pie.listen("chartDraw", function() {
			var title = pie.title();
			title.enabled(true);
			title.text("이번 달 책 구매량 분포도\n");
			title.fontColor("#000000");
			title.margin(0, 0, 15, 0);
			title.fontSize(20);
		});
		
		pie.container("pie");
		pie.draw();
	});
});