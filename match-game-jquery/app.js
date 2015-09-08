
// css from 1024
// code by Yen168

$(document).ready(function(){

	var setGrid = function(n){

		var combination = n * n / 2;
		var pool_num = {};

		for(var i = 0;i<combination;i++){

			pool_num[i]=0;

		};

		var pool = [];

		for(var i = 0;i<n*n;i++){

			var temp;

			do {
				temp = Math.floor((Math.random() * combination));
			} 
			while(pool_num[temp]===2);
			
			pool_num[temp]+=1;
			pool[i]=temp;

		};
		test = pool;
		return pool;

	};

	var initGrid = function(n){

		var pool = setGrid(n);


		$('body').append('<div id = "boardcontainer"></div>');
		// var i,j,k to limit scope
			for(var i=0, k=0;i<n;i++){
				for(var j=0;j<n;j++,k++){

					$('#boardcontainer').append('<div class = "boardtile emptytile" data-mapset="'+pool[k]+'" data-row="'+i+'" data-col="'+j+'"></div>');
				}
				$('#boardcontainer').append('<div style = "clear:both"></div>');
			}
			$('body').append('<div id = "scorediv"></div>');

	};

	
	var n = 4;
	var firstSecond = false;
	var firstNum = -999;
	var secondNum = 999;
	
	initGrid(n);
	
	// $('#boardcontainer').on('click','.emptytile',function(){

	// 	var test = this.text('mapset');
	// 	alert(test);

	// });

	$('#boardcontainer').on('click','.emptytile',function(){

		var mapSet = $(this).data('mapset');


		$(this).removeClass('emptytile');
		$(this).addClass('tile');

		if (firstSecond === false){
			$(this).attr('id','firstNumTag');
			firstNum = mapSet;
			$(this).text(mapSet);
			firstSecond = !firstSecond;

		}else{

			$(this).attr('id','secondNumTag');
			secondNum = mapSet;
			$(this).text(mapSet);
			firstSecond = !firstSecond;

			if (firstNum === secondNum){

				firstNum = -999;
				secondNum = 999;
				
				$('div#firstNumTag').removeAttr('id');
				$('div#secondNumTag').removeAttr('id');

			}else{

				
				var gogo = function(){

					$('div#firstNumTag').text('');
					$('div#firstNumTag').addClass('emptytile');
					$('div#firstNumTag').removeClass('tile');
					$('div#firstNumTag').removeAttr('id');

					$('div#secondNumTag').text('');
					$('div#secondNumTag').addClass('emptytile');
					$('div#secondNumTag').removeClass('tile');
					$('div#secondNumTag').removeAttr('id');
				};
				
				firstNum = -999;
				secondNum = 999;
				
				setTimeout(gogo,500);

			};

		};

	});

	

});


// anonymous
// (function (n){

// 	alert("aasdf: "+n);
// 	return "Yes";

// })(1);

// var an = [0, 1, 2, 3, 4].reduce(function(previousValue, currentValue) {

//   return previousValue + currentValue;
// });

// alert(an);

// var p = {};
// p["a"]=1;
// p[10]="30";

// alert(p[10]);



