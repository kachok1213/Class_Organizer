import $ from 'jquery';
var WebServiceURL = "http://localhost:51302/Project.asmx";

export default function Ajax(funcName, paramsObj) {
    return new Promise((res, rej) => {
        $.ajax({
            url: WebServiceURL + "/" + funcName,
            async: false,
            dataType: "json",
            type: "POST",
            data: JSON.stringify(paramsObj),
            contentType: "application/json; charset=utf-8"
        }).done(function (data) {
            res(data.d);
        }).fail(function (jqXHR, exception) {
            rej(formatErrorMessage(jqXHR, exception));
        })
    })
}

function formatErrorMessage(jqXHR, exception) {
    if (jqXHR.status === 0) {
        return ('Not connected.\nPlease verify your network connection.');
    } else if (jqXHR.status == 404) {
        return ('The requested page not found. [404]');
    } else if (jqXHR.status == 500) {
        return ('Internal Server Error [500].');
    } else if (exception === 'parsererror') {
        return ('Requested JSON parse failed.');
    } else if (exception === 'timeout') {
        return ('Time out error.');
    } else if (exception === 'abort') {
        return ('Ajax request aborted.');
    } else {
        return ('Uncaught Error.\n' + jqXHR.responseText);
    }
}