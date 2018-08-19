import React, { Component } from 'react';
import { BrowserRouter, Route, Link } from 'react-router-dom';
import $ from 'jquery';
import Style from '../css/Style.css';

import logo from '../images/logo.svg';
import id from '../images/id.png';
import pass from '../images/password.png';
import bg from '../images/bg.jpg';


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

class Login extends React.Component {
  constructor(props) {
    super(props);
    this.state = { output: "" };
    this.txtID = "";
    this.txtPass = "";
  }

  txtIDChanged = (e) => {
    this.txtID = e.target.value;
  }
  txtPassChanged = (e) => {
    this.txtPass = e.target.value;
  }

  login = () => {

    let paramsObj =
      {
        userId: this.txtID.match(/^[0-9]+$/) == null ? '0' : parseInt(this.txtID),
        pass: this.txtPass
      }

    $.ajax({
      url: WebServiceURL + "/Login",
      dataType: "json",
      type: "POST",
      data: JSON.stringify(paramsObj),
      contentType: "application/json; charset=utf-8",
      error: function (jqXHR, exception) {
        alert(formatErrorMessage(jqXHR, exception));
      },
      success: (data) => {
        if (data.d === 'null') {
          alert("Wrong ID / Password");
        }
        else {
          let user = JSON.parse(data.d);
          if (user.Role.RoleName == 'Student') {
            this.props.history.push({
              pathname: '/homepagestudent/' + user.StudentID,
              state: { user: user }
            });


          }
          else if (user.Role.RoleName == 'Lecturers') {
            this.props.history.push({
              pathname: '/homepage/' + user.LecturerID,
              state: { user: user }
            });
          }


        }
      }
    });
  }

  componentDidMount() {


    $("div.logo").delay(1000).animate({ top: '150px' }, 1000);

    $("div.login").delay(1500).animate({ opacity: '1' }, 1000);

  }

  render() {


    return (
      <div>


        <div className="logo">
          <img src={logo} />
        </div>

        <div className="login">

          <form>

            <div className="id">
              <img src={id} />
              <input type="text" placeholder="ת.ז" onChange={this.txtIDChanged} />
            </div>

            <div className="password">
              <img src={pass} />
              <input type="password" placeholder="סיסמא" onChange={this.txtPassChanged} />
            </div>
            <h6> {this.state.msg}</h6>
            <div className="checkbox">
              <input type="checkbox" class="check" />
              <h3> זכור אותי </h3>
            </div>

            <input type="button" value="כניסה" onClick={this.login} />

          </form>
        </div>
      </div>


    );


  }
}

export default Login;
