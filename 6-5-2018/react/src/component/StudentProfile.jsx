import React, { Component } from 'react';
import { BrowserRouter, Route, Link } from 'react-router-dom';
import $ from 'jquery';
import {withRouter} from 'react-router';

class StudentProfile extends Component {
    constructor(props) {
        super(props);
    
      }
      studntProf =(e)=> {


        this.props.history.push({
            pathname: '/StudentPage/' ,
            state: { stu: this.props.profile }
          });

      }

    render() {
        return (
            <div>
               <button onClick={this.studntProf}> {this.props.profile.FirstName }  </button>
            </div>
        );
    }
}


export default withRouter(StudentProfile);