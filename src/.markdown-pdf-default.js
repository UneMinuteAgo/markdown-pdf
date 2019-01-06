exports.header = {
	height: '1cm',
	contents: function(pageNum, numPages) {
		//if (pageNum === 1) {return "";}
		return "";
	}
}

exports.footer = {
	height: '1cm',
	contents: function(pageNum, numPages) {
		//if (pageNum === 1) {return "";}
		return "<footer style='font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, Oxygen-Sans, Ubuntu, Cantarell, \"Helvetica Neue\", sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\";font-size: 0.8rem; color: #3f3f3f; text-align: center;'>" + pageNum + ' / ' + numPages + "</footer>";
	}
}


