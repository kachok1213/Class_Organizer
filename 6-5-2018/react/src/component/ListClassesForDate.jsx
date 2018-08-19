import React, { Component } from 'react';
import { BrowserRouter, Route, Link } from 'react-router-dom';
import $ from 'jquery';
import Style from '../css/Style.css';
import Ajax from './Ajax';





export class ListClassesForDate extends Component {
    constructor(props) {
        super(props);
        this.state = {

        }

    };



    render() {


        let listLecture;



        if (this.props.list != null) {

            if (this.props.past == false) {
                listLecture = this.props.list.map((obj, index) =>

                    <div>
                        <a4>מיקום: {obj.Class.ClassName}</a4> <br />
                        <a4>שם הקורס: {obj.Course.CourseName}</a4> <br />
                        <a4>שעה: {obj.BeginHour}-{obj.EndHour} </a4>
                        <button onClick={() => {

                           alert(obj.LectureID);
                            let paramsObj =
                                {

                                    LectureID: parseInt(obj.LectureID)
                                }

                            Ajax('DeleteLecture', paramsObj)
                                .then(data => {
                                    alert("yes")

                                })
                                .catch(err => {
                                    alert(err)
                                });
                        }}>ביטול השיעור </button>

                        <hr />

                    </div >



                );
            }
            else {
                listLecture = this.props.list.map((obj, index) =>

                    <div>
                        <a4>מיקום: {obj.Class.ClassName}</a4> <br />
                        <a4>שם הקורס: {obj.Course.CourseName}</a4> <br />
                        <a4>שעה: {obj.BeginHour}-{obj.EndHour} </a4>


                        <hr />

                    </div >



                );
            }
        }


            return (
                <div>
                    <center>
                        {listLecture}
                    </center>
                </div>
            )
        }
    };

    export default ListClassesForDate;




