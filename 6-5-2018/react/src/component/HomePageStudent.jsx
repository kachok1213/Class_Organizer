    import React from 'react';
import $ from 'jquery';

import DayPickerInput from 'react-day-picker/DayPickerInput';
import 'react-day-picker/lib/style.css';


import MomentLocaleUtils, {
    formatDate,
    parseDate,
} from 'react-day-picker/moment';

import 'moment/locale/he';

var WebServiceURL = "http://localhost:51302/Project.asmx";

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

export default class HomePageStudent extends React.Component {
    constructor(props) {
        super(props);
        this.state = { output: null };
        this.lecture;
    }


    componentDidMount() {
        let paramsObj =
            {
                id: parseInt(this.props.location.state.user.StudentID)
            }

        $.ajax({
            url: WebServiceURL + "/GetCurrentLectureByStudent",
            dataType: "json",
            type: "POST",
            data: JSON.stringify(paramsObj),
            contentType: "application/json; charset=utf-8",
            error: function (jqXHR, exception) {
                alert(formatErrorMessage(jqXHR, exception));
            },
            success: (data) => {
                this.lecture = JSON.parse(data.d);
                if (this.lecture != null) {
                    let output = [];
                    output.push(<h1>קורס: {this.lecture.Course.CourseName}<br /></h1>);
                    output.push(<h3>כיתה: {this.lecture.Class.ClassName}<br /></h3>);
                    output.push(<h2>מרצה: {this.lecture.FirstName} {this.lecture.LastName}<br /></h2>);
                    output.push(<h2>{this.lecture.BeginHour.slice(0, -3)}-{this.lecture.EndHour.slice(0, -3)}<br /></h2>);
                    output.push(<hr />);
                    output.push(<h3>סטטוס: {this.lecture.StatusName}<br /></h3>);
                    this.setState({ output });
                    if (this.lecture.StatusName != 'נייטרלי') {
                        $("#updatePresent").hide();
                        $("#updateLate").hide();
                    }
                }
            }
        });
    }

    toCalendar = () => {
        this.props.history.push({
            pathname: '/calendarstudent/' + this.props.location.state.user.StudentID,
            state: { user: this.props.location.state.user }
        });
    }

    updateToPresent = () => {
        let paramsObj =
            {
                studentID: parseInt(this.props.location.state.user.StudentID),
                lectureID: parseInt(this.lecture.LectureID)
            }

        $.ajax({
            url: WebServiceURL + "/ChangeStudentStatusToPresent",
            dataType: "json",
            type: "POST",
            data: JSON.stringify(paramsObj),
            contentType: "application/json; charset=utf-8",
            error: function (jqXHR, exception) {
                alert(formatErrorMessage(jqXHR, exception));
            },
            success: (data) => {
                this.componentDidMount();
                $("#updatePresent").hide();
                $("#updateLate").hide();
            }
        });
    }

    updateToLate = () => {
        let paramsObj =
            {
                studentID: parseInt(this.props.location.state.user.StudentID),
                lectureID: parseInt(this.lecture.LectureID)
            }

        $.ajax({
            url: WebServiceURL + "/ChangeStudentStatusToLate",
            dataType: "json",
            type: "POST",
            data: JSON.stringify(paramsObj),
            contentType: "application/json; charset=utf-8",
            error: function (jqXHR, exception) {
                alert(formatErrorMessage(jqXHR, exception));
            },
            success: (data) => {
                this.componentDidMount();
                $("#updatePresent").hide();
                $("#updateLate").hide();
            }
        });
    }

    render() {
        return (
            <div>
                <center>
                    <button onClick={this.toCalendar}>יומן</button>
                    <hr />
                    {this.state.output}
                    <button onClick={this.updateToPresent} id="updatePresent">סמן נוכח</button>
                    <button onClick={this.updateToLate} id="updateLate">סמן איחור</button>
                    <hr />
                </center>
            </div>
        );
    }
}