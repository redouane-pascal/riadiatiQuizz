<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<style>
.latex {
	vertical-align: middle;
} /*default styling for latex imgs */
.bordered {
	border: 1px solid red;
}

.block {
	display: block;
}

td {
	border: none !important;
}

.label-mine {
	float: right;
	padding-right: 15px;
	margin: 0px;
}

.numeroQuizz {
	font-family: Century Gothic, CenturyGothic, AppleGothic, sans-serif;
	font-weight: bold;
	text-shadow: -2px 0 black, 0 2px black, 2px 0 black, 0 -2px black;
	color: white;
	font-size: 56px;
	padding: 15px;
}

#slidecontainer {
	width: 100%; /* Width of the outside container */
}

/* The slider itself */
.slider {
	-webkit-appearance: none; /* Override default CSS styles */
	appearance: none;
	width: 100%; /* Full-width */
	height: 25px; /* Specified height */
	background: #d3d3d3; /* Grey background */
	outline: none; /* Remove outline */
	opacity: 0.7; /* Set transparency (for mouse-over effects on hover) */
	-webkit-transition: .2s; /* 0.2 seconds transition on hover */
	transition: opacity .2s;
}

/* Mouse-over effects */
.slider:hover {
	opacity: 1; /* Fully shown on mouse-over */
}

/* The slider handle (use webkit (Chrome, Opera, Safari, Edge) and moz (Firefox) to override default look) */
.slider::-webkit-slider-thumb {
	-webkit-appearance: none; /* Override default look */
	appearance: none;
	width: 25px; /* Set a specific slider handle width */
	height: 25px; /* Slider handle height */
	background: #4CAF50; /* Green background */
	cursor: pointer; /* Cursor on hover */
}

.slider::-moz-range-thumb {
	width: 25px; /* Set a specific slider handle width */
	height: 25px; /* Slider handle height */
	background: #4CAF50; /* Green background */
	cursor: pointer; /* Cursor on hover */
}
</style>

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="js/codecogs.js"></script>
<script src="js/html2canvas.js"></script>
<script src="js/canvas2image.js"></script>

<script>
	function manageLocalStorage(itemLabel) {
		if (localStorage.getItem(itemLabel) == null) {
			localStorage.setItem(itemLabel, $("#" + itemLabel).val());
		} else {
			$("#" + itemLabel).val(localStorage.getItem(itemLabel));
		}
	}

	$(function() {
		manageLocalStorage("size");
		manageLocalStorage("dpi");
		manageLocalStorage("equation");
		manageLocalStorage("r1");
		manageLocalStorage("r2");
		manageLocalStorage("r3");
		manageLocalStorage("r4");
		$("#quizzNumber").val(localStorage.getItem("quizzNumber"));
		$("#myRange").val(localStorage.getItem("dpi"));

		$(".latex").latex();
	});
	$("#r1").click(function() {
		alert("oui");
	});
