/* eslint-disable max-len */
import React from 'react';
import PropTypes from 'prop-types';

const CloseIcon = ({ size }) => (
    <svg width={size} height={size} viewBox="0 0 30 30" xmlns="http://www.w3.org/2000/svg">
        <path d="M9.21967 20.0314C8.92678 20.3243 8.92678 20.7991 9.21967 21.092C9.51256 21.3849 9.98744 21.3849 10.2803 21.092L15.1497 16.2226L20.0314 21.1042C20.3243 21.3971 20.7991 21.3971 21.092 21.1042C21.3849 20.8113 21.3849 20.3365 21.092 20.0436L16.2104 15.1619L21.092 10.2803C21.3849 9.98744 21.3849 9.51256 21.092 9.21967C20.7991 8.92678 20.3243 8.92678 20.0314 9.21967L15.1497 14.1013L10.2803 9.2319C9.98745 8.939 9.51258 8.939 9.21969 9.2319C8.92679 9.52479 8.92679 9.99966 9.21969 10.2926L14.0891 15.1619L9.21967 20.0314Z" fill="#999999"/>
    </svg>
);

CloseIcon.defaultProps = {
    size: 30,
};

CloseIcon.propTypes = {
    size: PropTypes.number,
};

export default CloseIcon;
