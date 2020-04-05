import React from 'react';

import './ButtonIcon.css';


const ButtonIcon = ({ children, onClick}) => (

    <button 
        className="hh-button-icon"
        onClick={onClick}>
        {children}
    </button>
);

export default ButtonIcon;
