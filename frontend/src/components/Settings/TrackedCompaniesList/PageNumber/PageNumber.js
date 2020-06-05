import React from 'react';
import PropTypes from 'prop-types';

import ButtonIcon from 'components/ButtonIcon/ButtonIcon';

import './PageNumber.css';

const PageNumber = ({number, changePage}) => {

    return (
        <ButtonIcon onClick={changePage}>
            <div className="number">
                {number + 1}
            </div>
        </ButtonIcon>
    );
};

PageNumber.propTypes = {
    number: PropTypes.number.isRequired,
    changePage: PropTypes.func,
};

export default PageNumber;
