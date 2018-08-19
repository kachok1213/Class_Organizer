import React, { Component } from 'react';
import Calendar from 'react-calendar';
import $ from 'jquery';
import NextClass from './NextClass';
import ListClassesForDate from './ListClassesForDate.jsx';
import Menu from './Menu';
import CalendarLecturer from './CalendarLecturer';
import ListOfStudents from './ListOfStudents';
import Ajax from './Ajax';

let local;
let timeInterval;
let timer;
let lectureID;
class HomePage extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
     
      date: new Date(),
      nextClass: null,
      myClass:null,
      output:null,
      listStu:null,
      timer: ""
    };
  
  }

  listOfStudent =(e)=>
  {
  
    var paramsObj =
    {
        
     LectureID:e.target.id
    }

    Ajax('AllStudentsOnSpecLectur', paramsObj)
    .then(data => {
      
      let students = JSON.parse(data);
      
     if(students!=null)
     {
       
      this.setState({listStu:students})
              
     }
    })
    .catch(err => {
      alert(err)
    });
  }




  startTimer() {
    let now = new Date();
    let paramsObj =
      {
        TimeStarted: (now.getHours() > 9 ? now.getHours() + ":" : "0" + now.getHours() + ":") + (now.getMinutes() > 9 ? now.getMinutes() : "0" + now.getMinutes()),
        LectureID: lectureID
      }
 
      Ajax('StartTimer', paramsObj)
      .then(data => {
       alert("ays")
      })
      .catch(err => {
        alert(err)
      });


  }
  
  componentDidMount() {
    //this.setState({msg:"hello " + this.props.location.info.detailes.firstName +" "+ this.props.location.info.detailes.LasttName+" "+this.props.location.info.detailes.email })
    
   

    let outputs = [];
 
    var time1 = this.state.date.getHours() + ":" + this.state.date.getMinutes();
    var date1 = this.state.date.getDate() + "/" + (this.state.date.getMonth() + 1) + "/" + this.state.date.getFullYear()
    var paramsObj =
      {
        date: date1,
        LecturerID: 111,
        time: time1
      }


      Ajax('GetNextLectureForLecturer', paramsObj)
      .then(data => {
        let lecture = JSON.parse(data);
        
     
        
        
       if(lecture!=null)
       {


        if (lecture.TimeStarted != null) {

          let now = new Date().toTimeString().slice(0, 5);
          let timer = lecture.TimeStarted;
          let minutes = parseInt(timer.slice(3, 5));
          let hours = parseInt(timer.slice(0, 2));
  
          let totalMinutesOfTimer = hours * 60 + minutes;
          let totalMinutesOfNow = parseInt(now.slice(0, 2)) * 60 + parseInt(now.slice(3, 5));
  
          if (totalMinutesOfNow - totalMinutesOfTimer <= 15) {
  
  
            let minutes = 16 - (totalMinutesOfNow - totalMinutesOfTimer);
            let seconds = 0;
            timeInterval = setInterval(() => {
              this.setState({ timer: (minutes > 9 ? minutes : '0' + minutes) + ':' + (seconds > 9 ? seconds : '0' + seconds) });
              seconds--;
              if (seconds < 0) {
                minutes--;
                seconds = 59;
              }
              if (minutes == 0) {
                this.setState({ timer: "off" });
                clearInterval(timeInterval);
  
              }
            }, 1000);
  
  
  
          } else {
            this.setState({ timer: "off" });
          }
        }

           alert(lecture.IsActive);

              lectureID=lecture.LectureID;
                outputs.push(<h1>מגמה: {lecture.Department.DepartmentName}<br /></h1>);
                outputs.push(<h1>קורס: {lecture.Course.CourseName}<br /></h1>);
                outputs.push(<h3>כיתה: {lecture.Class.ClassName}<br /></h3>);
                outputs.push(<h2>{lecture.BeginHour.slice(0, -3)}-{lecture.EndHour.slice(0, -3)}<br /></h2>);
                outputs.push(<input type="button" onClick={this.listOfStudent} id={lecture.LectureID} value="הסטודנטים"/>);
                if(lecture.IsActive)
                {
                outputs.push(<input type="button" onClick={this.startTimer} id={lecture.LectureID} value="הפעל מצב נוכחות"/>);
                }
                else{
                  outputs.push(<div style={{color: 'red'}}>השיעור בוטל</div>)
                }
                outputs.push(<hr />);

                this.setState({output:outputs})
                
       }
      })
      .catch(err => {
        alert(err)
      });


      

  }

  render() {
    return (

      <div>
       <Menu/>
       {this.state.timer}
       {this.state.output}
      <ListOfStudents list={this.state.listStu}/>
      </div>
    );
  }
}

export default HomePage
