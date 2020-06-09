import React from 'react';
import PropTypes from "prop-types";

import Input from 'components/Input/Input';

import './Weight.css';

const Weight = ({refWeight, name}) => (
    <div className="weight">
        <label>{name}*</label>
        <div className="weight__input">
            <Input
                placeholderText={"Введите вес"}
                ref={refWeight}
                type={"number"}
                />
        </div>
    </div>
);

Weight.propTypes = {
    refWeight: PropTypes.object,
    name: PropTypes.string,
};

export default Weight;
