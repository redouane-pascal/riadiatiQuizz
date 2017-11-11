/*
 * jsLaTeX v1.2 - jQuery plugin
 * 
 *  Copyright (c) 2009 Andreas Grech
 *
 *  Dual licensed under the MIT and GPL licenses:
 *    http://www.opensource.org/licenses/mit-license.php
 *    http://www.gnu.org/licenses/gpl.html
 *
 * http://knowledge-aholic.blogspot.com
 */

(function ($) {
    var attachToImage = function () {
        return $("<img/>").attr({
            src: this.src
        });
    },
        formats = {
        'gif': attachToImage,
        'png': attachToImage,
        'swf': function () {
            return $("<embed/>").attr({
                src: this.src,
                type: 'application/x-shockwave-flash'
            });
        }
    },
        sections = {
        '{f}': 'format',
        '{e}': 'equation',
        '{sz}': 'size',
        '{dpi}': 'dpi'
    },
        escapes = {
        '+': '2B',
        '=': '3D'
    };

    $.fn.latex = function (opts) {
        opts = $.extend({}, $.fn.latex.defaults, opts);
        opts.format = formats[opts.format] ? opts.format : 'gif';
        return this.each(function () {
            var $this = $(this),
                format, s, element, url = opts.url;
            opts.equation = localStorage.getItem($this.attr('id'));
            opts.size = localStorage.getItem("size");
            opts.dpi = $("#dpi").val();
            for (s in sections) {
                if (sections.hasOwnProperty(s) && (format = url.indexOf(s)) >= 0) {
                    url = url.replace(s, opts[sections[s]]);
                }
            }
            for (s in escapes) {
                if (escapes.hasOwnProperty(s) && (format = url.indexOf(s)) >= 0) {
                    url = url.replace(s, '%' + escapes[s]);
                }
            }
            opts.src = url;
            element = formats[opts.format].call(opts);
            $this.html('').append(element);
            if (opts.callback) {
                opts.callback.call(element);
            }
        });
    };
//
    $.fn.latex.defaults = {
        format: 'gif',
        //url: 'http://latex.codecogs.com/{f}.latex?{sz}{e}'
		url: 'http://latex.codecogs.com/{f}.latex?%5Cdpi%7B{dpi}%7D%20%5C{sz}%20{e}'
		//    http://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20%5Clarge%20
		//    http://latex.codecogs.com/gif.latex?%5Cdpi%7B50%7D%20%5Ctiny%20
		//    http://latex.codecogs.com/gif.latex?%5Cdpi%7B50%7D%20%5Clarge%20">
    };
}(jQuery));

function refresh(itemId) {
	localStorage.setItem(itemId, $("#"+itemId).val());
	location.reload();
}

function setDPI(itemId) {
	
	localStorage.setItem('dpi', $("#"+itemId).val());
	location.reload();
	
//	$("#tdR1").css({
//		"padding": "50px 0px 0px "+$("#"+itemId).val()+"px"
//	});
}

function setPadding(itemId) {
	if(itemId == 'paddingLeft1'){
		$("#tdR1").css({
			"padding": "50px 0px 0px "+$("#"+itemId).val()+"px"
		});
		$("#tdR3").css({
			"padding": "50px 0px 0px "+$("#"+itemId).val()+"px"
		});
	}else if(itemId == 'paddingLeft2'){
		$("#tdR2").css({
			"padding": "50px 0px 0px "+$("#"+itemId).val()+"px"
		});
		$("#tdR4").css({
			"padding": "50px 0px 0px "+$("#"+itemId).val()+"px"
		});
		
	}
	
}

//Your modified code.
function printToFile() {
	html2canvas($("#quizz"), {
		onrendered: function(canvas) {
			theCanvas = canvas;
			document.body.appendChild(canvas);

			// Convert and download as image 
			Canvas2Image.saveAsPNG(canvas); 
			$("#img-out").append(canvas);
			// Clean up 
			//document.body.removeChild(canvas);
		}
	});
}

$(document).ready(function(){
	
	var element = $("#quizz"); // global variable
	var getCanvas; // global variable
	 
		$("#btn-Preview-Image").on('click', function () {
			 html2canvas(element, {
			 onrendered: function (canvas) {
					$("#previewImage").append(canvas);
					getCanvas = canvas;
				 }
			 });
		});

		$("#btn-Convert-Html2Image").on('click', function () {
			var imgageData = getCanvas.toDataURL("image/png");
 			var newData = imgageData.replace(/^data:image\/png/, "data:application/octet-stream");
			$("#btn-Convert-Html2Image").attr("download", "quiz.png").attr("href", newData);
		});
		
		$('#callServlet').on('click', function() {
			$.ajax({
				url : 'GetUserServlet',
				data : {
					quizzNumber : $('#quizzNumber').val()
				},
				success : function(responseText) {
					alert("Done");
//					$('#ajaxGetUserServletResponse').text(responseText);
				}
			});
		});
		
		

});