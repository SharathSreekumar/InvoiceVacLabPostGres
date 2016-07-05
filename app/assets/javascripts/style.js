window.onload = function(){
	var startI = parseInt($('#start').val());
	var endI = parseInt($('#end').val());
	$("#tableInvoice > tbody > tr").hide().slice(startI, endI).show();

	var startP = parseInt($('#startP').val());
	var endP = parseInt($('#endP').val());
	$("#tableProduct > tbody > tr").hide().slice(startP, endP).show();
};

function onPrev(){
	var start = parseInt($('#start').val());
	var end = parseInt($('#end').val());
	if(	start >= 5){
		start -= 5;
		end -= 5;
		$("#tableInvoice > tbody > tr").hide().slice(start, end).show();
		$('#start').val(start.toString());
		$('#end').val(end.toString());
	}	
}

function onNext(){
	var start = parseInt($('#start').val());
	var end = parseInt($('#end').val());
	if(end < $("#tableInvoice > tbody > tr").size()){
		start += 5;
		end += 5;
		$("#tableInvoice > tbody > tr").hide().slice(start, end).show();
		$('#start').val(start.toString());
		$('#end').val(end.toString());
	}
}

function prevProd(){
	var start = parseInt($('#startP').val());
	var end = parseInt($('#endP').val());
	if(	start >= 5){
		start -= 5;
		end -= 5;
		$("#tableProduct > tbody > tr").hide().slice(start, end).show();
		$('#startP').val(start.toString());
		$('#endP').val(end.toString());
	}	
}

function nextProd(){
	var start = parseInt($('#startP').val());
	var end = parseInt($('#endP').val());
	if(end < $("#tableProduct > tbody > tr").size()){
		start += 5;
		end += 5;
		$("#tableProduct > tbody > tr").hide().slice(start, end).show();
		$('#startP').val(start.toString());
		$('#endP').val(end.toString());
	}
}

function searchBox(){
	if ($('#search').val() == null || $('#search').val() == ""){
		$('#formSearch').action = "/invoices";
	}else{
		$('#formSearch').action = "/invoices?" + $('#search').val();
	}
}

function overrideLink(indexX){ // gets the value from the dropdown & assigns the rate & Edit option
	var x = $(indexX).closest('tr').index();
	
	var table = document.getElementById("newTable");
	var tableSize = $("#newTable > tbody > tr").size();
	if(indexX.options[indexX.selectedIndex].text.search("Custom") == -1){
		var index = indexX.selectedIndex;
		$(table.rows.item(x).cells[1]).find('a').attr("href","/products/"+ index +"/edit");
		$(table.rows.item(x).cells[1]).find('a').css('display','block');
		$(table.rows.item(x).cells[1]).find('input').val(indexX.value);
		$(table.rows.item(x).cells[0]).find('input').val($(indexX).children(':selected').text());// fetch text & assign

		//var productName = document.getElementsByName("Product");
		for (var i = 0; i < tableSize - 1 ; i++){
			if(i != x){
				$(table.rows.item(i).cells[0]).find('select').children('option')[index].style.display="none";
			}
		}
	}else{
		$(table.rows.item(x).cells[1]).find('a').attr("href","");
		$(table.rows.item(x).cells[1]).find('a').css('display','none');
		$(table.rows.item(x).cells[1]).find('input').val(10);
		$(table.rows.item(x).cells[0]).find('input').val($(indexX).children(':selected').text());
	}
	amount(indexX); // <- calls directly as the quantity is initially set to 1
}

//Note : if the function 'amount()'' is called from 'overrideLink(indexX)', then 'index.value' will fetch the value of "Rate" & not "Quantity"
function amount(index){ // rate * quantity
	var x = $(index).closest('tr').index();
	var table = document.getElementById("newTable");
	var rate = $(table.rows.item(x).cells[1]).find('input').val();
	var quantity = $(table.rows.item(x).cells[2]).find('input').val(); //index.value;
	
	if(rate > 0 && quantity > 0)
		$(table.rows.item(x).cells[3]).find('input').val(rate * quantity);
	else{
		alert("Please select a product & set quantity above 0");
		$(table.rows.item(x).cells[3]).find('input').val(0);
	}
}

function addTableRow(){ // adds new row & 5 columns to the table
	var table = document.getElementById("newTable");

	var rowCount = table.rows.length;
	var row = table.insertRow(rowCount - 1);

	var colCount = table.rows[0].cells.length;

	for(var i = 0; i < colCount; i++) {
		var newcell	= row.insertCell(i);// insert cell
		newcell.innerHTML = table.rows[0].cells[i].innerHTML;
	}

	var optionSize = $(table.rows.item(rowCount - 1).cells[0]).find('select').children('option').size();
	for (var j = 0; j < rowCount - 1 ; j++){// to track table rows
		for (var i = 1; i < optionSize ; i++){// to track options
			// compares if any of the above dropdowns hava chosen value, if so, then hide
			if($(table.rows.item(rowCount - 1).cells[0]).find('select').children('option')[i].text == $(table.rows.item(j).cells[0]).find('select').children(':selected').text()){
				$(table.rows.item(rowCount - 1).cells[0]).find('select').children('option')[i].style.display="none";
			}
		}
	}
}

function deleteTableRow(index){ // deletes the row that is selected by user
	try {
		var table = document.getElementById("newTable");
		var rowCount = table.rows.length;

		if(rowCount > 2){
			table.deleteRow($(index).closest('tr').index());// fetch index of that row of the table
		}else{
			alert("No more rows to delete");
		}
	}catch(e) {
		alert("No more rows to delete");
	}
}