import React, {forwardRef} from 'react';
import PropTypes from 'prop-types';

import './Checkbox.css';

const Checkbox = forwardRef(({ onChange, id, labelText}, ref) => {
    return (
        <div className="checkbox">
            <input
                ref={ref}
                onChange={onChange}
                type='checkbox'
                id={id}
                />
            <label className="checkbox__label" htmlFor={id}>{labelText}</label>
        </div>
    );
});

Checkbox.propTypes = {
    labelText: PropTypes.string.isRequired,
    id: PropTypes.string.isRequired,
    onChange: PropTypes.func.isRequired,
};

export default Checkbox;
