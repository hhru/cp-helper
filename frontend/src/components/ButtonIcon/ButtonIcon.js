import React from 'react';
import PropTypes from 'prop-types';

import './ButtonIcon.css';

const ButtonIcon = ({ children, onClick}) => (
    <button
        className="hh-button-icon"
        onClick={onClick}>
        {children}
    </button>
);

ButtonIcon.propTypes = {
    children: PropTypes.oneOfType([
        PropTypes.arrayOf(PropTypes.node),
        PropTypes.node,
    ]).isRequired,
    onClick: PropTypes.func.isRequired,
};

export default ButtonIcon;
