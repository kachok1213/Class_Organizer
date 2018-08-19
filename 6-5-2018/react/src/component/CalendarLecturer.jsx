import React, { Component } from 'react';
import Calendar from 'react-calendar';
import $ from 'jquery';
import NextClass from './NextClass';
import ListClassesForDate from './ListClassesForDate.jsx';
import Menu from './Menu';
import Ajax from './Ajax';






class CalendarLecturer extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      allClass: null,

      date: new Date(),

    };

    this.isPast;
  }

  onDateChange = (date) => {

    if (date > new Date() || date.toLocaleDateString() === new Date().toLocaleDateString()) {
      this.isPast = false;
    }
    else {
      this.isPast = true;
    }

    var date1 = date.getDate() + "/" + (date.getMonth() + 1) + "/" + date.getFullYear()

    let paramsObj =
      {
        date: date1,
        LecturerID: 111
      }
    Ajax('GetAllLectureForLecturerForSpecDate', paramsObj)
      .then(data => {
        let info = JSON.parse(data);
        this.setState({ allClass: info })
      })
      .catch(err => {
        alert(err)
      });
    }



  render() {

    return (

      <div>
        <Menu />

        <Calendar
          onChange={this.onDateChange}
          value={this.state.date}
        />

        <ListClassesForDate list={this.state.allClass} past={this.isPast} />
      </div>

    );
  }
}

export default CalendarLecturer