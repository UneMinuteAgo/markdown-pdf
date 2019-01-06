/**
 * PDF à 100% sur 1920x1080px
 *  1.2 cm =  40.00px
 *  1.0 cm =  33.33px
 *  1.0 mm =   3.33px
 *  1.0rem =  19.00px
 *  4.0rem =  74.00px
 *  0.1rem =   1.85px
 */
exports.header = {
    height: '1.2cm',
    contents: function(pageNum, numPages) {
        //if (pageNum === 1) {return "";}
        return "";
    }
}

exports.footer = {
    height: '1.2cm',
    contents: function(pageNum, numPages) {
        //if (pageNum === 1) {return "";} edeef1
        return "<footer style='position: absolute; bottom: -.6rem; left: 0px;padding: 0 1rem; display: block; padding: 0 1rem; width: calc(100% - 2rem); height: 100%; background: #edeef1; color: #446f8e; font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, Oxygen-Sans, Ubuntu, Cantarell, \"Helvetica Neue\", sans-serif, \"Apple Color Emoji\", \"Segoe UI Emoji\", \"Segoe UI Symbol\";font-size: 0.8rem; font-style: italic;'>" +
            "<div style='display: inline-block; float: left; height: 100%; padding: 0.421rem;'>#HackAN2018, Une Minute Ago Team</div>" +
            "<div style='display: inline-block; float: right; height: 100%; padding: 0.421rem;'>" + pageNum + ' / ' + numPages + "</div>" +
            "<div style='position: relative; left: 14rem;'>" +
            "<div style='position: relative;height: 50%; width: .4rem; left: .464rem; background: #f76806; -webkit-transform: skewX(30deg);'></div>" +
            "<div style='height: 50%; width: .464rem; background: #f76806; -webkit-transform: skewX(-30deg);'></div>" +
            "</div>" +
            "</footer>";
    }
}