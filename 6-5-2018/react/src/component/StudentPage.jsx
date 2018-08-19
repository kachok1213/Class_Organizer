import React, { Component } from 'react';
import $ from 'jquery';

class StudentPage extends Component {
    constructor(props) {
        super(props);
          this.name;
      }
      


    render() {
        return (
            <div>
               {this.props.location.stu.name}
            </div>
        );
    }
}


export default StudentPage;