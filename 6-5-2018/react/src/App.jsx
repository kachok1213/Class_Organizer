import React, { Component } from 'react';
import { BrowserRouter, Route, Link } from 'react-router-dom';
import Login from './component/Login';
import HomePage from './component/HomePage';
import CalendarStudent from './component/CalendarStudent';
import HomePageStudent from './component/HomePageStudent';
import NextClass from './component/NextClass';
import ListClassesForDate from './component/ListClassesForDate';
import Menu from './component/Menu';
import CalendarLecturer from './component/CalendarLecturer';
import './App.css';
import StudentPage from './component/StudentPage';





class App extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {


    return (
<BrowserRouter>
<div>
<Route exact path="/" component={Login} />
<Route path="/calendarstudent" component={CalendarStudent} />
<Route path="/homepagestudent" component={HomePageStudent} />
<Route path="/homepage" component={HomePage} />
<Route path="/CalendarLecturer" component={CalendarLecturer} />
<Route path="/StudentPage" component={StudentPage} />
</div>
</BrowserRouter>
    );
  }
}

export default App;
