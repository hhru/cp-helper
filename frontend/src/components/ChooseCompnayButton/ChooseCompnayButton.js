import React, {useState, Fragment} from 'react';
import {connect} from 'react-redux';

import Button from '../Button/Button';

import './ChooseCompnayButton.css';

const ChooseCompanyButton = ({ onClick, payload }) => {
    return (
        <div className="search__btn">
            <Button onClick={onClick} disabled={!payload}>Выбрать компанию</Button>
        </div> 
    );
};

export default ChooseCompanyButton;

