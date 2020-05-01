import React from 'react';
import PropTypes from 'prop-types';

import './Copyright.css';

const Copyright = ({year}) => (
    <div className="copyright">
        &copy; {year} Группа компаний HeadHunter
    </div>
);

Copyright.propTypes = {
    year: PropTypes.number,
};

export default Copyright;
