
$(function() {
	d3.json("/sns/getCategoryAmount", function(error, data) {
		if (error) {
		    console.error('Error getting or parsing the data.');
		    throw error;
		}
		
	    var chart = bubbleChart().width(500).height(450);
	    d3.select('#bubbleChart').datum(data).call(chart);
	});
});

function bubbleChart() {
	var width = 1000,
	height = 1000,
	marginTop = 96,
	minRadius = 20,
	maxRadius = 80,
	columnForColors = "CATEGORIES",
	columnForTitle = "CATEGORIES",
	columnForRadius = "CATEGORYCOUNT",
	forceApart = -400,
	customColors=false,
	customRange,
	customDomain,
	chartSelection,
	chartSVG,
	showTitleOnCircle=true;

	function chart(selection) {
		var data = selection.datum();
		chartSelection=selection;
		var div = selection,
		svg = div.selectAll('svg');
		svg.attr('width', width).attr('height', height);
		chartSVG=svg;

		var tooltip = selection
					.append("div")
					.style("position", "absolute")
					.style("visibility", "hidden")
					.style("color", "white")
					.style("padding", "5px")
					.style("background-color", "#bcbcbc")
					.style("border-radius", "3px")
					.style("text-align", "center")
					.style("font-family", "monospace")
					.style("width", "90px")
					.text("");

		var simulation = d3.forceSimulation(data)
						.force("charge", d3.forceManyBody().strength([forceApart]))
						.force("x", d3.forceX())
						.force("y", d3.forceY())
						.on("tick", ticked);

		function ticked(e) {
			node.attr("transform",function(d) {
				return "translate(" + [d.x+(width / 2), d.y+((height+marginTop) / 2)] +")";
			});
		}

		var colorCircles;
		if (!customColors) {
			colorCircles = d3.scaleOrdinal(d3.schemeCategory10);
		} else {
			colorCircles = d3.scaleOrdinal()
			.domain(customDomain)
			.range(customRange);
		}
	
		var minRadiusDomain = d3.min(data, function(d) { return +d[columnForRadius]; });
		var maxRadiusDomain = d3.max(data, function(d) { return +d[columnForRadius]; });
		
		var scaleRadius = d3.scaleLinear()
						.domain([minRadiusDomain, maxRadiusDomain])
						.range([minRadius, maxRadius])

		var node = svg.selectAll("circle")
				.data(data)
				.enter()
				.append("g")
				.attr('transform', 'translate(' + [width / 2, height / 2] + ')')
				.style('opacity', 1);
			
		node.append("circle")
		.attr("id",			function(d, i) 	{ return i; })
		.attr('r', 			function(d) 	{ return scaleRadius(d[columnForRadius]); })
		.style("fill", 		function(d) 	{ return colorCircles(d[columnForColors]); })
		.on("mouseover", 	function(d) { return tooltip.html(d[columnForRadius] + "권").style("visibility", "visible"); })
		.on("mousemove", 	function() 	{ return tooltip.style("top", (d3.event.pageY-10) + "px").style("left", (d3.event.pageX+10) + "px"); })
		.on("mouseout", 	function()  { return tooltip.style("visibility", "hidden"); });
		
		node.append("clipPath").attr("id", function(d,i) { return "clip-"+i; })
			.append("use").attr("xlink:href",function(d,i) { return "#" + i; });
		
		node.append("text")
		.attr("text-anchor", "middle")
		.append("tspan")
		.attr("x", function(d) { return 0;/*-1*scaleRadius(d[columnForRadius])/3;*/ })
		.attr("y", function(d) { return ".3em";/*scaleRadius(d[columnForRadius])/4;*/ })
		.style("color", "white")
		.text(function(d) { return d[columnForTitle]; })
		.on("mouseover", 	function(d) { return tooltip.html(d[columnForRadius] + "권").style("visibility", "visible"); })
		.on("mousemove", 	function() 	{ return tooltip.style("top", (d3.event.pageY-10) + "px").style("left", (d3.event.pageX+10) + "px"); })
		.on("mouseout", 	function()  { return tooltip.style("visibility", "hidden"); });

		svg.append("text")
			.attr("x", width/2).attr("y", "20px")
			.attr("text-anchor", "middle")
			.attr("font-size","1.5em")
			.text("가장 많이 가지고 있는 분야 Top 10");
	}

	chart.width = chartWidth;
	chart.height = chartHeight;
	chart.columnForColors = chartColForColors;
	chart.columnForRadius = chartColForRadius;
	chart.columnForTitle = chartColForTitle;
	chart.minRadius = chartMinRadius;
	chart.maxRadius = chartMaxRadius;
	chart.forceApart = chartForceApart;
	chart.unitName = chartUnitName;
	chart.customColors = chartCustomColors;
	chart.showTitleOnCircle = chartShowTitleOnCircle;
	chart.title=chartTitle;
	chart.remove = chartRemove;

	function chartWidth(value) {
		if (!arguments.length) {
			return width;
		}
		width = value;
		return chart;
	};

	function chartHeight(value) {
		if (!arguments.length) {
			return height;
		}
		height = value;
		marginTop=0.05*height;
		return chart;
	};

	function chartColForColors(value) {
		if (!arguments.length) {
			return columnForColors;
		}
		columnForColors = value;
		return chart;
	};
	
	function chartColForTitle(value) {
		if (!arguments.length) {
			return columnForTitle;
		}
		columnForTitle = value;
		return chart;
	};

	function chartColForRadius (value) {
		if (!arguments.length) {
			return columnForRadius;
		}
		columnForRadius = value;
		return chart;
	};
	
	function chartMinRadius(value) {
		if (!arguments.length) {
			return minRadius;
		}
		minRadius = value;
		return chart;
	};
	
	function chartMaxRadius(value) {
		if (!arguments.length) {
			return maxRadius;
		}
		maxRadius = value;
		return chart;
	};
	
	function chartUnitName(value) {
		if (!arguments.length) {
			return unitName;
		}
		unitName = value;
		return chart;
	};
	
	function chartForceApart(value) {
		if (!arguments.length) {
			return forceApart;
		}
		forceApart = value;
		return chart;
	};
	
	function chartShowTitleOnCircle(value) {
		if (!arguments.length) {
			return showTitleOnCircle;
		}
		showTitleOnCircle = value;
		return chart;
	};
	
	function chartCustomColors(domain,range) {
		customColors=true;
		customDomain=domain;
		customRange=range;
		return chart;
	};
	
	function chartTitle(value) {
		if (!arguments.length) {
			return title;
		}
		title = value;
		return chart;
	}

	function chartRemove(callback) {
		chartSVG.selectAll("text")
		.style("opacity",1)
		.transition()
		.duration(500)
		.style("opacity", "0")
		.remove();	
		if (!arguments.length) {	
			chartSVG.selectAll("g")
			.style("opacity",1)
			.transition()
			.duration(500)
			.style("opacity", "0")
			.remove();		
		} else {			
			chartSVG.selectAll("g")
			.style("opacity",1)
			.duration(500)
			.style("opacity", "0")
			.remove()
			.on("end", callback);
		}
		return chart;
	}
	
	return chart;
}