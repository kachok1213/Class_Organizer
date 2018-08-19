import React, { Component } from 'react';
import { BrowserRouter, Route, Link } from 'react-router-dom';
import $ from 'jquery';
import Style from '../css/Style.css';



function NextClass(props) {

    let view = [];
    
       if(props!=null)
       {
        view.push(<h6>השיעור הבא</h6>);
        
       }
    

    return (
        <div>
            {view}
        </div>
    );
}

export default NextClass;