</script>
</head>
<body width="100%">
	<table width="100%">
		<tr>
			<td width="50%">

				<form>
					<!--  action="helloServlet" method="post"> -->
					<table>
						<tr>
							<td colspan="5">&nbsp;</td>
						</tr>
						<tr>
							<td><label class="control-label label-mine">Nb.Quizz</label></td>
							<td><input class="form-control" name="quizzNumber"
								id="quizzNumber" title="Quizz Number"
								onchange="refresh('quizzNumber')" /></td>
							<td colspan="3">&nbsp;</td>
						<tr>
							<td colspan="5">&nbsp;</td>
						</tr>
						<tr>
							<td><label class="control-label label-mine">DPI</label></td>
							<td>
								<div id="slidecontainer">
									<input type="range" min="1" max="300" class="slider"
										id="myRange" onchange="setDPI('myRange')">
								</div>
							</td>
							<td>&nbsp;</td>
							<td>
								<div align="center">
									<input class="form-control" name="fontsize" id="dpi"
										title="DPI" onchange="refresh('dpi')"
										style="width: 80px; text-align: center;" />
								</div>
							</td>
							<td>&nbsp;</td>
						<tr>
							<td colspan="5">&nbsp;</td>
						</tr>
						<tr>
							<td width="20%"><label class="control-label label-mine">Size</label></td>
							<td width="60%"><select class="form-control" name="fontsize"
								id="size" title="Taille de police" onchange="refresh('size')"
								style="width: 80%">
									<option value="tiny">(5pt) Très petit</option>
									<option value="small">(9pt) Petit</option>
									<option value="">(10pt) Normal</option>
									<option value="large">(12pt) Grand</option>
									<option value="LARGE">(18pt) Grand</option>
									<option value="huge">(20pt) Énorme</option>
							</select></td>
							<td width="5%">&nbsp;</td>
							<td width="10%">&nbsp;</td>
							<td width="5%">&nbsp;</td>
						<tr>
							<td colspan="5">&nbsp;</td>
						</tr>
						<tr>
							<td><label class="control-label label-mine">Equation</label></td>
							<td colspan="3"><textarea class="form-control"
									name="fontsize" id="equation" title="Equation"
									onchange="refresh('equation')" rows="4" cols="50"></textarea></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td colspan="5">&nbsp;</td>
						</tr>
						<tr>
							<td><label class="control-label label-mine">Answer 1</label></td>
							<td colspan="3"><input class="form-control" name="fontsize"
								id="r1" title="Answer 1" onchange="refresh('r1')" /></td>
							<td>&nbsp;</td>
						<tr>
							<td colspan="5">&nbsp;</td>
						</tr>
						<tr>
							<td><label class="control-label label-mine">Answer 2</label></td>
							<td colspan="3"><input class="form-control" name="fontsize"
								id="r2" title="Answer 2" onchange="refresh('r2')" /></td>
							<td>&nbsp;</td>
						<tr>
							<td colspan="5">&nbsp;</td>
						</tr>
						<tr>
							<td><label class="control-label label-mine">Answer 3</label></td>
							<td colspan="3"><input class="form-control" name="fontsize"
								id="r3" title="Answer 3" onchange="refresh('r3')" /></td>
							<td>&nbsp;</td>
						<tr>
							<td colspan="5">&nbsp;</td>
						</tr>
						<tr>
							<td><label class="control-label label-mine">Answer 4</label></td>
							<td colspan="3"><input class="form-control" name="fontsize"
								id="r4" title="Answer 4" onchange="refresh('r4')" /></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td colspan="5">&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<button id="callServlet" type="button" class="btn btn-success">Imprimer</button>
							</td>
							<td>
							 	<a href="javascript:window.open('GetUserServlet')">Export</a>
							</td>
							<td colspan="3">&nbsp;</td>
						</tr>
					</table>

				</form>
			</td>
			<td style="padding: 6px;" width="100%" colspan="2">
				<div id="quizz" class="myDivToPrint"
					style="background-image: url('img/bg.png'); width: 710px; height: 600px;">
					<div class="numeroQuizz">
						<script>
							var qn = localStorage.getItem("quizzNumber");
							document.write(qn);
						</script>
					</div>
					<table class="table">
						<!--  table-striped -->
						<tr style="height: 167px;">
							<td colspan="2" align="center" style="vertical-align: middle;">
								<div id="equation" class="latex"></div>
							</td>
						</tr>
						<tr style="height: 130px;">
							<td id="tdR1"
								style="width: 50%; vertical-align: middle; padding: 50px 0px 0px 130px;">
								<div id="r1" class="latex" onclick='alert("youClickedMe!");'
									onmouseover="bigImg(this)" onmouseout="normalImg(this)">
								</div>
							</td>
							<td id="tdR2"
								style="width: 50%; vertical-align: middle; padding: 50px 0px 0px 70px;">
								<div id="r2" class="latex" onmouseover="bigImg(this)"
									onmouseout="normalImg(this)"></div>
							</td>
						</tr>
						<tr style="height: 130px;">
							<td id="tdR3"
								style="vertical-align: middle; padding: 50px 0px 0px 130px;">
								<div id="r3" class="latex" onmouseover="bigImg(this)"
									onmouseout="normalImg(this)"></div>
							</td>
							<td id="tdR4"
								style="vertical-align: middle; padding: 50px 0px 0px 70px;">
								<div id="r4" class="latex" onmouseover="bigImg(this)"
									onmouseout="normalImg(this)"></div>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
		<tr>
			<td width="50%">&nbsp;</td>
			<td width="25%">
				<div id="slidecontainer">
					<input type="range" min="1" max="300" class="slider"
						id="paddingLeft1" onchange="setPadding('paddingLeft1')"
						style="margin: -5px 0px 0px 20px; width: 90%;">
				</div>
			</td>
			<td width="25%">
				<div id="slidecontainer">
					<input type="range" min="1" max="300" class="slider"
						id="paddingLeft2" onchange="setPadding('paddingLeft2')"
						style="margin: -5px 0px 0px 20px; width: 90%;">
				</div>
			</td>
		</tr>
	</table>
	<script>
		function bigImg(x) {
			x.style.zoom = "130%";
		}
		function normalImg(x) {
			x.style.zoom = "100%";
		}
		var slider = document.getElementById("myRange");
		var output = document.getElementById("dpi");
		output.innerHTML = slider.value; // Display the default slider value

		// Update the current slider value (each time you drag the slider handle)
		slider.oninput = function() {
			output.innerHTML = this.value;
		}
	</script>
</body>
</html>
<!-- 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jQuery, Ajax and Servlet/JSP integration example</title>

<script src="http://code.jquery.com/jquery-1.10.2.js"
	type="text/javascript"></script>
<script src="js/app-ajax.js" type="text/javascript"></script>
</head>
<body>

	<form>
		Enter Your Name: <input type="text" id="userName" />
	</form>
	<br>
	<br>

	<strong>Ajax Response</strong>:
	<div id="ajaxGetUserServletResponse"></div>
</body>
</html>
 -->