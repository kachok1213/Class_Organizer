import React, { Component } from 'react';
import { BrowserRouter, Route, Link } from 'react-router-dom';
import $ from 'jquery';
import Style from '../css/Style.css';
import StudentProfile from './StudentProfile';



function ListOfStudents(props) {
    let listLecture;

    if (props.list != null) {
        listLecture = props.list.map((obj) =>

           <StudentProfile profile={obj}/>

        );
    }


    return (
        <div>
            {listLecture}
        </div>
    );
}

export default ListOfStudents;