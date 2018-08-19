import React, { Component } from 'react';
import { BrowserRouter, Route, Link } from 'react-router-dom';
import $ from 'jquery';
import Style from '../css/Style.css';





export default class Menu extends React.Component {
    constructor(props) {
        super(props);

        this.state = {

            date: new Date(),

        };
    }

    page = (e) => {
        debugger;
        this.props.history.push({
            pathname: '/CalendarLecturer/',

        });
    }

    render() {
        return (

            <div>
                <a id="home" href="/homepage" >Home</a> |
                <a id="home" href="/CalendarLecturer" >calendar</a> |
<a id="contact" href="/contact">Contact</a>
            </div>

        );
    }
}