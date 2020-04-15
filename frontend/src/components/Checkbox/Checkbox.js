import React, {forwardRef} from 'react';

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

export default Checkbox;
